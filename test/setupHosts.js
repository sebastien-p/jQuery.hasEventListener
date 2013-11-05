/*jshint jquery:true */

(function (exports, Host) {
	exports.setupHosts = function () {
		function handler1 () {}
		function handler2 () {}

		return {
			noEvents: new Host(),
			someEvents: {
				noNamespaced: {
					oneEvent: new Host({ "name1": handler1 }),
					severalEvents: {
						sameName: {
							sameHandler: new Host({ "name1": [handler1, handler1] }),
							differentHandlers: new Host({ "name1": [handler1, handler2] })
						},
						differentNames: {
							sameHandler: new Host({ "name1": handler1, "name2": handler1 }),
							differentHandlers: new Host({ "name1": handler1, "name2": handler2 })
						}
					}
				},
				someNamespaced: {
					oneEvent: new Host({ "name1.namespace1": handler1 }),
					severalEvents: {
						oneNamespaced: {
							sameName: {
								sameHandler: new Host({ "name1": handler1, "name1.namespace1": handler1 }),
								differentHandlers: new Host({ "name1": handler1, "name1.namespace1": handler2 })
							},
							differentNames: {
								sameHandler: new Host({ "name1": handler1, "name2.namespace1": handler1 }),
								differentHandlers: new Host({ "name1": handler1, "name2.namespace1": handler2 })
							}
						},
						allNamespaced: {
							sameName: {
								sameNamespace: {
									sameHandler: new Host({ "name1.namespace1": [handler1, handler1] }),
									differentHandlers: new Host({ "name1.namespace1": [handler1, handler2] })
								},
								differentNamespaces: {
									sameHandler: new Host({ "name1.namespace1": handler1, "name1.namespace2": handler1 }),
									differentHandlers: new Host({ "name1.namespace1": handler1, "name1.namespace2": handler2 })
								}
							},
							differentNames: {
								sameNamespace: {
									sameHandler: new Host({ "name1.namespace1": handler1, "name2.namespace1": handler1 }),
									differentHandlers: new Host({ "name1.namespace1": handler1, "name2.namespace1": handler2 })
								},
								differentNamespaces: {
									sameHandler: new Host({ "name1.namespace1": handler1, "name2.namespace2": handler1 }),
									differentHandlers: new Host({ "name1.namespace1": handler1, "name2.namespace2": handler2 })
								}
							}
						}
					}
				}
			}
		};
	};
}(jQuery.getEventsData, jQuery.getEventsData.Host));
