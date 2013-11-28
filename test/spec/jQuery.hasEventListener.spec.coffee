describe "jQuery.hasEventListener", ->
	expect = chai.expect
	hasEventListener = jQuery.hasEventListener

	it "should be a function", ->
		expect(hasEventListener).to.be.a "function"
	# hasEventListener()
	it "should throw an error if `host` isn't valid", ->
		expect(hasEventListener).to.throw()
