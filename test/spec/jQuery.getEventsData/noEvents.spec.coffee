describe "jQuery.getEventsData - `host` has no events attached", ->
	expect = chai.expect
	getEventsData = jQuery.getEventsData
	setupHosts = getEventsData.setupHosts
	notValid = undefined
	handler0 = ->

	beforeEach -> @host = setupHosts().noEvents

	# getEventsData(host)
	it "should return `undefined` if `host` is the only passed parameter", ->
		expect(getEventsData @host).to.be.undefined

	describe "two parameters passed", ->
		# getEventsData(host, notValid)
		it "should return `undefined` if the second parameter isn't valid", ->
			expect(getEventsData @host, notValid).to.be.undefined

		describe "the second parameter is a string or a function", ->
			# getEventsData(host, handler0)
			it "should return `undefined` if it's a function", ->
				expect(getEventsData @host, handler0).to.be.undefined

			describe "the second parameter is a string", ->
				# getEventsData(host, "")
				it "should return `undefined` if it's not a valid string", ->
					expect(getEventsData @host, "").to.be.undefined
				# getEventsData(host, ".namspace0")
				it "should return `undefined` if it contains a namespace", ->
					expect(getEventsData @host, ".namespace0").to.be.undefined
				# getEventsData(host, "name0")
				it "should return `undefined` if it contains a name", ->
					expect(getEventsData @host, "name0").to.be.undefined
				# getEventsData(host, "name0.namespace0")
				it "should return `undefined` if it contains a namespaced name", ->
					expect(getEventsData @host, "name0.namespace0").to.be.undefined

	describe "three parameters passed", ->

		describe "`event` isn't a string", ->
			# getEventsData(host, notValid, notValid)
			it "should return `undefined` if `handler` isn't a function", ->
				expect(getEventsData @host, notValid, notValid).to.be.undefined
			# getEventsData(host, notValid, handler0)
			it "should return `undefined` if `handler` is a function", ->
				expect(getEventsData @host, notValid, handler0).to.be.undefined

		describe "`event` is a string", ->

			describe "`handler` isn't a function", ->
				# getEventsData(host, "", notValid)
				it "should return `undefined` if it's not a valid string", ->
					expect(getEventsData @host, "", notValid).to.be.undefined
				# getEventsData(host, ".namespace0", notValid)
				it "should return `undefined` if it contains a namespace", ->
					expect(getEventsData @host, ".namespace0", notValid).to.be.undefined
				# getEventsData(host, "name0", notValid)
				it "should return `undefined` if it contains a name", ->
					expect(getEventsData @host, "name0", notValid).to.be.undefined
				# getEventsData(host, "name0.namespace0", notValid)
				it "should return `undefined` if it contains a namespaced name", ->
					expect(getEventsData @host, "name0.namespace0", notValid).to.be.undefined

			describe "`handler` is a function", ->
				# getEventsData(host, "", handler0)
				it "should return `undefined` if it's not a valid string", ->
					expect(getEventsData @host, "", handler0).to.be.undefined
				# getEventsData(host, ".namespace0", handler0)
				it "should return `undefined` if it contains a namespace", ->
					expect(getEventsData @host, ".namespace0", handler0).to.be.undefined
				# getEventsData(host, "name0", handler0)
				it "should return `undefined` if it contains a name", ->
					expect(getEventsData @host, "name0", handler0).to.be.undefined
				# getEventsData(host, "name0.namespace0", handler0)
				it "should return `undefined` if it contains a namespaced name", ->
					expect(getEventsData @host, "name0.namespace0", handler0).to.be.undefined
