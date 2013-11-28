describe "jQuery.getEventsData - `host` has some matching events attached", ->
	expect = chai.expect
	getEventsData = jQuery.getEventsData
	setupHosts = getEventsData.setupHosts
	forNested = getEventsData.Host.forNested
	extend = jQuery.extend

	beforeEach -> @hosts = setupHosts().someEvents

	describe "get a data object", ->

		# getEventsData(host)
		describe "`host` is the only passed parameter", ->
			it "should return an object", ->
				forNested @hosts, "names", (host) ->
					expect(getEventsData host).to.be.an "object"
			it "should return a cloned object", ->
				forNested @hosts, "names", (host) ->
					eventsData = extend getEventsData(host), { IShouldNotBeInHere: true }
					expect(getEventsData host).not.to.deep.equal eventsData
			it "should only contain data related to the attached events", ->
				forNested @hosts, "names", (host, names) ->
					expect(getEventsData host).to.have.keys names

		# getEventsData(host, handler)
		describe "the second parameter is a function", ->
			it "should return an object", ->
				forNested @hosts, "handlers.names", (host, handler) ->
					expect(getEventsData host, handler).to.be.an "object"
			it "should return a cloned object", ->
				forNested @hosts, "handlers.names", (host, handler) ->
					eventsData = extend getEventsData(host, handler), { IShouldNotBeInHere: true }
					expect(getEventsData host, handler).not.to.deep.equal eventsData
			it "should only contain data related to the attached events", ->
				forNested @hosts, "handlers.names", (host, handler, names) ->
					expect(getEventsData host, handler).to.have.keys names

		describe "`event` is a namespace", ->
			beforeEach -> @hosts = @hosts.someNamespaced

			# getEventsData(host, ".namespace")
			describe "`event` is the only passed parameter", ->
				it "should return an object", ->
					forNested @hosts, "namespaces.names", (host, namespace) ->
						expect(getEventsData host, namespace).to.be.an "object"
				it "should return a cloned object", ->
					forNested @hosts, "namespaces.names", (host, namespace) ->
						eventsData = extend getEventsData(host, namespace), { IShouldNotBeInHere: true }
						expect(getEventsData host, namespace).not.to.deep.equal eventsData
				it "should only contain data related to the attached events", ->
					forNested @hosts, "namespaces.names", (host, namespace, names) ->
						expect(getEventsData host, namespace).to.have.keys names

			# getEventsData(host, ".namespace", handler)
			describe "`event` and `handler` are both passed", ->
				it "should return an object", ->
					forNested @hosts, "namespaces.handlers.names", (host, namespace, handler) ->
						expect(getEventsData host, namespace, handler).to.be.an "object"
				it "should return a cloned object", ->
					forNested @hosts, "namespaces.handlers.names", (host, namespace, handler) ->
						eventsData = extend getEventsData(host, namespace, handler), { IShouldNotBeInHere: true }
						expect(getEventsData host, namespace, handler).not.to.deep.equal eventsData
				it "should only contain data related to the attached events", ->
					forNested @hosts, "namespaces.handlers.names", (host, namespace, handler, names) ->
						expect(getEventsData host, namespace, handler).to.have.keys names

	describe "get a data array", ->

		describe "`event` is the only passed parameter", ->

			# getEventsData(host, "name")
			describe "`event` is a name", ->
				it "should return an array", ->
					forNested @hosts, "names.handlers", (host, name) ->
						expect(getEventsData host, name).to.be.an "array"
				it "should return a cloned array", ->
					forNested @hosts, "names.handlers", (host, name) ->
						getEventsData(host, name).push "IShouldNotBeInHere"
						expect(getEventsData host, name).not.to.contain "IShouldNotBeInHere"
				it "should return the same array accessible via data objects", ->
					forNested @hosts, "names.handlers", (host, name) ->
						expect(getEventsData host, name).to.deep.equal getEventsData(host)[name]
				it "should only contain data related to the attached events", ->
					forNested @hosts, "names.data", (host, name, data) ->
						expect(getEventsData host, name).to.have.length data.length

			# getEventsData(host, "name.namespace")
			describe "`event` is a namespaced name", ->
				beforeEach -> @hosts = @hosts.someNamespaced

				it "should return an array", ->
					forNested @hosts, "names.namespaces.data", (host, name, namespace) ->
						expect(getEventsData host, name+namespace).to.be.an "array"
				it "should return a cloned array", ->
					forNested @hosts, "names.namespaces.data", (host, name, namespace) ->
						getEventsData(host, name+namespace).push "IShouldNotBeInHere"
						expect(getEventsData host, name+namespace).not.to.contain "IShouldNotBeInHere"
				it "should return the same array accessible via data objects", ->
					forNested @hosts, "names.namespaces.data", (host, name, namespace) ->
						expect(getEventsData host, name+namespace).to.deep.equal getEventsData(host, namespace)[name]
				it "should only contain data related to the attached events", ->
					forNested @hosts, "names.namespaces.data", (host, name, namespace, data) ->
						expect(getEventsData host, name+namespace).to.have.length data.length

		describe "`event` and `handler` are both passed", ->

			# getEventsData(host, "name", handler)
			describe "`event` is a name", ->
				it "should return an array", ->
					forNested @hosts, "names.handlers.data", (host, name, handler) ->
						expect(getEventsData host, name, handler).to.be.an "array"
				it "should return a cloned array", ->
					forNested @hosts, "names.handlers.data", (host, name, handler) ->
						getEventsData(host, name, handler).push "IShouldNotBeInHere"
						expect(getEventsData host, name, handler).not.to.contain "IShouldNotBeInHere"
				it "should return the same array accessible via data objects", ->
					forNested @hosts, "names.handlers.data", (host, name, handler) ->
						expect(getEventsData host, name, handler).to.deep.equal getEventsData(host, handler)[name]
				it "should only contain data related to the attached events", ->
					forNested @hosts, "names.handlers.data", (host, name, handler, data) ->
						expect(getEventsData host, name, handler).to.have.length data.length

			# getEventsData(host, "name.namespace", handler)
			describe "`event` is a namespaced name", ->
				beforeEach -> @hosts = @hosts.someNamespaced

				it "should return an array", ->
					forNested @hosts, "names.namespaces.handlers.data", (host, name, namespace, handler) ->
						expect(getEventsData host, name+namespace, handler).to.be.an "array"
				it "should return a cloned array", ->
					forNested @hosts, "names.namespaces.handlers.data", (host, name, namespace, handler) ->
						getEventsData(host, name+namespace, handler).push "IShouldNotBeInHere"
						expect(getEventsData host, name+namespace, handler).not.to.contain "IShouldNotBeInHere"
				it "should return the same array accessible via data objects", ->
					forNested @hosts, "names.namespaces.handlers.data", (host, name, namespace, handler) ->
						expect(getEventsData host, name+namespace, handler).to.deep.equal getEventsData(host, namespace, handler)[name]
				it "should only contain data related to the attached events", ->
					forNested @hosts, "names.namespaces.handlers.data", (host, name, namespace, handler, data) ->
						expect(getEventsData host, name+namespace, handler).to.have.length data.length

