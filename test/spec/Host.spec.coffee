describe "Host", ->
	expect = chai.expect
	spy = sinon.spy
	Host = jQuery.getEventsData.Host
	array = sinon.match.array
	func = sinon.match.func
	host = sinon.match.instanceOf Host
	string = sinon.match.string
	setupHosts = jQuery.getEventsData.setupHosts
	forEach = Host.forEach
	forNested = Host.forNested

	describe "constructor", ->
		it "should be a function", ->
			expect(Host).to.be.a "function"
		it "shouldn't leak to the global namespace", ->
			expect(Host()).to.be.an.instanceof Host
			expect(Host { "name.namespace": -> }).to.be.an.instanceOf Host

	describe "static methods", ->
		beforeEach -> @spy = spy()

		describe "`forEach`", ->
			it "should be a function", ->
				expect(forEach).to.be.a "function"

			# forEach(hosts, callback)
			describe "no `properties` parameter passed", ->
				beforeEach ->
					@hosts =
						host1: new Host { "name.namespace": -> }
						notHost: {}
						object:
							host: new Host { "name": [(->), (->)] }
							object:
								notHost: true
								host: new Host
						host2: new Host
					forEach @hosts, @spy

				it "should recursively find `Host` instances", ->
					expect(@spy.callCount).to.equal 4
				it "should pass the `Host` instance to the callback", ->
					expect(@spy.getCall(0).calledWithExactly @hosts.host1).to.be.true
					expect(@spy.getCall(1).calledWithExactly @hosts.object.host).to.be.true
					expect(@spy.getCall(2).calledWithExactly @hosts.object.object.host).to.be.true
					expect(@spy.getCall(3).calledWithExactly @hosts.host2).to.be.true

			describe "`properties` parameter passed", ->
				beforeEach -> @hosts = setupHosts()

				it "shouldn't call the callback if no events attached", ->
					@hosts = @hosts.noEvents
					forEach @hosts, "names", @spy
					forEach @hosts, "namespaces", @spy
					forEach @hosts, "handlers", @spy
					forEach @hosts, "names+namespaces", @spy
					forEach @hosts, "names+handlers", @spy
					forEach @hosts, "namespaces+names", @spy
					forEach @hosts, "namespaces+handlers", @spy
					forEach @hosts, "handlers+names", @spy
					forEach @hosts, "handlers+namespaces", @spy
					forEach @hosts, "names+namespaces+handlers", @spy
					forEach @hosts, "names+handlers+namespaces", @spy
					forEach @hosts, "namespaces+names+handlers", @spy
					forEach @hosts, "namespaces+handlers+names", @spy
					forEach @hosts, "handlers+names+namespaces", @spy
					forEach @hosts, "handlers+namespaces+names", @spy
					expect(@spy.callCount).to.equal 0

				describe "some events attached", ->
					beforeEach -> @hosts = @hosts.someEvents

					describe "one property passed", ->

						# forEach(hosts, "names", callback)
						describe "property is `\"names\"`", ->
							beforeEach -> forEach @hosts, "names", @spy

							it "should call the callback for each event name attached to each host", ->
								expect(@spy.callCount).to.equal 26
							it "should pass the `Host` instance and event names to each callback call", ->
								expect(@spy.alwaysCalledWithMatch host, string).to.be.true

						# forEach(hosts, "namespaces", callback)
						describe "property is `\"namespaces\"`", ->
							it "shouldn't call the callback if no namespaced events attached", ->
								forEach @hosts.noNamespaced, "namespaces", @spy
								expect(@spy.callCount).to.equal 0

							describe "some namespaced events attached", ->
								beforeEach -> forEach @hosts.someNamespaced, "namespaces", @spy

								it "should call the callback for each event namespace attached to each host", ->
									expect(@spy.callCount).equal 17
								it "should pass the `Host` instance and event namespaces to each callback call", ->
									expect(@spy.alwaysCalledWithMatch host, string).to.be.true

						# forEach(hosts, "handlers", callback)
						describe "property is `\"handlers\"`", ->
							beforeEach -> forEach @hosts, "handlers", @spy

							it "should call the callback for each event handler attached to each host", ->
								expect(@spy.callCount).to.equal 26
							it "should pass the `Host` instance and event handlers to each callback call", ->
								expect(@spy.alwaysCalledWithMatch host, func).to.be.true

					describe "two properties passed", ->

						# forEach(hosts, "names+handlers", callback)
						describe "`properties` are `\"names+handlers\"`", ->
							beforeEach -> forEach @hosts, "names+handlers", @spy

							it "should call the callback for each event name and handler attached to each host", ->
								expect(@spy.callCount).to.equal 38
							it "should pass the `Host` instance, event names and handlers to each callback call", ->
								expect(@spy.alwaysCalledWithMatch host, string, func).to.be.true

						# forEach(hosts, "handlers+names", callback)
						describe "`properties` are `\"handlers+names\"`", ->
							beforeEach -> forEach @hosts, "handlers+names", @spy

							it "should call the callback for each event handler and name attached to each host", ->
								expect(@spy.callCount).to.equal 38
							it "should pass the `Host` instance, event handlers and names to each callback call", ->
								expect(@spy.alwaysCalledWithMatch host, func, string).to.be.true

						describe "one of the passed `properties` is `\"namespaces\"`", ->
							it "shouldn't call the callback if no namespaced events attached", ->
								@hosts = @hosts.noNamespaced
								forEach @hosts, "names+namespaces", @spy
								forEach @hosts, "namespaces+names", @spy
								forEach @hosts, "handlers+namespaces", @spy
								forEach @hosts, "namespaces+handlers", @spy
								expect(@spy.callCount).to.equal 0

							describe "some namespaces evens attached", ->
								beforeEach -> @hosts = @hosts.someNamespaced

								# forEach(hosts, "names+namespaces", callback)
								describe "`properties` are `\"names+namespaces\"`", ->
									beforeEach -> forEach @hosts, "names+namespaces", @spy

									it "should call the callback for each event name and namespace attached to each host", ->
										expect(@spy.callCount).to.equal 25
									it "should pass the `Host` instance, event names and namespaces to each callback call", ->
										expect(@spy.alwaysCalledWithMatch host, string, string).to.be.true

								# forEach(hosts, "namespaces+names", callback)
								describe "`properties` are `\"namespaces+names\"`", ->
									beforeEach -> forEach @hosts, "namespaces+names", @spy

									it "should call the callback for each event namespace and name attached to each host", ->
										expect(@spy.callCount).to.equal 25
									it "should pass the `Host` instance, event namespaces and names to each callback call", ->
										expect(@spy.alwaysCalledWithMatch host, string, string).to.be.true

								# forEach(hosts, "namespaces+handlers", callback)
								describe "`properties` are `\"namespaces+handlers\"`", ->
									beforeEach -> forEach @hosts, "namespaces+handlers", @spy

									it "should call the callback for each event namespace and handler attached to each host", ->
										expect(@spy.callCount).to.equal 25
									it "should pass the `Host` instance, event namespaces and handlers to each callback call", ->
										expect(@spy.alwaysCalledWithMatch host, string, func).to.be.true

								# forEach(hosts, "handlers+namespaces", callback)
								describe "`properties` are `\"handlers+namespaces\"`", ->
									beforeEach -> forEach @hosts, "handlers+namespaces", @spy

									it "should call the callback for each event handler and namespace attached to each host", ->
										expect(@spy.callCount).to.equal 25
									it "should pass the `Host` instance, event handlers and namespaces to each callback call", ->
										expect(@spy.alwaysCalledWithMatch host, func, string).to.be.true

					describe "three properties passed", ->
						it "shouldn't call the callback if no namespaced events attached", ->
							@hosts = @hosts.noNamespaced
							forEach @hosts, "names+namespaces+handlers", @spy
							forEach @hosts, "names+handlers+namespaces", @spy
							forEach @hosts, "namespaces+names+handlers", @spy
							forEach @hosts, "namespaces+handlers+names", @spy
							forEach @hosts, "handlers+names+namespaces", @spy
							forEach @hosts, "handlers+namespaces+names", @spy
							expect(@spy.callCount).to.equal 0

						describe "some namespaced events attached", ->
							beforeEach -> @hosts = @hosts.someNamespaced

							# forEach(hosts, "names+namespaces+handlers", callback)
							describe "`properties` are `\"names+namespaces+handlers\"`", ->
								beforeEach -> forEach @hosts, "names+namespaces+handlers", @spy

								it "should call the callback for each event name, namespace and handler attached to each host", ->
									expect(@spy.callCount).to.equal 37
								it "should pass the `Host` instance, event names, namespaces and handlers to each callback call", ->
									expect(@spy.alwaysCalledWithMatch host, string, string, func).to.be.true

							# forEach(hosts, "names+handlers+namespaces", callback)
							describe "`properties` are `\"names+handlers+namespaces\"`", ->
								beforeEach -> forEach @hosts, "names+handlers+namespaces", @spy

								it "should call the callback for each event name, handler and namespace attached to each host", ->
									expect(@spy.callCount).to.equal 37
								it "should pass the `Host` instance, event names, handlers and namespaces to each callback call", ->
									expect(@spy.alwaysCalledWithMatch host, string, func, string).to.be.true

							# forEach(hosts, "namespaces+names+handlers", callback)
							describe "`properties` are `\"namespaces+names+handlers\"`", ->
								beforeEach -> forEach @hosts, "namespaces+names+handlers", @spy

								it "should call the callback for each event namespace, name and handler attached to each host", ->
									expect(@spy.callCount).to.equal 37
								it "should pass the `Host` instance, event namespaces, names and handlers to each callback call", ->
									expect(@spy.alwaysCalledWithMatch host, string, string, func).to.be.true

							# forEach(hosts, "namespaces+handlers+names", callback)
							describe "`properties` are `\"namespaces+handlers+names\"`", ->
								beforeEach -> forEach @hosts, "namespaces+handlers+names", @spy

								it "should call the callback for each event namespace, handler and name attached to each host", ->
									expect(@spy.callCount).to.equal 37
								it "should pass the `Host` instance, event namespaces, handlers and names to each callback call", ->
									expect(@spy.alwaysCalledWithMatch host, string, func, string).to.be.true

							# forEach(hosts, "handlers+names+namespaces", callback)
							describe "`properties` are `\"handlers+names+namespaces\"`", ->
								beforeEach -> forEach @hosts, "handlers+names+namespaces", @spy

								it "should call the callback for each event handler, name and namespace attached to each host", ->
									expect(@spy.callCount).to.equal 37
								it "should pass the `Host` instance, event handlers, names and namespaces to each callback call", ->
									expect(@spy.alwaysCalledWithMatch host, func, string, string).to.be.true

							# forEach(hosts, "handlers+namespaces+names", callback)
							describe "`properties` are `\"handlers+namespaces+names\"`", ->
								beforeEach -> forEach @hosts, "handlers+namespaces+names", @spy

								it "should call the callback for each event handler, namespace and name attached to each host", ->
									expect(@spy.callCount).to.equal 37
								it "should pass the `Host` instance, event handlers, namespaces and names to each callback call", ->
									expect(@spy.alwaysCalledWithMatch host, func, string, string).to.be.true

		describe "`forNested`", ->
			beforeEach -> @hosts = setupHosts()

			it "should be a function", ->
				expect(forNested).to.be.a "function"

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
