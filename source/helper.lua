--find distance between two gmt time tables
function getTimeDiff(t1, t2)
    local yearDiff = t2["year"] - t1["year"]
    local monthDiff = t2["month"] - t1["month"]
    local dayDiff = t2["day"] - t1["day"]
    local hourDiff = t2["hour"] - t1["hour"]
    local minuteDiff = t2["minute"] - t1["minute"]
    local secondDiff = t2["second"] - t1["second"]
    local millisecondDiff = t2["millisecond"] - t1["millisecond"]
    return (yearDiff * 31536000) + (monthDiff * 2592000) + (dayDiff * 86400) + (hourDiff * 3600) + (minuteDiff * 60) +
        secondDiff + (millisecondDiff / 1000)
end

function round(num, idp)
    local mult = 10 ^ (idp or 0)
    if math.floor(num * mult + 0.5) / mult == nil then
        return 0
    end
    return math.floor(num * mult + 0.5) / mult
end

function abbreviate(num)
    local abbrv = {
        "",
        "k",
        "m",
        "b",
        "t",
        "q",
        "Q",
        "s",
        "S",
        "o",
        "n",
        "d",
        "N/A"
    }
    -- local abbrv = {
    --     "",
    --     "10^3",
    --     "10^6",
    --     "10^9",
    --     "10^12",
    --     "10^15",
    --     "10^18",
    --     "10^21",
    --     "10^24",
    --     "10^27",
    --     "10^30",
    --     "10^33",
    --     "10^36"
    -- }
    local pos = math.max(math.min(math.floor(math.log(num, 10) / 3) + 1, 13), 1)
    -- print(pos)
    -- if pos >= 13 then
    --     -- we have reached the end of the world
    -- end
    local result = round(num / 10 ^ (math.max(math.floor(math.log(num, 10) / 3), 0) * 3), 3) .. abbrv[pos]
    if num < 1000 then
        result = string.gsub(result, "%.0", "")
    end
    return result
    -- return {result, abbrv[pos]}
end