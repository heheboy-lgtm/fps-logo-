-- ╔══════════════════════════════════════════╗
-- ║  DMK OVERLAY — SIÊU NHẸ                 ║
-- ║  Chạy qua Executor                      ║
-- ╚══════════════════════════════════════════╝

local RS  = game:GetService("RunService")
local CG  = game:GetService("CoreGui")
local LP  = game:GetService("Players").LocalPlayer

-- dọn cũ
pcall(function()
    local h = gethui and gethui() or CG
    for _, v in ipairs(h:GetChildren()) do
        if v.Name == "DMK_OV" then v:Destroy() end
    end
end)

local Parent = (pcall(gethui) and gethui()) or CG

-- ── GUI ──────────────────────────────────────
local gui = Instance.new("ScreenGui")
gui.Name           = "DMK_OV"
gui.ResetOnSpawn   = false
gui.IgnoreGuiInset = true
gui.DisplayOrder   = 99999
gui.Parent         = Parent

-- ── BLACK frame ──────────────────────────────
local black = Instance.new("Frame")
black.Size                   = UDim2.new(1,0,1,0)
black.BackgroundColor3       = Color3.new(0,0,0)
black.BackgroundTransparency = 1
black.BorderSizePixel        = 0
black.ZIndex                 = 1
black.Visible                = false
black.Parent                 = gui

-- ── CARD — chính giữa ────────────────────────
local card = Instance.new("Frame")
card.Size                   = UDim2.new(0,200,0,145)
card.AnchorPoint            = Vector2.new(0.5,0.5)
card.Position               = UDim2.new(0.5,0,0.5,0)
card.BackgroundColor3       = Color3.fromRGB(6,8,18)
card.BackgroundTransparency = 0.1
card.BorderSizePixel        = 0
card.ZIndex                 = 99999
card.Parent                 = gui
Instance.new("UICorner",card).CornerRadius = UDim.new(0,14)

local sk = Instance.new("UIStroke",card)
sk.Color = Color3.fromRGB(99,179,255)
sk.Transparency = 0.4
sk.Thickness = 2

-- ── DMK ──────────────────────────────────────
local lbName = Instance.new("TextLabel")
lbName.Size                   = UDim2.new(1,0,0,62)
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

-- ── divider ──────────────────────────────────
local dv = Instance.new("Frame")
dv.Size = UDim2.new(1,-20,0,1)
dv.Position = UDim2.new(0,10,0,62)
dv.BackgroundColor3 = Color3.fromRGB(99,179,255)
dv.BackgroundTransparency = 0.6
dv.BorderSizePixel = 0
dv.ZIndex = 99999
dv.Parent = card

-- ── FPS — căn giữa ───────────────────────────
local lbFPS = Instance.new("TextLabel")
lbFPS.Size                   = UDim2.new(1,0,0,30)
lbFPS.Position               = UDim2.new(0,0,0,64)
lbFPS.BackgroundTransparency = 1
lbFPS.Text                   = "FPS: --"
lbFPS.TextColor3             = Color3.fromRGB(74,222,128)
lbFPS.TextSize               = 22
lbFPS.Font                   = Enum.Font.GothamBlack
lbFPS.TextXAlignment         = Enum.TextXAlignment.Center
lbFPS.TextYAlignment         = Enum.TextYAlignment.Center
lbFPS.ZIndex                 = 99999
lbFPS.Parent                 = card

-- ── BLACK button ─────────────────────────────
local btnB = Instance.new("TextButton")
btnB.Size                   = UDim2.new(1,-16,0,20)
btnB.Position               = UDim2.new(0,8,1,-24)
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

-- ════════════════════════════════════════════
-- BLACK LOGIC
-- ════════════════════════════════════════════
local isB = false
pcall(function()
    if isfile and isfile("dmk_b.txt") then isB = readfile("dmk_b.txt")=="true" end
end)

local function setBlack()
    black.Visible = isB
    black.BackgroundTransparency = isB and 0 or 1
    pcall(function() RS:Set3dRenderingEnabled(not isB) end)
    if isB then
        btnB.Text = "BLACK: ON"
        btnB.TextColor3 = Color3.fromRGB(255,70,70)
        sk.Color = Color3.fromRGB(255,60,60)
    else
        btnB.Text = "BLACK: OFF"
        btnB.TextColor3 = Color3.fromRGB(120,120,140)
        sk.Color = Color3.fromRGB(99,179,255)
    end
    pcall(function() if writefile then writefile("dmk_b.txt",tostring(isB)) end end)
end

setBlack()
btnB.MouseButton1Click:Connect(function() isB = not isB; setBlack() end)

-- ════════════════════════════════════════════
-- FPS — chỉ 1 connection RenderStepped, nhẹ nhất có thể
-- ════════════════════════════════════════════
local f, e = 0, 0
RS.RenderStepped:Connect(function(dt)
    f = f + 1
    e = e + dt
    if e >= 1 then                          -- cập nhật mỗi 1 giây
        local fps = math.floor(f / e)
        f, e = 0, 0
        lbFPS.Text = "FPS: " .. fps
        lbFPS.TextColor3 =
            fps >= 50 and Color3.fromRGB(74,222,128) or
            fps >= 30 and Color3.fromRGB(250,204,21) or
            Color3.fromRGB(248,113,113)
    end
end)

print("[DMK] loaded")
