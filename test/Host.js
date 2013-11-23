/*jshint jquery:true */

/**
Provides an interface to ease unit testing of `jQuery.hasEventListener`.
@module hasEventListener
@submodule hasEventListener.host
@requires hasEventListener.map
**/

(function ($, exports) {
	function isHost (object) { return object instanceof Host; }

	function createMaps (object, properties) {
		if (properties) {
			$.each(properties.split(" "), function (index, key) {
				object["_" + key] = new exports.Map();
			});
		}
		// If not necessary, don't add another map
		// but keep the ability to use recursion
		return object;
	}

	function addMaps (map, key, properties) {
		return map.get(key) || map.set(key, createMaps({}, properties));
	}

	// host._names.get(name)._data
	// host._names.get(name)._namespaces
	// host._names.get(name)._namespaces.get(namespace)._data
	// host._names.get(name)._namespaces.get(namespace)._handlers
	// host._names.get(name)._namespaces.get(namespace)._handlers.get(handler)._data
	// host._names.get(name)._handlers
	// host._names.get(name)._handlers.get(handler)._data
	// host._names.get(name)._handlers.get(handler)._namespaces
	// host._names.get(name)._handlers.get(handler)._namespaces.get(namespace)._data
	function addToNames (object, name, namespace, handler) {
		// Use `data` as both an unique key and a value
		// because hosts can have multiple handlers for a given event
		var data = { name: name, namespace: namespace, handler: handler };
		name = addMaps(object._names, name, "handlers namespaces data");
		name._data.set(data, data);
		object = addMaps(name._handlers, handler, "namespaces data");
		object._data.set(data, data);
		if (!namespace) { return; }
		addMaps(object._namespaces, namespace, "data")._data.set(data, data);
		object = addMaps(name._namespaces, namespace, "handlers data");
		object._data.set(data, data);
		addMaps(object._handlers, handler, "data")._data.set(data, data);
	}

	// host._namespaces.get(namespace)._names
	// host._namespaces.get(namespace)._names.get(name)._handlers
	// host._namespaces.get(namespace)._handlers
	// host._namespaces.get(namespace)._handlers.get(handler)._names
	function addToNamespaces (object, name, namespace, handler) {
		if (!namespace) { return; }
		namespace = addMaps(object._namespaces, namespace, "names handlers");
		object = addMaps(namespace._names, name, "handlers");
		addMaps(object._handlers, handler);
		object = addMaps(namespace._handlers, handler, "names");
		addMaps(object._names, name);
	}

	// host._handlers.get(handler)._names
	// host._handlers.get(handler)._names.get(name)._namespaces
	// host._handlers.get(handler)._namespaces
	// host._handlers.get(handler)._namespaces.get(namespace)._names
	function addToHandlers (object, name, namespace, handler) {
		handler = addMaps(object._handlers, handler, "names namespaces");
		object = addMaps(handler._names, name, "namespaces");
		if (!namespace) { return; }
		addMaps(object._namespaces, namespace);
		object = addMaps(handler._namespaces, namespace, "names");
		addMaps(object._names, name);
	}

	function bindEvent (host, event, name, namespace, handler) {
		addToNames(host, name, namespace, handler);
		addToNamespaces(host, name, namespace, handler);
		addToHandlers(host, name, namespace, handler);
		host._$.on(event, handler);
	}

	function bindEvents (host, event, handlers) {
		var parsed = event.split(/^([^.]+)/);
		// Multiple handlers for a given event like so:
		// { "name.namespace": [handler1, handler2] }
		if (!$.isArray(handlers)) { handlers = [handlers]; }
		$.each(handlers, function (index, handler) {
			bindEvent(host, event, parsed[1], parsed[2], handler);
		});
	}

	function handleEvents (host, events) {
		host._$ = $(host);
		// host._names
		// host._namespaces
		// host._handlers
		createMaps(host, "names handlers namespaces");
		if (!events) { return; }
		$.each(events, $.proxy(bindEvents, null, host));
	}

	function forEachHost (object, callback) {
		// Find (nested) hosts in objects and arrays
		if (isHost(object)) { callback(object); return; }
		$.each(object, function (key, value) {
			forEachHost(value, callback);
		});
	}

	function forEach (host, properties, callback) {
		if (!properties) { callback(host); return; }
		// Multiple properties are separated by a plus sign
		properties = properties.split(/\+?([^+]+)$/);
		// Because of the recursion, we have to nest callbacks
		// from bottom to up, so get the last property fisrt
		var keys = host["_" + properties[1]].keys();
		forEach(host, properties[0], function () {
			var outerParameters = $.makeArray(arguments);
			$.each(keys, function (index, value) {
				// Recursively add arguments to be passed
				var parameters = outerParameters.concat(value);
				callback.apply(null, parameters);
			});
		});
	}

	function forNested (object, properties, callback) {
		// Multiple properties are separated by a dot
		properties = properties.split(/^([^.]+)\.?/);
		var map = object["_" + properties[1]];
		var keys = map.keys();
		properties = properties[2];
		if (!properties) { callback(keys); return; }
		$.each(keys, function (index, value) {
			// Recursively add arguments to be passed
			var newCallback = $.proxy(callback, null, value);
			forNested(map.get(value), properties, newCallback);
		});
	}

	/**
	A host: its purpose is to receive event listeners.
	@class jQuery.getEventsData.Host
	@constructor
	@param [events] {Object} A hash of events and listeners.
	@example
		new Host();
	@example
		new Host({
			"name.namespace": [handler1, handler2],
			"name1.namespace": handler1,
			name2: handler2
		});
	**/

	function Host (events) {
		if (!isHost(this)) { return new Host(events); }
		handleEvents(this, events);
	}

	exports.Host = Host;

	/**
	Recursively search for `Host` instances in objects and arrays.
	Also, loops over each passed property for each found host.
	@private
	@static
	@method forEach
	@for jQuery.getEventsData.Host
	@param object {Object|Array} It should contain some `Host` instances.
	@param [properties] {String} `/^name(space)?s|handlers$/`, separated by a plus sign.
	@param callback {Function} The function to be called for each host and property.
	@example
		Host.forEach(hosts, function (host) {});
	@example
		Host.forEach(hosts, "names", function (host, name) {});
	@example
		Host.forEach(hosts, "names+handlers", function (host, name, handler) {});
	**/

	Host.forEach = function (object, properties, callback) {
		// Allow a `function (object, callback) {}` signature
		forEachHost(object, !callback ? properties : function (host) {
			forEach(host, properties, callback);
		});
	};

	/**
	Recursively search for `Host` instances in objects and arrays.
	Also, loops over each value for any passed property for each found host.
	@private
	@static
	@method forNested
	@for jQuery.getEventsData.Host
	@param object {Object|Array} It should contain some `Host` instances.
	@param properties {String} `/^name(space)?s|handlers|data$/`, separated by a dot.
	@param callback {Function} The function to be called for each host and property.
	@example
		Host.forNested(hosts, "namespaces", function (host, namespaces) {});
	@example
		Host.forNested(hosts, "handlers.names", function (host, handler, names) {});
	@example
		Host.forNested(hosts, "names.data", function (host, name, data) {});
	**/

	Host.forNested = function (object, properties, callback) {
		forEachHost(object, function (host) {
			// Prepend `host` to the arguments to be passed
			var newCallback = $.proxy(callback, null, host);
			forNested(host, properties, newCallback);
		});
	};
}(jQuery, jQuery.getEventsData));
