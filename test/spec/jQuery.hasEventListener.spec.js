/*jshint jquery:true, expr:true */
/*global chai, describe, it */

describe("jQuery.hasEventListener", function () {
	var expect = chai.expect;
	var $ = jQuery;
	var hasEventListener = $.hasEventListener;

	it("should be a function", function () {
		expect(hasEventListener).to.be.a("function");
	});

	it("should throw an error if the first arguments isn't valid", function () {
		expect(hasEventListener).to.throw();
	});

	it("should return false if the given host has no events attached", function () {
		expect(hasEventListener({})).to.be.false; // grouper
	});

	it("should return false if the given host has no events of the given type attached", function () {
		var host = {}; // grouper
		expect(hasEventListener({}, "event")).to.be.false;
		$(host).on("event1", $.noop);
		expect(hasEventListener(host, "event2")).to.be.false;
	});

	it("should return false if the given host has no namespaced events of the given type attached", function () {
		var host = {}; // grouper
		expect(hasEventListener(host, "event.namespace")).to.be.false;
		$(host).on("event", $.noop);
		expect(hasEventListener(host, "event.namespace")).to.be.false;
		$(host).on("event.namespace1", $.noop);
		expect(hasEventListener(host, "event.namespace2")).to.be.false;
	});

	it("should return true if the given host has some events of the given type attached", function () {
		var host = {}; // grouper
		$(host).on("event", $.noop);
		expect(hasEventListener(host, "event")).to.be.true;
	});

	it("should return true if the given host has some namespaced events of the given type attached", function () {
		var host = {}; // grouper
		$(host).on("event.namespace", $.noop);
		expect(hasEventListener(host, "event.namespace")).to.be.true;
	});

	it("should return true if the given host has some events for a given handler attached", function () {
		var host = {}; // grouper + rajouter le not !
		$(host).on("event", $.noop);
		//expect(hasEventListener(host, $.noop)).to.be.true;
		expect(hasEventListener(host, "event", $.noop)).to.be.true;
		$(host).on("event.namespace", $.noop);
		expect(hasEventListener(host, "event.namespace", $.noop)).to.be.true;
	});
});
