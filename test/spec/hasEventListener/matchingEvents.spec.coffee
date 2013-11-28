describe "jQuery.hasEventListener - `host` has some matching events attached", ->
	expect = chai.expect
	hasEventListener = jQuery.hasEventListener
	setupHosts = jQuery.getEventsData.setupHosts
	forNested = jQuery.getEventsData.Host.forNested

	beforeEach -> @hosts = setupHosts().someEvents

	# hasEventListener(host)
	it "should return `true` if `host` is the only passed parameter", ->
		forNested @hosts, "names", (host) ->
			expect(hasEventListener host).to.be.true

	describe "two parameters passed", ->
		# hasEventListener(host, handler)
		it "should return `true` if the second parameter is a function", ->
			forNested @hosts, "handlers.names", (host, handler) ->
				expect(hasEventListener host, handler).to.be.true
		# hasEventListener(host, "name")
		it "should return `true` if `event` is a name", ->
			forNested @hosts, "names.handlers", (host, name) ->
				expect(hasEventListener host, name).to.be.true

		describe "`event` contains a namespace", ->
			beforeEach -> @hosts = @hosts.someNamespaced

			# hasEventListener(host, ".namespace")
			it "should return `true` if `event` is a namespace", ->
				forNested @hosts, "namespaces.names", (host, namespace) ->
					expect(hasEventListener host, namespace).to.be.true
			# hasEventListener(host, "name.namespace")
			it "should return `true` if `event` is a namespaced name", ->
				forNested @hosts, "names.namespaces.data", (host, name, namespace) ->
					expect(hasEventListener host, name+namespace).to.be.true

	describe "three parameters passed", ->
		it "should return `true` if `event` is a name", ->
			forNested @hosts, "names.handlers.data", (host, name, handler) ->
				expect(hasEventListener host, name, handler).to.be.true

		describe "`event` contains a namespace", ->
			beforeEach -> @hosts = @hosts.someNamespaced

			# hasEventListener(host, ".namespace", handler)
			it "should return `true` if `event` is a namespace", ->
				forNested @hosts, "namespaces.handlers.names", (host, namespace, handler) ->
					expect(hasEventListener host, namespace, handler).to.be.true
			# hasEventListener(host, "name.namespace", handler)
			it "should return `true` if `event` is a namespaced name", ->
				forNested @hosts, "names.namespaces.handlers.data", (host, name, namespace, handler) ->
					expect(hasEventListener host, name+namespace, handler).to.be.true
