
local testRunner = {}

testRunner.run = function(before, test, after)

	local old = getfenv()

	setfenv(1, setmetatable({}, { __index = old }))

	local action = function()

		if before then
			pcall(before)
		end

		local success, e = pcall(test)

		if after then
			after()
		end

		return success, e

	end

	local s, e = action()

	setfenv(1, old)

	return s, e

end

testRunner.runSet = function(set)

	local before = set.before
	local after = set.after

	local result = {}

	for k,v in pairs(set) do

		if k ~= "before" and k ~= "after" then
			result[k] = testRunner.run(before, v, after)
		end

	end

	return result

end