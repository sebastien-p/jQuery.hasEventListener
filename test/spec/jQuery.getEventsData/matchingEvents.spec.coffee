describe "jQuery.getEventsData - `host` has some matching events attached", ->
	expect = chai.expect
	method = jQuery.getEventsData
	setupHosts = method.setupHosts
	forEachHost = method.Host.forEachHost
	forAll = method.Host.forAll

	beforeEach -> @hosts = setupHosts().someEvents

	describe "get a data object", ->

		# method(host)
		describe "`host` is the only passed parameter", ->
			it "should return an object", ->
				forEachHost @hosts, (host) ->
					expect(method host).to.be.a "object"
			it "should only contain data related to the attached events", ->
				forEachHost @hosts, (host) ->
					expect(method host).to.have.keys host.names # forAll "names" ? en fait non, plutot host._names mais publique ?

		# method(host, handler)
		describe "the second parameter is a function", ->
			it "should return an object", ->
				forAll @hosts, "handlers", (host, handler) ->
					expect(method host, handler).to.be.a "object"
			it "should only contain data related to the attached events", ->
				forAll @hosts, "handlers", (host, handler, names) ->
					expect(method host, handler).to.have.keys names

		describe "`event` is a namespace", ->
			beforeEach -> @hosts = @hosts.someNamespaced

			# method(host, ".namespace")
			describe "`event` is the only passed parameter", ->
				it "should return an object", ->
					forAll @hosts, "namespaces", (host, namespace) ->
						expect(method host, namespace).to.be.a "object"
				it "should only contain data related to the attached events", ->
					forAll @hosts, "namespaces", (host, namespace, names) ->
						expect(method host, namespace).to.have.keys names

			# method(host, ".namespace", handler)
			describe "`event` and `handler` are both passed", ->
				it "should return an object", ->
					#forEachHost @hosts, (host) ->
					#	host.forAll "namespaces", (namespace) ->
					#		host.forAll "handlers", (handler) ->
					#			expect(method host, namespace, handler).to.be.a "object"
				it "should only contain data related to the attached events", ->

	describe "get a data array", ->

		describe "`event` is the only passed parameter", ->

			# method(host, "name")
			describe "`event` is a name", ->
				it "should return an array", ->
					forEachHost @hosts, (host) ->
						host.forAllNames (name) ->
							expect(method host, name).to.be.a "array"
				it "should only contain data related to the attached events", ->
					forEachHost @hosts, (host) ->
						host.forAllNames (name, length) ->
							expect(method host, name).to.have.length length
				it "should return the same array accessible via data objects", ->
					forEachHost @hosts, (host) ->
						host.forAllNames (name) ->
							expect(method host, name).to.equal method(host)[name]

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


