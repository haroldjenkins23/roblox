--======================================================================--
--  ESP with DUAL HITBOX MODES (v58 - The Definitive Version)
--======================================================================--

--// Step 1: Define the settings table that our UI will control
local Settings = {
    -- Core Visuals
    ESP_Enabled = true, Team_Check = true, Show_Teammates = true,
    Name_Enabled = true, Distance_Enabled = true,
    ESP_Render_Distance = 500,
    Enemy_Color = Color3.fromRGB(255, 50, 50),
    Teammate_Color = Color3.fromRGB(50, 150, 255),
    -- Weapon Features
    WeaponChams_Enabled = true,
    WeaponChams_VisibleThroughWalls = true,
    WeaponChams_Style = 1,
    WeaponChams_Color = Color3.fromRGB(255, 0, 255),
    -- Aimbot Features
    Aimbot_Enabled = false,
    Aim_at_Head = true,
    Show_FOV = true,
    FOV_Size = 80,
    Smoothing = 10,
    -- Hitbox Expanders
    HitboxExpander_Enabled = false,
    Hitbox_Size = 1.5,
    ReplicatingHitbox_Enabled = false,
    Replicating_Size = 4
}

--// ====================================================================
--//  CUSTOM UI CREATION
--// ====================================================================

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local CustomUIScreenGui = Instance.new("ScreenGui", CoreGui); CustomUIScreenGui.Name = "CustomESP_UI_Container"; CustomUIScreenGui.ResetOnSpawn = false
local MainWindow = Instance.new("Frame", CustomUIScreenGui); MainWindow.Size = UDim2.fromOffset(450, 600); MainWindow.Position = UDim2.fromOffset(20, 20); MainWindow.BackgroundColor3 = Color3.fromRGB(18, 18, 23); MainWindow.BorderSizePixel = 0
MainWindow.Visible = false
local MainWindowCorner = Instance.new("UICorner", MainWindow); MainWindowCorner.CornerRadius = UDim.new(0, 10)
local MainWindowGradient = Instance.new("UIGradient", MainWindow)
MainWindowGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 23)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 28))
}
MainWindowGradient.Rotation = 45
local MainWindowStroke = Instance.new("UIStroke", MainWindow); MainWindowStroke.Color = Color3.fromRGB(60, 100, 180); MainWindowStroke.Thickness = 2; MainWindowStroke.Transparency = 0.5

local TitleBar = Instance.new("Frame", MainWindow); TitleBar.Size = UDim2.new(1, 0, 0, 40); TitleBar.BackgroundColor3 = Color3.fromRGB(12, 12, 18); TitleBar.BorderSizePixel = 0
local TitleBarCorner = Instance.new("UICorner", TitleBar); TitleBarCorner.CornerRadius = UDim.new(0, 10)
local TitleBarGradient = Instance.new("UIGradient", TitleBar)
TitleBarGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 12, 18)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 30, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 18))
}
TitleBarGradient.Rotation = 90
local TitleBarStroke = Instance.new("UIStroke", TitleBar)
TitleBarStroke.Color = Color3.fromRGB(80, 150, 255)
TitleBarStroke.Thickness = 1
TitleBarStroke.Transparency = 0.7
local TitleLabel = Instance.new("TextLabel", TitleBar); TitleLabel.Size = UDim2.new(1,-80,1,0); TitleLabel.Position = UDim2.fromOffset(15,0); TitleLabel.BackgroundTransparency = 1; TitleLabel.Text = "⚡ Project ESP - v58"; TitleLabel.Font = Enum.Font.GothamBold; TitleLabel.TextColor3 = Color3.fromRGB(255,255,255); TitleLabel.TextXAlignment = Enum.TextXAlignment.Left; TitleLabel.TextSize = 17
local TitleLabelStroke = Instance.new("UIStroke", TitleLabel)
TitleLabelStroke.Color = Color3.fromRGB(80, 150, 255)
TitleLabelStroke.Thickness = 0.5
TitleLabelStroke.Transparency = 0.8
local CloseButton = Instance.new("TextButton", TitleBar); CloseButton.Size = UDim2.fromOffset(25, 25); CloseButton.Position = UDim2.new(1, -30, 0.5, -12.5); CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50); CloseButton.Text = "×"; CloseButton.Font = Enum.Font.GothamBold; CloseButton.TextColor3 = Color3.fromRGB(255,255,255); CloseButton.TextSize = 18; CloseButton.BorderSizePixel = 0
local CloseButtonCorner = Instance.new("UICorner", CloseButton); CloseButtonCorner.CornerRadius = UDim.new(0, 4)
CloseButton.MouseButton1Click:Connect(function() MainWindow.Visible = false end)
CloseButton.MouseEnter:Connect(function() CloseButton.BackgroundColor3 = Color3.fromRGB(220, 70, 70) end)
CloseButton.MouseLeave:Connect(function() CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) end)
local dragging, dragStart, startPos; TitleBar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true;dragStart=i.Position;startPos=MainWindow.Position;i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then dragging=false end end)end end); UserInputService.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement and dragging then local d=i.Position-dragStart;MainWindow.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)end end)
local TabContainer = Instance.new("Frame", MainWindow); TabContainer.Size = UDim2.new(1,0,0,40); TabContainer.Position = UDim2.new(0,0,0,40); TabContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 28); TabContainer.BorderSizePixel = 0
local TabContainerGradient = Instance.new("UIGradient", TabContainer)
TabContainerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 22, 28)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 32))
}
local TabListLayout = Instance.new("UIListLayout", TabContainer); TabListLayout.FillDirection = Enum.FillDirection.Horizontal; TabListLayout.Padding = UDim.new(0, 6)
local TabPadding = Instance.new("UIPadding", TabContainer); TabPadding.PaddingLeft = UDim.new(0, 8); TabPadding.PaddingTop = UDim.new(0, 4)
local ContentContainer = Instance.new("Frame", MainWindow); ContentContainer.Size = UDim2.new(1,-20,1,-90); ContentContainer.Position = UDim2.new(0,10,0,80); ContentContainer.BackgroundTransparency = 1
local ContentPadding = Instance.new("UIPadding", ContentContainer); ContentPadding.PaddingTop = UDim.new(0, 5)
local VisualsPage = Instance.new("ScrollingFrame", ContentContainer); VisualsPage.Size = UDim2.fromScale(1,1); VisualsPage.BackgroundTransparency = 1; VisualsPage.BorderSizePixel = 0; VisualsPage.ScrollBarThickness = 4; VisualsPage.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
local VisualsListLayout = Instance.new("UIListLayout", VisualsPage); VisualsListLayout.Padding = UDim.new(0, 8)
local WeaponPage = Instance.new("ScrollingFrame", ContentContainer); WeaponPage.Size = UDim2.fromScale(1,1); WeaponPage.BackgroundTransparency = 1; WeaponPage.BorderSizePixel = 0; WeaponPage.Visible = false; WeaponPage.ScrollBarThickness = 4; WeaponPage.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
local WeaponListLayout = Instance.new("UIListLayout", WeaponPage); WeaponListLayout.Padding = UDim.new(0, 8)
local AimPage = Instance.new("ScrollingFrame", ContentContainer); AimPage.Size = UDim2.fromScale(1,1); AimPage.BackgroundTransparency = 1; AimPage.BorderSizePixel = 0; AimPage.Visible = false; AimPage.ScrollBarThickness = 4; AimPage.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
local AimListLayout = Instance.new("UIListLayout", AimPage); AimListLayout.Padding = UDim.new(0, 8)
local MiscPage = Instance.new("ScrollingFrame", ContentContainer); MiscPage.Size = UDim2.fromScale(1,1); MiscPage.BackgroundTransparency = 1; MiscPage.BorderSizePixel = 0; MiscPage.Visible = false; MiscPage.ScrollBarThickness = 4; MiscPage.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
local MiscListLayout = Instance.new("UIListLayout", MiscPage); MiscListLayout.Padding = UDim.new(0, 8)
VisualsListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    VisualsPage.CanvasSize = UDim2.new(0, 0, 0, VisualsListLayout.AbsoluteContentSize.Y + 10)
end)
WeaponListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    WeaponPage.CanvasSize = UDim2.new(0, 0, 0, WeaponListLayout.AbsoluteContentSize.Y + 10)
end)
AimListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    AimPage.CanvasSize = UDim2.new(0, 0, 0, AimListLayout.AbsoluteContentSize.Y + 10)
end)
MiscListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    MiscPage.CanvasSize = UDim2.new(0, 0, 0, MiscListLayout.AbsoluteContentSize.Y + 10)
end)
local ActiveTabColor, InactiveTabColor = Color3.fromRGB(80, 150, 255), Color3.fromRGB(35, 35, 45)
local function createTabButton(text, isActive)
    local button = Instance.new("TextButton", TabContainer)
    button.Size = UDim2.fromOffset(100, 32)
    button.BackgroundColor3 = isActive and ActiveTabColor or InactiveTabColor
    button.Text = text
    button.Font = Enum.Font.GothamSemibold
    button.TextColor3 = Color3.fromRGB(255,255,255)
    button.TextSize = 13
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 8)
    local buttonGradient = Instance.new("UIGradient", button)
    if isActive then
        buttonGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 150, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 170, 255))
        }
    else
        buttonGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 45)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 50))
        }
    end
    buttonGradient.Rotation = 90
    local buttonStroke = Instance.new("UIStroke", button)
    buttonStroke.Color = isActive and Color3.fromRGB(100, 170, 255) or Color3.fromRGB(50, 50, 60)
    buttonStroke.Thickness = 1
    buttonStroke.Transparency = isActive and 0.5 or 0.8
    button.MouseEnter:Connect(function()
        if not isActive then
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 65)}):Play()
            TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0.6}):Play()
        end
    end)
    button.MouseLeave:Connect(function()
        if not isActive then
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = InactiveTabColor}):Play()
            TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0.8}):Play()
        end
    end)
    return button, buttonGradient, buttonStroke
