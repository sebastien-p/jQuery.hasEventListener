/*jshint jquery:true */

(function ($, exports) {
	function Host (events) { // tester avec sinon-chai
		if (!isHost(this)) { return new Host(events); }
		this._$ = $(this);
		this._names = new exports.Map();
		this._handlers = new exports.Map();
		this._namespaces = new exports.Map();
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

	function foo (host, parsedEvent) {
		//host._names.set(parserEvent.name, {});
		//host._names.set(parserEvent.namespace, {});
		$.each(parsedEvent, function (key, value) {
			host["_" +  key + "s"].set(value, {});
		});
	}

	function bar (host, handler) {
		host._handlers.set(handler, {});
	}

	function bindEvent (host, event, handler) {
		bar(host, handler);
		host._$.on(event, handler);
	}

	function bindEvents (host, event, handlers) {
		foo(host, parseEvent(event));
		if (!$.isArray(handlers)) { handlers = [handlers]; }
		$.each(handlers, function (index, handler) {
			bindEvent(host, event, handler);
		});
	}

	function handleEvents (host, events) {
		if (!events) { return; }
		$.each(events, $.proxy(bindEvents, null, host));
	}

	function forEachHost (object, callback) {
		if (isHost(object)) { callback(object); return; }
		$.each(object, function (key, value) {
			forEachHost(value, callback);
		});
	}

	function forEach (host, properties, callback) {
		if (!properties) { callback(host); return; }
		properties = properties.split(/\+?([^+]+)$/);
		//var keys = host["_" + properties[1]].keys();
		//var keys = get(host, properties[1]);
		var keys = host.get(properties[1]);
		forEach(host, properties[0], function () {
			var outerParameters = $.makeArray(arguments);
			$.each(keys, function (index, value) {
				var parameters = outerParameters.concat(value);
				callback.apply(null, parameters);
			});
		});
	}

/*

	names: {
		name: {
			namespaces: {
				.namespace: {
					handlers: {}
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
					handlers: {}
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

	Host.prototype.get = function (property) {
		return this["_" + property].keys();
	};

	Host.forEach = function (object, properties, callback) {
		if (arguments.length < 3) {
			callback = properties;
			properties = "";
		}
		forEachHost(object, function (host) {
			forEach(host, properties, callback);
		});
	};

	exports.Host = Host;
}(jQuery, jQuery.getEventsData));
