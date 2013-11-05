describe "jQuery.expr[\":\"].hasEventListener", ->
	expect = chai.expect
	$ = jQuery

	it "should be a function", ->
		expect($.expr[":"].hasEventListener).to.be.a "function"

