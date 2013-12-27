
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


-- run tests:
---------------------------------------
tests.run()
tests.print()
