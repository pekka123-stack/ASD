-- Define panel elements
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local CreatorLabel = Instance.new("TextLabel")
local GroupIDBox = Instance.new("TextBox")
local AudioIDBox = Instance.new("TextBox")
local VerifyLabel = Instance.new("TextLabel")
local PlayButton = Instance.new("TextButton")
local DistortionSlider = Instance.new("Slider")
local SpeedSlider = Instance.new("Slider")
local TimePositionSlider = Instance.new("Slider")
local DistanceSlider = Instance.new("Slider")

-- Initialize GUI properties
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 300, 0, 500)
Frame.Position = UDim2.new(0.5, -150, 0.5, -250)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Title
TitleLabel.Parent = Frame
TitleLabel.Text = "RANASONIC V1"
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.SourceSans
TitleLabel.TextSize = 24

-- Creator
CreatorLabel.Parent = Frame
CreatorLabel.Text = "created by ronttosaurus54321"
CreatorLabel.Size = UDim2.new(1, 0, 0, 30)
CreatorLabel.Position = UDim2.new(0, 0, 0, 50)
CreatorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Font = Enum.Font.SourceSans
CreatorLabel.TextSize = 18

-- Group ID Box
GroupIDBox.Parent = Frame
GroupIDBox.Size = UDim2.new(1, -20, 0, 40)
GroupIDBox.Position = UDim2.new(0, 10, 0, 90)
GroupIDBox.PlaceholderText = "Enter Group ID"
GroupIDBox.Text = ""

-- Audio ID Box
AudioIDBox.Parent = Frame
AudioIDBox.Size = UDim2.new(1, -20, 0, 40)
AudioIDBox.Position = UDim2.new(0, 10, 0, 140)
AudioIDBox.PlaceholderText = "Enter Audio ID"
AudioIDBox.Text = ""

-- Verify label
VerifyLabel.Parent = Frame
VerifyLabel.Size = UDim2.new(1, 0, 0, 30)
VerifyLabel.Position = UDim2.new(0, 0, 0, 190)
VerifyLabel.Text = "Unverified"
VerifyLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
VerifyLabel.BackgroundTransparency = 1
VerifyLabel.Font = Enum.Font.SourceSans
VerifyLabel.TextSize = 18

-- Play button
PlayButton.Parent = Frame
PlayButton.Size = UDim2.new(0, 100, 0, 40)
PlayButton.Position = UDim2.new(0.5, -50, 0, 230)
PlayButton.Text = "Play"
PlayButton.TextSize = 18

-- Sliders
-- Distortion Slider
DistortionSlider.Parent = Frame
DistortionSlider.Size = UDim2.new(0.9, 0, 0, 40)
DistortionSlider.Position = UDim2.new(0.05, 0, 0, 280)
DistortionSlider.MinValue = 0
DistortionSlider.MaxValue = 5
DistortionSlider.Value = 0
DistortionSlider.Text = "Distortion"

-- Speed Slider
SpeedSlider.Parent = Frame
SpeedSlider.Size = UDim2.new(0.9, 0, 0, 40)
SpeedSlider.Position = UDim2.new(0.05, 0, 0, 330)
SpeedSlider.MinValue = 0.01
SpeedSlider.MaxValue = 10
SpeedSlider.Value = 1
SpeedSlider.Text = "Speed"

-- Time Position Slider
TimePositionSlider.Parent = Frame
TimePositionSlider.Size = UDim2.new(0.9, 0, 0, 40)
TimePositionSlider.Position = UDim2.new(0.05, 0, 0, 380)
TimePositionSlider.MinValue = 0
TimePositionSlider.MaxValue = 100 -- Adjust to max length of audio
TimePositionSlider.Value = 0
TimePositionSlider.Text = "Time Position"

-- Distance Slider
DistanceSlider.Parent = Frame
DistanceSlider.Size = UDim2.new(0.9, 0, 0, 40)
DistanceSlider.Position = UDim2.new(0.05, 0, 0, 430)
DistanceSlider.MinValue = 0
DistanceSlider.MaxValue = 500 -- Adjust max distance as per game needs
DistanceSlider.Value = 100
DistanceSlider.Text = "Distance"

-- Function to verify audio
local function verifyAudio(groupId, audioId)
    local isVerified = false
    -- Check if the audio ID belongs to the selected group (pseudo check)
    if tonumber(groupId) and tonumber(audioId) then
        -- In V2, you can fetch the group data and cross-check here
        isVerified = true
        VerifyLabel.Text = "Verified"
        VerifyLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        VerifyLabel.Text = "Unverified"
        VerifyLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
    return isVerified
end

-- Audio playing function
local function playAudio(groupId, audioId, speed, distortion, timePos, distance)
    local sound = Instance.new("Sound", game.Players.LocalPlayer.Character)
    sound.SoundId = "rbxassetid://" .. audioId
    sound.Volume = 1
    sound.PlaybackSpeed = speed
    sound.TimePosition = timePos
    sound.MaxDistance = distance
    sound:Play()
    
    -- Apply distortion (pseudo, Roblox doesn't have built-in distortion, so we improvise)
    if distortion > 0 then
        sound.Pitch = 1 / (distortion + 1) -- Change pitch to simulate distortion
    end
end

-- Play button click
PlayButton.MouseButton1Click:Connect(function()
    local groupId = GroupIDBox.Text
    local audioId = AudioIDBox.Text
    local speed = SpeedSlider.Value
    local distortion = DistortionSlider.Value
    local timePos = TimePositionSlider.Value
    local distance = DistanceSlider.Value
    
    if verifyAudio(groupId, audioId) then
        playAudio(groupId, audioId, speed, distortion, timePos, distance)
    else
        print("Audio verification failed.")
    end
end)
