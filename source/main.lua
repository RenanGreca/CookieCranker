-- Common CoreLibs imports.
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"


-- Project imports
import "button"
import "crank"
import "lifecycle"
import "simulator"
import "screens/shop"
import "screens/cookie"
import "navigation"
import "storage"

-- Use common shorthands for playdate code
local gfx <const> = playdate.graphics
local ui <const> = playdate.ui

local numberOfCranks = 0
NumberOfCookies = 0
CookiesPerSecond = 0.0
-- Cheat code!
-- CookiesPerSecond = 10^3
local cookieTimer

local function timerCallback()
    print(string.format("NoC %f", NumberOfCookies))
    print(string.format("CpS %f", CookiesPerSecond))
    NumberOfCookies = NumberOfCookies + CookiesPerSecond
    print(string.format("NoC2 %f", NumberOfCookies))
    print()
end

--- By convention, most games need to perform some initial setup when they're
--- initially launched. Perform that setup here.
---
--- Note: This will be called exactly once. If you're looking to do something
--- whenever the game is resumed from the background, see playdate.gameWillResume
--- in lifecycle.lua
local function gameDidLaunch()
    print(playdate.metadata.name .. " launched!")

    loadData()
    -- print(UnlockedScreens)
    -- Navigation:setNumberOfColumns(UnlockedScreens)

    gfx.setBackgroundColor(gfx.kColorWhite)
    -- cookieTimer = playdate.timer.keyRepeatTimerWithDelay(1000, 1000, timerCallback)
end
gameDidLaunch()

local preFPS = 15
local FPS = 15
local lastTime = 0

--- This update method is called once per frame.
function playdate.update()
    -- Update and draw all sprites. Calling this method in playdate.update
    -- is generally what you want, if you're using sprites.
    -- See https://sdk.play.date/1.9.3/#f-graphics.sprite.update for more info
    gfx.sprite.update()

    -- Example code. Draw a full-screen rectangle and the frames per second
    -- gfx.fillRect(0, 0, 400, 240)
    CookieSprite:remove()
    gfx.clear()

    -- gfx.drawText(string.format('%d', playdate.getFPS()), 0, 0)

    crankSpeed = playdate.getCrankChange(change)
    -- easedCrankSpeed = (.95 * easedCrankSpeed) + (.05 * crankSpeed)

    --calculate FPS
    preFPS = FPS
    FPS = 1000 / (playdate.getCurrentTimeMilliseconds() - lastTime)
    FPS = (.95 * preFPS) + (.05 * FPS) --smooth FPS
    lastTime = playdate.getCurrentTimeMilliseconds()

    NumberOfCookies = NumberOfCookies + math.abs(crankSpeed / 360) + (CookiesPerSecond / FPS)
    checkForMilestone()
    -- NumberOfCookies = CookiesPerSecond / FPS

    -- local ticks = getCrankTicks(1)
    -- if (ticks > 0) then
    --     numberOfCranks = numberOfCranks + ticks
    --     NumberOfCookies = NumberOfCookies + ticks
    --     checkForMilestone()
    --     print(string.format("[Crank] performed %d revolutions so far", numberOfCranks))
    -- end

    -- if (Screens[CurrentScreen] == "Shop") {
    --     drawShopMenu()
    -- }
    local screen = Screens[CurrentScreen]
    if (screen) then
        screen.func()
        drawFooter(screen)
    end

    -- Update all timers once per frame. This is required if you're using
    -- timers in your game.
    -- See https://sdk.play.date/1.9.3/#f-timer.updateTimers for more info
    playdate.timer.updateTimers()
end