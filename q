local AllieConfiguration = false
--local PluginsRoot = MainRoot.Plugins

--[ INPUTERS ]--

local UserInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local FirebaseService = require(script.Parent.Parent.Access.ReplicatedStorage.QuantumUIStorage.Modules.FirebaseService)
-- Not in use
local AnimationService = require(script.Parent.Parent.Access.ReplicatedStorage.QuantumUIStorage.Modules.AnimationManager)
-- Not in use
local WebhookService = require(script.Parent.Parent.Access.ReplicatedStorage.QuantumUIStorage.Modules.WebhookService)
--[[
local url = "Url Here"

local webhookService = require(game.ServerStorage.WebhookService)

webhookService:createMessage(url, "Message Here")

webhookService:createEmbed(url, "Title Here", "Message Here", "Image Link Here (OPTIONAL)")
]]
local NoticationService = require(script.Parent.Parent.Access.ReplicatedStorage.QuantumUIStorage.Modules.NotificationService)
-- Ex: NoticationService:CreateNotification("WELCOME!", "Quantum UI is now active.","rbxassetid://13300915301", 5)

--[ INPUTERS END ]--

--[ DRAG SYSTEM ]--

local function setupDraggable(gui)
	local dragging
	local dragStart
	local startPos

	local function Lerp(a, b, m)
		return a + (b - a) * m
	end

	local lastMousePos
	local lastGoalPos
	local DRAG_SPEED = 8

	local function Update(dt)
		if not startPos then return end
		if not dragging and lastGoalPos then
			gui.Position = UDim2.new(
				startPos.X.Scale,
				Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED),
				startPos.Y.Scale,
				Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED)
			)
			return
		end

		local delta = (lastMousePos - UserInputService:GetMouseLocation())
		local xGoal = (startPos.X.Offset - delta.X)
		local yGoal = (startPos.Y.Offset - delta.Y)
		lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
		gui.Position = UDim2.new(
			startPos.X.Scale,
			Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED),
			startPos.Y.Scale,
			Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED)
		)
	end

	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			lastMousePos = UserInputService:GetMouseLocation()

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	runService.Heartbeat:Connect(Update)
end

setupDraggable(UserUI)
setupDraggable(KeySys)

--[[ DEPRECATED

local gui = UserUI

local dragging
local dragInput
local dragStart
local startPos

local function Lerp(a, b, m)
	return a + (b - a) * m
end

local lastMousePos
local lastGoalPos
local DRAG_SPEED = 8
local function Update(dt)
	if not (startPos) then return end;
	if not (dragging) and (lastGoalPos) then
		gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED))
		return 
	end

	local delta = (lastMousePos - UserInputService:GetMouseLocation())
	local xGoal = (startPos.X.Offset - delta.X);
	local yGoal = (startPos.Y.Offset - delta.Y);
	lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
	gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED))
end;

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		lastMousePos = UserInputService:GetMouseLocation()

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

runService.Heartbeat:Connect(Update)

----------------------------------------

local gui = KeySys

local dragging
local dragInput
local dragStart
local startPos

local function Lerp(a, b, m)
	return a + (b - a) * m
end

local lastMousePos
local lastGoalPos
local DRAG_SPEED = 8

local function Update(dt)
	if not (startPos) then return end;
	if not (dragging) and (lastGoalPos) then
		gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED))
		return 
	end

	local delta = (lastMousePos - UserInputService:GetMouseLocation())
	local xGoal = (startPos.X.Offset - delta.X);
	local yGoal = (startPos.Y.Offset - delta.Y);
	lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
	gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED))
end;

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		lastMousePos = UserInputService:GetMouseLocation()

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

runService.Heartbeat:Connect(Update)

--]]

--[ AUTO-CONCEAL, DEPRECATED ]--

local i_channel = script.Parent.Parent.Access
local i_sps = i_channel.StarterPlayerScripts
local i_rs = i_channel.ReplicatedStorage
local i_sss = i_channel.ServerScriptService
local i_ss = i_channel.ServerStorage

local function KeyGenerate(Location,SetRangeA,SetRangeB,ServerInvoked)
	Location = math.random(SetRangeA,SetRangeB)
	if VariablesRoot.DevConfig.MajorConsoleAccess.Value == true and ServerInvoked ~= true then
		print("[ALI | Networker]: Key generated for SubRoot "..Location.. " with access accepted from VariablesRoot.DevConfig.MajorConsoleAccess")
	end
