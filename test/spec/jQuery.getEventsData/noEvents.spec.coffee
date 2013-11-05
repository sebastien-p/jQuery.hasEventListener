describe "jQuery.getEventsData - `host` has no events attached", ->
	expect = chai.expect
	method = jQuery.getEventsData
	setupHosts = method.setupHosts
	notValid = undefined
	handler0 = ->

	beforeEach -> @host = setupHosts().noEvents

	# method(host)
	it "should return `undefined` if `host` is the only passed parameter", ->
		expect(method @host).to.be.undefined

	describe "two parameters passed", ->
		# method(host, notValid)
		it "should return `undefined` if the second parameter isn't valid", ->
			expect(method @host, notValid).to.be.undefined

		describe "the second parameter is a string or a function", ->
			# method(host, handler0)
			it "should return `undefined` if it's a function", ->
				expect(method @host, handler0).to.be.undefined

			describe "the second parameter is a string", ->
				# method(host, "")
				it "should return `undefined` if it's not a valid string", ->
					expect(method @host, "").to.be.undefined
				# method(host, ".namspace0")
				it "should return `undefined` if it contains a namespace", ->
					expect(method @host, ".namespace0").to.be.undefined
				# method(host, "name0")
				it "should return `undefined` if it contains a name", ->
					expect(method @host, "name0").to.be.undefined
				# method(host, "name0.namespace0")
				it "should return `undefined` if it contains a namespaced name", ->
					expect(method @host, "name0.namespace0").to.be.undefined

	describe "three parameters passed", ->

		describe "`event` isn't a string", ->
			# method(host, notValid, notValid)
			it "should return `undefined` if `handler` isn't a function", ->
				expect(method @host, notValid, notValid).to.be.undefined
			# method(host, notValid, handler0)
			it "should return `undefined` if `handler` is a function", ->
				expect(method @host, notValid, handler0).to.be.undefined

		describe "`event` is a string", ->

			describe "`handler` isn't a function", ->
				# method(host, "", notValid)
				it "should return `undefined` if it's not a valid string", ->
					expect(method @host, "", notValid).to.be.undefined
				# method(host, ".namespace0", notValid)
				it "should return `undefined` if it contains a namespace", ->
					expect(method @host, ".namespace0", notValid).to.be.undefined
				# method(host, "name0", notValid)
				it "should return `undefined` if it contains a name", ->
					expect(method @host, "name0", notValid).to.be.undefined
				# method(host, "name0.namespace0", notValid)
				it "should return `undefined` if it contains a namespaced name", ->
					expect(method @host, "name0.namespace0", notValid).to.be.undefined

			describe "`handler` is a function", ->
				# method(host, "", handler0)
				it "should return `undefined` if it's not a valid string", ->
					expect(method @host, "", handler0).to.be.undefined
				# method(host, ".namespace0", handler0)
				it "should return `undefined` if it contains a namespace", ->
					expect(method @host, ".namespace0", handler0).to.be.undefined
				# method(host, "name0", handler0)
				it "should return `undefined` if it contains a name", ->
					expect(method @host, "name0", handler0).to.be.undefined
				# method(host, "name0.namespace0", handler0)
				it "should return `undefined` if it contains a namespaced name", ->
					expect(method @host, "name0.namespace0", handler0).to.be.undefined
