-- Common CoreLibs imports.
import "CoreLibs/graphics"
import "CoreLibs/ui"


local gfx <const> = playdate.graphics
local ui <const> = playdate.ui

-- local menuItems = ["Grandma", "Cookie Factory", "Cookie Monster"]
MenuItems = {
    { name="Grandma", count=0, cost=10, cps=1 },
    { name="Cookie Factory", count=0, cost=100, cps=10 },
    { name="Cookie Monster", count=0, cost=1000, cps=100 }
}
-- Selected = 1

Shop = ui.gridview.new(0, 20)
Shop:setNumberOfRows(#MenuItems)
Shop:setContentInset(0, 0, 1, 1)
Shop:setCellPadding(0, 0, 1, 1)

function Shop:drawCell(section, row, column, selected, x, y, width, height)
    if selected then
        gfx.fillRoundRect(x, y, width-20, 20, 4)
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    else
        gfx.setImageDrawMode(gfx.kDrawModeCopy)
    end
    local string = string.format("%s", MenuItems[row]["name"])
    gfx.drawTextInRect(string, x + 24, y + 2, width, height)
    string = string.format("%d", MenuItems[row]["count"])
    gfx.drawTextInRect(string, 370, y + 2, width, height, kTextAlignment.right)

    -- if (i == Selected) then
    --     playdate.graphics.drawRoundRect(5, yPos-3, 390, 24, 2)
    -- end
    -- gfx.drawTextAligned(string, 10, yPos, kTextAlignment.left)
    -- string = string.format("C$%d", MenuItems[i]["cost"])
    -- gfx.drawTextAligned(string, 390, yPos, kTextAlignment.right)
end

function drawShopMenu()
    local selected = Shop:getSelectedRow()
    -- local cash = string.format("*C$%s*", NumberOfCookies)
    -- gfx.drawTextAligned(cash, 10, 5, kTextAlignment.left)
    local cost = string.format("*COST C$%d*", MenuItems[selected].cost)
    gfx.drawTextAligned(cost, 390, 5, kTextAlignment.right)

    Shop:drawInRect(9, 30, 400, 200)
    -- local yPos = 25
    -- for i=1, 3 do
    --     if (i == Selected) then
    --         playdate.graphics.drawRoundRect(5, yPos-3, 390, 24, 2)
    --     end
    --     local string = string.format("(%d) %s", MenuItems[i]["count"], MenuItems[i]["name"])
    --     gfx.drawTextAligned(string, 10, yPos, kTextAlignment.left)
    --     string = string.format("C$%d", MenuItems[i]["cost"])
    --     gfx.drawTextAligned(string, 390, yPos, kTextAlignment.right)
    --     yPos = yPos + 25
    -- end
    -- gfx.drawTextAligned(string.format("(%d) %s", menuItems[0], menuQuantities[menuItems[0]]), 200, 25, kTextAlignment.left)
    -- gfx.drawTextAligned(string.format("(%d) %s", menuItems[1], menuQuantities[menuItems[1]]), 200, 50, kTextAlignment.left)
    -- gfx.drawTextAligned(string.format("(%d) %s", menuItems[2], menuQuantities[menuItems[2]]), 200, 75, kTextAlignment.left)
end

-- function setSelectedShopItem(val)
--     Shop:selectNextRow(val)
-- end