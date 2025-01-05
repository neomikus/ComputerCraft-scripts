-- Small script for Turtles to level an area --
            -- Made by Mikus --

-- Globals --
y = 0
x = 0
max_x = tonumber(arg[1])
max_y = tonumber(arg[2])
block_to_fill = "minecraft:dirt"

function    refuel(steps)
    
    for i = 1, 16 do
        turtle.select(i)
        if turtle.refuel(0) then break end
    end

    if not turtle.refuel(0) then
        printError("NO FUEL ON INV")
        return (false)
    end

    while turtle.getFuelLevel() < steps do
        turtle.refuel(1)
    end
end

function    select_filler_block()
    local i = 1

    if turtle.getItemDetail(turtle.getSelectedSlot()).name == block_to_fill then return true end

    while i <= 16 do
        if turtle.getItemDetail(i).name == block_to_fill then
            turtle.select(i)
        end
        i = i + 1
    end
    
    if i > 16 then
        printError("NO BLOCK IN INV")
        return false
    end

    return true
end

function    fill_ground()
    if not select_filler_block() then return end
    
    if not turtle.compareDown() then
        turtle.digDown()
        turtle.placeDown()
    end
end

function    mine_upwards(mined)
    local falling = 0
    local moves = 0
    
    while mined > 0 do
        turtle.up()
        mined = mined - 1
    end
    while turtle.detectUp() do
        -- If there's a way to detect gravity in blocks it would be way better --
        local is_block, data = turtle.InspectUp()
        while is_block and data.name == 'Minecraft:gravel' or data.name == 'Minecraft:Sand' or data.name == 'Minecraft:Gravel' do
            falling = falling + 1
            turtle.digUp()
        end
        moves = moves + falling
        while falling > 0 do
            turtle.up()
            falling = falling - 1
        end
        turtle.digUp()
        turtle.up()
        moves = moves + 1
    end

    while moves > 0 do 
        turtle.down() 
        moves = moves - 1
    end

end

-- Border Regions are not gonna contemplate falling blocks, I'm already tired
function    turn(direction)
    local   mined
    if direction == "right" then
        fill_ground()
        mine_upwards(0)
        turtle.turnRight()
        while turtle.detect() do turtle.dig() end
        turtle.forward()
        turtle.turnRight()
    else
        fill_ground()
        mine_upwards(0)
        turtle.turnLeft()
        while turtle.detect() do turtle.dig() end
        turtle.forward()
        turtle.turnLeft()  
    end
end

function    main()
    local mined = 0

    if not arg[1] or not arg[2] then return end
    while y < max_y do
        if turtle.getFuelLevel() < max_x then 
           if not refuel(max_x) then return end
        end
        while x < max_x do
            fill_ground()
            mine_upwards(mined)
            mined = 0
            while turtle.detect() do 
                turtle.dig()
                mined = mined + 1
            end
            turtle.forward()
            x = x + 1
        end
        turn("right")
        if turtle.getFuelLevel() < max_x then 
            if not refuel(max_x) then return end
        end
        while x > 0 do
            fill_ground()
            mine_upwards(mined)
            mined = 0
            while turtle.detect() do 
                turtle.dig()
                mined = mined + 1
            end
            turtle.forward()
            x = x - 1
        end
        turn("left")
        y = y + 1 -- That LUA does not have a var++ or at least var += 1 is a crime against coding
    end
end

main()