end
local VisualsTabButton, VGrad, VStroke = createTabButton("VISUALS", true)
local WeaponTabButton, WGrad, WStroke = createTabButton("WEAPON", false)
local AimTabButton, AGrad, AStroke = createTabButton("AIM", false)
local MiscTabButton, MGrad, MStroke = createTabButton("MISC", false)
local allTabs={VisualsPage,WeaponPage,AimPage,MiscPage}
local allTabButtons={VisualsTabButton,WeaponTabButton,AimTabButton,MiscTabButton}
local allTabGradients={VGrad,WGrad,AGrad,MGrad}
local allTabStrokes={VStroke,WStroke,AStroke,MStroke}
for i,button in ipairs(allTabButtons)do 
    button.MouseButton1Click:Connect(function()
        for j,page in ipairs(allTabs)do page.Visible=(i==j)end
        for j,btn in ipairs(allTabButtons)do 
            local isActive = (i==j)
            if isActive then
                btn.BackgroundColor3 = ActiveTabColor
                allTabGradients[j].Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 150, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 170, 255))
                }
                allTabStrokes[j].Color = Color3.fromRGB(100, 170, 255)
                allTabStrokes[j].Transparency = 0.5
            else
                btn.BackgroundColor3 = InactiveTabColor
                allTabGradients[j].Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 45)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 50))
                }
                allTabStrokes[j].Color = Color3.fromRGB(50, 50, 60)
                allTabStrokes[j].Transparency = 0.8
            end
        end
    end)
