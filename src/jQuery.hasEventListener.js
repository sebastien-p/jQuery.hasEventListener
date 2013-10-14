(function (factory) {

	typeof define === "function" && define.amd ?
		define(["jquery"], factory) : factory(jQuery);

}(function ($) {

	$.hasEventListener = true;

}));