end

local i_sps_key = nil
KeyGenerate(i_sps_key,50,50000,true)
local i_rs_key = nil
KeyGenerate(i_rs_key,50,50000,true)
local i_sss_key = nil
KeyGenerate(i_sss_key,50,50000,true)
local i_ss_key = nil
KeyGenerate(i_ss_key,50,50000,true)

if VariablesRoot.DevConfig.Anonymous.Value == true then
	UserUI["_QI-PageContainer"].MainPageA.USERNAME.Text = "Anonymous"
else
	UserUI["_QI-PageContainer"].MainPageA.USERNAME.Text = "<b>"..string.upper(game.Players.LocalPlayer.Name).."</b>"
end

--[[
if script.Parent.Parent.Variables.DevConfig.AutoInstall.Value == true then

	for x,e in i_sps:GetChildren() do
		e.Parent =  game.Players.LocalPlayer.PlayerScripts
	end
	wait(0.2)
	i_sps.Name = "StarterPlayerScripts [LOCKED]"
	for x,e in i_rs:GetChildren() do
		e.Parent =  game.ReplicatedStorage
	end
	wait(0.2)
	i_rs.Name = "ReplicatedStorage [LOCKED]"
	for x,e in i_sss:GetChildren() do
		e.Parent =  game.ServerScriptService
	end
	wait(0.2)
	i_sss.Name = "ServerScriptService [LOCKED]"
	for x,e in i_ss:GetChildren() do
		e.Parent =  game.ServerStorage
	end
	wait(0.2)
	i_ss.Name = "ServerStorage [LOCKED]"

	wait(5)

	script:Destroy()

else
	if script.Parent.Parent.Variables.DevConfig.ConsoleAccess.Value == true then
		warn("[QI-HANDLER]: Auto Install was denied. To safely install QuantumUI, please place the folders inside Access into their respective places.")
	end
end
]]
--[ AUTO-CONCEAL, DEPRECATED END ]--

--[ PLUGIN MANAGER ]--
local PluginTable = {}

if VariablesRoot.DevConfig.PluginConsoleAccess == true then
	print("[ALI | PLUGINS] Loading Plugins..")
	for i,v in PluginsRoot:GetChildren() do
		print("[ALI | PLUGINS] Loading Plugin:" ..v.Name.. " with Identification class of " ..v.ClassName)
		if v.PluginUsage then
			if v.PluginUsage.HarmfulCommands.Value == true then
				print("[ALI | PLUGINS] Plugin " ..v.Name.. " contains harmful commands, make sure to review all Plugins before running.")
			end
			if v.PluginUsage.OfficialPlugin.Value == true then
				print("[ALI | PLUGINS] Official Plugin detected: "..v.Name)
			end
			if v.PluginUsage.HandleBugs.Value == true then
				print("[ALI | PLUGINS] HandleBugs enabled on "..v.Name.. ". Make sure to turn this off if you don't want errors and bugs or prints.")
			end
		else
			print("[ALI | PLUGINS] Plugin's PluginUsage folder not found for "..v.Name.. ". If your the developer of the Plugin, make sure to add one!")
		end
	end
end

for i,v in PluginsRoot:GetChildren() do
	table.insert(PluginTable,v.Name)
	if VariablesRoot.DevConfig.PluginConsoleAccess.Value == true then
		print("[ALI | PLUGINS] Plugin "..v.Name.." added to PluginTable.")
	end
end

--[[ KEY INSTALLER ]]

if script.Parent.KeySystem.Visible == true then
	script.Parent.KeySystem.Visible = true
	VariablesRoot.InvokedConfig.Key_Visible.Value = true
end
if script.Parent.KeySystem.Visible == false then
	VariablesRoot.InvokedConfig.Key_Visible.Value = false
	script.Parent.KeySystem.Visible = true
	VariablesRoot.InvokedConfig.Key_Visible.Value = true
end
if script.Parent.UserUI.Visible == true then
	VariablesRoot.InvokedConfig.Key_Visible.Value = true
	script.Parent.UserUI.Visible = false
	VariablesRoot.InvokedConfig.Key_Visible.Value = false
end
if script.Parent.KeySystem.Visible == false then
	VariablesRoot.InvokedConfig.Key_Visible.Value = false
end

