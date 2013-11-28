describe "jQuery.hasEventListener - `host` has no matching events attached", ->
	expect = chai.expect
	hasEventListener = jQuery.hasEventListener
	setupHosts = jQuery.getEventsData.setupHosts
	forEach = jQuery.getEventsData.Host.forEach
	notValid = undefined
	handler0 = ->

	beforeEach -> @hosts = setupHosts().someEvents

	describe "two parameters passed", ->
		# hasEventListener(host, notValid)
		it "should return `false` if the second parameter isn't valid", ->
			forEach @hosts, (host) ->
				expect(hasEventListener host, notValid).to.be.false

		describe "the second parameter is a string or a function", ->
			# hasEventListener(host, handler0)
			it "should return `false` if it's a non attached handler", ->
				forEach @hosts, (host) ->
					expect(hasEventListener host, handler0).to.be.false

			describe "the second parameter is a string", ->
				# hasEventListener(host, "")
				it "should return `false` if it's not a valid string", ->
					forEach @hosts, (host) ->
						expect(hasEventListener host, "").to.be.false
						expect(hasEventListener host, "..").to.be.false
				# hasEventListener(host, "name0")
				it "should return `false` if it's a non attached name", ->
					forEach @hosts, (host) ->
						expect(hasEventListener host, "name0").to.be.false

				describe "`host` has no namespaced events attached", ->
					beforeEach -> @hosts = @hosts.noNamespaced

					# hasEventListener(host, ".namespace0")
					it "should return `false` if it's a non attached namespace", ->
						forEach @hosts, (host) ->
							expect(hasEventListener host, ".namespace0").to.be.false
					# hasEventListener(host, "name0.namespace0")
					it "should return `false` if it's both non attached name and namespace", ->
						forEach @hosts, (host) ->
							expect(hasEventListener host, "name0.namespace0").to.be.false
					# hasEventListener(host, "nameN.namespace0")
					it "should return `false` if it's an attached name and a non attached namespace", ->
						forEach @hosts, "names", (host, name) ->
							expect(hasEventListener host, "#{name}.namespace0").to.be.false

				describe "`host` has some namespaced events attached", ->
					beforeEach -> @hosts = @hosts.someNamespaced

					# hasEventListener(host, ".namespace0")
					it "should return `false` if it's a non attached namespace", ->
						forEach @hosts, (host) ->
							expect(hasEventListener host, ".namespace0").to.be.false
					# hasEventListener(host, "name0.namespace0")
					it "should return `false` if it's both non attached name and namespace", ->
						forEach @hosts, (host) ->
							expect(hasEventListener host, "name0.namespace0").to.be.false
					# hasEventListener(host, "nameN.namespace0")
					it "should return `false` if it's an attached name and a non attached namespace", ->
						forEach @hosts, "names", (host, name) ->
							expect(hasEventListener host, "#{name}.namespace0").to.be.false
					# hasEventListener(host, "name0.namespaceN")
					it "should return `false` if it's a non attached name and an attached namespace", ->
						forEach @hosts, "namespaces", (host, namespace) ->
							expect(hasEventListener host, "name0#{namespace}").to.be.false

	describe "three parameters passed", ->

		describe "`event` isn't a string", ->
			# hasEventListener(host, notValid, notValid)
			it "should return `false` if `handler` isn't a function", ->
				forEach @hosts, (host) ->
					expect(hasEventListener host, notValid, notValid).to.be.false

			describe "`handler` is a function", ->
				# hasEventListener(host, notValid, handler0)
				it "should return `false` if it's a non attached handler", ->
					forEach @hosts, (host) ->
						expect(hasEventListener host, notValid, handler0).to.be.false
				# hasEventListener(host, notValid, handlerN)
				it "should return `false` if it's an attached handler", ->
					forEach @hosts, "handlers", (host, handler) ->
						expect(hasEventListener host, notValid, handler).to.be.false

		describe "`event` is a string", ->

			describe "`event` isn't a valid string", ->
				# hasEventListener(host, "", notValid)
				it "should return `false` if `handler` isn't a function", ->
					forEach @hosts, (host) ->
						expect(hasEventListener host, "", notValid).to.be.false
						expect(hasEventListener host, "..", notValid).to.be.false

				describe "`handler` is a function", ->
					# hasEventListener(host, "", handler0)
					it "should return `false` if it's a non attached handler", ->
						forEach @hosts, (host) ->
							expect(hasEventListener host, "", handler0).to.be.false
							expect(hasEventListener host, "..", handler0).to.be.false
					# hasEventListener(host, "", handlerN)
					it "should return `false` if it's an attached handler", ->
						forEach @hosts, "handlers", (host, handler) ->
							expect(hasEventListener host, "", handler).to.be.false
							expect(hasEventListener host, "..", handler).to.be.false

			describe "`event` is a valid string", ->

				describe "`handler` isn't a function", ->
					# hasEventListener(host, "name0", notValid)
					it "should return `false` if `event` is a non attached name", ->
						forEach @hosts, (host) ->
							expect(hasEventListener host, "name0", notValid).to.be.false
					# hasEventListener(host, "nameN", notValid)
					it "should return `false` if `event` is an attached name", ->
						forEach @hosts, "names", (host, name) ->
							expect(hasEventListener host, name, notValid).to.be.false

					describe "`host` has no namespaced events attached", ->
						beforeEach -> @hosts = @hosts.noNamespaced

						# hasEventListener(host, ".namespace0", notValid)
						it "should return `false` if `event` is a non attached namespace", ->
							forEach @hosts, (host) ->
								expect(hasEventListener host, ".namespace0", notValid).to.be.false
						# hasEventListener(host, "name0.namespace0", notValid)
						it "should return `false` if `event` is both non attached name and namespace", ->
							forEach @hosts, (host) ->
								expect(hasEventListener host, "name0.namespace0", notValid).to.be.false
						# hasEventListener(host, "nameN.namespace0", notValid)
						it "should return `false` if `event` is an attached name and a non attached namespace", ->
							forEach @hosts, "names", (host, name) ->
								expect(hasEventListener host, "#{name}.namespace0", notValid).to.be.false

					describe "`host` has some namespaced events attached", ->
						beforeEach -> @hosts = @hosts.someNamespaced

						# hasEventListener(host, ".namespace0", notValid)
						it "should return `false` if `event` is a non attached namespace", ->
							forEach @hosts, (host) ->
								expect(hasEventListener host, ".namespace0", notValid).to.be.false
						# hasEventListener(host, "name0.namespace0", notValid)
						it "should return `false` if `event` is both non attached name and namespace", ->
							forEach @hosts, (host) ->
								expect(hasEventListener host, "name0.namespace0", notValid).to.be.false
						# hasEventListener(host, "nameN.namespace0", notValid)
						it "should return `false` if `event` is an attached name and a non attached namespace", ->
							forEach @hosts, "names", (host, name) ->
								expect(hasEventListener host, "#{name}.namespace0", notValid).to.be.false
						# hasEventListener(host, "name0.namespaceN", notValid)
						it "should return `false` if `event` is a non attached name and an attached namespace", ->
							forEach @hosts, "namespaces", (host, namespace) ->
								expect(hasEventListener host, "name0#{namespace}", notValid).to.be.false

				describe "`handler` is a function", ->

					describe "`handler` is a non attached handler", ->
						# hasEventListener(host, "name0", handler0)
						it "should return `false` if `event` is a non attached name", ->
							forEach @hosts, (host) ->
								expect(hasEventListener host, "name0", handler0).to.be.false
						# hasEventListener(host, "nameN", handler0)
						it "should return `false` if `event` is an attached name", ->
							forEach @hosts, "names", (host, name) ->
								expect(hasEventListener host, name, handler0).to.be.false

						describe "`host` has no namespaced events attached", ->
							beforeEach -> @hosts = @hosts.noNamespaced

							# hasEventListener(host, ".namespace0", handler0)
							it "should return `false` if `event` is a non attached namespace", ->
								forEach @hosts, (host) ->
									expect(hasEventListener host, ".namespace0", handler0).to.be.false
							# hasEventListener(host, "name0.namespace0", handler0)
							it "should return `false` if `event` is both non attached name and namespace", ->
								forEach @hosts, (host) ->
									expect(hasEventListener host, "name0.namespace0", handler0).to.be.false
							# hasEventListener(host, "nameN.namespace0", handler0)
							it "should return `false` if `event` is an attached name and a non attached namespace", ->
								forEach @hosts, "names", (host, name) ->
									expect(hasEventListener host, "#{name}.namespace0", handler0).to.be.false

						describe "`host` has some namespaced events attached", ->
							beforeEach -> @hosts = @hosts.someNamespaced

							# hasEventListener(host, ".namespace0", handler0)
							it "should return `false` if `event` is a non attached namespace", ->
								forEach @hosts, (host) ->
									expect(hasEventListener host, ".namespace0", handler0).to.be.false
							# hasEventListener(host, "name0.namespace0", handler0)
							it "should return `false` if `event` is both non attached name and namespace", ->
								forEach @hosts, (host) ->
									expect(hasEventListener host, "name0.namespace0", handler0).to.be.false
							# hasEventListener(host, "nameN.namespace0", handler0)
							it "should return `false` if `event` is an attached name and a non attached namespace", ->
								forEach @hosts, "names", (host, name) ->
									expect(hasEventListener host, "#{name}.namespace0", handler0).to.be.false
							# hasEventListener(host, "name0.namespaceN", handler0)
							it "should return `false` if `event` is a non attached name and an attached namespace", ->
								forEach @hosts, "namespaces", (host, namespace) ->
									expect(hasEventListener host, "name0#{namespace}", handler0).to.be.false

					describe "`handler` is an attached handler", ->
						# hasEventListener(host, "name0", handlerN)
						it "should return `false` if `event` is a non attached name", ->
							forEach @hosts, "handlers", (host, handler) ->
								expect(hasEventListener host, "name0", handler).to.be.false

						describe "`host` has no namespaced events attached", ->
							beforeEach -> @hosts = @hosts.noNamespaced

							# hasEventListener(host, ".namespace0", handlerN)
							it "should return `false` if `event` is a non attached namespace", ->
								forEach @hosts, "handlers", (host, handler) ->
									expect(hasEventListener host, ".namespace0", handler).to.be.false
							# hasEventListener(host, "name0.namespace0", handlerN)
							it "should return `false` if `event` is both non attached name and namespace", ->
								forEach @hosts, "handlers", (host, handler) ->
									expect(hasEventListener host, "name0.namespace0", handler).to.be.false
							# hasEventListener(host, "nameN.namespace0", handlerN)
							it "should return `false` if `event` is an attached name and a non attached namespace", ->
								forEach @hosts, "names+handlers", (host, name, handler) ->
									expect(hasEventListener host, "#{name}.namespace0", handler).to.be.false

						describe "`host` has some namespaced events attached", ->
							beforeEach -> @hosts = @hosts.someNamespaced

							# hasEventListener(host, ".namespace0", handlerN)
							it "should return `false` if `event` is a non attached namespace", ->
								forEach @hosts, "handlers", (host, handler) ->
									expect(hasEventListener host, ".namespace0", handler).to.be.false
							# hasEventListener(host, "name0.namespace0", handlerN)
							it "should return `false` if `event` is both non attached name and namespace", ->
								forEach @hosts, "handlers", (host, handler) ->
									expect(hasEventListener host, "name0.namespace0", handler).to.be.false
							# hasEventListener(host, "nameN.namespace0", handlerN)
							it "should return `false` if `event` is an attached name and a non attached namespace", ->
								forEach @hosts, "names+handlers", (host, name, handler) ->
									expect(hasEventListener host, "#{name}.namespace0", handler).to.be.false
							# hasEventListener(host, "name0.namespaceN", handlerN)
							it "should return `false` if `event` is a non attached name and an attached namespace", ->
								forEach @hosts, "namespaces+handlers", (host, namespace, handler) ->
									expect(hasEventListener host, "name0#{namespace}", handler).to.be.false
