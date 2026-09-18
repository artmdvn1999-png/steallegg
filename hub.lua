-- [[ Steal Egg Vip Hub - Clean Version ]]
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("StealEggVipHub") then
    PlayerGui.StealEggVipHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealEggVipHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 400)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 0, 45)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Steal Egg Vip | FlowAuth"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local Config = { Auto = false, God = true, Speed = 16, TweenSpeed = 50 }

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(1, -30, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 60)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
ToggleBtn.Text = "Auto Steal & Godmode: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 13
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = MainFrame
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)

ToggleBtn.MouseButton1Click:Connect(function()
    Config.Auto = not Config.Auto
    ToggleBtn.BackgroundColor3 = Config.Auto and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
    ToggleBtn.Text = Config.Auto and "Auto Steal & Godmode: ON" or "Auto Steal & Godmode: OFF"
end)

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -30, 0, 50)
Status.Position = UDim2.new(0, 15, 0, 120)
Status.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
Status.Text = "🟢 Trạng thái: Sẵn sàng hoạt động"
Status.TextColor3 = Color3.fromRGB(46, 204, 113)
Status.TextSize = 12
Status.Font = Enum.Font.GothamBold
Status.Parent = MainFrame
Instance.new("UICorner", Status).CornerRadius = UDim.new(0, 8)

RunService.Stepped:Connect(function()
    pcall(function()
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then
            h.WalkSpeed = Config.Speed
            if Config.God then h.Health = h.MaxHealth end
        end
    end)
end)

task.spawn(function()
    while ScreenGui.Parent do
        task.wait(1)
        if Config.Auto then
            pcall(function()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
                local target, part
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("Model") or obj:IsA("BasePart") then
                        local n = obj.Name:lower()
                        if n:find("egg") or n:find("pet") then
                            target = obj
                            part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                            if part then break end
                        end
                    end
                end

                if target and part then
                    Status.Text = "⚡ Đang trộm: " .. target.Name
                    for _, p in ipairs(LocalPlayer.Character:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanCollide = false end
                    end
                    
                    local dest = part.CFrame + Vector3.new(0, 3, 0)
                    local dist = (hrp.Position - dest.Position).Magnitude
                    local tw = TweenService:Create(hrp, TweenInfo.new(dist / Config.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = dest})
                    tw:Play()
                    tw.Completed:Wait()

                    local pr = target:FindFirstChildWhichIsA("ProximityPrompt", true) or part:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if pr and fireproximityprompt then fireproximityprompt(pr) end
                    task.wait(0.2)
                else
                    Status.Text = "🔍 Đang tìm trứng/pet trong map..."
                end
            end)
        end
    end
end)
