/*jshint jquery:true */
/*global chai, describe, it */

describe("todo", function () {
	var expect = chai.expect;

	it("should be a function", function () {
		expect($.hasEventListener).to.be.a("function");
	});
});
