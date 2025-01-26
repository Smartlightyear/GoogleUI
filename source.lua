local Library = {}

function Library:Init()
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local Container = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")

    ScreenGui.Name = "GoogleLightUI"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Light background
    Main.Position = UDim2.new(0.5, -150, 0.5, -100)
    Main.Size = UDim2.new(0, 300, 0, 200)
    Main.Active = true
    Main.Draggable = true

    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main

    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 5)
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "Google Light UI"
    Title.TextColor3 = Color3.fromRGB(60, 60, 60) -- Dark text
    Title.TextSize = 16

    Container.Name = "Container"
    Container.Parent = Main
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0, 10, 0, 40)
    Container.Size = UDim2.new(1, -20, 1, -50)

    UIListLayout.Parent = Container
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    self.Main = Main
    return Library
end

function Library:AddSlider(title, min, max, default, callback)
    local Slider = Instance.new("Frame")
    local SliderTitle = Instance.new("TextLabel")
    local SliderBar = Instance.new("Frame")
    local SliderFill = Instance.new("Frame")
    local Value = Instance.new("TextLabel")

    Slider.Name = "Slider"
    Slider.Parent = self.Main.Container
    Slider.BackgroundTransparency = 1
    Slider.Size = UDim2.new(1, 0, 0, 35)

    SliderTitle.Name = "Title"
    SliderTitle.Parent = Slider
    SliderTitle.BackgroundTransparency = 1
    SliderTitle.Size = UDim2.new(1, -50, 0, 20)
    SliderTitle.Font = Enum.Font.Gotham
    SliderTitle.Text = title
    SliderTitle.TextColor3 = Color3.fromRGB(60, 60, 60) -- Dark text
    SliderTitle.TextSize = 14
    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

    SliderBar.Name = "Bar"
    SliderBar.Parent = Slider
    SliderBar.BackgroundColor3 = Color3.fromRGB(230, 230, 230) -- Light gray bar
    SliderBar.BorderSizePixel = 0
    SliderBar.Position = UDim2.new(0, 0, 0, 25)
    SliderBar.Size = UDim2.new(1, 0, 0, 5)

    SliderFill.Name = "Fill"
    SliderFill.Parent = SliderBar
    SliderFill.BackgroundColor3 = Color3.fromRGB(66, 133, 244) -- Blue fill
    SliderFill.BorderSizePixel = 0
    SliderFill.Size = UDim2.new(0.5, 0, 1, 0)

    Value.Name = "Value"
    Value.Parent = Slider
    Value.BackgroundTransparency = 1
    Value.Position = UDim2.new(1, -45, 0, 0)
    Value.Size = UDim2.new(0, 45, 0, 20)
    Value.Font = Enum.Font.Gotham
    Value.Text = tostring(default)
    Value.TextColor3 = Color3.fromRGB(60, 60, 60) -- Dark text
    Value.TextSize = 14

    local dragging = false

    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
            local relativePos = mousePos.X - SliderBar.AbsolutePosition.X
            local percentage = math.clamp(relativePos / SliderBar.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * percentage)

            SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
            Value.Text = tostring(value)
            callback(value)
        end
    end)
end

function Library:AddButton(text, callback)
    local Button = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")

    Button.Name = "Button"
    Button.Parent = self.Main.Container
    Button.BackgroundColor3 = Color3.fromRGB(245, 245, 245) -- Light button
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.Font = Enum.Font.Gotham
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(60, 60, 60) -- Dark text
    Button.TextSize = 14
    Button.AutoButtonColor = false

    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Button

    Button.MouseButton1Click:Connect(callback)

    -- Hover effect
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(230, 230, 230) -- Hover color
    end)

    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(245, 245, 245) -- Default color
    end)
end

return Library