--[[ KEY INSTALLER END ]]

--[[ BUTTON CONTROL ]]--

local Buttons = {
	'_QI-1PRIORITY-MainPageB', -- }} Main page
	'_QI-2PRIORITY-SettingsB', -- }} Settings/configuration page
	'_QI-3PRIORITY-ShopB', -- }} Shop/market page
	'_QI-CharacterB', -- }} Character settings/configuration (wip?)
	'_QI-ExecutorB', -- }} Local/server-sided executor
	'_QI-NSFW_AnimationsB', -- }} NSFW../ Animations, server-side, does not req
	'_QI-NSFW_UIB', -- }} NSFW../ User Interface that are inside the UI itself, which they may accidentally delete..
	'_QI-NSFW_Tools1B', -- }} NSFW../ Tools 1 but NSFW tools, found in ReplicatedStorage.QuantumUIStorage.Tools (?)
	'_QI-ScriptsB', -- }} Scripts, most are server-side or req
	'_QI-Tools1B' -- }} Tools 1 Page found in ReplicatedStorage.QuantumUIStorage.Tools (?)
}

local Frames = {
	'MainPageA',
	'SettingsA',
	'ShopA',
	'CharacterA',
	'ExecutorA',
	'NSFWAnimationsA',
	'NSFWUserInterfaceA',
	'NSFWTools1A',
	'ScriptsA',
	'Tools1A'
}

local function Counting(num)
	for i, frame in pairs(UserUI["_QI-PageContainer"]:GetChildren()) do
		if frame.ClassName == 'Frame' then
			if frame.Name == Frames[num] then
				frame.Visible = true
			else
				frame.Visible = false
			end
		end
	end
end

for i, val in pairs(UserUI["_QI-ButtonContainer"]["_QI-Buttons"]:GetChildren()) do
	if val.ClassName == 'TextButton' then
		for index, buttonName in ipairs(Buttons) do
			if val.Name == buttonName then
				val.MouseButton1Click:Connect(function()
					Counting(index)
				end)
				break
			end
		end
	end
end

--[[ DEPRECATED
for i, val in pairs(UserUI["_QI-ButtonContainer"]["_QI-Buttons"]:GetChildren()) do
	if val.ClassName == 'TextButton' then
		val.MouseButton1Click:Connect(function()
			if val.Name == Buttons[1] then
				Counting(1)
			elseif val.Name == Buttons[2] then
				Counting(2)
			elseif val.Name == Buttons[3] then
				Counting(3)
			elseif val.Name == Buttons[4] then
				Counting(4)
			elseif val.Name == Buttons[5] then
				Counting(5)
			elseif val.Name == Buttons[6] then
				Counting(6)
			elseif val.Name == Buttons[7] then
				Counting(7)
			elseif val.Name == Buttons[8] then
				Counting(8)
			elseif val.Name == Buttons[9] then
				Counting(9)
			elseif val.Name == Buttons[10] then
				Counting(10)
			elseif val.Name == Buttons[11] then
				Counting(11)
			elseif val.Name == Buttons[12] then
				Counting(12)
			elseif val.Name == Buttons[13] then
				Counting(13)
			elseif val.Name == Buttons[14] then
				Counting(14)
			elseif val.Name == Buttons[15] then
				Counting(15)
			elseif val.Name == Buttons[16] then
				Counting(16)
			elseif val.Name == Buttons[17] then
				Counting(17)
			elseif val.Name == Buttons[18] then
				Counting(18)
			elseif val.Name == Buttons[19] then
				Counting(19)
			elseif val.Name == Buttons[20] then
				Counting(20)
			elseif val.Name == Buttons[21] then
				Counting(21)
			elseif val.Name == Buttons[22] then
				Counting(22)
			elseif val.Name == Buttons[23] then
				Counting(23)
			elseif val.Name == Buttons[24] then
				Counting(24)
			elseif val.Name == Buttons[25] then
				Counting(25)
			elseif val.Name == Buttons[26] then
				Counting(26)
			elseif val.Name == Buttons[27] then
				Counting(27)
			elseif val.Name == Buttons[28] then
				Counting(28)
			elseif val.Name == Buttons[29] then
				Counting(29)
			elseif val.Name == Buttons[30] then
				Counting(30)
			elseif val.Name == Buttons[31] then
				Counting(31)
end
		end)
	end
end
]]
