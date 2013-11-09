describe "Hosts", ->
	expect = chai.expect
	Subject = jQuery.getEventsData.Host

	it "should be a function", ->
		expect(Subject).to.be.a "function"
