local ns = ...


local tests = ns.tests
local should = ns.should
local runner = ns.lunatic.__private.runner

local exec = {}
local lunatic = ns.lunatic.new()
lunatic.add("one", {
	first = function() exec["one.first"] = true end,
	second = function() exec["one.second"] = true end,
})
lunatic.add("two", {
	first = function() exec["two.first"] = true end,
	second = function() exec["two.second"] = true end,
})


tests.add("testEngine.run tests", {

	before = function()
		exec = {}
	end,

	when_running_all_tests = function()

		lunatic.run()

		should.haveKey("one.first", exec)
		should.haveKey("one.second", exec)
		should.haveKey("two.first", exec)
		should.haveKey("two.second", exec)

	end,

	when_running_a_single_set = function()

		lunatic.run("one")

		should.haveKey("one.first", exec)
		should.haveKey("one.second", exec)
		should.notHaveKey("two.first", exec)
		should.notHaveKey("two.second", exec)

	end,

	when_running_a_single_test = function()

		lunatic.run("one", "second")

		should.notHaveKey("one.first", exec)
		should.haveKey("one.second", exec)
		should.notHaveKey("two.first", exec)
		should.notHaveKey("two.second", exec)

	end

})