local Library = {}
local TweenService = game:GetService("TweenService")

Library.Colors = {
    Blue = Color3.fromRGB(66, 133, 244),
    Red = Color3.fromRGB(234, 67, 53),
    Yellow = Color3.fromRGB(251, 188, 5),
    Green = Color3.fromRGB(52, 168, 83),
    Background = Color3.fromRGB(255, 255, 255),
    Text = Color3.fromRGB(60, 64, 67),
    Border = Color3.fromRGB(218, 220, 224),
    HoverBlue = Color3.fromRGB(26, 115, 232)
}

function Library:CreateWindow(config)
    local Window = {}
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TabContainer = Instance.new("Frame")
    local TabContent = Instance.new("Frame")

    -- Window setup code here
    ScreenGui.Parent = game:GetService("CoreGui")
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.Position = UDim2.new(0.5, -300, 0.5, -200)
    Main.BackgroundColor3 = Library.Colors.Background
    
    function Window:CreateTab(name)
        local Tab = {}
        local TabButton = Instance.new("TextButton")
        local TabPage = Instance.new("ScrollingFrame")
        
        -- Tab setup code here
        TabButton.Text = name
        TabButton.BackgroundColor3 = Library.Colors.Blue
        TabButton.TextColor3 = Color3.new(1, 1, 1)
        
        function Tab:CreateButton(config)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(0, 180, 0, 40)
            Button.BackgroundColor3 = Library.Colors.Blue
            Button.Text = config.Name
            Button.TextColor3 = Color3.new(1, 1, 1)
            Button.MouseButton1Click:Connect(config.Callback)
            return Button
        end
        
        function Tab:CreateSlider(config)
            local Slider = Instance.new("Frame")
            local SliderBar = Instance.new("Frame")
            local SliderButton = Instance.new("TextButton")
            
            -- Slider functionality here
            SliderBar.BackgroundColor3 = Library.Colors.Border
            SliderButton.BackgroundColor3 = Library.Colors.Blue
            
            -- Add drag functionality
            local dragging = false
            SliderButton.MouseButton1Down:Connect(function()
                dragging = true
            end)
            
            game:GetService("UserInputService").InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            return Slider
        end
        
        function Tab:CreateToggle(config)
            local Toggle = Instance.new("Frame")
            local ToggleButton = Instance.new("TextButton")
            local Status = Instance.new("Frame")
            
            -- Toggle setup
            ToggleButton.BackgroundColor3 = Library.Colors.Border
            Status.BackgroundColor3 = config.Default and Library.Colors.Green or Library.Colors.Red
            
            ToggleButton.MouseButton1Click:Connect(function()
                config.Value = not config.Value
                Status.BackgroundColor3 = config.Value and Library.Colors.Green or Library.Colors.Red
                config.Callback(config.Value)
            end)
            
            return Toggle
        end
        
        function Tab:CreateDropdown(config)
            local Dropdown = Instance.new("Frame")
            local DropButton = Instance.new("TextButton")
            local ItemList = Instance.new("ScrollingFrame")
            
            -- Dropdown setup
            DropButton.Text = config.Name
            DropButton.BackgroundColor3 = Library.Colors.Blue
            
            -- Add items
            for _, item in ipairs(config.Options) do
                local ItemButton = Instance.new("TextButton")
                ItemButton.Text = item
                ItemButton.MouseButton1Click:Connect(function()
                    config.Callback(item)
                    DropButton.Text = item
                end)
            end
            
            return Dropdown
        end
        
        return Tab
    end
    
    return Window
end

