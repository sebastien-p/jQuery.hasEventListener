describe "jQuery.hasEventListener - `host` has no events attached", ->
	expect = chai.expect
	hasEventListener = jQuery.hasEventListener
	setupHosts = jQuery.getEventsData.setupHosts
	notValid = undefined
	handler0 = ->

	beforeEach -> @host = setupHosts().noEvents

	# hasEventListener(host)
	it "should return `false` if `host` is the only passed parameter", ->
		expect(hasEventListener @host).to.be.false

	describe "two parameters passed", ->
		# hasEventListener(host, notValid)
		it "should return `false` if the second parameter isn't valid", ->
			expect(hasEventListener @host, notValid).to.be.false

		describe "the second parameter is a string or a function", ->
			# hasEventListener(host, handler0)
			it "should return `false` if it's a function", ->
				expect(hasEventListener @host, handler0).to.be.false

			describe "the second parameter is a string", ->
				# hasEventListener(host, "")
				it "should return `false` if it's not a valid string", ->
					expect(hasEventListener @host, "").to.be.false
					expect(hasEventListener @host, "..").to.be.false
				# hasEventListener(host, ".namspace0")
				it "should return `false` if it contains a namespace", ->
					expect(hasEventListener @host, ".namespace0").to.be.false
				# hasEventListener(host, "name0")
				it "should return `false` if it contains a name", ->
					expect(hasEventListener @host, "name0").to.be.false
				# hasEventListener(host, "name0.namespace0")
				it "should return `false` if it contains a namespaced name", ->
					expect(hasEventListener @host, "name0.namespace0").to.be.false

	describe "three parameters passed", ->

		describe "`event` isn't a string", ->
			# hasEventListener(host, notValid, notValid)
			it "should return `false` if `handler` isn't a function", ->
				expect(hasEventListener @host, notValid, notValid).to.be.false
			# hasEventListener(host, notValid, handler0)
			it "should return `false` if `handler` is a function", ->
				expect(hasEventListener @host, notValid, handler0).to.be.false

		describe "`event` is a string", ->

			describe "`handler` isn't a function", ->
				# hasEventListener(host, "", notValid)
				it "should return `false` if it's not a valid string", ->
					expect(hasEventListener @host, "", notValid).to.be.false
					expect(hasEventListener @host, "..", notValid).to.be.false
				# hasEventListener(host, ".namespace0", notValid)
				it "should return `false` if it contains a namespace", ->
					expect(hasEventListener @host, ".namespace0", notValid).to.be.false
				# hasEventListener(host, "name0", notValid)
				it "should return `false` if it contains a name", ->
					expect(hasEventListener @host, "name0", notValid).to.be.false
				# hasEventListener(host, "name0.namespace0", notValid)
				it "should return `false` if it contains a namespaced name", ->
					expect(hasEventListener @host, "name0.namespace0", notValid).to.be.false

			describe "`handler` is a function", ->
				# hasEventListener(host, "", handler0)
				it "should return `false` if it's not a valid string", ->
					expect(hasEventListener @host, "", handler0).to.be.false
					expect(hasEventListener @host, "..", handler0).to.be.false
				# hasEventListener(host, ".namespace0", handler0)
				it "should return `false` if it contains a namespace", ->
					expect(hasEventListener @host, ".namespace0", handler0).to.be.false
				# hasEventListener(host, "name0", handler0)
				it "should return `false` if it contains a name", ->
					expect(hasEventListener @host, "name0", handler0).to.be.false
				# hasEventListener(host, "name0.namespace0", handler0)
				it "should return `false` if it contains a namespaced name", ->
					expect(hasEventListener @host, "name0.namespace0", handler0).to.be.false
