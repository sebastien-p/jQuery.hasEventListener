describe.only "jQuery.getEventsData - `host` has some matching events attached", ->
	expect = chai.expect
	method = jQuery.getEventsData
	setupHosts = method.setupHosts
	forEach = method.Host.forNested # rename!
	extend = jQuery.extend

	beforeEach -> @hosts = setupHosts().someEvents

	describe "get a data object", ->

		# method(host)
		describe "`host` is the only passed parameter", ->
			it "should return an object", ->
				forEach @hosts, "names", (host) ->
					expect(method host).to.be.an "object"
			it "should return a cloned object", ->
				forEach @hosts, "names", (host) ->
					eventsData = extend method(host), IShouldNotBeInHere: true
					expect(method host).not.to.deep.equal eventsData
			it "should only contain data related to the attached events", ->
				forEach @hosts, "names", (host, names) ->
					expect(method host).to.have.keys names

		# method(host, handler)
		describe "the second parameter is a function", ->
			it "should return an object", ->
				forEach @hosts, "handlers.names", (host, handler) ->
					expect(method host, handler).to.be.an "object"
			it "should return a cloned object", ->
				forEach @hosts, "handlers.name", (host, handler) ->
					eventsData = extend method(host, handler), IShouldNotBeInHere: true
					expect(method host, handler).not.to.deep.equal eventsData
			it "should only contain data related to the attached events", ->
				forEach @hosts, "handlers.names", (host, handler, names) ->
					expect(method host, handler).to.have.keys names

		describe "`event` is a namespace", ->
			beforeEach -> @hosts = @hosts.someNamespaced

			# method(host, ".namespace")
			describe "`event` is the only passed parameter", ->
				it "should return an object", ->
					forEach @hosts, "namespaces.names", (host, namespace) ->
						expect(method host, namespace).to.be.an "object"
				it "should return a cloned object", ->
					forEach @hosts, "namespaces.names", (host, namespace) ->
						eventsData = extend method(host, namespace), IShouldNotBeInHere: true
						expect(method host, namespace).not.to.deep.equal eventsData
				it "should only contain data related to the attached events", ->
					forEach @hosts, "namespaces.names", (host, namespace, names) ->
						expect(method host, namespace).to.have.keys names

			# method(host, ".namespace", handler)
			describe "`event` and `handler` are both passed", ->
				it "should return an object", ->
					forEach @hosts, "namespaces.handlers.names", (host, namespace, handler) ->
						expect(method host, namespace, handler).to.be.an "object"
				it "should return a cloned object", ->
					forEach @hosts, "namespaces.handlers.names", (host, namespace, handler) ->
						eventsData = extend method(host, namespace, handler), IShouldNotBeInHere: true
						expect(method host, namespace, handler).not.to.deep.equal eventsData
				it "should only contain data related to the attached events", ->
					forEach @hosts, "namespaces.handlers.names", (host, namespace, handler, names) ->
						expect(method host, namespace, handler).to.have.keys names

	describe "get a data array", ->

		describe "`event` is the only passed parameter", ->

			# method(host, "name")
			describe "`event` is a name", ->
				it "should return an array", ->
					forEach @hosts, "names.handlers", (name) ->
						expect(method host, name).to.be.an "array"
				it "should return a cloned array", ->
					forEach @hosts, "names.handlers", (name) ->
						method(host, name).push "IShouldNotBeInHere"
						expect(method host, name).not.to.contain "IShouldNotBeInHere"
				it "should return the same array accessible via data objects", ->
					forEach @hosts, "names.handlers", (name) ->
						expect(method host, name).to.deep.equal method(host, name)[name]
				it "should only contain data related to the attached events", ->
					forEach @hosts, "names.handlers", (name, handlers) ->
						expect(method host, name).to.have.length handlers.length

			# method(host, "name.namespace")
			describe "`event` is a namespaced name", ->
				beforeEach -> @hosts = @hosts.someNamespaced

				it "should return an array", ->
					forEach @hosts, "names.namespaces.handlers", (name, namespace) ->
						expect(method host, name+namespace).to.be.an "array"
				it "should return a cloned array", ->
					forEach @hosts, "names.namespaces.handlers", (name, namespace) ->
						method(host, name+namespace).push "IShouldNotBeInHere"
						expect(method host, name+namespace).not.to.contain "IShouldNotBeInHere"
				it "should return the same array accessible via data objects", ->
					forEach @hosts, "names.namespaces.handlers", (name, namespace) ->
						expect(method host, name+namespace).to.deep.equal method(host, name+namespace)[name]
				it "should only contain data related to the attached events", ->
					forEach @hosts, "names.namespaces.handlers", (name, namespace, handlers) ->
						expect(method host, name+namespace).to.have.length handlers.length

		describe "`event` and `handler` are both passed", ->

			# method(host, "name", handler)
			describe "`event` is a name", ->
				it "should return an array", ->
					forEach @hosts, "names.handlers.namespaces", (name, handler) ->
						expect(method host, name, handler).to.be.an "array"
				it "should return a cloned array", ->
					forEach @hosts, "names.handlers.namespaces", (name, handler) ->
						method(host, name, handler).push "IShouldNotBeInHere"
						expect(method host, name, handler).not.to.contain "IShouldNotBeInHere"
				it "should return the same array accessible via data objects", ->
					forEach @hosts, "names.handlers.namespaces", (name, handler) ->
						expect(method host, name, handler).to.deep.equal method(host, name, handler)[name]
				it "should only contain data related to the attached events", ->
					forEach @hosts, "names.handlers.namespaces", (name, handler, namespaces) ->
						expect(method host, name, handler).to.have.length namespace.length # !!!!! ATTENTION A VERIFIER !!!!!

			# method(host, "name.namespace", handler)
			describe "`event` is a namespaced name", ->
				beforeEach -> @hosts = @hosts.someNamespaced

				it "should return an array", ->
					forEach @hosts, "names.namespaces.handlers.todo", (name, namespace, handler) ->
						expect(method host, name+namespace, handler).to.be.an "array"
				it "should return a cloned array", ->
					forEach @hosts, "names.namespaces.handlers.todo", (name, namespace, handler) ->
						method(host, name+namespace, handler).push "IShouldNotBeInHere"
						expect(method host, name+namespace, handler).not.to.contain "IShouldNotBeInHere"
				it "should return the same array accessible via data objects", ->
					forEach @hosts, "names.namespaces.handlers.todo", (name, namespace, handler) ->
						expect(method host, name+namespace, handler).to.deep.equal method(host, name+namespace, handler)[name]
				it "should only contain data related to the attached events", ->
					forEach @hosts, "names.namespaces.handlers.todo", (name, namespace, handlers, toto) ->
						expect(method host, name+namespace, handler).to.have.length todo.length # !!!!! ATTENTION A VERIFIER !!!!!


