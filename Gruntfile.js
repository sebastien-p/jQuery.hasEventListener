module.exports = function (grunt) {
	grunt.initConfig({
		pkg: grunt.file.readJSON("bower.json"),

		jshint: {
			src: "src/<%=pkg.name%>.js"
		},

		uglify: {
			options: {
				banner: "/*! <%=pkg.name%>.js v<%=pkg.version%> - <%=pkg.license%> */\n"
			},
			dist: {
				src: "src/<%=pkg.name%>.js",
				dest: "dist/<%=pkg.name%>.min.js"
			}
		},

		yuidoc: {
			dist: {
				name: "<%=pkg.name%>",
				//description: "<%=pkg.description%>",
				version: "<%=pkg.version%>",
				url: "<%=pkg.homepage%>",
				//logo: "https://si0.twimg.com/profile_images/1520318561/fingerproof_logo.jpg",
				options: {
					linkNatives: true,
					paths: "src",
					outdir: "doc"
				}
			}
		}
	});

	grunt.loadNpmTasks("grunt-contrib-jshint");
	grunt.loadNpmTasks("grunt-contrib-uglify");
	grunt.loadNpmTasks("grunt-contrib-yuidoc");

	grunt.registerTask("release", ["jshint", /*"testem:src",*/ "uglify", /*"testem:dist",*/ "yuidoc"]);
	//grunt.registerTask("default", ["testem"]);
};
