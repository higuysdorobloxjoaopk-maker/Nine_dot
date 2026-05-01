--[[
    NineDot UI Library
    Feito para injetar botões customizados no novo menu "nine dot" (TopBar) do Roblox.
    Usa clonagem de elementos nativos para 100% de fidelidade visual.
]]

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local Nine = {
    Buttons = {},
    NativeSettings = {},
    Connections = {}
}

-- Função interna para achar o Canvas principal do menu
local function GetMainCanvas()
    local success, target = pcall(function()  
        return CoreGui.TopBarApp.TopBarApp.UnibarLeftFrame.TopBarLeftContainer.UnibarMenu.SubMenuHost.nine_dot.ScrollingFrame.MainCanvas  
    end)  
    return success and target or nil
end

-- Função interna para aplicar configurações de visibilidade aos botões nativos
local function ApplyNativeSettings(canvas)
    for name, isVisible in pairs(Nine.NativeSettings) do
        local nativeItem = canvas:FindFirstChild(name)
        if nativeItem then
            nativeItem.Visible = isVisible
            
            -- Para garantir que o Roblox não mude a visibilidade de volta
            if not Nine.Connections[name] then
                Nine.Connections[name] = nativeItem:GetPropertyChangedSignal("Visible"):Connect(function()
                    if nativeItem.Visible ~= isVisible then
                        nativeItem.Visible = isVisible
                    end
                end)
            end
        end
    end
end

-- Função interna para criar/injetar os botões na UI
local function InjectButtons()
    local canvas = GetMainCanvas()
    if not canvas then return end

    -- Aplica as configurações do RobloxNines
    ApplyNativeSettings(canvas)

    -- Procura um template nativo para clonar (prioridade para o backpack)
    local template = canvas:FindFirstChild("backpack") or canvas:FindFirstChild("trust_and_safety")
    if not template then return end

    for _, btnConfig in ipairs(Nine.Buttons) do
        local btnName = "CustomBtn_" .. btnConfig.Name

        -- Se o botão já existe, pula
        if canvas:FindFirstChild(btnName) then continue end

        -- Clona o elemento nativo para ficar 100% igual ao Roblox
        local newBtn = template:Clone()
        newBtn.Name = btnName
        newBtn.LayoutOrder = 100 -- Joga pros últimos da lista
        newBtn.Visible = true

        -- Limpa conexões antigas do clone (se houver)
        for _, obj in ipairs(newBtn:GetDescendants()) do
            if obj:IsA("LocalScript") or obj:IsA("Script") then
                obj:Destroy()
            end
        end

        -- Modifica o Texto
        local textLabel = newBtn:FindFirstChildWhichIsA("TextLabel", true)
        if textLabel then
            textLabel.Text = btnConfig.Name
        end

        -- Modifica a Imagem
        local imageLabel = newBtn:FindFirstChildWhichIsA("ImageLabel", true)
        if imageLabel then
            if btnConfig.Type == "Toggle" then
                imageLabel.Image = (btnConfig.ToggleDefaultMode == "On") and btnConfig.ImageOn or btnConfig.ImageOff
            else
                imageLabel.Image = btnConfig.Image
            end
        end

        -- Cria um botão invisível por cima de tudo para registrar o clique
        local clicker = Instance.new("TextButton")
        clicker.Name = "ClickDetector"
        clicker.Size = UDim2.new(1, 0, 1, 0)
        clicker.BackgroundTransparency = 1
        clicker.Text = ""
        clicker.ZIndex = 10
        clicker.Parent = newBtn

        -- Lógica de Clique e Toggle
        local isOn = btnConfig.ToggleDefaultMode == "On"

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

-- Loop de manutenção (garante que os botões não sumam se o Roblox recarregar a UI)
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

-- ==========================================
-- API DA LIBRARY EXPOSTA PARA O USUÁRIO
-- ==========================================

function Nine:New(config)
    -- Valores padrões
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
        for itemName, isVisible in pairs(config.List) do
            self.NativeSettings[itemName] = isVisible
        end
    end
end

return Nine
