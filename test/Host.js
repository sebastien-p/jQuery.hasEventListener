/*jshint jquery:true */

(function ($) {
	function Host (events) { // tester avec sinon-chai
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

	Host.hasOwn = $.proxy($.call, {}.hasOwnProperty); // private?

	Host.isHost = function (value) { // private?
		return value instanceof Host;
	};

	Host.inArray = function (array, value) { // private?
		return $.inArray(value, array) > -1;
	};

	Host.uniquePush = function (array, value) { // private?
		if (!Host.inArray(array, value)) { array.push(value); }
	};

	Host.parseEvent = function (event) { // private?
		event = event.split(/^([^.]+)/);
		var name = event[1];
		var namespace = event[2];
		return { name: name, namespace: namespace };
	};

	Host._forEachHost = function inception (object, callback) {
		if (Host.isHost(object)) {
			callback(object);
			return;
		}
		$.each(object, function (key, value) {
			inception(value, callback);
		});
	};

	Host.forEach = function inception (object, properties, callback) {
		if (arguments.length < 3) {
			callback = properties;
			properties = "";
		}
		if (!properties) {
			Host._forEachHost(object, callback);
			return;
		}
		properties = properties.split(/\+?([^+]+)$/);
		inception(object, properties[0], function (host) {
			var outerParameters = $.makeArray(arguments);
			host._forEach(properties[1], function (value) {
				var parameters = outerParameters.concat([value]); // [value] or value?
				callback.apply(null, parameters);
			});
		});
	};


	Host.prototype._bindEvent = function (_events, event, handler) { // _events en param c'est bizarre...
		Host.uniquePush(this._handlers, handler);
		_events.push(handler);
		this._$.on(event, handler);
	};

	Host.prototype._getEvent = function (name) {
		var events = this._events;
		if (!Host.hasOwn(events, name)) {
			events[name] = { handlers: [], namespaces: [] };
		}
		return events[name];
	};

	Host.prototype._bindEvents = function (event, handlers) { // too big!
		var host = this;
		var parsed = Host.parseEvent(event);
		var _event = host._getEvent(parsed.name);
		Host.uniquePush(host.names, parsed.name); // dans _getEvent ? + sans unique ?
		if (parsed.namespace) {
			Host.uniquePush(host._namespaces, parsed.namespace);
			Host.uniquePush(_event.namespaces, parsed.namespace);
		}
		if (!$.isArray(handlers)) { handlers = [handlers]; }
		$.each(handlers, function (index, handler) {
			host._bindEvent(_event.handlers, event, handler);
		});
	};

	Host.prototype._handleEvents = function (events) {
		var host = this;
		$.each(events, function (event, handlers) {
			host._bindEvents(event, handlers);
		});
	};

	/*Host.prototype._getNamesFor = function (property, value) {
		return $.map(this._events, function (event, name) {
			if (Host.inArray(event[property], value)) { return name; }
		});
	};*/

	Host.prototype._forEach = function (property, callback) {
		$.each(this["_" + property], function (index, value) {
			callback(value);
		});
	};

	$.getEventsData.Host = Host;
}(jQuery));
