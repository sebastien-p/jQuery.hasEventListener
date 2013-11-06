/*jshint node:true, camelcase:false */

module.exports = function (grunt) {
	require("load-grunt-tasks")(grunt, { scope: "devDependencies" });
	var config = grunt.config;
	var readJSON = grunt.file.readJSON;
	var registerTask = grunt.registerTask;

	grunt.initConfig({
		component: readJSON("bower.json"),
		files: {
			src: "src/<%= component.name %>.js",
			dist: "dist/<%= component.name %>.min.js",
			conf: [
				".jshintrc",
				".coffeelintrc",
				"bower.json",
				"package.json",
				"Gruntfile.js",
				"test/testem.json"
			],
			test: {
				helpers: "test/*js",
				spec: {
					js: "test/spec/**/*.spec.js",
					coffee: "test/spec/**/*.spec.coffee"
				}
			}
		},
		// VOIR https://github.com/gruntjs/grunt-contrib-uglify/issues/22#issuecomment-13250492
		banner: [ // rajouter auteur + license url
			"/*!",
			"<%= component.name %>",
			"v<%= component.version %>",
			"- <%= component.license %>",
			"*/\n"
		].join(" ") // add banner to src
	});

	/**
	$ grunt jshint
	$ grunt jshint:src
	$ grunt jshint:conf
	$ grunt jshint:test
	**/

	config("jshint", {
		options: { jshintrc: true },
		conf: "<%= files.conf %>",
		src: "<%= files.src %>",
		test: [
			"<%= files.test.helpers %>",
			"<%= files.test.spec.js %>"
		]
	});

	/**
	$ grunt coffeelint
	$ grunt coffeelint:spec
	**/

	config("coffeelint", {
		options: readJSON(".coffeelintrc"),
		spec: "<%= files.test.spec.coffee %>"
	});

	/**
	$ grunt testem
	$ grunt testem:ci
	$ grunt testem:dev
	$ grunt testem:ci:src
	$ grunt testem:ci:dist
	$ grunt testem:launchers
	$ grunt testem:ci:src@jquery-x.y
	$ grunt testem:ci:dist@jquery-x.y
	$ grunt testem:run:src@jquery-x.y
	$ grunt testem:run:dist@jquery-x.y
	**/

	config("testem", (function (testem, settings) {
		var each = grunt.util._.forOwn;
		var tasks = { src: [], dist: [] };
		var versions = config("component").devDependencies;
		each(versions, function (__, jQuery) {
			if (!/^jquery/.exec(jQuery)) { return; }
			each(tasks, function (task, target) {
				var environment = target + "@" + jQuery;
				//var min = "/jquery" + (target === "src" ? "" : ".min");
				task.push("testem:ci:" + environment);
				testem[environment] = {
					options: settings,
					src: [
						//"bower_components/" + jQuery + min + ".js", // cf ci-dessous
						"bower_components/" + jQuery + "/jquery.js",
						"<%= files." + target + "%>",
						"<%= files.test.helpers %>",
						//"<%= files.test.spec.js %>",
						"<%= files.test.spec.coffee %>"
					]
				};
			});
		});
		registerTask("testem:ci:src", tasks.src);
		registerTask("testem:ci:dist", tasks.dist); // jquery 1.7.2 n'inclus pas jquery.min.js !
		registerTask("testem:dev", tasks.src[0].replace(/ci/, "run")); // ou grunt dev ?
		return testem;
	}({}, readJSON("test/testem.json"))));

	/**
	$ grunt uglify
	$ grunt uglify:dist
	**/

	config("uglify", (function (dotMap) {
		return {
			options: {
				banner: "<%= banner %>",
				report: "min",
				preserveComments: "some",
				sourceMapRoot: "../",
				sourceMap: dotMap,
				sourceMappingURL: function (dest) {
					return dotMap(dest).replace(/^[^\/]+\//, "");
				}
			},
			dist: {
				src: "<%= files.src %>",
				dest: "<%= files.dist %>"
			}
		};
	}(function (url) { return url.replace(/[^.]+$/, "map"); })));

	/**
	$ grunt yuidoc
	$ grunt yuidoc:doc
	**/

	config("yuidoc", {
		doc: {
			options: {
				paths: "src", // files.src
				outdir: "doc", // dans une branche gh-pages
				linkNatives: true
			},
			logo: "../logo.png", // à revoir
			name: "<%= component.name %>",
			url: "<%= component.homepage %>",
			version: "<%= component.version %>",
			description: "<%= component.description %>"
		}
	});

	/**
	$ grunt lint
	**/

	registerTask("lint", ["jshint", "coffeelint"]);

	/**
	$ grunt release
	**/

	registerTask("release", [
		"lint",
		"testem:ci:src",
		"uglify",
		"testem:ci:dist",
		"yuidoc"
	]);

	/**
	$ grunt
	**/

	registerTask("default", ["lint", "testem:ci"]); // $ grunt test -> [lint, testem:ci:src] ? ou échanger grunt default et grunt test ?
};
