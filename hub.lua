-- [[ Steal Egg Vip Hub - Full Source Code ]]
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("StealEggVipHub") then
    PlayerGui.StealEggVipHub:Destroy()
end

local TextTable = {
    EN = {
        Title = "Steal Egg Vip | FlowAuth",
        AutoSteal = "Toggle Auto Steal & Godmode",
        OpenSide = "Open Pet & Egg List Panel",
        WalkSpeed = "WalkSpeed (Max 1000):",
        TweenSpeed = "Tween Fly Speed:",
        StatusReady = "🟢 Secure & Optimized!",
        TargetDef = "🎯 Target: Auto highest value",
        SideTitle = "Pet & Egg List Panel",
        RefreshBtn = "Refresh List",
        ChooseBtn = "CHOOSE",
        LangBtn = "VN / EN",
        StatusStealing = "⚡ Stealing: ",
        StatusSafe = "🛡️ Returning to Safe Zone...",
        StatusFinding = "🔍 Scanning targets...",
        StatusGhim = "✅ Target fixed!",
        StatusRefreshed = "🔄 List refreshed!"
    },
    VN = {
        Title = "Steal Egg Vip | FlowAuth",
        AutoSteal = "Bật Auto Steal & Chống Chết",
        OpenSide = "Mở Bảng Chọn Pet & Trứng",
        WalkSpeed = "Tốc độ chạy (WalkSpeed):",
        TweenSpeed = "Tốc độ bay (Tween Speed):",
        StatusReady = "🟢 Đã bảo mật & tối ưu!",
        TargetDef = "🎯 Đang chọn: Tự động con cao nhất",
        SideTitle = "Danh Sách Pet & Trứng",
        RefreshBtn = "Làm mới danh sách",
        ChooseBtn = "CHỌN",
        LangBtn = "EN / VN",
        StatusStealing = "⚡ Đang trộm: ",
        StatusSafe = "🛡️ Về Safe Zone an toàn...",
        StatusFinding = "🔍 Đang tìm trứng/pet...",
        StatusGhim = "✅ Đã ghim mục tiêu!",
        StatusRefreshed = "🔄 Đã làm mới danh sách!"
    }
}

local CurrentLang = "EN"
local function T(key)
    if TextTable[CurrentLang] and TextTable[CurrentLang][key] then
        return TextTable[CurrentLang][key]
    end
    return key
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealEggVipHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 500)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = T("Title")
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local LangToggleBtn = Instance.new("TextButton")
LangToggleBtn.Size = UDim2.new(0, 75, 0, 28)
LangToggleBtn.Position = UDim2.new(1, -115, 0.5, -14)
LangToggleBtn.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
LangToggleBtn.Text = T("LangBtn")
LangToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LangToggleBtn.TextSize = 10
LangToggleBtn.Font = Enum.Font.GothamBold
LangToggleBtn.Parent = TopBar
Instance.new("UICorner", LangToggleBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -16)
CloseBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
CloseBtn.MouseButton1Click:Connect(function() 
    pcall(function() ScreenGui:Destroy() end) 
end)

local SidePanel = Instance.new("Frame")
SidePanel.Size = UDim2.new(0, 320, 0, 500)
SidePanel.Position = UDim2.new(1, 10, 0, 0)
SidePanel.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
SidePanel.BorderSizePixel = 0
SidePanel.Visible = false
SidePanel.Parent = MainFrame
Instance.new("UICorner", SidePanel).CornerRadius = UDim.new(0, 12)

local SideTop = Instance.new("Frame")
SideTop.Size = UDim2.new(1, 0, 0, 45)
SideTop.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
SideTop.BorderSizePixel = 0
SideTop.Parent = SidePanel
Instance.new("UICorner", SideTop).CornerRadius = UDim.new(0, 12)

local SideTitle = Instance.new("TextLabel")
SideTitle.Size = UDim2.new(1, -20, 1, 0)
SideTitle.Position = UDim2.new(0, 15, 0, 0)
SideTitle.BackgroundTransparency = 1
SideTitle.Text = T("SideTitle")
SideTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SideTitle.TextSize = 13
SideTitle.Font = Enum.Font.GothamBold
SideTitle.TextXAlignment = Enum.TextXAlignment.Left
SideTitle.Parent = SideTop

local SideListContainer = Instance.new("ScrollingFrame")
SideListContainer.Size = UDim2.new(1, -20, 1, -110)
SideListContainer.Position = UDim2.new(0, 10, 0, 55)
SideListContainer.BackgroundTransparency = 1
SideListContainer.BorderSizePixel = 0
SideListContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
SideListContainer.ScrollBarThickness = 3
SideListContainer.Parent = SidePanel

