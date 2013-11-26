describe "setupHosts", ->
	expect = chai.expect
	setupHosts = jQuery.getEventsData.setupHosts
	Host = jQuery.getEventsData.Host

	it "should be a function", ->
		expect(setupHosts).to.be.a "function"

	describe "get a structured hash of hosts", ->
		beforeEach -> @hosts = setupHosts()

		it "shouldn't be a host", ->
			expect(@hosts).not.to.be.an.instanceOf Host
		it "should own needed properties", ->
			expect(@hosts).to.have.keys ["noEvents", "someEvents"]
		it "`noEvents` property should contain a host", ->
			expect(@hosts.noEvents).to.be.an.instanceOf Host

		describe "`someEvents` property", ->
			beforeEach -> @hosts = @hosts.someEvents

			it "shouldn't contain a host", ->
				expect(@hosts).not.to.be.an.instanceOf Host
			it "should own needed properties", ->
				expect(@hosts).to.have.keys ["noNamespaced", "someNamespaced"]

			describe "`noNamespaced` property", ->
				beforeEach -> @hosts = @hosts.noNamespaced

				it "shouldn't contain a host", ->
					expect(@hosts).not.to.be.an.instanceOf Host
				it "should own needed properties", ->
					expect(@hosts).to.have.keys ["oneEvent", "severalEvents"]
				it "`oneEvent` property should contain a host", ->
					expect(@hosts.oneEvent).to.be.an.instanceOf Host

				describe "`severalEvents` property", ->
					beforeEach -> @hosts = @hosts.severalEvents

					it "shouldn't contain a host", ->
						expect(@hosts).not.to.be.an.instanceOf Host
					it "should own needed properties", ->
						expect(@hosts).to.have.keys ["sameName", "differentNames"]

					describe "`sameName` property", ->
						beforeEach -> @hosts = @hosts.sameName

						it "shouldn't contain a host", ->
							expect(@hosts).not.to.be.an.instanceOf Host
						it "should own needed properties", ->
							expect(@hosts).to.have.keys ["sameHandler", "differentHandlers"]
						it "`sameHandler` property should contain a host", ->
							expect(@hosts.sameHandler).to.be.an.instanceOf Host
						it "`differentHandlers` property should contain a host", ->
							expect(@hosts.differentHandlers).to.be.an.instanceOf Host

					describe "`differentNames` property", ->
						beforeEach -> @hosts = @hosts.differentNames

						it "shouldn't contain a host", ->
							expect(@hosts).not.to.be.an.instanceOf Host
						it "should own needed properties", ->
							expect(@hosts).to.have.keys ["sameHandler", "differentHandlers"]
						it "`sameHandler` property should contain a host", ->
							expect(@hosts.sameHandler).to.be.an.instanceOf Host
						it "`differentHandlers` property should contain a host", ->
							expect(@hosts.differentHandlers).to.be.an.instanceOf Host

			describe "`someNamespaced` property", ->
				beforeEach -> @hosts = @hosts.someNamespaced

				it "shouldn't contain a host", ->
					expect(@hosts).not.to.be.an.instanceOf Host
				it "should own needed properties", ->
					expect(@hosts).to.have.keys ["oneEvent", "severalEvents"]
				it "`oneEvent` property should contain a host", ->
					expect(@hosts.oneEvent).to.be.an.instanceOf Host

				describe "`severalEvents` property", ->
					beforeEach -> @hosts = @hosts.severalEvents

					it "shouldn't contain a host", ->
						expect(@hosts).not.to.be.an.instanceOf Host
					it "should own needed properties", ->
						expect(@hosts).to.have.keys ["oneNamespaced", "allNamespaced"]

					describe "`oneNamespaced` property", ->
						beforeEach -> @hosts = @hosts.oneNamespaced

						it "shouldn't contain a host", ->
							expect(@hosts).not.to.be.an.instanceOf Host
						it "should own needed properties", ->
							expect(@hosts).to.have.keys ["sameName", "differentNames"]

						describe "`sameName` property", ->
							beforeEach -> @hosts = @hosts.sameName

							it "shouldn't contain a host", ->
								expect(@hosts).not.to.be.an.instanceOf Host
							it "should own needed properties", ->
								expect(@hosts).to.have.keys ["sameHandler", "differentHandlers"]
							it "`sameHandler` property should contain a host", ->
								expect(@hosts.sameHandler).to.be.an.instanceOf Host
							it "`differentHandlers` property should contain a host", ->
								expect(@hosts.differentHandlers).to.be.an.instanceOf Host

						describe "`differentNames` property", ->
							beforeEach -> @hosts = @hosts.differentNames

							it "shouldn't contain a host", ->
								expect(@hosts).not.to.be.an.instanceOf Host
							it "should own needed properties", ->
								expect(@hosts).to.have.keys ["sameHandler", "differentHandlers"]
							it "`sameHandler` property should contain a host", ->
								expect(@hosts.sameHandler).to.be.an.instanceOf Host
							it "`differentHandlers` property should contain a host", ->
								expect(@hosts.differentHandlers).to.be.an.instanceOf Host

					describe "`allNamespaced` property", ->
						beforeEach -> @hosts = @hosts.allNamespaced

						it "shouldn't contain a host", ->
							expect(@hosts).not.to.be.an.instanceOf Host
						it "should own needed properties", ->
							expect(@hosts).to.have.keys ["sameName", "differentNames"]

						describe "`sameName` property", ->
							beforeEach -> @hosts = @hosts.sameName

							it "shouldn't contain a host", ->
								expect(@hosts).not.to.be.an.instanceOf Host
							it "should own needed properties", ->
								expect(@hosts).to.have.keys ["sameNamespace", "differentNamespaces"]

							describe "`sameNamespace` property", ->
								beforeEach -> @hosts = @hosts.sameNamespace

								it "shouldn't contain a host", ->
									expect(@hosts).not.to.be.an.instanceOf Host
								it "should own needed properties", ->
									expect(@hosts).to.have.keys ["sameHandler", "differentHandlers"]
								it "`sameHandler` property should contain a host", ->
									expect(@hosts.sameHandler).to.be.an.instanceOf Host
								it "`differentHandlers` property should contain a host", ->
									expect(@hosts.differentHandlers).to.be.an.instanceOf Host

							describe "`differentNamespaces` property", ->
								beforeEach -> @hosts = @hosts.differentNamespaces

								it "shouldn't contain a host", ->
									expect(@hosts).not.to.be.an.instanceOf Host
								it "should own needed properties", ->
									expect(@hosts).to.have.keys ["sameHandler", "differentHandlers"]
								it "`sameHandler` property should contain a host", ->
									expect(@hosts.sameHandler).to.be.an.instanceOf Host
								it "`differentHandlers` property should contain a host", ->
									expect(@hosts.differentHandlers).to.be.an.instanceOf Host

						describe "`differentNames` property", ->
							beforeEach -> @hosts = @hosts.differentNames

							it "shouldn't contain a host", ->
								expect(@hosts).not.to.be.an.instanceOf Host
							it "should own needed properties", ->
								expect(@hosts).to.have.keys ["sameNamespace", "differentNamespaces"]

							describe "`sameNamespace` property", ->
								beforeEach -> @hosts = @hosts.sameNamespace

								it "shouldn't contain a host", ->
									expect(@hosts).not.to.be.an.instanceOf Host
								it "should own needed properties", ->
									expect(@hosts).to.have.keys ["sameHandler", "differentHandlers"]
								it "`sameHandler` property should contain a host", ->
									expect(@hosts.sameHandler).to.be.an.instanceOf Host
								it "`differentHandlers` property should contain a host", ->
									expect(@hosts.differentHandlers).to.be.an.instanceOf Host

							describe "`differentNamespaces` property", ->
								beforeEach -> @hosts = @hosts.differentNamespaces

								it "shouldn't contain a host", ->
									expect(@hosts).not.to.be.an.instanceOf Host
								it "should own needed properties", ->
									expect(@hosts).to.have.keys ["sameHandler", "differentHandlers"]
								it "`sameHandler` property should contain a host", ->
									expect(@hosts.sameHandler).to.be.an.instanceOf Host
								it "`differentHandlers` property should contain a host", ->
									expect(@hosts.differentHandlers).to.be.an.instanceOf Host
