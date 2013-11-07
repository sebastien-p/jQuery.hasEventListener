describe "jQuery.getEventsData - `host` has some matching events attached", ->
	expect = chai.expect
	method = jQuery.getEventsData
	setupHosts = method.setupHosts
	forEach = method.Host.forEach

	beforeEach -> @hosts = setupHosts().someEvents

	describe "get a data object", ->

		# method(host)
		describe "`host` is the only passed parameter", -> # to not equal $._data(host, "events") but to deep equal + should not modify internal data
			it "should return an object", ->
				forEach @hosts, (host) ->
					expect(method host).to.be.an "object"
			it "should only contain data related to the attached events", ->
				forEach @hosts, (host) ->
					expect(method host).to.have.keys host.names # host._names mais publique ?

		# method(host, handler)
		describe "the second parameter is a function", ->
			it "should return an object", ->
				forEach @hosts, "handlers", (host, handler) ->
					expect(method host, handler).to.be.an "object"
			it "should only contain data related to the attached events", ->
				forEach @hosts, "handlers", (host, handler, names) ->
					expect(method host, handler).to.have.keys names

		describe "`event` is a namespace", ->
			beforeEach -> @hosts = @hosts.someNamespaced

			# method(host, ".namespace")
			describe "`event` is the only passed parameter", ->
				it "should return an object", ->
					forEach @hosts, "namespaces", (host, namespace) ->
						expect(method host, namespace).to.be.an "object"
				it "should only contain data related to the attached events", ->
					forEach @hosts, "namespaces", (host, namespace, names) ->
						expect(method host, namespace).to.have.keys names

			# method(host, ".namespace", handler)
			describe "`event` and `handler` are both passed", ->
				it "should return an object", ->
					#forEachHost @hosts, (host) ->
					#	host.forAll "namespaces", (namespace) ->
					#		host.forAll "handlers", (handler) ->
					#			expect(method host, namespace, handler).to.be.an "object"
				it "should only contain data related to the attached events", ->

	describe "get a data array", ->

		describe "`event` is the only passed parameter", ->

			# method(host, "name")
			describe "`event` is a name", ->
				it "should return an array", ->
					forEach @hosts, (host) ->
						host.forAllNames (name) ->
							expect(method host, name).to.be.an "array" # forEach "names"
				it "should only contain data related to the attached events", ->
					forEach @hosts, (host) ->
						host.forAllNames (name, length) ->
							expect(method host, name).to.have.length length # forEach "names"
				it "should return the same array accessible via data objects", ->
					forEach @hosts, (host) ->
						host.forAllNames (name) ->
							expect(method host, name).to.equal method(host)[name] # deep equal, donc to not equal, but to deep equal (objects and arrays!) # forEach "names"

			# method(host, "name.namespace")
			describe "`event` is a namespaced name", ->
				beforeEach -> @hosts = @hosts.someNamespaced

				it "should return an array", ->
				it "should only contain data related to the attached events", ->

		describe "`event` and `handler` are both passed", ->

			# method(host, "name", handler)
			describe "`event` is a name", ->
				it "should return an array", ->
				it "should only contain data related to the attached events", ->
				it "should return the same array accessible via data objects", ->

			# method(host, "name.namespace", handler)
			describe "`event` is a namespaced name", ->
				beforeEach -> @hosts = @hosts.someNamespaced

				it "should return an array", ->
				it "should only contain data related to the attached events", ->


