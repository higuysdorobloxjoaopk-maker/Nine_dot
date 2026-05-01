local CoreGui = game:GetService("CoreGui")

local Nine = {
    Buttons = {},
    NativeSettings = {}
}

local function GetMainCanvas()
    local success, target = pcall(function()  
        return CoreGui.TopBarApp.TopBarApp.UnibarLeftFrame.TopBarLeftContainer.UnibarMenu.SubMenuHost.nine_dot.ScrollingFrame.MainCanvas  
    end)  
    return success and target or nil
end

local function ApplyNativeSettings(canvas)
    for name, keep in pairs(Nine.NativeSettings) do
        local nativeItem = canvas:FindFirstChild(name)
        if nativeItem then
            if not keep then
                nativeItem:Destroy()
            else
                nativeItem.Visible = true
            end
        end
    end
end

local function InjectButtons()
    local canvas = GetMainCanvas()
    if not canvas then return end

    ApplyNativeSettings(canvas)

    local template = canvas:FindFirstChild("backpack") or canvas:FindFirstChild("trust_and_safety")
    if not template then return end

    for _, btnConfig in ipairs(Nine.Buttons) do
        local btnName = "CustomBtn_" .. btnConfig.Name

        if canvas:FindFirstChild(btnName) then continue end

        local newBtn = template:Clone()
        newBtn.Name = btnName
        newBtn.LayoutOrder = 100
        newBtn.Visible = true

        for _, obj in ipairs(newBtn:GetDescendants()) do
            if obj:IsA("LocalScript") or obj:IsA("Script") then
                obj:Destroy()
            end
        end

        local textLabel = newBtn:FindFirstChildWhichIsA("TextLabel", true)
        if textLabel then
            textLabel.Text = btnConfig.Name
        end

        local imageLabel = newBtn:FindFirstChildWhichIsA("ImageLabel", true)
        local isOn = btnConfig.ToggleDefaultMode == "On"

        if imageLabel then
            if btnConfig.Type == "Toggle" then
                imageLabel.Image = isOn and btnConfig.ImageOn or btnConfig.ImageOff
            else
                imageLabel.Image = btnConfig.Image
            end
        end

        local clicker = Instance.new("TextButton")
        clicker.Name = "ClickDetector"
        clicker.Size = UDim2.new(1, 0, 1, 0)
        clicker.BackgroundTransparency = 1
        clicker.Text = ""
        clicker.ZIndex = 10
        clicker.Parent = newBtn

        clicker.MouseButton1Click:Connect(function()
            if btnConfig.Type == "Toggle" then
                isOn = not isOn
                if imageLabel then
                    imageLabel.Image = isOn and btnConfig.ImageOn or btnConfig.ImageOff
                end
                if btnConfig.Callback then
                    btnConfig.Callback(isOn)
                end
            elseif btnConfig.Type == "Click" then
                if btnConfig.Callback then
                    btnConfig.Callback()
                end
            end
        end)

        newBtn.Parent = canvas
    end
end

task.spawn(function()
    while true do
        InjectButtons()
        task.wait(1)
    end
end)

CoreGui.DescendantAdded:Connect(function(obj)
    if obj.Name == "nine_dot" then
        task.wait(0.5)
        InjectButtons()
    end
end)

function Nine:New(config)
    config.Name = config.Name or "Sem Nome"
    config.Type = config.Type or "Click"
    config.Image = config.Image or ""
    config.ImageOn = config.ImageOn or config.Image
    config.ImageOff = config.ImageOff or config.Image
    config.ToggleDefaultMode = config.ToggleDefaultMode or "Off"
    config.Callback = config.Callback or function() end

    table.insert(self.Buttons, config)
end

function Nine:RobloxNines(config)
    if config and config.List then
        for itemName, keep in pairs(config.List) do
            self.NativeSettings[itemName] = keep
        end
    end
end

return Nine