end
local function createToggle(parent, name, defaultValue, callback) 
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    frame.BorderSizePixel = 0
    local frameCorner = Instance.new("UICorner", frame)
    frameCorner.CornerRadius = UDim.new(0, 8)
    local frameGradient = Instance.new("UIGradient", frame)
    frameGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 32, 40))
    }
    frameGradient.Rotation = 90
    local frameStroke = Instance.new("UIStroke", frame)
    frameStroke.Color = Color3.fromRGB(60, 60, 75)
    frameStroke.Thickness = 1
    frameStroke.Transparency = 0.7
    local framePadding = Instance.new("UIPadding", frame)
    framePadding.PaddingLeft = UDim.new(0, 15)
    framePadding.PaddingRight = UDim.new(0, 15)
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = name
    label.TextColor3 = Color3.fromRGB(240, 240, 240)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextSize = 14
    
    local toggleContainer = Instance.new("TextButton", frame)
    toggleContainer.Size = UDim2.fromOffset(52, 26)
    toggleContainer.Position = UDim2.new(1, -65, 0.5, -13)
    toggleContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    toggleContainer.BorderSizePixel = 0
    toggleContainer.Text = ""
    toggleContainer.AutoButtonColor = false
    local toggleCorner = Instance.new("UICorner", toggleContainer)
    toggleCorner.CornerRadius = UDim.new(0, 13)
    local toggleGradient = Instance.new("UIGradient", toggleContainer)
    toggleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 55, 65))
    }
    toggleGradient.Rotation = 90
    
    local indicator = Instance.new("Frame", toggleContainer)
    indicator.Size = UDim2.fromOffset(20, 20)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    indicator.BorderSizePixel = 0
    local indicatorCorner = Instance.new("UICorner", indicator)
    indicatorCorner.CornerRadius = UDim.new(0, 10)
    local indicatorGradient = Instance.new("UIGradient", indicator)
    indicatorGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 240))
    }
    indicatorGradient.Rotation = 45
    local indicatorShadow = Instance.new("UIStroke", indicator)
    indicatorShadow.Color = Color3.fromRGB(0, 0, 0)
    indicatorShadow.Thickness = 1
    indicatorShadow.Transparency = 0.7
    indicator.Position = UDim2.new(0, 3, 0.5, -10)
    
    local value = defaultValue
    local function updateVisuals()
        local targetPos = value and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
        local targetColor = value and Color3.fromRGB(80, 150, 255) or Color3.fromRGB(50, 50, 60)
        local targetGradient = value and ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 150, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 170, 255))
        } or ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 60)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 55, 65))
        }
        TweenService:Create(indicator, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos}):Play()
        TweenService:Create(toggleContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = targetColor}):Play()
        toggleGradient.Color = targetGradient
    end
    
    toggleContainer.MouseButton1Click:Connect(function()
        value = not value
        updateVisuals()
        if callback then callback(value) end
    end)
    
    updateVisuals()
end
local function createRGBSliders(parent, name, defaultColor, callback) 
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, 0, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    frame.BorderSizePixel = 0
    local frameCorner = Instance.new("UICorner", frame)
    frameCorner.CornerRadius = UDim.new(0, 8)
    local frameGradient = Instance.new("UIGradient", frame)
    frameGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 32, 40))
    }
    frameGradient.Rotation = 90
    local frameStroke = Instance.new("UIStroke", frame)
    frameStroke.Color = Color3.fromRGB(60, 60, 75)
    frameStroke.Thickness = 1
    frameStroke.Transparency = 0.7
    local framePadding = Instance.new("UIPadding", frame)
    framePadding.PaddingLeft = UDim.new(0, 15)
    framePadding.PaddingRight = UDim.new(0, 15)
    framePadding.PaddingTop = UDim.new(0, 12)
    framePadding.PaddingBottom = UDim.new(0, 12)
    
    local headerFrame = Instance.new("Frame", frame)
    headerFrame.Size = UDim2.new(1, 0, 0, 20)
    headerFrame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel", headerFrame)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = name
    label.TextColor3 = Color3.fromRGB(240, 240, 240)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextSize = 14
    
    local colorPreview = Instance.new("Frame", headerFrame)
    colorPreview.Size = UDim2.fromOffset(35, 22)
    colorPreview.Position = UDim2.new(1, -35, 0, 0)
    colorPreview.BackgroundColor3 = defaultColor
    colorPreview.BorderSizePixel = 0
    local previewCorner = Instance.new("UICorner", colorPreview)
    previewCorner.CornerRadius = UDim.new(0, 5)
    local previewGradient = Instance.new("UIGradient", colorPreview)
    previewGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, defaultColor),
        ColorSequenceKeypoint.new(1, defaultColor)
    }
    local previewStroke = Instance.new("UIStroke", colorPreview)
    previewStroke.Color = Color3.fromRGB(80, 150, 255)
    previewStroke.Thickness = 2
    previewStroke.Transparency = 0.3
    
    local r, g, b = defaultColor.r * 255, defaultColor.g * 255, defaultColor.b * 255
    local function fireCallback()
        local nC = Color3.fromRGB(r, g, b)
        colorPreview.BackgroundColor3 = nC
        previewGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, nC),
            ColorSequenceKeypoint.new(1, nC)
        }
        if callback then callback(nC) end
    end
    
    local function createSlider(yPos, colorName, colorValue)
        local sliderContainer = Instance.new("Frame", frame)
        sliderContainer.Size = UDim2.new(1, 0, 0, 18)
        sliderContainer.Position = UDim2.new(0, 0, 0, yPos)
        sliderContainer.BackgroundTransparency = 1
        
        local labelText = Instance.new("TextLabel", sliderContainer)
        labelText.Size = UDim2.fromOffset(15, 18)
        labelText.BackgroundTransparency = 1
        labelText.Font = Enum.Font.GothamSemibold
        labelText.Text = colorName
        labelText.TextColor3 = Color3.fromRGB(180, 180, 180)
        labelText.TextXAlignment = Enum.TextXAlignment.Left
        labelText.TextSize = 12
        
        local sliderFrame = Instance.new("Frame", sliderContainer)
        sliderFrame.Size = UDim2.new(1, -20, 0, 6)
        sliderFrame.Position = UDim2.new(0, 20, 0.5, -3)
        sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        sliderFrame.BorderSizePixel = 0
        local sliderCorner = Instance.new("UICorner", sliderFrame)
        sliderCorner.CornerRadius = UDim.new(0, 3)
        
        local fillFrame = Instance.new("Frame", sliderFrame)
        fillFrame.Size = UDim2.new(0, 0, 1, 0)
        fillFrame.BackgroundColor3 = Color3.fromRGB(colorValue, colorValue == 0 and 0 or 0, colorValue == 0 and 0 or 0)
        if colorName == "G" then fillFrame.BackgroundColor3 = Color3.fromRGB(0, colorValue, 0) end
        if colorName == "B" then fillFrame.BackgroundColor3 = Color3.fromRGB(0, 0, colorValue) end
        fillFrame.BorderSizePixel = 0
        fillFrame.ZIndex = 1
        local fillCorner = Instance.new("UICorner", fillFrame)
        fillCorner.CornerRadius = UDim.new(0, 3)
        
        local indicator = Instance.new("Frame", sliderFrame)
        indicator.Size = UDim2.fromOffset(12, 12)
        indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        indicator.BorderSizePixel = 0
        indicator.ZIndex = 2
        local indicatorCorner = Instance.new("UICorner", indicator)
        indicatorCorner.CornerRadius = UDim.new(0, 6)
        
        local isDragging = false
        local function update(input)
            if isDragging or input.UserInputType == Enum.UserInputType.MouseButton1 then
                local x = math.clamp(input.Position.X - sliderFrame.AbsolutePosition.X, 0, sliderFrame.AbsoluteSize.X)
                local percent = x / sliderFrame.AbsoluteSize.X
                local val = math.floor(percent * 255)
                if colorName == "R" then r = val end
                if colorName == "G" then g = val end
                if colorName == "B" then b = val end
                indicator.Position = UDim2.new(percent, -6, 0.5, -6)
                fillFrame.Size = UDim2.new(percent, 0, 1, 0)
                local newColor = Color3.fromRGB(colorName == "R" and val or 0, colorName == "G" and val or 0, colorName == "B" and val or 0)
                fillFrame.BackgroundColor3 = newColor
                fireCallback()
            end
        end
        
        sliderFrame.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = true
                update(i)
            end
        end)
        sliderFrame.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = false
            end
        end)
        sliderFrame.InputChanged:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseMovement then
                update(i)
            end
        end)
        
        return indicator, fillFrame
    end
    
    local rI, rF = createSlider(25, "R", r)
    local gI, gF = createSlider(45, "G", g)
    local bI, bF = createSlider(65, "B", b)
    
    rI.Position = UDim2.new(r / 255, -6, 0.5, -6)
    gI.Position = UDim2.new(g / 255, -6, 0.5, -6)
    bI.Position = UDim2.new(b / 255, -6, 0.5, -6)
    rF.Size = UDim2.new(r / 255, 0, 1, 0)
    gF.Size = UDim2.new(g / 255, 0, 1, 0)
    bF.Size = UDim2.new(b / 255, 0, 1, 0)