local SideUIList = Instance.new("UIListLayout")
SideUIList.SortOrder = Enum.SortOrder.LayoutOrder
SideUIList.Padding = UDim.new(0, 5)
SideUIList.Parent = SideListContainer

local RefreshListBtn = Instance.new("TextButton")
RefreshListBtn.Size = UDim2.new(1, -20, 0, 35)
RefreshListBtn.Position = UDim2.new(0, 10, 1, -45)
RefreshListBtn.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
RefreshListBtn.Text = T("RefreshBtn")
RefreshListBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshListBtn.TextSize = 12
RefreshListBtn.Font = Enum.Font.GothamBold
RefreshListBtn.Parent = SidePanel
Instance.new("UICorner", RefreshListBtn).CornerRadius = UDim.new(0, 6)

local Config = {
    AutoSteal = false,
    GodMode = true,
    SelectedTarget = nil,
    StealSpeed = 1.5,
    TweenFlySpeed = 50,
    WalkSpeedVal = 16,
    SafeZonePos = Vector3.new(0, 10, 0)
}

local function createSectionTitle(text, posY)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -30, 0, 20)
    lbl.Position = UDim2.new(0, 15, 0, posY)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(150, 150, 180)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = MainFrame
    return lbl
end

local sec1 = createSectionTitle("1. CONTROLS & UTILITIES", 52)

local ControlBox = Instance.new("Frame")
ControlBox.Size = UDim2.new(1, -30, 0, 195)
ControlBox.Position = UDim2.new(0, 15, 0, 75)
ControlBox.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
ControlBox.BorderSizePixel = 0
ControlBox.Parent = MainFrame
Instance.new("UICorner", ControlBox).CornerRadius = UDim.new(0, 8)

local ToggleFrame = Instance.new("Frame")
ToggleFrame.Size = UDim2.new(1, -20, 0, 35)
ToggleFrame.Position = UDim2.new(0, 10, 0, 8)
ToggleFrame.BackgroundTransparency = 1
ToggleFrame.Parent = ControlBox

local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = T("AutoSteal")
ToggleLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
ToggleLabel.TextSize = 12
ToggleLabel.Font = Enum.Font.Gotham
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.Parent = ToggleFrame

local SwitchBtn = Instance.new("TextButton")
SwitchBtn.Size = UDim2.new(0, 45, 0, 22)
SwitchBtn.Position = UDim2.new(1, -45, 0.5, -11)
SwitchBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
SwitchBtn.Text = ""
SwitchBtn.Parent = ToggleFrame
Instance.new("UICorner", SwitchBtn).CornerRadius = UDim.new(1, 0)

local Circle = Instance.new("Frame")
Circle.Size = UDim2.new(0, 16, 0, 16)
Circle.Position = UDim2.new(0, 3, 0.5, -8)
Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Circle.Parent = SwitchBtn
Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

SwitchBtn.MouseButton1Click:Connect(function()
    Config.AutoSteal = not Config.AutoSteal
    if Config.AutoSteal then
        SwitchBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        Circle.Position = UDim2.new(1, -19, 0.5, -8)
    else
        SwitchBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
        Circle.Position = UDim2.new(0, 3, 0.5, -8)
    end
end)

local SideToggleFrame = Instance.new("Frame")
SideToggleFrame.Size = UDim2.new(1, -20, 0, 35)
SideToggleFrame.Position = UDim2.new(0, 10, 0, 45)
SideToggleFrame.BackgroundTransparency = 1
SideToggleFrame.Parent = ControlBox

local SideToggleLabel = Instance.new("TextLabel")
SideToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
SideToggleLabel.BackgroundTransparency = 1
SideToggleLabel.Text = T("OpenSide")
SideToggleLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
SideToggleLabel.TextSize = 12
SideToggleLabel.Font = Enum.Font.Gotham
SideToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
SideToggleLabel.Parent = SideToggleFrame

local SideSwitchBtn = Instance.new("TextButton")
SideSwitchBtn.Size = UDim2.new(0, 45, 0, 22)
SideSwitchBtn.Position = UDim2.new(1, -45, 0.5, -11)
SideSwitchBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
SideSwitchBtn.Text = ""
SideSwitchBtn.Parent = SideToggleFrame
Instance.new("UICorner", SideSwitchBtn).CornerRadius = UDim.new(1, 0)

local SideCircle = Instance.new("Frame")
SideCircle.Size = UDim2.new(0, 16, 0, 16)
SideCircle.Position = UDim2.new(0, 3, 0.5, -8)
SideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SideCircle.Parent = SideSwitchBtn
Instance.new("UICorner", SideCircle).CornerRadius = UDim.new(1, 0)

