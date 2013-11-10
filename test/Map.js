/*jshint jquery:true */

(function ($, exports) {
	function Map () {
		if (!(this instanceof Map)) { return new Map(); }
		this._keys = [];
		this._values = [];
	}

	function indexOf (array, value) {
		return $.inArray(value, array);
	}

	function push (array, value) {
		return array.push(value) - 1;
	}

	function uniquePush (array, value) {
		var index = indexOf(array, value);
		if (index < 0) { index = push(array, value); }
		return index;
	}

	Map.prototype.set = function (key, value) {
		if (arguments.length < 2) { return; }
		var index = uniquePush(this._keys, key);
		this._values[index] = value;
	};

	Map.prototype.get = function (key) {
		var index = indexOf(this._keys, key);
		return this._values[index];
	};

	Map.prototype.keys = function () {
		return this._keys.slice();
	};

	exports.Map = Map;
}(jQuery, jQuery.getEventsData));