end
local function createSlider(parent, name, min, max, defaultValue, callback) 
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, 0, 0, 54)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    frame.BorderSizePixel = 0
    local frameCorner = Instance.new("UICorner", frame)
    frameCorner.CornerRadius = UDim.new(0, 8)
    local frameGradient = Instance.new("UIGradient", frame)
    frameGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 32, 40))
    }
    frameGradient.Rotation = 90
    local frameStroke = Instance.new("UIStroke", frame)
    frameStroke.Color = Color3.fromRGB(60, 60, 75)
    frameStroke.Thickness = 1
    frameStroke.Transparency = 0.7
    local framePadding = Instance.new("UIPadding", frame)
    framePadding.PaddingLeft = UDim.new(0, 15)
    framePadding.PaddingRight = UDim.new(0, 15)
    framePadding.PaddingTop = UDim.new(0, 10)
    framePadding.PaddingBottom = UDim.new(0, 10)
    
    local textFrame = Instance.new("Frame", frame)
    textFrame.Size = UDim2.new(1, 0, 0, 18)
    textFrame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel", textFrame)
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = name
    label.TextColor3 = Color3.fromRGB(240, 240, 240)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextSize = 14
    
    local valueLabel = Instance.new("TextLabel", textFrame)
    valueLabel.Size = UDim2.new(0.35, -5, 1, 0)
    valueLabel.Position = UDim2.new(0.65, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Font = Enum.Font.GothamSemibold
    valueLabel.TextColor3 = Color3.fromRGB(80, 150, 255)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.TextSize = 14
    
    local sliderFrame = Instance.new("Frame", frame)
    sliderFrame.Size = UDim2.new(1, 0, 0, 7)
    sliderFrame.Position = UDim2.new(0, 0, 1, -12)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    sliderFrame.BorderSizePixel = 0
    local sliderCorner = Instance.new("UICorner", sliderFrame)
    sliderCorner.CornerRadius = UDim.new(0, 4)
    local sliderGradient = Instance.new("UIGradient", sliderFrame)
    sliderGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 55)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 60))
    }
    
    local fillFrame = Instance.new("Frame", sliderFrame)
    fillFrame.Size = UDim2.new(0, 0, 1, 0)
    fillFrame.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
    fillFrame.BorderSizePixel = 0
    fillFrame.ZIndex = 1
    local fillCorner = Instance.new("UICorner", fillFrame)
    fillCorner.CornerRadius = UDim.new(0, 4)
    local fillGradient = Instance.new("UIGradient", fillFrame)
    fillGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 170, 255))
    }
    fillGradient.Rotation = 0
    
    local indicator = Instance.new("Frame", sliderFrame)
    indicator.Size = UDim2.fromOffset(16, 16)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    indicator.BorderSizePixel = 0
    indicator.ZIndex = 2
    local indicatorCorner = Instance.new("UICorner", indicator)
    indicatorCorner.CornerRadius = UDim.new(0, 8)
    local indicatorGradient = Instance.new("UIGradient", indicator)
    indicatorGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 240))
    }
    indicatorGradient.Rotation = 45
    local indicatorStroke = Instance.new("UIStroke", indicator)
    indicatorStroke.Color = Color3.fromRGB(80, 150, 255)
    indicatorStroke.Thickness = 2.5
    indicatorStroke.Transparency = 0.2
    
    local isDragging = false
    local function update(input)
        if isDragging or input.UserInputType == Enum.UserInputType.MouseButton1 then
            local x = math.clamp(input.Position.X - sliderFrame.AbsolutePosition.X, 0, sliderFrame.AbsoluteSize.X)
            local percent = x / sliderFrame.AbsoluteSize.X
            local value = math.floor(min + (max - min) * percent)
            valueLabel.Text = tostring(value)
            indicator.Position = UDim2.new(percent, -8, 0.5, -8)
            fillFrame.Size = UDim2.new(percent, 0, 1, 0)
            if callback then callback(value) end
        end
    end
    
    sliderFrame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            update(i)
        end
    end)
    sliderFrame.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
    sliderFrame.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            update(i)
        end
    end)
    
    local initialPercent = (defaultValue - min) / (max - min)
    indicator.Position = UDim2.new(initialPercent, -8, 0.5, -8)
    fillFrame.Size = UDim2.new(initialPercent, 0, 1, 0)
    valueLabel.Text = tostring(defaultValue)
