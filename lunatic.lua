local VERSION = "0.0.3"

local testRunner = {}

testRunner.run = function(before, test, after)

	local old = getfenv()

	setfenv(1, setmetatable({}, { __index = old }))

	local action = function()

		if before then
			before()
		end

		local success, e = pcall(test)

		if after then
			after()
		end

		return success, e

	end

	local s, e = pcall(action)

	setfenv(1, old)

	return s, e

end

testRunner.runSet = function(set)

	local before = set.before
	local after = set.after

	local result = {}

	for k,v in pairs(set) do

		if k ~= "before" and k ~= "after" then

			local s, e = testRunner.run(before, v, after)

			result[k] = { success = s, message = e }

		end

	end

	return result

end

local should = {

	haveCount = function(expected, collection, message)

		local actual = 0

		for k,v in pairs(collection) do
			actual = actual + 1
		end

		assert(actual == expected, string.format(message or "Expected %d elements, but there were %d.", expected, actual))

	end,

	equal = function(expected, actual, message)

		assert(actual == expected, string.format(message or "Expected %s and %s to be the same, but were different.", expected, actual))

	end,

	notEqual = function(expected, actual, message)

		assert(actual ~= expected, string.format(message or "Expected %s and %s to be different, but were the same.", expected, actual))

	end,

	containKey = function(item, collection, message)

		assert(collection[item], string.format(message or "Expected the key %s to exist, but didn't.", item))

	end,

	notContainKey = function(item, collection, message)

		assert(collection[item] == nil, string.format(message or "Expected the key %s to exist, but didn't.", item))

	end,

	containValue = function(item, collection, message)

		local inCollection = false

		for k,v in pairs(collection) do
			if v == item then
				inCollection = true
			end
		end

		assert(inCollection, string.format(message or "Expected %s to be in the collection, but it wasn't.", item))

	end,

	notContainValue = function(item, collection, message)

		local inCollection = false

		for k,v in pairs(collection) do
			if v == item then
				inCollection = true
			end
		end

		assert(inCollection == false, string.format(message or "Expected %s to not be in the collection, but it was.", item))

	end,

}

local testEngine = {

	should = should,

	new = function()

		local this = {}
		local sets = {}
		local results = {}

		this.should = should

		this.add = function(name, set)

			assert(type(name) == "string", "must be a name/description of the test set.")
			assert(type(set) == "table", "must be a table of tests to run.")

			sets[name] = set
		end

		this.run = function()

			results = {}

			for name, set in pairs(sets) do
				results[name] = testRunner.runSet(set)
			end

		end

		this.results = function()
			return results
		end

		this.print = function()

			local fails = {}

			print("Tests run:")

			for name, setResults in pairs(results) do
				print("  ", name .. ":")

				for testName, result in pairs(setResults) do
					print("    ", testName, result.success and "passed" or "failed" )

					if not result.success then
						fails[testName] = result
					end

				end

			end

			if next(fails) then

				print("Details")

				for testName, result in pairs(fails) do
					print("    ", testName, result.message)
				end

			end

		end

		return this

	end,

	version = function()

		print("Lunatic.lua, version ".. VERSION)

	end,

}

return testEngine
