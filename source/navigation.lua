import "CoreLibs/ui"
import "CoreLibs/graphics"

import "screens/cookie"
import "screens/shop"

import "helper"

-- Use common shorthands for playdate code
local gfx <const> = playdate.graphics
local ui <const> = playdate.ui

Milestones = {10}

Screens = {
    {name="COOKIE", func=drawCookieScreen, locked=false },
    {name="SHOP", func=drawShopMenu, locked=true },
}
UnlockedScreens = 1
CurrentScreen = 1

Navigation = ui.gridview.new(100, 5)
Navigation:setNumberOfRows(1)
Navigation:setCellPadding(1, 1, 1, 1)
Navigation:setCellSize(10, 10)

function Navigation:drawCell(section, row, column, selected, x, y, width, height)
    if Screens[column].locked then
        return
    end
    if selected then
        gfx.fillCircleAtPoint(x+width, y+height, width/2)
    else
        gfx.drawCircleAtPoint(x+width, y+height, width/2)
    end
end

function drawFooter(screen)
    gfx.drawLine(0, 215, 400, 215)
    -- gfx.drawRect(0, 220, 100, 20)
    Navigation:drawInRect(200, 215, 100, 20)
    -- gfx.fillCircleAtPoint(200, 220, 5)
    -- local s = string.format("*You have %d cookies*", math.floor(NumberOfCookies))
    local num = abbreviate(math.floor(NumberOfCookies))
    local s = string.format("*C$%s*", num)
    gfx.drawTextAligned(s, 10, 220, kTextAlignment.left)
    -- s = string.format("+ %s", num[2])
    -- gfx.drawTextAligned(s, 70, 220, kTextAlignment.left)
    gfx.drawTextAligned(string.format("*%s*",screen.name), 390, 220, kTextAlignment.right)
end

function checkForMilestone()
    if #Milestones < UnlockedScreens then
        return
    end
    if NumberOfCookies >= Milestones[UnlockedScreens] then
        UnlockedScreens = UnlockedScreens + 1
        Screens[UnlockedScreens].locked = false
        Navigation:setNumberOfColumns(UnlockedScreens)
    end
end

function setSelectedScreen(val)
    CurrentScreen = (CurrentScreen-1+val)%UnlockedScreens + 1
end