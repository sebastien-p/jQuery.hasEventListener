/*jshint jquery:true */
/*global define */

/**
todo.
@module jQuery.hasEventListener
@author fingerproof
@class jQuery
@static
**/

(function (factory) {
	// AMD or global variable export
	if (typeof define === "function" && define.amd) {
		define(["jquery"], factory);
	} else { factory(jQuery); }
}(function ($) {

	//var map = $.map;
	var each = $.each;
	var grep = $.grep; // virer
	var merge = $.merge;
	var getIternalData = $._data;
	var hasOwn = $.proxy($.call, {}.hasOwnProperty);

	/**
	Get the internal jQuery events data for a given host.
	@method getEventsData
	@category Function
	@uses hasOwn
	@param host {Mixed} Whatever jQuery can bind events to.
	@param [key] {String} The name of a particular event.
	@return {Object|Array} The actual data, can be empty. // undefined à la place !
	@example
		jQuery.getEventsData(window);
	@example
		jQuery.getEventsData(document.body, "click");
	**/

	/*function getEventsData (host, event) {
		var data = getIternalData(host, "events") || {};
		if (arguments.length < 2) { return data; }
		//return hasOwn(data, event) ? data[event] : [];
		return event && hasOwn(data, event) ? data[event] : []; // ?
	}*/

	function filterOne (data, key, value) {
		if (!value) { return data; } // virer ou ajouter aussi a filerAll ?
		return grep(data, function (v) { // map ?
			return v[key] === value;
		});
	}

	function filterAll (data, key, value) {
		var bar = {};
		each(data, function (k, v) {
			var foo = filterOne(v, key, value);
			if (foo.length) { bar[k] = foo; } // extend ?
		});
		if ($.isEmptyObject(bar)) { return; }
		return bar;
	}

	function parseEvent (event) {
		//var eventRegex = /^(?:(delegated)!)?([^.]+)?(?:\.([^.]+))?$/; // support de delegated dans 3.1
		event = /^([^.]+)?(?:\.([^.]+))?$/.exec(event);
		if (event[1] || event[2]) {
			return {
				//delegated: !!event[1],
				//name: event[2],
				//namespace: event[3]
				name: event[1],
				namespace: event[2]
			};
		}
	}

	function getEventsData (host, event, handler) {
		var data = getIternalData(host, "events");
		if (!data) { return; }
		if (arguments.length < 2) { return data; }
		var filter = filterAll;

		if (typeof event === "string") {
			event = parseEvent(event);
			if (!event) { return; }
			if (event.name) {
				if (!hasOwn(data, event.name)) { return; }
				data = data[event.name];
				filter = filterOne;
			}
			data = filter(data, "namespace", event.namespace);
		}
		else {
			if (typeof event !== "function") { return; }
			data = filter(data, "handler", event);
			//handler = event;
		}

		if (arguments.length > 2 && typeof handler !== "function") {
			return;
		}

		if (!$.isEmptyObject(data) && typeof handler === "function") {
			data = filter(data, "handler", handler);
		} // si args.length > 2 return + si event pas string

		if (data && $.isEmptyObject(data)) { return; }

		return data;
	}

	//var tests = $.Callbacks("stopOnFalse");
/*	function addTest (tests, property, value) {
		tests.add(function (event) {
			return event[property] === value;
		});
	}*/

	/*function getEventsData (host, event, handler) {
		var eventsData = getIternalData(host, "events") || {};
		if (arguments.length < 2) { return eventsData; }
		var tests = $.Callbacks("stopOnFalse");
		if (arguments.length < 3) {
			if (typeof event === "string") {
				event = /^([^.]+)(?:\.([^.]+))?$/.exec(event);
				var name = event[1];
				var namespace = event[2];
				if (name && !hasOwn(eventsData, name)) { return []; }

			} else {
				handler = event;
			}
		} else {
			handler();
		}
		if (arguments.length > 2 || handler) {
			addTest(tests, "handler", handler);
		}
		return eventsData;
	}*/

	$.getEventsData = getEventsData;

	/**
	todo.
	@method fn.getEventsData
	@category Function
	@param [key] {String} todo.
	@return {todo} todo.
	@example
		$(todo).getEventsData();
	@example
		$(todo).getEventsData(todo);
	**/

	function fnGetEventsData (event/*, handler*/) { // use makeOneOrTwoParams ?
		var data = {};
		var fillData = function (__, host) {
			each(getEventsData(host), function (key, value) {
				if (!data[key]) { data[key] = []; }
				merge(data[key], value);
			});
		};
		if (arguments.length) {
			data = [];
			fillData = function (__, host) {
				merge(data, getEventsData(host, event));
			};
		}
		each(this, fillData);
		return data;
	}

	$.fn.getEventsData = fnGetEventsData;

	/**
	todo.
	@method hasEventListener
	@category Function
	@uses getEventsData
	@param host {Mixed} todo.
	@param [event] {String} todo.
	@param [handler] {Function} todo.
	@return {Boolean} todo.
	@example
		todo;
	@example
		todo;
	**/

	function hasEventListener (host, event, handler) {
		//return !!getEventsData.apply(this, arguments);
		var eventsData;
		if (arguments.length > 1) {
			event = /^([^.]+)(?:\.([^.]+))?$/.exec(event); // en fait ça doit aller dans getEventsData !
			var name = event[1];
			var namespace = event[2]; //|| ""; // ??
			eventsData = getEventsData(host, name);
			if (namespace) {
				eventsData = grep(eventsData, function (value) {
					return value.namespace === namespace;
				});
			}
			if (handler) {
				eventsData = grep(eventsData, function (value) {
					return value.handler === handler;
				});
			}
		} else {
			eventsData = getEventsData(host);
		}
		//var eventsData = getEventsData.apply(null, arguments);
		return !$.isEmptyObject(eventsData);
	}

	$.hasEventListener = hasEventListener;

	/**
	todo.
	@method fn.hasEventListener
	@category Function
	@uses hasEventListener
	@param [event] {String} todo.
	@param [handler] {Function} todo.
	@return {todo} todo.
	@example
		todo;
	@example
		todo;
	**/

	function fnHasEventListener (/*event, handler*/) { // use oneParameter et twoParameters
		var outterParameters = arguments;
		return grep(this, function (host) {
			var parameters = merge([host], outterParameters);
			return hasEventListener.apply(null, parameters);
		});
	}

	$.fn.hasEventListener = fnHasEventListener;

	/**
	todo.
	@method expr[":"].hasEventListener
	@category Function
	@uses hasEventListener
	@param todo.
	@return {todo} todo.
	@example
		todo;
	@example
		todo;
	**/

	/*var makeArray = $.makeArray;

	function make (callback, rest) {
		rest = makeArray(arguments).slice(1);
		return function () {
			var parameters = makeArray(arguments).concat(rest);
			return callback.apply(this, parameters);
		};
	}*/

	// https://github.com/jquery/sizzle/wiki/Sizzle-Documentation#-backwards-compatible-plugins-for-pseudos-with-arguments
	var exprHasEventListener = (function (pseudo) {
		try { return $.expr.createPseudo(pseudo); }
		catch (error) {
			return function (host, __, match) {
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

	// todo.
	return $;
}));
