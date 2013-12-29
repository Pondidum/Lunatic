local project = loadfile("lib\\project.lua")()

local testProject = project:new({

	files = project:io(function(io)

		io.addFile("tests\\init.lua")
		io.addFilesIn("tests")

	end),

	run = function(ns)

		ns.tests.run()
		ns.tests.print()

	end,

})

testProject.run()
