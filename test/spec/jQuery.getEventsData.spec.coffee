describe "jQuery.getEventsData", ->
	expect = chai.expect
	method = jQuery.getEventsData

	it "should be a function", ->
		expect(method).to.be.a "function"
	# method()
	it "should throw an error if `host` isn't valid", ->
		expect(method).to.throw()
