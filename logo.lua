local RS  = game:GetService("RunService")
local CG  = game:GetService("CoreGui")
local LP  = game:GetService("Players").LocalPlayer

pcall(function()
    local h = gethui and gethui() or CG
    for _, v in ipairs(h:GetChildren()) do
        if v.Name == "DMK_OV" then v:Destroy() end
    end
end)
local Parent = (pcall(gethui) and gethui()) or CG

local gui = Instance.new("ScreenGui")
gui.Name           = "DMK_OV"
gui.ResetOnSpawn   = false
gui.IgnoreGuiInset = true
gui.DisplayOrder   = 99999
gui.Parent         = Parent
local black = Instance.new("Frame")
black.Size                   = UDim2.new(1,0,1,0)
black.BackgroundColor3       = Color3.new(0,0,0)
black.BackgroundTransparency = 1
black.BorderSizePixel        = 0
black.ZIndex                 = 1
black.Visible                = false
black.Parent                 = gui
local card = Instance.new("Frame")
card.Size                   = UDim2.new(0,200,0,170)   -- cao hơn để chứa ping
card.AnchorPoint            = Vector2.new(0.5,0.5)
card.Position               = UDim2.new(0.5,0,0.5,0)
card.BackgroundColor3       = Color3.fromRGB(6,8,18)
card.BackgroundTransparency = 0.1
card.BorderSizePixel        = 0
card.ZIndex                 = 99999
card.Parent                 = gui
Instance.new("UICorner",card).CornerRadius = UDim.new(0,14)
local sk = Instance.new("UIStroke",card)
sk.Color        = Color3.fromRGB(99,179,255)
sk.Transparency = 0.4
sk.Thickness    = 2
local lbName = Instance.new("TextLabel")
lbName.Size                   = UDim2.new(1,0,0,70)
lbName.Position               = UDim2.new(0,0,0,0)
lbName.BackgroundTransparency = 1
lbName.Text                   = "DMK"
lbName.TextColor3             = Color3.fromRGB(99,179,255)
lbName.TextSize               = 48
lbName.Font                   = Enum.Font.GothamBlack
lbName.TextXAlignment         = Enum.TextXAlignment.Center
lbName.TextYAlignment         = Enum.TextYAlignment.Center
lbName.ZIndex                 = 99999
lbName.Parent                 = card
local dv1 = Instance.new("Frame")
dv1.Size                = UDim2.new(1,-20,0,1)
dv1.Position            = UDim2.new(0,10,0,70)
dv1.BackgroundColor3    = Color3.fromRGB(99,179,255)
dv1.BackgroundTransparency = 0.6
dv1.BorderSizePixel     = 0
dv1.ZIndex              = 99999
dv1.Parent              = card
local lbFPS = Instance.new("TextLabel")
lbFPS.Size                   = UDim2.new(1,0,0,32)
lbFPS.Position               = UDim2.new(0,0,0,72)
lbFPS.BackgroundTransparency = 1
lbFPS.Text                   = "FPS: --"
lbFPS.TextColor3             = Color3.fromRGB(74,222,128)
lbFPS.TextSize               = 22
lbFPS.Font                   = Enum.Font.GothamBlack
lbFPS.TextXAlignment         = Enum.TextXAlignment.Center
lbFPS.TextYAlignment         = Enum.TextYAlignment.Center
lbFPS.ZIndex                 = 99999
lbFPS.Parent                 = card
local lbPing = Instance.new("TextLabel")
lbPing.Size                   = UDim2.new(1,0,0,28)
lbPing.Position               = UDim2.new(0,0,0,104)
lbPing.BackgroundTransparency = 1
lbPing.Text                   = "PING: --"
lbPing.TextColor3             = Color3.fromRGB(180,180,200)
lbPing.TextSize               = 18
lbPing.Font                   = Enum.Font.GothamBlack
lbPing.TextXAlignment         = Enum.TextXAlignment.Center
lbPing.TextYAlignment         = Enum.TextYAlignment.Center
lbPing.ZIndex                 = 99999
lbPing.Parent                 = card
local dv2 = Instance.new("Frame")
dv2.Size                = UDim2.new(1,-20,0,1)
dv2.Position            = UDim2.new(0,10,0,133)
dv2.BackgroundColor3    = Color3.fromRGB(99,179,255)
dv2.BackgroundTransparency = 0.6
dv2.BorderSizePixel     = 0
dv2.ZIndex              = 99999
dv2.Parent              = card
local btnB = Instance.new("TextButton")
btnB.Size                   = UDim2.new(1,-16,0,22)
btnB.Position               = UDim2.new(0,8,1,-26)
btnB.BackgroundColor3       = Color3.fromRGB(18,18,26)
btnB.BackgroundTransparency = 0.1
btnB.Text                   = "BLACK: OFF"
btnB.TextColor3             = Color3.fromRGB(120,120,140)
btnB.Font                   = Enum.Font.GothamBold
btnB.TextSize               = 10
btnB.BorderSizePixel        = 0
btnB.ZIndex                 = 99999
btnB.Parent                 = card
Instance.new("UICorner",btnB).CornerRadius = UDim.new(0,6)
local isB = false
pcall(function()
    if isfile and isfile("dmk_b.txt") then isB = readfile("dmk_b.txt")=="true" end
end)

local function setBlack()
    black.Visible                = isB
    black.BackgroundTransparency = isB and 0 or 1
    pcall(function() RS:Set3dRenderingEnabled(not isB) end)
    if isB then
        btnB.Text       = "BLACK: ON"
        btnB.TextColor3 = Color3.fromRGB(255,70,70)
        sk.Color        = Color3.fromRGB(255,60,60)
    else
        btnB.Text       = "BLACK: OFF"
        btnB.TextColor3 = Color3.fromRGB(120,120,140)
        sk.Color        = Color3.fromRGB(99,179,255)
    end
    pcall(function() if writefile then writefile("dmk_b.txt",tostring(isB)) end end)
end

setBlack()
btnB.MouseButton1Click:Connect(function() isB = not isB; setBlack() end)
local f, e = 0, 0

RS.RenderStepped:Connect(function(dt)
    f = f + 1
    e = e + dt
    if e >= 1 then
        -- FPS
        local fps = math.floor(f / e)
        f, e = 0, 0
        lbFPS.Text = "FPS: " .. fps
        lbFPS.TextColor3 =
            fps >= 50 and Color3.fromRGB(74,222,128) or
            fps >= 30 and Color3.fromRGB(250,204,21) or
            Color3.fromRGB(248,113,113)

        -- PING
        pcall(function()
            local ping = math.floor(LP:GetNetworkPing() * 1000)
            lbPing.Text = "PING: " .. ping .. "ms"
            lbPing.TextColor3 =
                ping <= 80  and Color3.fromRGB(74,222,128) or
                ping <= 150 and Color3.fromRGB(250,204,21) or
                Color3.fromRGB(248,113,113)
        end)
    end
end)

print("[DMK] loaded")
