#Lunatic

A small library for running unit tests in lua.

##Features

* Separate environment per test to be run.
* Setup and Teardown in the form of `before` and `after` functions.
* Simple api.


##Example

```lua
local engine = require("Lunatic")

engine.add("Example Tests", {

	before = function()
		-- optional, do your setup
		-- runs before every test
	end,

	after = function()
		-- optional, do any clean up
		-- runs after every test
	end,

	When_a_test_raises_an_error = function()
		error("I am failing")
	end,

	When_a_test_raises_an_assertion = function()
		assert(false, "I am a failing assertion")
	end,

	When_a_test_doesnt_error = function()
		assert(true, "I am a passing assertion")
	end,

})

-- run the tests
engine.run()

-- you can print the results directly
engine.print()

-- or you can get the results and inspect etc.
local results = engine.results()
```
