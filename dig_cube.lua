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

    if Z < 0 then
        Left = true
        Z = Z * -1
    end

	local area = X * Y * Z
	while turtle.getFuelLevel() ~= "unlimited" and turtle.getFuelLevel() < area do
		local ok = turtle.refuel(1)
		if not ok then
			print("Error: Not enough fuel for the task!")
			return (0);
		end
	end


	local x = 0
	local y = 0
	local z = 0
	local reverse = false

	while y < Y do
		
		z = 0
		while z < Z do
			
			x = 0
			while x < X do
				turtle.dig()
				turtle.forward()
				x = x + 1
			end
            
            if z < Z - 1 then
                if not reverse then
                    if not Left then
                        turtle.turnRight()
                        turtle.dig()
                        turtle.forward()
                        turtle.turnRight()
                    else
                        turtle.turnLeft()
                        turtle.dig()
                        turtle.forward()
                        turtle.turnLeft()
                    end
                else
                    if Left then
                        turtle.turnRight()
                        turtle.dig()
                        turtle.forward()
                        turtle.turnRight()
                    else
                        turtle.turnLeft()
                        turtle.dig()
                        turtle.forward()
                        turtle.turnLeft()
                    end
                end
            else
                turtle.turnLeft()
                turtle.turnLeft()
            end
            
			Left = not Left
			
			z = z + 1
		end
        
		if not Neg and y < Y - 1 then
			turtle.digUp()
			turtle.up()
        elseif y < Y - 1 then
			turtle.digDown()
			turtle.down()
		end
        
        reverse = not reverse
		y = y + 1
	end

    while y < 0 do
        turtle.down()
        y = y - 1
    end

end

Main()