
local lunatic = require("lunatic")

local tests = lunatic.new()
local should = lunatic.should

tests.add("should.haveCount tests", {

	when_counting_a_nil_table = function()

		local t = nil

		local success = pcall(function() should.haveCount(5, nil) end)

		assert(success == false)

	end,

	when_counting_an_indexed_table_with_the_right_element_count = function()

		local t = {"a", "b", "c"}

		local success = pcall(function() should.haveCount(3, t) end)

		assert(success)

	end,

	when_counting_an_indexed_table_with_the_wrong_element_count = function()

		local t = {"a", "b", "c"}

		local success = pcall(function() should.haveCount(7, t) end)

		assert(success == false)

	end,

	when_counting_a_keyed_table_with_the_right_element_count = function()

		local t = {
			["a"] = "a",
			["b"] = "b",
			["c"] = "c",
		}

		local success = pcall(function() should.haveCount(3, t) end)

		assert(success)

	end,

	when_counting_a_keyed_table_with_the_wrong_element_count = function()

		local t = {
			["a"] = "a",
			["b"] = "b",
			["c"] = "c",
		}

		local success = pcall(function() should.haveCount(7, t) end)

		assert(success == false)

	end,

	when_counting_an_indexed_table_with_gaps_and_the_right_element_count = function()

		local t = {
			[1] = "a",
			[2] = "b",
			[9] = "c",
		}

		local success = pcall(function() should.haveCount(3, t) end)

		assert(success)

	end,

	when_counting_an_indexed_table_with_gaps_and_the_wrong_element_count = function()

		local t = {
			[1] = "a",
			[2] = "b",
			[9] = "c",
		}

		local success = pcall(function() should.haveCount(7, t) end)

		assert(success == false)

	end,


})

local runner = lunatic.__private.runner

tests.add("testRunner.run tests", {

	When_before_fails_and_action_passes_and_after_passes = function()

		local before = function() error("before") end
		local action = function() end
		local after = function() end

		local s, e = runner.run(before, action, after)

		assert(s ~= true, "Test should not have succeeded.")
		assert(e:find("before$"), "Error should be from 'before'.")

	end,

	When_before_passes_and_action_fails_and_after_passes = function()

		local before = function() end
		local action = function() error("action") end
		local after = function() end

		local s, e = runner.run(before, action, after)

		assert(s ~= true, "Test should not have succeeded.")
		assert(e:find("action$"), "Error should be from 'action'.")

	end,

	When_before_fails_and_action_fails_and_after_passes = function()

		local before = function() error("before") end
		local action = function() error("action") end
		local after = function() end

		local s, e = runner.run(before, action, after)

		assert(s ~= true, "Test should not have succeeded.")
		assert(e:find("before$"), "Error should be from 'before'.")

	end,

	When_before_passes_and_action_passes_and_after_fails = function()

		local before = function() end
		local action = function() end
		local after = function() error("after") end

		local s, e = runner.run(before, action, after)

		assert(s ~= true, "Test should not have succeeded.")
		assert(e:find("after$"), "Error should be from 'after'.")

	end,

	When_before_fails_and_action_passes_and_after_fails = function()

		local before = function() error("before") end
		local action = function() end
		local after = function() error("after") end

		local s, e = runner.run(before, action, after)

		assert(s ~= true, "Test should not have succeeded.")
		assert(e:find("before$"), "Error should be from 'before'.")

	end,

	When_before_passes_and_action_fails_and_after_fails = function()

		local before = function() end
		local action = function() error("action") end
		local after = function() error("after") end

		local s, e = runner.run(before, action, after)

		assert(s ~= true, "Test should not have succeeded.")
		assert(e:find("action$"), "Error should be from 'action'.")

	end,

	When_before_fails_and_action_fails_and_after_fails = function()

		local before = function() error("before") end
		local action = function() error("action") end
		local after = function() error("after") end

		local s, e = runner.run(before, action, after)

		assert(s ~= true, "Test should not have succeeded.")
		assert(e:find("before$"), "Error should be from 'before'.")

	end,

})



-- run tests:
---------------------------------------
tests.run()
tests.print()
