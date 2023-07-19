import "navigation"
import "screens/shop"
-- import "main"

local storage <const> = playdate.datastore

function saveData()
    local save = {
        ["Cookies"] = NumberOfCookies,
        ["Unlocks"] = UnlockedScreens,
        ["ShopItems"] = MenuItems,
    }
    storage.write(save, "save", true)
end

function loadData()
    -- storage.delete("save")
    local save = storage.read("save")
    print(dump(save))
    if save ~= nil then
        if save["Cookies"] ~= nil then
            NumberOfCookies = save["Cookies"]
        end
        if save["Unlocks"] ~= nil then
            UnlockedScreens = save["Unlocks"]
        end
        if save["ShopItems"] ~=nil then
            MenuItems = save["ShopItems"]
        end

        for index, item in pairs(MenuItems) do
            CookiesPerSecond = CookiesPerSecond + item["count"]*item["cps"]
        end

        for i=1,UnlockedScreens do
            Screens[i]["locked"] = false
        end

        -- for index, item in pairs(Screens) do
        --     item["locked"]
        -- end

        Navigation:setNumberOfColumns(UnlockedScreens)
    end
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end