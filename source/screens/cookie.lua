import "CoreLibs/graphics"
import "CoreLibs/sprites"

local gfx <const> = playdate.graphics

local cookieImage = gfx.image.new("images/cookie.png")
assert(cookieImage)
CookieSprite = gfx.sprite.new(cookieImage)
assert(CookieSprite)
CookieSprite:moveTo(200, 120)

function drawCookieScreen()
    CookieSprite:add()
    gfx.sprite.update()

    if CookiesPerSecond > 0 then 
        local num = abbreviate(CookiesPerSecond)
        -- print(dump(num))
        local s = string.format("*%s CpS*", num)
        gfx.drawTextAligned(s, 200, 160, kTextAlignment.center)
    end
end