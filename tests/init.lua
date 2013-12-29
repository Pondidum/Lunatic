local ns = ...

local lunatic = require("lunatic")
local should = loadfile("lib\\should.lua")()

ns.lunatic = lunatic
ns.tests = lunatic.new()
ns.should = should