end
local function createSectionDivider(parent, text)
    local divider = Instance.new("Frame", parent)
    divider.Size = UDim2.new(1, 0, 0, 30)
    divider.BackgroundTransparency = 1
    
    local line = Instance.new("Frame", divider)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 0.5, 0)
    line.BackgroundColor3 = Color3.fromRGB(60, 100, 180)
    line.BorderSizePixel = 0
    local lineGradient = Instance.new("UIGradient", line)
    lineGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 100, 180)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 100, 180))
    }
    lineGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.7),
        NumberSequenceKeypoint.new(0.5, 0.3),
        NumberSequenceKeypoint.new(1, 0.7)
    }
    
    if text then
        local label = Instance.new("TextLabel", divider)
        label.Size = UDim2.new(0, 0, 1, 0)
        label.Position = UDim2.new(0.5, 0, 0, 0)
        label.AnchorPoint = Vector2.new(0.5, 0)
        label.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
        label.BorderSizePixel = 0
        label.Text = text
        label.Font = Enum.Font.GothamSemibold
        label.TextColor3 = Color3.fromRGB(80, 150, 255)
        label.TextSize = 12
        label.TextXAlignment = Enum.TextXAlignment.Center
        local labelPadding = Instance.new("UIPadding", label)
        labelPadding.PaddingLeft = UDim.new(0, 10)
        labelPadding.PaddingRight = UDim.new(0, 10)
    end
    
    return divider
end

local function createCycleButton(parent, name, options, values, defaultValue, callback) 
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    frame.BorderSizePixel = 0
    local frameCorner = Instance.new("UICorner", frame)
    frameCorner.CornerRadius = UDim.new(0, 8)
    local frameGradient = Instance.new("UIGradient", frame)
    frameGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 32, 40))
    }
    frameGradient.Rotation = 90
    local frameStroke = Instance.new("UIStroke", frame)
    frameStroke.Color = Color3.fromRGB(60, 60, 75)
    frameStroke.Thickness = 1
    frameStroke.Transparency = 0.7
    local framePadding = Instance.new("UIPadding", frame)
    framePadding.PaddingLeft = UDim.new(0, 15)
    framePadding.PaddingRight = UDim.new(0, 15)
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.55, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = name
    label.TextColor3 = Color3.fromRGB(240, 240, 240)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextSize = 14
    
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(0.4, 0, 0, 26)
    button.Position = UDim2.new(0.58, 0, 0.5, -13)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamSemibold
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 13
    button.AutoButtonColor = false
    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(0, 6)
    local buttonGradient = Instance.new("UIGradient", button)
    buttonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 55, 70))
    }
    buttonGradient.Rotation = 90
    local buttonStroke = Instance.new("UIStroke", button)
    buttonStroke.Color = Color3.fromRGB(80, 150, 255)
    buttonStroke.Thickness = 1
    buttonStroke.Transparency = 0.7
    
    local valueIndex = table.find(values, defaultValue) or 1
    button.Text = options[valueIndex] or tostring(defaultValue)
    
    button.MouseButton1Click:Connect(function()
        valueIndex = valueIndex % #options + 1
        button.Text = options[valueIndex]
        if callback then callback(values[valueIndex] or valueIndex) end
    end)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 80)}):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0.4}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0.7}):Play()
    end)
end

local function createButton(parent, name, callback) 
    local button = Instance.new("TextButton", parent)
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    button.BorderSizePixel = 0
    button.Text = name
    button.Font = Enum.Font.GothamBold
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 15
    button.AutoButtonColor = false
    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(0, 8)
    local buttonGradient = Instance.new("UIGradient", button)
    buttonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 60, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 80, 80))
    }
    buttonGradient.Rotation = 90
    local buttonStroke = Instance.new("UIStroke", button)
    buttonStroke.Color = Color3.fromRGB(255, 100, 100)
    buttonStroke.Thickness = 2
    buttonStroke.Transparency = 0.5
    button.MouseButton1Click:Connect(callback)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 80, 80)}):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0.3}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 60, 60)}):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
    end)
    return button 
end

createSectionDivider(VisualsPage, "ESP SETTINGS")
createToggle(VisualsPage,"Enable ESP",Settings.ESP_Enabled,function(v)Settings.ESP_Enabled=v end);createToggle(VisualsPage,"Show Name",Settings.Name_Enabled,function(v)Settings.Name_Enabled=v end);createToggle(VisualsPage,"Show Distance",Settings.Distance_Enabled,function(v)Settings.Distance_Enabled=v end);createToggle(VisualsPage,"Team Check",Settings.Team_Check,function(v)Settings.Team_Check=v end);createToggle(VisualsPage,"Show Teammates",Settings.Show_Teammates,function(v)Settings.Show_Teammates=v end);createSlider(VisualsPage,"Render Distance",50,2000,Settings.ESP_Render_Distance,function(v)Settings.ESP_Render_Distance=v end)
createSectionDivider(VisualsPage, "COLORS")
createRGBSliders(VisualsPage,"Enemy Color",Settings.Enemy_Color,function(v)Settings.Enemy_Color=v end);createRGBSliders(VisualsPage,"Teammate Color",Settings.Teammate_Color,function(v)Settings.Teammate_Color=v end)
createSectionDivider(WeaponPage, "WEAPON CHAMS")
createToggle(WeaponPage,"Enable Weapon Chams",Settings.WeaponChams_Enabled,function(v)Settings.WeaponChams_Enabled=v end);createToggle(WeaponPage,"Chams Through Walls",Settings.WeaponChams_VisibleThroughWalls,function(v)Settings.WeaponChams_VisibleThroughWalls=v end);createCycleButton(WeaponPage,"Chams Style",{"Solid","Outline","Glass","Glow","ForceField","Transparent","O + F","Animated"},{},Settings.WeaponChams_Style,function(v)Settings.WeaponChams_Style=v end)
createSectionDivider(WeaponPage, "CHAMS COLOR")
createRGBSliders(WeaponPage,"Chams Color",Settings.WeaponChams_Color,function(v)Settings.WeaponChams_Color=v end)
createSectionDivider(AimPage, "AIMBOT")
createToggle(AimPage,"Enable Aimbot",Settings.Aimbot_Enabled,function(v)Settings.Aimbot_Enabled=v end);createToggle(AimPage,"Aim at Head",Settings.Aim_at_Head,function(v)Settings.Aim_at_Head=v end);createToggle(AimPage,"Show FOV Circle",Settings.Show_FOV,function(v)Settings.Show_FOV=v end);createSlider(AimPage,"FOV Size",20,300,Settings.FOV_Size,function(v)Settings.FOV_Size=v end);createSlider(AimPage,"Smoothing",1,20,Settings.Smoothing,function(v)Settings.Smoothing=v end)
createSectionDivider(AimPage, "HITBOX EXPANDER (SAFE)")
createToggle(AimPage,"Hitbox Expander (Safe)",Settings.HitboxExpander_Enabled,function(v)Settings.HitboxExpander_Enabled=v end);createSlider(AimPage,"Hitbox Size",1,50,Settings.Hitbox_Size*10,function(v)Settings.Hitbox_Size=v/10 end)
createSectionDivider(AimPage, "REPLICATING HITBOX (RISKY)")
createToggle(AimPage,"Replicating Hitbox (Risky)",Settings.ReplicatingHitbox_Enabled,function(v)Settings.ReplicatingHitbox_Enabled=v end);createSlider(AimPage,"Replicating Size",4,20,Settings.Replicating_Size,function(v)Settings.Replicating_Size=v end)

