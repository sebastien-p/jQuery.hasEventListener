describe "jQuery.fn.hasEventListener", ->
	expect = chai.expect
	$ = jQuery

	# should not use $.hasEventListener

	it "should be a function", ->
		expect($.fn.hasEventListener).to.be.a "function"
