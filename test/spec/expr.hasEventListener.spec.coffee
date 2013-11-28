describe "jQuery.expr[\":\"].hasEventListener", ->
	expect = chai.expect
	$ = jQuery

	# should not use $.hasEventListener
	# should be chainable
	# test $collection.filter("expr"), etc.

	it "should be a function", ->
		expect($.expr[":"].hasEventListener).to.be.a "function"