--// ====================================================================
--//  SCRIPT CORE
--// ====================================================================

local Players=game:GetService("Players");local RunService=game:GetService("RunService");local LocalPlayer=Players.LocalPlayer;local Debris=game:GetService("Debris");local CORNER_SCALE=0.25;local THICKNESS=2;local SIZING_CONSTANT=0.5;local espGui=Instance.new("ScreenGui",CoreGui);espGui.Name="ESP_Drawing_Container";espGui.ResetOnSpawn=false;local camera=workspace.CurrentCamera
local FOVGui=Instance.new("ScreenGui",CoreGui)
FOVGui.Name="FOV_Circle_Container"
FOVGui.ResetOnSpawn=false
FOVGui.IgnoreGuiInset = true -- [FIX] This line ensures the circle is centered exactly in the middle of the screen
FOVGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
local FOVCircle=Instance.new("Frame",FOVGui)
FOVCircle.BackgroundTransparency=0.95
FOVCircle.BackgroundColor3=Color3.fromRGB(80,150,255)
FOVCircle.BorderSizePixel=0
FOVCircle.ZIndex=999
FOVCircle.AnchorPoint=Vector2.new(0.5,0.5)
FOVCircle.Size=UDim2.fromOffset(160,160)
FOVCircle.Position=UDim2.new(0.5,0,0.5,0)
local UICorner=Instance.new("UICorner",FOVCircle)
UICorner.CornerRadius=UDim.new(1,0)
local FOVStroke=Instance.new("UIStroke",FOVCircle)
FOVStroke.Color=Color3.fromRGB(80,150,255)
FOVStroke.Thickness=2
FOVStroke.Transparency=0.3
local raycastParams=RaycastParams.new()
raycastParams.FilterType=Enum.RaycastFilterType.Exclude
local hitboxContainer=Instance.new("Folder",CoreGui)
hitboxContainer.Name="HitboxContainer"
function createPlayerESP()local container=Instance.new("Frame",espGui);container.BackgroundTransparency=1;container.Size=UDim2.fromOffset(0,0);local elements={Container=container,Corners={},NameLabel=Instance.new("TextLabel",container),DistanceLabel=Instance.new("TextLabel",container)};for i=1,4 do local h=Instance.new("Frame",container);h.BorderSizePixel=0;local v=Instance.new("Frame",container);v.BorderSizePixel=0;table.insert(elements.Corners,h);table.insert(elements.Corners,v)end;elements.NameLabel.TextSize=14;elements.NameLabel.Font=Enum.Font.SourceSansBold;elements.NameLabel.TextStrokeTransparency=0.4;elements.NameLabel.BackgroundTransparency=1;elements.NameLabel.TextXAlignment=Enum.TextXAlignment.Center;elements.NameLabel.AnchorPoint=Vector2.new(0.5,1);elements.DistanceLabel.TextSize=12;elements.DistanceLabel.Font=Enum.Font.SourceSans;elements.DistanceLabel.TextStrokeTransparency=0.4;elements.DistanceLabel.BackgroundTransparency=1;elements.DistanceLabel.TextXAlignment=Enum.TextXAlignment.Center;elements.DistanceLabel.AnchorPoint=Vector2.new(0.5,0);return elements end
local activeESPs={};local crosshairPosition=Vector2.new(camera.ViewportSize.X/2,camera.ViewportSize.Y/2);local currentHighlights={};local chammedTool=nil;local originalTransparencies={};local rainbowHue=0;local ghostHeads={};local originalHitboxes={};local gameLoopConnection
gameLoopConnection=RunService.RenderStepped:Connect(function()if not camera then camera=workspace.CurrentCamera;return end;crosshairPosition=Vector2.new(camera.ViewportSize.X/2,camera.ViewportSize.Y/2);raycastParams.FilterDescendantsInstances={LocalPlayer.Character,camera,hitboxContainer};rainbowHue=(rainbowHue+0.005)%1;local currentTool=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool");if Settings.WeaponChams_Enabled and currentTool then if currentTool~=chammedTool then for part,h in pairs(currentHighlights)do if h and h.Parent then h:Destroy()end;if originalTransparencies[part]then part.Transparency=originalTransparencies[part]end end;currentHighlights,originalTransparencies={},{};chammedTool=currentTool;for _,d in ipairs(currentTool:GetDescendants())do if d:IsA("BasePart")and d.Transparency<1 then originalTransparencies[d]=d.Transparency;currentHighlights[d]=Instance.new("Highlight",d)end end end;for part,h in pairs(currentHighlights)do local color=Settings.WeaponChams_Style==8 and Color3.fromHSV(rainbowHue,1,1)or Settings.WeaponChams_Color;h.FillColor=color;h.OutlineColor=color;if Settings.WeaponChams_Style==6 then part.Transparency=0.7;h.FillTransparency=0.8;h.OutlineTransparency=0.6 else if originalTransparencies[part]then part.Transparency=originalTransparencies[part]end end;if Settings.WeaponChams_Style==1 then h.FillTransparency=0;h.OutlineTransparency=1 end;if Settings.WeaponChams_Style==2 then h.FillTransparency=1;h.OutlineTransparency=0 end;if Settings.WeaponChams_Style==3 then h.FillTransparency=0.8;h.OutlineTransparency=0.2 end;if Settings.WeaponChams_Style==4 then h.FillTransparency=0.7;h.OutlineTransparency=0 end;if Settings.WeaponChams_Style==5 then h.FillTransparency=0.6;h.OutlineTransparency=0 end;if Settings.WeaponChams_Style==7 then h.FillTransparency=0.5;h.OutlineTransparency=0 end;if Settings.WeaponChams_Style==8 then h.FillTransparency=0;h.OutlineTransparency=1 end;h.DepthMode=Settings.WeaponChams_VisibleThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded end elseif chammedTool then for part,h in pairs(currentHighlights)do if h and h.Parent then h:Destroy()end;if originalTransparencies[part]then part.Transparency=originalTransparencies[part]end end;currentHighlights,originalTransparencies,chammedTool={},{},nil end
    for player,head in pairs(ghostHeads)do local humanoid=player.Character and player.Character:FindFirstChildOfClass("Humanoid");if not humanoid or humanoid.Health<=0 then head:Destroy();ghostHeads[player]=nil end end;if Settings.HitboxExpander_Enabled then for _,player in ipairs(Players:GetPlayers())do if player~=LocalPlayer then local character=player.Character;local head=character and character:FindFirstChild("Head");if head and not ghostHeads[player]then local ghostHead=Instance.new("Part",hitboxContainer);ghostHead.Name="GhostHead";ghostHead.Anchored=false;ghostHead.CanCollide=false;ghostHead.Transparency=1;ghostHeads[player]=ghostHead end;if ghostHeads[player]then ghostHeads[player].Size=head.Size+Vector3.new(Settings.Hitbox_Size,Settings.Hitbox_Size,Settings.Hitbox_Size);ghostHeads[player].CFrame=head.CFrame end end end else for _,head in pairs(ghostHeads)do head:Destroy()end;ghostHeads={}end
    if Settings.ReplicatingHitbox_Enabled then for _,player in ipairs(Players:GetPlayers())do if player~=LocalPlayer then local char=player.Character;local hrp=char and char:FindFirstChild("HumanoidRootPart");if hrp and not originalHitboxes[hrp]then originalHitboxes[hrp]={Size=hrp.Size,Transparency=hrp.Transparency,Material=hrp.Material,Color=hrp.Color}end;if hrp then hrp.Size=Vector3.new(Settings.Replicating_Size,Settings.Replicating_Size,Settings.Replicating_Size);hrp.Transparency=0.7;hrp.Color=Color3.fromRGB(255,0,0);hrp.Material=Enum.Material.Neon;hrp.CanCollide=false end end end else for hrp,props in pairs(originalHitboxes)do if hrp and hrp.Parent then hrp.Size=props.Size;hrp.Transparency=props.Transparency;hrp.Material=props.Material;hrp.Color=props.Color end end;originalHitboxes={}end
    local aimTarget=nil
    -- Check if aimbot is enabled and right mouse button is held down
    local aimbotKeyPressed = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    if Settings.Aimbot_Enabled and aimbotKeyPressed then
        local cP, mD = nil, Settings.FOV_Size
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local iT = Settings.Team_Check and LocalPlayer.Team and p.Team and p.Team == LocalPlayer.Team
                if not iT then
                    local c = p.Character
                    local aPN = Settings.Aim_at_Head and "Head" or "HumanoidRootPart"
                    local aP = Settings.HitboxExpander_Enabled and ghostHeads[p] or (c and c:FindFirstChild(aPN))
                    local rP = c and c:FindFirstChild("HumanoidRootPart")
                    if aP and rP then
                        local direction = (aP.Position - camera.CFrame.Position)
                        local distance = direction.Magnitude
                        if distance > 0 and distance < 1000 then
                            raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, camera, hitboxContainer}
                            local rR = workspace:Raycast(camera.CFrame.Position, direction, raycastParams)
                            if not rR or rR.Instance:IsDescendantOf(c) then
                                local sP, oS = camera:WorldToScreenPoint(rP.Position)
                                if oS then
                                    local dTC = (Vector2.new(sP.X, sP.Y) - crosshairPosition).Magnitude
                                    if dTC < mD then
                                        mD = dTC
                                        cP = p
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        aimTarget = cP
    end
    if aimTarget and aimTarget.Character and LocalPlayer.Character then
        local aPN = Settings.Aim_at_Head and "Head" or "HumanoidRootPart"
        local aP = Settings.HitboxExpander_Enabled and ghostHeads[aimTarget] or (aimTarget.Character:FindFirstChild(aPN))
        if aP then
            local currentCFrame = camera.CFrame
            local targetPosition = aP.Position
            local smoothingFactor = math.clamp(Settings.Smoothing / 20, 0.01, 0.95)
            local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetPosition)
            local lerpedCFrame = currentCFrame:Lerp(targetCFrame, 1 - smoothingFactor)
            
            -- Try multiple methods to aim
            -- Method 1: Direct camera manipulation
            local success = pcall(function()
                camera.CFrame = lerpedCFrame
            end)
            
            -- Method 2: If camera fails, try using camera's Focus property
            if not success then
                success = pcall(function()
                    camera.Focus = CFrame.new(targetPosition)
                end)
            end
            
            -- Method 3: Rotate character's root part as fallback
            if not success and LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.RootPart then
                    local rootPart = humanoid.RootPart
                    local direction = (targetPosition - rootPart.Position).Unit
                    local targetRotation = CFrame.lookAt(rootPart.Position, rootPart.Position + direction)
                    pcall(function()
                        rootPart.CFrame = rootPart.CFrame:Lerp(targetRotation, 1 - smoothingFactor)
                    end)
                end
            end
        end
    end
    FOVCircle.Visible = Settings.Show_FOV
    if Settings.Show_FOV then
        local fovRadius = Settings.FOV_Size
        
        -- Ensure AnchorPoint is set for centering
        FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
        
        -- Set size based on FOV radius
        FOVCircle.Size = UDim2.fromOffset(fovRadius * 2, fovRadius * 2)
        
        -- Position at exact center using scale (0.5 = 50% = center)
        -- This works regardless of viewport size changes
        FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
    end
    if not Settings.ESP_Enabled then
        for _, esp in pairs(activeESPs) do
            if esp.Container.Visible then
                esp.Container.Visible = false
            end
        end
        return
    end
    local playersThisFrame = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local head = character and character:FindFirstChild("Head")
            if humanoid and rootPart and head and humanoid.Health > 0 then
                table.insert(playersThisFrame, player)
                local isTeammate = false
                if Settings.Team_Check and LocalPlayer.Team and player.Team and player.Team == LocalPlayer.Team then
                    isTeammate = true
                end
                if isTeammate and not Settings.Show_Teammates then
                    if activeESPs[player] then
                        activeESPs[player].Container.Visible = false
                    end
                else
                    local esp = activeESPs[player] or createPlayerESP()
                    activeESPs[player] = esp
                    local viewportPoint = camera:WorldToViewportPoint(rootPart.Position)
                    local distance = math.floor((camera.CFrame.Position - rootPart.Position).Magnitude)
                    if viewportPoint.Z > 0 and distance <= Settings.ESP_Render_Distance then
                        esp.Container.Visible = true
                        local depth = viewportPoint.Z
                        local boxHeight = math.clamp(camera.ViewportSize.Y / (depth * SIZING_CONSTANT), 20, 1000)
                        local boxWidth = boxHeight * 0.6
                        local top3D = head.Position + Vector3.new(0, head.Size.Y / 2, 0)
                        local topScreenPos, onScreen = camera:WorldToScreenPoint(top3D)
                        if onScreen then
                            local boxTopLeft = Vector2.new(viewportPoint.X - boxWidth / 2, topScreenPos.Y)
                            esp.Container.Position = UDim2.fromOffset(boxTopLeft.X, boxTopLeft.Y)
                            esp.Container.Size = UDim2.fromOffset(boxWidth, boxHeight)
                            local currentColor = isTeammate and Settings.Teammate_Color or Settings.Enemy_Color
                            for _, corner in ipairs(esp.Corners) do
                                corner.BackgroundColor3 = currentColor
                            end
                            local h_size = UDim2.new(CORNER_SCALE, 0, 0, THICKNESS)
                            local v_size = UDim2.new(0, THICKNESS, CORNER_SCALE, 0)
                            esp.Corners[1].Size = h_size
                            esp.Corners[1].Position = UDim2.fromScale(0, 0)
                            esp.Corners[2].Size = v_size
                            esp.Corners[2].Position = UDim2.fromScale(0, 0)
                            esp.Corners[3].Size = h_size
                            esp.Corners[3].Position = UDim2.new(1 - CORNER_SCALE, 0, 0, 0)
                            esp.Corners[4].Size = v_size
                            esp.Corners[4].Position = UDim2.new(1, -THICKNESS, 0, 0)
                            esp.Corners[5].Size = h_size
                            esp.Corners[5].Position = UDim2.new(0, 0, 1, -THICKNESS)
                            esp.Corners[6].Size = v_size
                            esp.Corners[6].Position = UDim2.new(0, 0, 1 - CORNER_SCALE, 0)
                            esp.Corners[7].Size = h_size
                            esp.Corners[7].Position = UDim2.new(1 - CORNER_SCALE, 0, 1, -THICKNESS)
                            esp.Corners[8].Size = v_size
                            esp.Corners[8].Position = UDim2.new(1, -THICKNESS, 1 - CORNER_SCALE, 0)
                            esp.NameLabel.Visible = Settings.Name_Enabled
                            if Settings.Name_Enabled then
                                esp.NameLabel.TextColor3 = currentColor
                                esp.NameLabel.Text = player.Name
                                esp.NameLabel.Position = UDim2.new(0.5, 0, 0, -4)
                                esp.NameLabel.Size = UDim2.new(1.5, 0, 0, 14)
                            end
                            esp.DistanceLabel.Visible = Settings.Distance_Enabled
                            if Settings.Distance_Enabled then
                                esp.DistanceLabel.TextColor3 = currentColor
                                esp.DistanceLabel.Text = "[" .. distance .. "s]"
                                esp.DistanceLabel.Position = UDim2.new(0.5, 0, 1, 4)
                                esp.DistanceLabel.Size = UDim2.new(1.5, 0, 0, 12)
                            end
                        else
                            esp.Container.Visible = false
                        end
                    else
                        esp.Container.Visible = false
                    end
                end
            else
                if activeESPs[player] then
                    activeESPs[player].Container.Visible = false
                end
            end
        end
    end
    for player, esp in pairs(activeESPs) do
        if not table.find(playersThisFrame, player) then
            esp.Container:Destroy()
            activeESPs[player] = nil
        end
    end
end)
createButton(MiscPage,"Unload Script",function()if gameLoopConnection then gameLoopConnection:Disconnect()end;for _,esp in pairs(activeESPs)do esp.Container:Destroy()end;activeESPs={};for _,h in pairs(currentHighlights)do if h and h.Parent then h:Destroy()end end;currentHighlights={};for part,trans in pairs(originalTransparencies)do if part and part.Parent then part.Transparency=trans end end;originalTransparencies={};for hrp,props in pairs(originalHitboxes)do if hrp and hrp.Parent then hrp.Size=props.Size;hrp.Transparency=props.Transparency;hrp.Material=props.Material;hrp.Color=props.Color end end;originalHitboxes={};for _,head in pairs(ghostHeads)do head:Destroy()end;ghostHeads={};CustomUIScreenGui:Destroy();print("Project ESP has been unloaded.")end)
UserInputService.InputBegan:Connect(function(input)if input.KeyCode==Enum.KeyCode.Delete then MainWindow.Visible=not MainWindow.Visible end end)

print("Project ESP with Dual Hitbox Modes (v58) Initialized. Press 'Delete' to toggle the menu.")
