/**

todo.

@module jQuery.hasEventListener
@author fingerproof

@class jQuery
@static

**/

(function (factory) {
	typeof define === "function" && define.amd ?
		define(["jquery"], factory) : factory(jQuery);
}(function ($) {

	var each = $.each;
	var filter = $.grep;
	var extend = $.extend;
	var getIternalData = $._data;
	var isEmpty = $.isEmptyObject;

	/**

	todo.

	@method hasOwnProperty
	@category Function

	@param todo.

	@return {Boolean} todo.

	@example
		todo;
	@example
		todo;

	**/

	var owns = {}.hasOwnProperty;
	$.hasOwnProperty = owns = $.proxy(owns.call, owns); // et enumerable ?

	/**

	todo.

	@method getEventsData
	@category Function

	@uses hasOwnProperty

	@param host {Mixed} todo.
	@param [key] {String} todo.

	@return {Mixed} todo.

	@example
		jQuery.getEventsData(todo);
	@example
		jQuery.getEventsData(todo, todo);

	**/

	function getEventsData (host, key) {
		var data = getIternalData(host, "events");
		//if (arguments.length < 2) { return data; }
		if (!key) { return data; } // cf fnGetEventsData !
		if (data && owns(data, key)) { return data[key]; }
	}

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

	function fnGetEventsData (key) {
		var data = {};
		each(this, function (index, host) {
			extend(true, data, getEventsData(host, key));
		});
		if (!isEmpty(data)) { return data; }
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
		//
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

	function fnHasEventListener (event, handler) {
		return filter(this, function (host) {
			return hasEventListener(host, event, handler);
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

	function exprHasEventListener (host, index, match) {
		return hasEventListener(host, match[3]);
	}

	$.expr[":"].hasEventListener = exprHasEventListener;

	/**

	todo.

	**/

	return $;
}));
