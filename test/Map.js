/*jshint jquery:true */

/**
Provides an interface to ease unit testing of `jQuery.hasEventListener`.
@module hasEventListener
@submodule hasEventListener.map
@requires hasEventListener
**/

(function ($, exports) {
	function indexOf (array, value) {
		return $.inArray(value, array);
	}

	function push (array, value) {
		// Return the index of `value` in `array`
		return array.push(value) - 1;
	}

	function uniquePush (array, value) {
		var index = indexOf(array, value);
		if (index < 0) { index = push(array, value); }
		return index;
	}

	/**
	A key/value hash accepting non-string values as keys.
	@namespace jQuery.getEventsData
	@class Map
	@constructor
	@example
		var map = new jQuery.getEventsData.Map();
	**/

	function Map () {
		if (!(this instanceof Map)) { return new Map(); }
		this._keys = [];
		this._values = [];
	}

	exports.Map = Map;

	/**
	Set a value for a given key, creating or modifyng it.
	@private
	@method set
	@param key {Mixed} The key used to refer to the passed `value`.
	@param value {Mixed} Any value.
	@return {Mixed} The passed `value`.
	@example
		map.set("bestYearEver", 1986);
	@example
		map.set(function(){}, true);
	**/

	Map.prototype.set = function (key, value) {
		if (arguments.length < 2) { return; }
		var index = uniquePush(this._keys, key);
		this._values[index] = value;
		return value;
	};

	/**
	Get the value associated to a given key.
	@private
	@method get
	@param key {Mixed} The key used to refer to the value.
	@return {Mixed} The value associated to the passed `key` or `undefined`.
	@example
		map.get("bestYearEver");
	**/

	Map.prototype.get = function (key) {
		var index = indexOf(this._keys, key);
		return this._values[index];
	};

	/**
	Get all the keys in the map.
	@private
	@method keys
	@return {Array} An array containing all the keys in the map.
	@example
		map.keys();
	**/

	Map.prototype.keys = function () {
		return this._keys.slice();
	};
}(jQuery, jQuery.getEventsData));
