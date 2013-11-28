/*jshint jquery:true */
/*global define */

/**
todo.
@main hasEventListener
@module hasEventListener
**/

(function (factory) {
	// AMD or global variable export
	if (typeof define !== "function" || !define.amd) { factory(jQuery); }
	else { define(["jquery"], factory); }
}(function ($) {

	var each = $.each;
	var grep = $.grep;
	var getInternalData = $._data;
	var isEmpty = $.isEmptyObject;
	var hasOwn = $.proxy($.call, {}.hasOwnProperty);
	var deepCopy = $.proxy($.call, $.extend, $, true);

	function parseEvent (event) {
		// `event` must be a valid non-empty string
		// like `"myName"` or `".nyNamespace"`
		// or even `"myName.myNamespace"`
		event = event && /^([^.]+)?(?:\.([^.]+))?$/.exec(event);
		// if the regular expression doesn't match anything
		// `event` would be `null` so make sure to handler that
		return event && { name: event[1], namespace: event[2] };
	}

	function filterOne (event, property, value) {
		event = grep(event, function (object) {
			return object[property] === value;
		});
		// return `undefined` instead of empty arrays
		if (event.length) { return event; }
	}

	function filterAll (events, property, value) {
		each(events, function (name, event) {
			event = filterOne(event, property, value);
			// reuse the passed object because it's a clone
			if (event) { events[name] = event; }
			else { delete events[name]; }
		});
		// return `undefined` instead of empty objects
		if (!isEmpty(events)) { return events; }
	}

	function useFilter (filter) {
		return function (data, property, value) {
			// if no data passed, return `undefined`
			// if no value passed, return `data`
			if (!data || !value) { return data; }
			return filter(data, property, value);
		};
	}

	/**
	Get a clone of the internal jQuery events data for a given host.
	@static
	@method getEventsData
	@for jQuery
	@param host {Mixed} Whatever jQuery can bind events to.
	@param [event] {String} `"name"`, `"name.namespace"` or `".namespace"`.
	@param [handler] {Function} A handler that may have been attached.
	@return {Object|Array} The cloned data or `undefined`.
	@example
		jQuery.getEventsData(window);
	@example
		jQuery.getEventsData(document.body, "click");
	@example
		jQuery.getEventsData($("img")[0], "load.avatar");
	@example
		jQuery.getEventsData(object, ".myNamespace");
	@example
		jQuery.getEventsData(host, function () {});
	@example
		jQuery.getEventsData(host, ".myNamespace", handler);
	@example
		jQuery.getEventsData(host, "myName.myNamespace", handler);
	**/

	function getEventsData (host, event, handler) {
		var data = getInternalData(host, "events");
		// `host` has no events attached
		if (!data) { return; }
		var numberOfParameters = arguments.length;
		data = deepCopy({}, data);
		// `host` is the only passed parameter
		if (numberOfParameters < 2) { return data; }
		var filter = useFilter(filterAll);
		// `host` and `event` are passed
		if (typeof event === "string") {
			event = parseEvent(event);
			// `event` isn't a valid string
			if (!event) { return; }
			if (event.name) {
				// `host` has no events of this name attached
				if (!hasOwn(data, event.name)) { return; }
				data = data[event.name];
				filter = useFilter(filterOne);
			}
			// if no namespace passed, just do `data = data`
			// `data` can also be `undefined` at this point
			data = filter(data, "namespace", event.namespace);
		}
		// `host` and `event` are passed but `event`
		// isn't a string so it must be a function
		else if (numberOfParameters < 3) {
			numberOfParameters = 3;
			handler = event;
		}
		// `host` and `event` and `handler` are passed
		// but `event` isn't a string so stop here
		else { return; }
		// `host` and `event` are passed
		// and `event` is a valid string
		if (numberOfParameters < 3) { return data; }
		// `host` and `event` are passed and `event`
		// isn't a function or `handler` is also
		// passed but it isn't a function either
		if (typeof handler !== "function") { return; }
		// `handler` is a function, `event` is valid
		return filter(data, "handler", handler);
	}

	$.getEventsData = getEventsData;

	/**
	Know if a given host has some matching event handlers attached.
	@static
	@method hasEventListener
	@for jQuery
	@param host {Mixed} Whatever jQuery can bind events to.
	@param [event] {String} `"name"`, `"name.namespace"` or `".namespace"`.
	@param [handler] {Function} A handler that may have been attached.
	@return {Boolean} Wether the passed host has some matching events attached.
	@example
		jQuery.hasEventListener(window);
	@example
		jQuery.hasEventListener(document.body, "click");
	@example
		jQuery.hasEventListener($("img")[0], "load.avatar");
	@example
		jQuery.hasEventListener(object, ".myNamespace");
	@example
		jQuery.hasEventListener(host, function () {});
	@example
		jQuery.hasEventListener(host, ".myNamespace", handler);
	@example
		jQuery.hasEventListener(host, "myName.myNamespace", handler);
	**/

	function hasEventListener (/*host, event, handler*/) {
		return !!getEventsData.apply(this, arguments);
	}

	$.hasEventListener = hasEventListener;

	/**
	Get a merged clone of the internal jQuery events data for all given hosts.
	@method fn.getEventsData
	@for jQuery
	@since 3.1.0
	@param [event] {String} `"name"`, `"name.namespace"` or `".namespace"`.
	@param [handler] {Function} A handler that may have been attached.
	@return {Object|Array} The merged cloned data or `undefined`.
	@example
		jQuery(window).getEventsData();
	@example
		jQuery([window, document.body]).getEventsData("click");
	@example
		jQuery("img").getEventsData("load.avatar");
	@example
		jQuery("*").getEventsData(".myNamespace");
	@example
		jQuery([object1, object2, objectN]).getEventsData(function () {});
	@example
		jQuery(hosts).getEventsData(".myNamespace", handler);
	@example
		jQuery(hosts).getEventsData("myName.myNamespace", handler);
	**/

	function fnGetEventsData (/*event, handler*/) {
		var outerParameters = $.makeArray(arguments);
		each(this, function (index, host) {
			var parameters = [host].concat(outerParameters);
			var data = getEventsData.apply(null, parameters);
			return data;
			//console.log(data);
		});
	}

	// function fnGetEventsData (event/*, handler*/) { // use makeOneOrTwoParams ?
	//	var data = {};
	//	var fillData = function (__, host) {
	//		each(getEventsData(host), function (key, value) {
	//			if (!data[key]) { data[key] = []; }
	//			merge(data[key], value);
	//		});
	//	};
	//	if (arguments.length) {
	//		data = [];
	//		fillData = function (__, host) {
	//			merge(data, getEventsData(host, event));
	//		};
	//	}
	//	each(this, fillData);
	//	return data;
	//}

	$.fn.getEventsData = fnGetEventsData;

	/**
	Filter all given hosts that have some matching event handlers attached.
	@chainable
	@method fn.hasEventListener
	@for jQuery
	@param [event] {String} `"name"`, `"name.namespace"` or `".namespace"`.
	@param [handler] {Function} A handler that may have been attached.
	@return {jQuery Collection} All hosts that have some matching events attached.
	@example
		jQuery(window).hasEventListener();
	@example
		jQuery([window, document.body]).hasEventListener("click");
	@example
		jQuery("img").hasEventListener("load.avatar");
	@example
		jQuery("*").hasEventListener(".myNamespace");
	@example
		jQuery([object1, object2, objectN]).hasEventListener(function () {});
	@example
		jQuery(hosts).hasEventListener(".myNamespace", handler);
	@example
		jQuery(hosts).hasEventListener("myName.myNamespace", handler);
	**/

	function fnHasEventListener (/*event, handler*/) { // use oneParameter et twoParameters
		var context = this;
		var outterParameters = arguments;
		return grep(this, function (host) {
			var parameters = $.merge([host], outterParameters);
			return hasEventListener.apply(context, parameters); // top level this au lieu de null ?
		});
	}

	$.fn.hasEventListener = fnHasEventListener;

	/*var makeArray = $.makeArray;

	function make (callback, rest) {
		rest = makeArray(arguments).slice(1);
		return function () {
			var parameters = makeArray(arguments).concat(rest);
			return callback.apply(this, parameters);
		};
	}*/

	/**
	Select all given hosts that have some matching event handlers attached.
	@chainable
	@method expr.hasEventListener
	@for jQuery
	@return {jQuery Collection} All hosts that have some matching events attached.
	@example
		jQuery("*:hasEventListener");
	@example
		jQuery("img:hasEventListener(load)");
	@example
		jQuery("div:hasEventListener(.myNamespace)");
	@example
		jQuery("p,span:hasEventListener(myName.myNamespace)");
	**/

	// https://github.com/jquery/sizzle/wiki/Sizzle-Documentation#-backwards-compatible-plugins-for-pseudos-with-arguments
	var exprHasEventListener = (function (pseudo) {
		try { return $.expr.createPseudo(pseudo); }
		catch (error) {
			return function (host, index, match) {
				return pseudo(match[3])(host);
			};
		}
	}(function (selector) {
		function one (host) { return hasEventListener(host); }
		function two (host) { return hasEventListener(host, selector); }
		return selector ? two : one;
		//if (selector) { return make(hasEventListener, selector); }
		//return make(hasEventListener);
	}));

	$.expr[":"].hasEventListener = exprHasEventListener;

	/**
	The "write less, do more" JavaScript library.
	@class jQuery
	@static
	**/

	return $;
}));
