local ns = ...

local lunatic = loadfile("src\\lunatic.lua")()
local should = loadfile("lib\\should.lua")()

ns.lunatic = lunatic
ns.tests = lunatic.new()
ns.should = should
