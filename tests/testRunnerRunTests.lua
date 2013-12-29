local ns = ...

local tests = ns.tests
local should = ns.should
local runner = ns.lunatic.__private.runner

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
