/*jshint jquery:true */

(function ($) {
	function Host (events) {
		var host = this;
		if (!Host.isHost(host)) { return new Host(events); }
		host._names = host.names = []; // l'un ou l'autre !
		host._$ = $(host);
		host._events = {};
		/*{
			name1: {
				handlers: [],
				namespaces: {
					".namespace1": []
				}
			}
		}*/
		host._handlers = [];
		host._namespaces = [];
		if ($.isPlainObject(events)) { host._handleEvents(events); }
	}

	Host.hasOwn = $.proxy($.noop.call, {}.hasOwnProperty);

	Host.isHost = function (value) {
		return value instanceof Host;
	};

	Host.inArray = function (array, value) {
		return $.inArray(value, array) > -1;
	};

	Host.uniquePush = function (array, value) {
		if (!Host.inArray(array, value)) { array.push(value); }
	};

	Host.parseEvent = function (event) {
		event = event.split(/^([^.]+)/);
		var name = event[1];
		var namespace = event[2];
		return { name: name, namespace: namespace };
	};

	Host.forEachHost = function (object, callback) {
		if (Host.isHost(object)) {
			callback(object);
			return;
		}
		$.each(object, function (key, value) {
			Host.forEachHost(value, callback);
		});
	};

	Host.prototype._bindEvent = function (_events, event, handler) {
		var host = this;
		Host.uniquePush(host._handlers, handler);
		Host.uniquePush(_events, handler);
		host._$.on(event, handler);
	};

	Host.prototype._bindEvents = function (event, handlers) { // too big!
		var host = this;
		var parsed = Host.parseEvent(event);
		var _events = host._events;
		if (!Host.hasOwn(_events, parsed.name)) {
			_events[parsed.name] = { handlers: [], namespaces: [] };
		}
		_events = _events[parsed.name];
		Host.uniquePush(host.names, parsed.name);
		if (parsed.namespace) {
			Host.uniquePush(host._namespaces, parsed.namespace);
			Host.uniquePush(_events.namespaces, parsed.namespace);
		}
		_events = _events.handlers;
		if (!$.isArray(handlers)) { handlers = [handlers]; }
		$.each(handlers, function (index, handler) {
			host._bindEvent(_events, event, handler);
		});
	};

	Host.prototype._handleEvents = function (events) {
		var host = this;
		$.each(events, function (event, handlers) {
			host._bindEvents(event, handlers);
		});
	};

	Host.prototype._getNamesFor = function (property, value) {
		return $.map(this._events, function (event, name) {
			if (Host.inArray(event[property], value)) { return name; }
		});
	};

	Host.prototype.forAll = function (property, callback) {
		var host = this;
		$.each(host["_" + property], function (index, namespace) {
			var names = host._getNamesFor(property, namespace);
			callback(namespace, names);
		});
	};

	$.getEventsData.Host = Host;
}(jQuery));
