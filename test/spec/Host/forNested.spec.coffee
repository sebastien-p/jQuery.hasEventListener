describe "Host.forNested", ->
	expect = chai.expect
	spy = sinon.spy
	array = sinon.match.array
	func = sinon.match.func
	host = sinon.match.instanceOf jQuery.getEventsData.Host
	string = sinon.match.string
	setupHosts = jQuery.getEventsData.setupHosts
	forNested = jQuery.getEventsData.Host.forNested

	beforeEach ->
		@hosts = setupHosts()
		@spy = spy()

	it "shouldn't call the callback if no events attached", ->
		@hosts = @hosts.noEvents
		forNested @hosts, "names", @spy
		forNested @hosts, "namespaces", @spy
		forNested @hosts, "handlers", @spy
		forNested @hosts, "names.namespaces", @spy
		forNested @hosts, "names.handlers", @spy
		forNested @hosts, "names.data", @spy
		forNested @hosts, "namespaces.names", @spy
		forNested @hosts, "namespaces.handlers", @spy
		forNested @hosts, "handlers.names", @spy
		forNested @hosts, "handlers.namespaces", @spy
		forNested @hosts, "names.namespaces.handlers", @spy
		forNested @hosts, "names.handlers.namespaces", @spy
		forNested @hosts, "names.namespaces.data", @spy
		forNested @hosts, "names.handlers.data", @spy
		forNested @hosts, "namespaces.names.handlers", @spy
		forNested @hosts, "namespaces.handlers.names", @spy
		forNested @hosts, "handlers.names.namespaces", @spy
		forNested @hosts, "handlers.namespaces.names", @spy
		forNested @hosts, "names.namespaces.handlers.data", @spy
		forNested @hosts, "names.handlers.namespaces.data", @spy
		expect(@spy.callCount).to.equal 0

	describe "some events attached", ->
		beforeEach -> @hosts = @hosts.someEvents

		describe "one property passed", ->

			# forNested(hosts, "names", callback)
			describe "property is `\"names\"`", ->
				beforeEach -> forNested @hosts, "names", @spy

				it "should call the callback for each host", ->
					expect(@spy.callCount).to.equal 18
				it "should pass the `Host` instance and event name to each callback call", ->
					expect(@spy.alwaysCalledWithMatch host, array).to.be.true

			# forNested(hosts, "namespaces", callback)
			describe "property is `\"namespaces\"`", ->
				it "shouldn't call the callback if no namespaced events attached", ->
					forNested @hosts.noNamespaced, "namespaces", @spy
					expect(@spy.callCount).to.equal 0

				describe "some namespaced events attached", ->
					beforeEach -> forNested @hosts.someNamespaced, "namespaces", @spy

					it "should call the callback for each host", ->
						expect(@spy.callCount).equal 13
					it "should pass the `Host` instance and event namespace to each callback call", ->
						expect(@spy.alwaysCalledWithMatch host, array).to.be.true

			# forNested(hosts, "handlers", callback)
			describe "property is `\"handlers\"`", ->
				beforeEach -> forNested @hosts, "handlers", @spy

				it "should call the callback for each host", ->
					expect(@spy.callCount).to.equal 18
				it "should pass the `Host` instance and event handler to each callback call", ->
					expect(@spy.alwaysCalledWithMatch host, array).to.be.true

		describe "two properties passed", ->

			# forNested(hosts, "names.handlers", callback)
			describe "`properties` are `\"names.handlers\"`", ->
				beforeEach -> forNested @hosts, "names.handlers", @spy

				it "should call the callback for each event name attached to each host", ->
					expect(@spy.callCount).to.equal 26
				it "should pass the `Host` instance, event name and handlers to each callback call", ->
					expect(@spy.alwaysCalledWithMatch host, string, array).to.be.true

			# forNested(hosts, "names.data", callback)
			describe "`properties` are `\"names.data\"`", ->
				beforeEach -> forNested @hosts, "names.data", @spy

				it "should call the callback for each event name attached to each host", ->
					expect(@spy.callCount).to.equal 26
				it "should pass the `Host` instance, event name and data to each callback call", ->
					expect(@spy.alwaysCalledWithMatch host, string, array).to.be.true

			# forNested(hosts, "handlers.names", callback)
			describe "`properties` are `\"handlers.names\"`", ->
				beforeEach -> forNested @hosts, "handlers.names", @spy

				it "should call the callback for each event handler attached to each host", ->
					expect(@spy.callCount).to.equal 26
				it "should pass the `Host` instance, event handler and data to each callback call", ->
					expect(@spy.alwaysCalledWithMatch host, func, array).to.be.true

			describe "one of the passed `properties` is `\"namespaces\"`", ->
				it "shouldn't call the callback if no namespaced events attached", ->
					@hosts = @hosts.noNamespaced
					forNested @hosts, "names.namespaces", @spy
					forNested @hosts, "namespaces.names", @spy
					forNested @hosts, "handlers.namespaces", @spy
					forNested @hosts, "namespaces.handlers", @spy
					expect(@spy.callCount).to.equal 0

				describe "some namespaces evens attached", ->
					beforeEach -> @hosts = @hosts.someNamespaced

					# forNested(hosts, "names.namespaces", callback)
					describe "`properties` are `\"names.namespaces\"`", ->
						beforeEach -> forNested @hosts, "names.namespaces", @spy

						it "should call the callback for each event name attached to each host", ->
							expect(@spy.callCount).to.equal 17
						it "should pass the `Host` instance, event name and namespaces to each callback call", ->
							expect(@spy.alwaysCalledWithMatch host, string, array).to.be.true

					# forNested(hosts, "namespaces.names", callback)
					describe "`properties` are `\"namespaces.names\"`", ->
						beforeEach -> forNested @hosts, "namespaces.names", @spy

						it "should call the callback for each event namespace attached to each host", ->
							expect(@spy.callCount).to.equal 17
						it "should pass the `Host` instance, event namespace and names to each callback call", ->
							expect(@spy.alwaysCalledWithMatch host, string, array).to.be.true

					# forNested(hosts, "namespaces.handlers", callback)
					describe "`properties` are `\"namespaces.handlers\"`", ->
						beforeEach -> forNested @hosts, "namespaces.handlers", @spy

						it "should call the callback for each event namespace attached to each host", ->
							expect(@spy.callCount).to.equal 17
						it "should pass the `Host` instance, event namespace and handlers to each callback call", ->
							expect(@spy.alwaysCalledWithMatch host, string, array).to.be.true

					# forNested(hosts, "handlers.namespaces", callback)
					describe "`properties` are `\"handlers.namespaces\"`", ->
						beforeEach -> forNested @hosts, "handlers.namespaces", @spy

						it "should call the callback for each event handler attached to each host", ->
							expect(@spy.callCount).to.equal 17
						it "should pass the `Host` instance, event handler and namespaces to each callback call", ->
							expect(@spy.alwaysCalledWithMatch host, func, array).to.be.true

		describe "three properties passed", ->
			it "shouldn't call the callback if no namespaced events attached", ->
				@hosts = @hosts.noNamespaced
				forNested @hosts, "names.namespaces.handlers", @spy
				forNested @hosts, "names.namespaces.data", @spy
				forNested @hosts, "names.handlers.namespaces", @spy
				forNested @hosts, "namespaces.names.handlers", @spy
				forNested @hosts, "namespaces.handlers.names", @spy
				forNested @hosts, "handlers.names.namespaces", @spy
				forNested @hosts, "handlers.namespaces.names", @spy
				expect(@spy.callCount).to.equal 0

			# forNested(hosts, "names.handlers.data", callback)
			describe "`properties` are `\"names.handlers.data\"`", ->
				beforeEach -> forNested @hosts, "names.handlers.data", @spy

				it "should call the callback for each event name and handler attached to each host", ->
					expect(@spy.callCount).to.equal 30
				it "should pass the `Host` instance, event name, handler and data to each callback call", ->
					expect(@spy.alwaysCalledWithMatch host, string, func, array).to.be.true

			describe "some namespaced events attached", ->
				beforeEach -> @hosts = @hosts.someNamespaced

				# forNested(hosts, "names.namespaces.handlers", callback)
				describe "`properties` are `\"names.namespaces.handlers\"`", ->
					beforeEach -> forNested @hosts, "names.namespaces.handlers", @spy

					it "should call the callback for each event name and namespace attached to each host", ->
						expect(@spy.callCount).to.equal 19
					it "should pass the `Host` instance, event name, namespace and handlers to each callback call", ->
						expect(@spy.alwaysCalledWithMatch host, string, string, array).to.be.true

				# forNested(hosts, "names.handlers.namespaces", callback)
				describe "`properties` are `\"names.handlers.namespaces\"`", ->
					beforeEach -> forNested @hosts, "names.handlers.namespaces", @spy

					it "should call the callback for each event name and handler attached to each host", ->
						expect(@spy.callCount).to.equal 19
					it "should pass the `Host` instance, event name, handler and namespaces to each callback call", ->
						expect(@spy.alwaysCalledWithMatch host, string, func, array).to.be.true

				# forNested(hosts, "names.namespaces.data", callback)
				describe "`properties` are `\"names.namespaces.data\"`", ->
					beforeEach -> forNested @hosts, "names.namespaces.data", @spy

					it "should call the callback for each event name and namespace attached to each host", ->
						expect(@spy.callCount).to.equal 19
					it "should pass the `Host` instance, event name, namespace and data to each callback call", ->
						expect(@spy.alwaysCalledWithMatch host, string, string, array).to.be.true

				# forNested(hosts, "namespaces.names.handlers", callback)
				describe "`properties` are `\"namespaces.names.handlers\"`", ->
					beforeEach -> forNested @hosts, "namespaces.names.handlers", @spy

					it "should call the callback for each event namespace and name attached to each host", ->
						expect(@spy.callCount).to.equal 19
					it "should pass the `Host` instance, event namespace, name and handlers to each callback call", ->
						expect(@spy.alwaysCalledWithMatch host, string, string, array).to.be.true

				# forNested(hosts, "namespaces.handlers.names", callback)
				describe "`properties` are `\"namespaces.handlers.names\"`", ->
					beforeEach -> forNested @hosts, "namespaces.handlers.names", @spy

					it "should call the callback for each event namespace and handler attached to each host", ->
						expect(@spy.callCount).to.equal 19
					it "should pass the `Host` instance, event namespace, handler and names to each callback call", ->
						expect(@spy.alwaysCalledWithMatch host, string, func, array).to.be.true

				# forNested(hosts, "handlers.names.namespaces", callback)
				describe "`properties` are `\"handlers.names.namespaces\"`", ->
					beforeEach -> forNested @hosts, "handlers.names.namespaces", @spy

					it "should call the callback for each event handler and name attached to each host", ->
						expect(@spy.callCount).to.equal 19
					it "should pass the `Host` instance, event handler, name and namespaces to each callback call", ->
						expect(@spy.alwaysCalledWithMatch host, func, string, array).to.be.true

				# forNested(hosts, "handlers.namespaces.names", callback)
				describe "`properties` are `\"handlers.namespaces.names\"`", ->
					beforeEach -> forNested @hosts, "handlers.namespaces.names", @spy

					it "should call the callback for each event handler and namespace attached to each host", ->
						expect(@spy.callCount).to.equal 19
					it "should pass the `Host` instance, event handler, namespace and names to each callback call", ->
						expect(@spy.alwaysCalledWithMatch host, func, string, array).to.be.true

		describe "four properties passed", ->
			it "shouldn't call the callback if no namespaced events attached", ->
				@hosts = @hosts.noNamespaced
				forNested @hosts, "names.namespaces.handlers.data", @spy
				forNested @hosts, "names.handlers.namespaces.data", @spy
				expect(@spy.callCount).to.equal 0

			describe "some namespaced events attached", ->
				beforeEach -> @hosts = @hosts.someNamespaced

				# forNested(hosts, "names.namespaces.handlers.data", callback)
				describe "`properties` are `\"names.namespaces.handlers.data\"`", ->
					beforeEach -> forNested @hosts, "names.namespaces.handlers.data", @spy

					it "should call the callback for each event name, namespace and handler attached to each host", ->
						expect(@spy.callCount).to.equal 20
					it "should pass the `Host` instance, event name, namespace, handler and data to each callback call", ->
						expect(@spy.alwaysCalledWithMatch host, string, string, func, array).to.be.true

				# forNested(hosts, "names.handlers.namespaces.data", callback)
				describe "`properties` are `\"names.handlers.namespaces.data\"`", ->
					beforeEach -> forNested @hosts, "names.handlers.namespaces.data", @spy

					it "should call the callback for each event name, handler and namespace attached to each host", ->
						expect(@spy.callCount).to.equal 20
					it "should pass the `Host` instance, event name, handler, namespace and data to each callback call", ->
						expect(@spy.alwaysCalledWithMatch host, string, func, string, array).to.be.true
