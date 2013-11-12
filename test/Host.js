/*jshint jquery:true */

(function ($, exports) {
	function Host (events) { // tester avec sinon-chai
		if (!isHost(this)) { return new Host(events); }
		this._$ = $(this);
		this._names = new exports.Map(); // lulu()?
		this._handlers = new exports.Map(); // lulu()?
		this._namespaces = new exports.Map(); // lulu()?
		handleEvents(this, events);
	}

	function isHost (object) { return object instanceof Host; }

	function parseEvent (event) {
		event = event.split(/^([^.]+)/);
		var name = event[1];
		var namespace = event[2];
		event = { name: name };
		if (namespace) { event.namespace = namespace; }
		return event;
	}

	function setNameAndNamespace (host, parsedEvent) {
		$.each(parsedEvent, function (key, value) {
			host["_" +  key + "s"].set(value, {});
		});
	}

	function lulu (map, key) {
		if  (!map.get(key)) { map.set(key, new exports.Map()); }
		return map.get(key);
	}

	function foo (host, parsedEvent) {
		var names = lulu(host._names, parsedEvent.name);
		if (!parsedEvent.namespace) { return; }
		names = lulu(names, "namespaces");
		lulu(names, parsedEvent.namespace);
		var namespaces = lulu(host._namespaces, parsedEvent.namespace);
		namespaces = lulu(namespaces, "names");
		lulu(namespaces, parsedEvent.name);
	}

	function bar (host, handler) {
		host._handlers.set(handler, {});
	}

	function bindEvent (host, event, handler) {
		bar(host, handler);
		host._$.on(event, handler);
	}

	function bindEvents (host, event, handlers) {
		/*setNameAndNamespace*/foo(host, parseEvent(event));
		if (!$.isArray(handlers)) { handlers = [handlers]; }
		$.each(handlers, function (index, handler) {
			bindEvent(host, event, handler);
		});
	}

	function handleEvents (host, events) {
		if (!events) { return; }
		$.each(events, $.proxy(bindEvents, null, host));
	}





/*

	var Map = $.getEventsData.Map;
	var map = { _names: new Map(), _handlers: new Map(), _namespaces: new Map() };

	map._names.set("name1", { _handlers: new Map(), _namespaces: new Map() });
	map._names.get("name1")._handlers.set($.noop, { _namespaces: new Map() });
	map._names.get("name1")._handlers.get($.noop)._namespaces.set(".namespace1", true);
	map._names.get("name1")._namespaces.set(".namespace1", { _handlers: new Map() });
	map._names.get("name1")._namespaces.get(".namespace1")._handlers.set($.noop, true);
	map._names.set("name2", { _handlers: new Map(), _namespaces: new Map() });
	map._names.get("name2")._handlers.set($.noop, { _namespaces: new Map() });
	map._names.get("name2")._handlers.get($.noop)._namespaces.set(".namespace2", true);
	map._names.get("name2")._namespaces.set(".namespace2", { _handlers: new Map() });
	map._names.get("name2")._namespaces.get(".namespace2")._handlers.set($.noop, true);


	map._handlers.set($.noop, { _names: new Map(), _namespaces: new Map() });
	map._handlers.get($.noop)._names.set("name1", { _namespaces: new Map() });
	map._handlers.get($.noop)._names.get("name1")._namespaces.set(".namespace1", true);
	map._handlers.get($.noop)._namespaces.set(".namespace1", { _names: new Map() });
	map._handlers.get($.noop)._namespaces.get(".namespace1")._names.set("name1", true);
	//map._handlers.set($.noop, { _names: new Map(), _namespaces: new Map() });
	map._handlers.get($.noop)._names.set("name2", { _namespaces: new Map() });
	map._handlers.get($.noop)._names.get("name2")._namespaces.set(".namespace2", true);
	map._handlers.get($.noop)._namespaces.set(".namespace2", { _names: new Map() });
	map._handlers.get($.noop)._namespaces.get(".namespace2")._names.set("name2", true);

	map._namespaces.set(".namepace1", { _names: new Map(), _handlers: new Map() });
	map._namespaces.get(".namepace1")._names.set("name1", { _handlers: new Map() });
	map._namespaces.get(".namepace1")._names.get("name1")._handlers.set($.noop, true);
	map._namespaces.get(".namepace1")._handlers.set($.noop, { _names: new Map() });
	map._namespaces.get(".namepace1")._handlers.get($.noop)._names.set("name1", true);
	map._namespaces.set(".namepace2", { _names: new Map(), _handlers: new Map() });
	map._namespaces.get(".namepace2")._names.set("name2", { _handlers: new Map() });
	map._namespaces.get(".namepace2")._names.get("name2")._handlers.set($.noop, true);
	map._namespaces.get(".namepace2")._handlers.set($.noop, { _names: new Map() });
	map._namespaces.get(".namepace2")._handlers.get($.noop)._names.set("name2", true);


	names: { map
		name: { object
			namespaces: { map
				.namespace: { object
					handlers: {} map ------> attention peut avoir plusieurs fois le même handler !
				}
			},
			handlers: {
				handler: {
					namespaces: {}
				}
			}
		}
	}

	namespaces: {
		.namespace: {
			names: {
				name: {
					handlers: {} ------> attention peut avoir plusieurs fois le même handler !
				}
			},
			handlers: {
				handler: {
					names: {}
				}
			}
		}
	}

	handlers: {
		.handler: {
			names: {
				name: {
					namespaces: {}
				}
			},
			namespaces: {
				.namespace: {
					names: {}
				}
			}
		}
	}

*/





	function forEachHost (object, callback) {
		if (isHost(object)) { callback(object); return; }
		$.each(object, function (key, value) {
			forEachHost(value, callback);
		});
	}

	function forEach (host, properties, callback) {
		if (!properties) { callback(host); return; }
		properties = properties.split(/\+?([^+]+)$/);
		var keys = host["_" + properties[1]].keys();
		forEach(host, properties[0], function () {
			var outerParameters = $.makeArray(arguments);
			$.each(keys, function (index, value) {
				var parameters = outerParameters.concat(value);
				callback.apply(null, parameters);
			});
		});
	}

	function forNested (object, properties, callback) {
		properties = properties.split(/^([^.]+)\.?/);
		var map = object["_" + properties[1]];
		var keys = map.keys();
		properties = properties[2];
		if (!properties) { callback(keys); return; }
		$.each(keys, function (index, value) {
			var newCallback = $.proxy(callback, null, value);
			forNested(map.get(value), properties, newCallback);
		});
	}

	Host.forEach = function (object, properties, callback) {
		forEachHost(object, !callback ? properties : function (host) {
			forEach(host, properties, callback);
		});
	};

	Host.forNested = function (object, properties, callback) { // rename getXXX?
		forEachHost(object, function (host) {
			var newCallback = $.proxy(callback, null, host);
			forNested(host, properties, newCallback);
		});
	};

	exports.Host = Host;
}(jQuery, jQuery.getEventsData));
