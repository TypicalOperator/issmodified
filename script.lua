-- mini script supporter by Kade and others :33
-- should help 


-- i modified kade's script cuz im too lazy

if getfenv(0).OldEnv then
    for i,v in pairs(getfenv(0).OldEnv) do
        getfenv(0)[i] = v
    end
end

getfenv(0).OldEnv = getfenv(0)

if getfenv(0).Loaded then
    --return
end

local Global = getfenv(0)
local FakeCoreGuiEnv = Instance.new("ScreenGui", game:FindFirstChildOfClass("CoreGui"))
local VirtualInputManager = game:FindFirstChildOfClass("VirtualInputManager")

Global.Loaded = true
Global.getgenv = getgenv
Global.rconsoleprint = print

local nilinstances = {}
game.DescendantRemoving:Connect(function(Descendant)
	nilinstances[#nilinstances+1]=Descendant	
end)

game.DescendantAdded:Connect(function(Descendant)
	if table.find(nilinstances, Descendant) then
		nilinstances[Descendant] = nil
	end
end)

Global.sethiddenproperty = function(X, Y, Z) -- kade
    pcall(function()
        X[Y]=Z
    end)
end

Global.getexecutorname = function() -- kade
    return "Incognito"
end

Global.gethiddenproperty = function(X, Y)
    return select(2, pcall(function()
        local Result = X[Y]
        return Result
    end))
end

Global.isscriptable = gethiddenproperty
Global.setscriptable = sethiddenproperty

Global.getscripts = function() 
    local x = {}
    for i,v in pairs(game:GetDescendants()) do
        if v:IsA("Script") then
            x[#x+1]=v
        end
    end
    return x
end

Global.hookfunction = function(Old, New) -- kade
    Old = New
end

Global.isnetworkowner = function(Part) -- kade 
    return Part.ReceiveAge == 0
end

Global.gethui = function(Part) -- kade 
    return FakeCoreGuiEnv
end

Global.getinstances = function() -- kade 
    local x = {}
    for i,v in pairs(game:GetDescendants()) do
        if v:IsA("Instance") then
            x[#x+1]=v
        end
    end
    return x
end

Global.getnilinstances = function() -- kade 
    return nilinstances
end

-- Global.setclipboard = function(String) -- kade 
   -- print(String)
-- end

Global.toclipboard = setclipboard
Global.setrbxclipboard = setclipboard

Global.fireclickdetector = function(ClickDetector) -- pio <---- OH MY GOD PIO
    if typeof(ClickDetector) ~= "ClickDetector" then
        return
    end

    local Parent = ClickDetector.Parent
    if (not Parent) or Parent and typeof(Parent) ~= "Part" then
        return
    end

    local CameraCalc = workspace.CurrentCamera:WorldToViewportPoint(ClickDetector.Parent.Position)

    VirtualInputManager:SendMouseButtonEvent(res.X, res.Y, 0, true, game, 1)
    VirtualInputManager:SendMouseButtonEvent(res.X, res.Y, 0, false, game, 1)
end

Global.cloneref = function(X) -- kade
    return X
end

local HttpService = game:GetService("HttpService")
Global.request = function(url, method, body) -- kade
    local Options = {
        Url = url,
        Method = method,
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(body)
    }
    
    local response = method == "GET" and HttpService:GetAsync(options) or HttpService:PostAsync(options.Url, options.Body)
    local data = HttpService:JSONDecode(response)

    return data
end

Global.writefile = function(path, data)
    print(game:HttpGet("http://localhost:8000/writefile?path="..path.."&data="..data))
end

Global.readfile = function(path)
    print(game:HttpGet("http://localhost:8000/readfile?path="..path))
end

Global.appendfile = function(path, data)
    print(game:HttpGet("http://localhost:8000/appendfile?path="..path.."&data="..data))
end

Global.setclipboard = function(text)
    print(game:HttpGet("http://localhost:8000/setclipboard?text="..text))
end

Global.printREALidentity = function()
    print('level 1 executor 🤢🤮 even ratted arceus x is better "on FULL release we will have OBFUSCATED CODE execution and the incognito support team will be pissing you off tonight"')
end

Global.clonefunction = function(Old, New) -- kade
    local New = Old
    return New
end

Global.mouse1down = function() -- jxsh
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 1)
end

Global.mouse1up = function() -- jxsh
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 1)
end

Global.mouse1click = function() -- jxsh
    mouse1down()
    mouse1up()
end

Global.keypress = function(key) -- jxsh
    VirtualInputManager:SendKeyEvent(true, key, false, game)
end

Global.keyrelease = function(key) -- jxsh
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end