SideSwitchBtn.MouseButton1Click:Connect(function()
    SidePanel.Visible = not SidePanel.Visible
    if SidePanel.Visible then
        SideSwitchBtn.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
        SideCircle.Position = UDim2.new(1, -19, 0.5, -8)
    else
        SideSwitchBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
        SideCircle.Position = UDim2.new(0, 3, 0.5, -8)
    end
end)

local SpeedInputFrame = Instance.new("Frame")
SpeedInputFrame.Size = UDim2.new(1, -20, 0, 32)
SpeedInputFrame.Position = UDim2.new(0, 10, 0, 85)
SpeedInputFrame.BackgroundTransparency = 1
SpeedInputFrame.Parent = ControlBox

local SpeedText = Instance.new("TextLabel")
SpeedText.Size = UDim2.new(0.6, 0, 1, 0)
SpeedText.BackgroundTransparency = 1
SpeedText.Text = T("WalkSpeed")
SpeedText.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedText.TextSize = 11
SpeedText.Font = Enum.Font.Gotham
SpeedText.TextXAlignment = Enum.TextXAlignment.Left
SpeedText.Parent = SpeedInputFrame

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0.35, 0, 0, 26)
SpeedBox.Position = UDim2.new(0.65, 0, 0.5, -13)
SpeedBox.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
SpeedBox.Text = "16"
SpeedBox.TextColor3 = Color3.fromRGB(46, 204, 113)
SpeedBox.TextSize = 12
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.ClearTextOnFocus = false
SpeedBox.Parent = SpeedInputFrame
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 6)

SpeedBox.FocusLost:Connect(function()
    local val = tonumber(SpeedBox.Text)
    if val then
        if val > 1000 then val = 1000 elseif val < 16 then val = 16 end
        Config.WalkSpeedVal = val
        SpeedBox.Text = tostring(val)
    end
end)

local TweenInputFrame = Instance.new("Frame")
TweenInputFrame.Size = UDim2.new(1, -20, 0, 32)
TweenInputFrame.Position = UDim2.new(0, 10, 0, 122)
TweenInputFrame.BackgroundTransparency = 1
TweenInputFrame.Parent = ControlBox

local TweenText = Instance.new("TextLabel")
TweenText.Size = UDim2.new(0.6, 0, 1, 0)
TweenText.BackgroundTransparency = 1
TweenText.Text = T("TweenSpeed")
TweenText.TextColor3 = Color3.fromRGB(200, 200, 200)
TweenText.TextSize = 11
TweenText.Font = Enum.Font.Gotham
TweenText.TextXAlignment = Enum.TextXAlignment.Left
TweenText.Parent = TweenInputFrame

local TweenBox = Instance.new("TextBox")
TweenBox.Size = UDim2.new(0.35, 0, 0, 26)
TweenBox.Position = UDim2.new(0.65, 0, 0.5, -13)
TweenBox.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
TweenBox.Text = "50"
TweenBox.TextColor3 = Color3.fromRGB(52, 152, 219)
TweenBox.TextSize = 12
TweenBox.Font = Enum.Font.GothamBold
TweenBox.ClearTextOnFocus = false
TweenBox.Parent = TweenInputFrame
Instance.new("UICorner", TweenBox).CornerRadius = UDim.new(0, 6)

TweenBox.FocusLost:Connect(function()
    local val = tonumber(TweenBox.Text)
    if val and val > 0 then
        Config.TweenFlySpeed = val
    else
        TweenBox.Text = tostring(Config.TweenFlySpeed)
    end
end)

local sec2 = createSectionTitle("2. STATUS & TARGET", 280)

local StatusBox = Instance.new("Frame")
StatusBox.Size = UDim2.new(1, -30, 0, 95)
StatusBox.Position = UDim2.new(0, 15, 0, 305)
StatusBox.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
StatusBox.BorderSizePixel = 0
StatusBox.Parent = MainFrame
Instance.new("UICorner", StatusBox).CornerRadius = UDim.new(0, 8)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 45)
StatusLabel.Position = UDim2.new(0, 10, 0, 6)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = T("StatusReady")
StatusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextWrapped = true
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = StatusBox

local TargetInfoLabel = Instance.new("TextLabel")
TargetInfoLabel.Size = UDim2.new(1, -20, 0, 35)
TargetInfoLabel.Position = UDim2.new(0, 10, 0, 52)
TargetInfoLabel.BackgroundTransparency = 1
TargetInfoLabel.Text = T("TargetDef")
TargetInfoLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
TargetInfoLabel.TextSize = 11
TargetInfoLabel.Font = Enum.Font.Gotham
TargetInfoLabel.TextWrapped = true
TargetInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
TargetInfoLabel.Parent = StatusBox

