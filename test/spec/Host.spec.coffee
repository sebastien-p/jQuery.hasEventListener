describe "Host", ->
	expect = chai.expect
	Host = jQuery.getEventsData.Host

	describe "constructor", ->
		it "should be a function", ->
			expect(Host).to.be.a "function"
		it "shouldn't leak to the global namespace", ->
			expect(Host()).to.be.an.instanceof Host
			expect(Host { "name.namespace": -> }).to.be.an.instanceOf Host

	describe "static methods", ->
		it "should have a `forEach` static method", ->
			expect(Host.forEach).to.be.a "function"
		it "should have a `forNested` static method", ->
			expect(Host.forNested).to.be.a "function"
