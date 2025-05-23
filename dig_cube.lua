-- Small script for Turtles to dig in a cube --
            -- Made by Mikus --

-- Globals --
X = tonumber(arg[1])
Y = tonumber(arg[2])
Z = tonumber(arg[3])
Neg = false
Left = false

function    Main()
			-- X			Y			 Z
    if not arg[1] or not arg[2] or not arg[3] then return end

	if Y < 0 then
		Neg = true -- If y axis is negative it will dig downwards instead
		Y = Y * -1
	end

	local area = X * Y * Z
	while turtle.getFuelLevel() ~= "unlimited" and turtle.getFuelLevel() < area do
		local ok = turtle.refuel(1)
		if not ok then
			print("Error: Not enough fuel for the task!")
			return (0);
		end
	end


	print(X, Y, Z)
	local x = 0
	local y = 0
	local z = 0

	while y < Y do
		
		z = 0
		while z < Z do
			
			x = 0
			while x < X do
				turtle.dig()
				turtle.forward()
				x = x + 1
			end

			if not Left then
				turtle.turnRight()
				turtle.dig()
				turtle.turnRight()
			else
				turtle.turnLeft()
				turtle.dig()
				turtle.turnLeft()
			end	
		
			Left = not Left
			
			z = z + 1
		end

		if not Neg then
			turtle.digUp()
			turtle.up()
		else
			turtle.digDown()
			turtle.down()
		end

		y = y + 1
	end


end

Main()