local function updateUILanguage()
    pcall(function()
        Title.Text = T("Title")
        LangToggleBtn.Text = T("LangBtn")
        ToggleLabel.Text = T("AutoSteal")
        SideToggleLabel.Text = T("OpenSide")
        SpeedText.Text = T("WalkSpeed")
        TweenText.Text = T("TweenSpeed")
        sec1.Text = CurrentLang == "VN" and "1. ĐIỀU KHIỂN & TIỆN ÍCH" or "1. CONTROLS & UTILITIES"
        sec2.Text = CurrentLang == "VN" and "2. TRẠNG THÁI & MỤC TIÊU" or "2. STATUS & TARGET"
        SideTitle.Text = T("SideTitle")
        RefreshListBtn.Text = T("RefreshBtn")
        StatusLabel.Text = T("StatusReady")
    end)
end

LangToggleBtn.MouseButton1Click:Connect(function()
    CurrentLang = (CurrentLang == "EN") and "VN" or "EN"
    updateUILanguage()
end)

local function parseMoneyValue(text)
    local numStr = text:match("[%d%.]+")
    if not numStr then return 0 end
    local val = tonumber(numStr) or 0
    local lower = text:lower()
    if lower:find("k") then val = val * 1e3
    elseif lower:find("m") then val = val * 1e6
    elseif lower:find("b") then val = val * 1e9
    elseif lower:find("t") then val = val * 1e12 end
    return val
end

local function scanMapTargets()
    local results = {}
    local folders = {Workspace, Workspace:FindFirstChild("Map"), Workspace:FindFirstChild("Spawned"), Workspace:FindFirstChild("Eggs")}
    for _, parentFolder in ipairs(folders) do
        if parentFolder then
            pcall(function()
                for _, obj in ipairs(parentFolder:GetChildren()) do
                    if obj and obj.Parent then
                        local nameL = obj.Name:lower()
                        if obj:IsA("Model") or obj:IsA("BasePart") then
                            if nameL:find("egg") or nameL:find("pet") or nameL:find("unit") then
                                local primaryPart = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                                if primaryPart then
                                    local earningsText = "+$100/s"
                                    local displayName = obj.Name
                                    local count = 0
                                    for _, desc in ipairs(obj:GetDescendants()) do
                                        count = count + 1
                                        if count > 15 then break end
                                        if desc:IsA("TextLabel") and desc.Text ~= "" then
                                            local txt = desc.Text
                                            if txt:lower():find("$") or txt:lower():find("/s") then
                                                earningsText = txt
                                            elseif not txt:lower():find("egg") and #txt < 15 then
                                                displayName = txt
                                            end
                                        end
                                    end
                                    table.insert(results, {
                                        Object = obj,
                                        Part = primaryPart,
                                        Name = displayName,
                                        Earnings = earningsText,
                                        Score = parseMoneyValue(earningsText)
                                    })
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
    pcall(function()
        table.sort(results, function(a, b) return a.Score > b.Score end)
    end)
    return results
end

local function updateSideList()
    pcall(function()
        for _, child in ipairs(SideListContainer:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end
        local list = scanMapTargets()
        for i, item in ipairs(list) do
            if i > 25 then break end
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 36)
            row.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
            row.Parent = SideListContainer
            Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

            local infoLbl = Instance.new("TextLabel")
            infoLbl.Size = UDim2.new(0.65, 0, 1, 0)
            infoLbl.Position = UDim2.new(0, 8, 0, 0)
            infoLbl.BackgroundTransparency = 1
            infoLbl.Text = "🐾 " .. item.Name .. "\n💰 " .. item.Earnings
            infoLbl.TextColor3 = Color3.fromRGB(230, 230, 230)
            infoLbl.TextSize = 10
            infoLbl.Font = Enum.Font.GothamBold
            infoLbl.TextXAlignment = Enum.TextXAlignment.Left
            infoLbl.Parent = row

            local chooseBtn = Instance.new("TextButton")
            chooseBtn.Size = UDim2.new(0, 75, 0, 26)
            chooseBtn.Position = UDim2.new(1, -80, 0.5, -13)
            chooseBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
            chooseBtn.Text = T("ChooseBtn")
            chooseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            chooseBtn.TextSize = 11
            chooseBtn.Font = Enum.Font.GothamBold
            chooseBtn.Parent = row
            Instance.new("UICorner", chooseBtn).CornerRadius = UDim.new(0, 6)

            chooseBtn.MouseButton1Click:Connect(function()
                Config.SelectedTarget = item
                TargetInfoLabel.Text = (CurrentLang == "VN" and "🎯 Đã chọn: " or "🎯 Selected: ") .. item.Name .. " (" .. item.Earnings .. ")"
                StatusLabel.Text = T("StatusGhim")
            end)
        end
        SideListContainer
