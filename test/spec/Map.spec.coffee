describe "Map", ->
	expect = chai.expect
	Map = jQuery.getEventsData.Map

	beforeEach -> @map = new Map()

	it "should be a function", ->
		expect(Map).to.be.a "function"

	describe "`set` method", ->
		it "should have a `set` method", ->
			expect(@map).to.respondTo "set"
		it "should return `undefined` if no key/value are passed", ->
			expect(@map.set()).to.be.undefined
			expect(@map.set "key1").to.be.undefined
		it "should return the passed value", ->
			expect(@map.set "key1", "value1").to.equal "value1"
			expect(@map.set "key2", "value1").to.equal "value1"
			expect(@map.set "key2", @map).to.equal @map

	describe "`get` method", ->
		it "should have a `get` method", ->
			expect(@map).to.respondTo "get"
		it "should return `undefined` when the map is empty", ->
			expect(@map.get()).to.be.undefined
			expect(@map.get "key1").to.be.undefined

		describe "the map isn't empty", ->
			beforeEach -> @map.set "key1", "value1"

			it "should return `undefined` when no keys are passed", ->
				expect(@map.get()).to.be.undefined
			it "should return `undefined` when a non existing key is passed", ->
				expect(@map.get "key2").to.be.undefined
			it "should return the value associated to a given key", ->
				expect(@map.get "key1").to.equal "value1"
				@map.set "key1", "value2"
				expect(@map.get "key1").to.equal "value2"
				@map.set "key2"
				expect(@map.get "key2").to.be.undefined
				@map.set Map, Map
				expect(@map.get Map).to.equal Map

	describe "`keys` method", ->
		it "should have a `keys` method", ->
			expect(@map).to.respondTo "keys"
		it "should return an empty array when the map is empty", ->
			@map.set()
			@map.set "key1"
			expect(@map.keys()).to.be.an("array").that.is.empty

		describe "the map isn't empty", ->
			beforeEach -> @map.set "key1", "value1"

			it "should return an array containing the added keys", ->
				expect(@map.keys()).to.be.an("array").that.eql ["key1"]
				@map.set Map, Map
				expect(@map.keys()).to.eql ["key1", Map]
			it "should return a cloned array", ->
				@map.keys().push "IShouldNotBeInHere"
				expect(@map.keys()).not.to.contain "IShouldNotBeInHere"

