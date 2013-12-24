
local testRunner = {

	run = function(before, test, after)

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

	end,

}
