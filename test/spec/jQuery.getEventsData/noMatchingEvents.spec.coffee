describe "jQuery.getEventsData - `host` has no matching events attached", ->
	expect = chai.expect
	getEventsData = jQuery.getEventsData
	setupHosts = getEventsData.setupHosts
	forEach = getEventsData.Host.forEach
	notValid = undefined
	handler0 = ->

	beforeEach -> @hosts = setupHosts().someEvents

	describe "two parameters passed", ->
		# getEventsData(host, notValid)
		it "should return `undefined` if the second parameter isn't valid", ->
			forEach @hosts, (host) ->
				expect(getEventsData host, notValid).to.be.undefined

		describe "the second parameter is a string or a function", ->
			# getEventsData(host, handler0)
			it "should return `undefined` if it's a non attached handler", ->
				forEach @hosts, (host) ->
					expect(getEventsData host, handler0).to.be.undefined

			describe "the second parameter is a string", ->
				# getEventsData(host, "")
				it "should return `undefined` if it's not a valid string", ->
					forEach @hosts, (host) ->
						expect(getEventsData host, "").to.be.undefined
				# getEventsData(host, "name0")
				it "should return `undefined` if it's a non attached name", ->
					forEach @hosts, (host) ->
						expect(getEventsData host, "name0").to.be.undefined

				describe "`host` has no namespaced events attached", ->
					beforeEach -> @hosts = @hosts.noNamespaced

					# getEventsData(host, ".namespace0")
					it "should return `undefined` if it's a non attached namespace", ->
						forEach @hosts, (host) ->
							expect(getEventsData host, ".namespace0").to.be.undefined
					# getEventsData(host, "name0.namespace0")
					it "should return `undefined` if it's both non attached name and namespace", ->
						forEach @hosts, (host) ->
							expect(getEventsData host, "name0.namespace0").to.be.undefined
					# getEventsData(host, "nameN.namespace0")
					it "should return `undefined` if it's an attached name and a non attached namespace", ->
						forEach @hosts, "names", (host, name) ->
							expect(getEventsData host, "#{name}.namespace0").to.be.undefined

				describe "`host` has some namespaced events attached", ->
					beforeEach -> @hosts = @hosts.someNamespaced

					# getEventsData(host, ".namespace0")
					it "should return `undefined` if it's a non attached namespace", ->
						forEach @hosts, (host) ->
							expect(getEventsData host, ".namespace0").to.be.undefined
					# getEventsData(host, "name0.namespace0")
					it "should return `undefined` if it's both non attached name and namespace", ->
						forEach @hosts, (host) ->
							expect(getEventsData host, "name0.namespace0").to.be.undefined
					# getEventsData(host, "nameN.namespace0")
					it "should return `undefined` if it's an attached name and a non attached namespace", ->
						forEach @hosts, "names", (host, name) ->
							expect(getEventsData host, "#{name}.namespace0").to.be.undefined
					# getEventsData(host, "name0.namespaceN")
					it "should return `undefined` if it's a non attached name and an attached namespace", ->
						forEach @hosts, "namespaces", (host, namespace) ->
							expect(getEventsData host, "name0#{namespace}").to.be.undefined

	describe "three parameters passed", ->

		describe "`event` isn't a string", ->
			# getEventsData(host, notValid, notValid)
			it "should return `undefined` if `handler` isn't a function", ->
				forEach @hosts, (host) ->
					expect(getEventsData host, notValid, notValid).to.be.undefined

			describe "`handler` is a function", ->
				# getEventsData(host, notValid, handler0)
				it "should return `undefined` if it's a non attached handler", ->
					forEach @hosts, (host) ->
						expect(getEventsData host, notValid, handler0).to.be.undefined
				# getEventsData(host, notValid, handlerN)
				it "should return `undefined` if it's an attached handler", ->
					forEach @hosts, "handlers", (host, handler) ->
						expect(getEventsData host, notValid, handler).to.be.undefined

		describe "`event` is a string", ->

			describe "`event` isn't a valid string", ->
				# getEventsData(host, "", notValid)
				it "should return `undefined` if `handler` isn't a function", ->
					forEach @hosts, (host) ->
						expect(getEventsData host, "", notValid).to.be.undefined

				describe "`handler` is a function", ->
					# getEventsData(host, "", handler0)
					it "should return `undefined` if it's a non attached handler", ->
						forEach @hosts, (host) ->
							expect(getEventsData host, "", handler0).to.be.undefined
					# getEventsData(host, "", handlerN)
					it "should return `undefined` if it's an attached handler", ->
						forEach @hosts, "handlers", (host, handler) ->
							expect(getEventsData host, "", handler).to.be.undefined

			describe "`event` is a valid string", ->

				describe "`handler` isn't a function", ->
					# getEventsData(host, "name0", notValid)
					it "should return `undefined` if `event` is a non attached name", ->
						forEach @hosts, (host) ->
							expect(getEventsData host, "name0", notValid).to.be.undefined
					# getEventsData(host, "nameN", notValid)
					it "should return `undefined` if `event` is an attached name", ->
						forEach @hosts, "names", (host, name) ->
							expect(getEventsData host, name, notValid).to.be.undefined

					describe "`host` has no namespaced events attached", ->
						beforeEach -> @hosts = @hosts.noNamespaced

						# getEventsData(host, ".namespace0", notValid)
						it "should return `undefined` if `event` is a non attached namespace", ->
							forEach @hosts, (host) ->
								expect(getEventsData host, ".namespace0", notValid).to.be.undefined
						# getEventsData(host, "name0.namespace0", notValid)
						it "should return `undefined` if `event` is both non attached name and namespace", ->
							forEach @hosts, (host) ->
								expect(getEventsData host, "name0.namespace0", notValid).to.be.undefined
						# getEventsData(host, "nameN.namespace0", notValid)
						it "should return `undefined` if `event` is an attached name and a non attached namespace", ->
							forEach @hosts, "names", (host, name) ->
								expect(getEventsData host, "#{name}.namespace0", notValid).to.be.undefined

					describe "`host` has some namespaced events attached", ->
						beforeEach -> @hosts = @hosts.someNamespaced

						# getEventsData(host, ".namespace0", notValid)
						it "should return `undefined` if `event` is a non attached namespace", ->
							forEach @hosts, (host) ->
								expect(getEventsData host, ".namespace0", notValid).to.be.undefined
						# getEventsData(host, "name0.namespace0", notValid)
						it "should return `undefined` if `event` is both non attached name and namespace", ->
							forEach @hosts, (host) ->
								expect(getEventsData host, "name0.namespace0", notValid).to.be.undefined
						# getEventsData(host, "nameN.namespace0", notValid)
						it "should return `undefined` if `event` is an attached name and a non attached namespace", ->
							forEach @hosts, "names", (host, name) ->
								expect(getEventsData host, "#{name}.namespace0", notValid).to.be.undefined
						# getEventsData(host, "name0.namespaceN", notValid)
						it "should return `undefined` if `event` is a non attached name and an attached namespace", ->
							forEach @hosts, "namespaces", (host, namespace) ->
								expect(getEventsData host, "name0#{namespace}", notValid).to.be.undefined

				describe "`handler` is a function", ->

					describe "`handler` is a non attached handler", ->
						# getEventsData(host, "name0", handler0)
						it "should return `undefined` if `event` is a non attached name", ->
							forEach @hosts, (host) ->
								expect(getEventsData host, "name0", handler0).to.be.undefined
						# getEventsData(host, "nameN", handler0)
						it "should return `undefined` if `event` is an attached name", ->
							forEach @hosts, "names", (host, name) ->
								expect(getEventsData host, name, handler0).to.be.undefined

						describe "`host` has no namespaced events attached", ->
							beforeEach -> @hosts = @hosts.noNamespaced

							# getEventsData(host, ".namespace0", handler0)
							it "should return `undefined` if `event` is a non attached namespace", ->
								forEach @hosts, (host) ->
									expect(getEventsData host, ".namespace0", handler0).to.be.undefined
							# getEventsData(host, "name0.namespace0", handler0)
							it "should return `undefined` if `event` is both non attached name and namespace", ->
								forEach @hosts, (host) ->
									expect(getEventsData host, "name0.namespace0", handler0).to.be.undefined
							# getEventsData(host, "nameN.namespace0", handler0)
							it "should return `undefined` if `event` is an attached name and a non attached namespace", ->
								forEach @hosts, "names", (host, name) ->
									expect(getEventsData host, "#{name}.namespace0", handler0).to.be.undefined

						describe "`host` has some namespaced events attached", ->
							beforeEach -> @hosts = @hosts.someNamespaced

							# getEventsData(host, ".namespace0", handler0)
							it "should return `undefined` if `event` is a non attached namespace", ->
								forEach @hosts, (host) ->
									expect(getEventsData host, ".namespace0", handler0).to.be.undefined
							# getEventsData(host, "name0.namespace0", handler0)
							it "should return `undefined` if `event` is both non attached name and namespace", ->
								forEach @hosts, (host) ->
									expect(getEventsData host, "name0.namespace0", handler0).to.be.undefined
							# getEventsData(host, "nameN.namespace0", handler0)
							it "should return `undefined` if `event` is an attached name and a non attached namespace", ->
								forEach @hosts, "names", (host, name) ->
									expect(getEventsData host, "#{name}.namespace0", handler0).to.be.undefined
							# getEventsData(host, "name0.namespaceN", handler0)
							it "should return `undefined` if `event` is a non attached name and an attached namespace", ->
								forEach @hosts, "namespaces", (host, namespace) ->
									expect(getEventsData host, "name0#{namespace}", handler0).to.be.undefined

					describe "`handler` is an attached handler", ->
						# getEventsData(host, "name0", handlerN)
						it "should return `undefined` if `event` is a non attached name", ->
							forEach @hosts, "handlers", (host, handler) ->
								expect(getEventsData host, "name0", handler).to.be.undefined

						describe "`host` has no namespaced events attached", ->
							beforeEach -> @hosts = @hosts.noNamespaced

							# getEventsData(host, ".namespace0", handlerN)
							it "should return `undefined` if `event` is a non attached namespace", ->
								forEach @hosts, "handlers", (host, handler) ->
									expect(getEventsData host, ".namespace0", handler).to.be.undefined
							# getEventsData(host, "name0.namespace0", handlerN)
							it "should return `undefined` if `event` is both non attached name and namespace", ->
								forEach @hosts, "handlers", (host, handler) ->
									expect(getEventsData host, "name0.namespace0", handler).to.be.undefined
							# getEventsData(host, "nameN.namespace0", handlerN)
							it "should return `undefined` if `event` is an attached name and a non attached namespace", ->
								forEach @hosts, "names+handlers", (host, name, handler) ->
									expect(getEventsData host, "#{name}.namespace0", handler).to.be.undefined

						describe "`host` has some namespaced events attached", ->
							beforeEach -> @hosts = @hosts.someNamespaced

							# getEventsData(host, ".namespace0", handlerN)
							it "should return `undefined` if `event` is a non attached namespace", ->
								forEach @hosts, "handlers", (host, handler) ->
									expect(getEventsData host, ".namespace0", handler).to.be.undefined
							# getEventsData(host, "name0.namespace0", handlerN)
							it "should return `undefined` if `event` is both non attached name and namespace", ->
								forEach @hosts, "handlers", (host, handler) ->
									expect(getEventsData host, "name0.namespace0", handler).to.be.undefined
							# getEventsData(host, "nameN.namespace0", handlerN)
							it "should return `undefined` if `event` is an attached name and a non attached namespace", ->
								forEach @hosts, "names+handlers", (host, name, handler) ->
									expect(getEventsData host, "#{name}.namespace0", handler).to.be.undefined
							# getEventsData(host, "name0.namespaceN", handlerN)
							it "should return `undefined` if `event` is a non attached name and an attached namespace", ->
								forEach @hosts, "namespaces+handlers", (host, namespace, handler) ->
									expect(getEventsData host, "name0#{namespace}", handler).to.be.undefined
