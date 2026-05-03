-- Notification Lib

local NotificationLib = {}
local queue = {}
local active = {}
local enabled = true
local maxNotifications = 3

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local gui = nil
local container = nil

local function createUI()
    local LMG2L = {}

    LMG2L["ScreenGui_1"] = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    LMG2L["ScreenGui_1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    LMG2L["NotFrame_2"] = Instance.new("Frame", LMG2L["ScreenGui_1"])
    LMG2L["NotFrame_2"].BorderSizePixel = 0
    LMG2L["NotFrame_2"].BackgroundTransparency = 1
    LMG2L["NotFrame_2"].Size = UDim2.new(0, 348, 0, 230)
    LMG2L["NotFrame_2"].Position = UDim2.new(0, -2, 0, 2)

    local layout = Instance.new("UIListLayout", LMG2L["NotFrame_2"])
    layout.Padding = UDim.new(0, 5)

    gui = LMG2L["ScreenGui_1"]
    container = LMG2L["NotFrame_2"]
end

local function playSound(id)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. id
    sound.Volume = 1
    sound.Parent = SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 3)
end

local function createNotification(data)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 336, 0, 56)
    frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = container

    frame.ClipsDescendants = true
    frame.Size = UDim2.new(0, 0, 0, 56)

    local icon = Instance.new("ImageLabel", frame)
    icon.Image = "rbxasset://textures/ui/Emotes/ErrorIcon.png"
    icon.Size = UDim2.new(0.2, -20, 1, -20)
    icon.Position = UDim2.new(0, 10, 0.5, 0)
    icon.AnchorPoint = Vector2.new(0, 0.5)
    icon.BackgroundTransparency = 1

    local text = Instance.new("TextLabel", frame)
    text.Text = data.Text or "..."
    text.Size = UDim2.new(0, 224, 0, 44)
    text.Position = UDim2.new(0.2, -10, 0.5, 0)
    text.AnchorPoint = Vector2.new(0, 0.5)
    text.BackgroundTransparency = 1
    text.TextScaled = true
    text.TextWrapped = true
    text.TextColor3 = Color3.new(1,1,1)
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.Font = Enum.Font.BuilderSans

    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(1,0,1,0)
    button.BackgroundTransparency = 1
    button.Text = ""

    TweenService:Create(frame, TweenInfo.new(0.3), {
        Size = UDim2.new(0,336,0,56)
    }):Play()
  
    if data.Sound ~= false then
        playSound(data.Sound or "137402801272072")
    end

    local function remove()
        TweenService:Create(frame, TweenInfo.new(0.25), {
            Size = UDim2.new(0,0,0,56)
        }):Play()

        task.wait(0.25)
        frame:Destroy()
        active[data.Id] = nil

        if #queue > 0 then
            local next = table.remove(queue,1)
            NotificationLib:New(next)
        end
    end

    button.MouseButton1Click:Connect(remove)

    if data.LifeTime then
        task.delay(data.LifeTime, function()
            if frame.Parent then
                remove()
            end
        end)
    end

    active[data.Id] = frame
end

function NotificationLib:New(data)
    if not enabled then return end
    if not gui then createUI() end

    data.Id = data.Id or tostring(math.random(1000,9999))

    if #container:GetChildren() - 1 >= maxNotifications then
        table.insert(queue, data)
        return
    end

    createNotification(data)
end

function NotificationLib:MinimizeNotifications(cfg)
    local ids = cfg.Notifications

    for id,frame in pairs(active) do
        if ids == "All" or table.find(ids, id) then
            TweenService:Create(frame, TweenInfo.new(0.25), {
                Size = UDim2.new(0,0,0,56)
            }):Play()
        end
    end
end

function NotificationLib:Notifications(cfg)
    enabled = cfg.Notifications ~= false
end

return NotificationLib
