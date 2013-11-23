describe "jQuery.getEventsData", ->
	expect = chai.expect
	getEventsData = jQuery.getEventsData

	it "should be a function", ->
		expect(getEventsData).to.be.a "function"
	# getEventsData()
	it "should throw an error if `host` isn't valid", ->
		expect(getEventsData).to.throw()
