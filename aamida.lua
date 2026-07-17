local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")	
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local guiService = game:GetService("GuiService")

local viewport = workspace.CurrentCamera.ViewportSize

local FONT do
	local getcustomasset = getcustomasset or getsynasset or (syn and syn.getcustomasset)
	if writefile and getcustomasset then
		local ok, custom = pcall(function()
			local ttf = "aamida_ProggyClean.ttf"
			local json = "aamida_ProggyClean.json"
			if not (isfile and isfile(ttf)) then
				writefile(ttf, game:HttpGet("https://github.com/sleepypuppy77/aamida/raw/refs/heads/main/ProggyClean.ttf"))
			end
			writefile(json, game:GetService("HttpService"):JSONEncode({
				name = "ProggyClean",
				faces = {
					{ name = "Regular", weight = 400, style = "normal", assetId = getcustomasset(ttf) },
				},
			}))
			return Font.new(getcustomasset(json), Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		end)
		if ok then FONT = custom end
	end
	if not FONT then
		FONT = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	end
end

local Library = {}

 
function Library:validate(defaults, options)
	for i, v in pairs(defaults) do
		if options[i] == nil then
			options[i] = v
		end
	end
	return options
end

function Library:Init(options)
	local options = options or {}
	options = Library:validate({
		title = "Aamida UI Library",	 -- this da first ui i coded :3 set a title retard
		toggleKey = Enum.KeyCode.RightShift,	-- key that shows/hides the menu (Enum.KeyCode or a string like "RightShift")
	}, options or {})
	
	local Tree = {}
	
	-- StarterGui.aamida
	Tree["1"] = Instance.new("ScreenGui", runService:IsStudio() and players.LocalPlayer:WaitForChild("PlayerGui") or coreGui);
	Tree["1"]["IgnoreGuiInset"] = true;
	Tree["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
	Tree["1"]["Name"] = [[aamida]];
	Tree["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
	Tree["1"]["IgnoreGuiInset"] = true


	-- StarterGui.aamida.Window (CanvasGroup so the whole menu can fade as one)
	Tree["2"] = Instance.new("CanvasGroup", Tree["1"]);
	Tree["2"]["BorderSizePixel"] = 0;
	Tree["2"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
	Tree["2"]["AnchorPoint"] = Vector2.new(0, 0);
	Tree["2"]["Size"] = UDim2.new(0, 430, 0, 256);
	Tree["2"]["Position"] = UDim2.fromOffset((viewport.X/2) - (Tree["2"].Size.X.Offset /2), (viewport.Y/2) - (Tree["2"].Size.Y.Offset /2));
	Tree["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Tree["2"]["Name"] = [[Window]];

	-- StarterGui.aamida.Window.UIStroke
	Tree["8"] = Instance.new("UIStroke", Tree["2"]);
	Tree["8"]["LineJoinMode"] = Enum.LineJoinMode.Miter;

	
	-- StarterGui.aamida.UIScale
	Tree["7e"] = Instance.new("UIScale", Tree["1"]);
	

	-- StarterGui.aamida.Window.Resize
	Tree["7c"] = Instance.new("TextButton", Tree["2"]);
	Tree["7c"]["BorderSizePixel"] = 0;
	Tree["7c"]["TextSize"] = 14;
	Tree["7c"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
	Tree["7c"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
	Tree["7c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	Tree["7c"]["Size"] = UDim2.new(0, 4, 0, 4);
	Tree["7c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Tree["7c"]["Text"] = [[]];
	Tree["7c"]["Name"] = [[Resize]];
	Tree["7c"]["Position"] = UDim2.new(0.99, 0, 0.985, 0);


	-- StarterGui.aamida.Window.UIGradient
	Tree["7d"] = Instance.new("UIGradient", Tree["2"]);
	Tree["7d"]["Rotation"] = 90;
	Tree["7d"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};
	
	
	-- StarterGui.aamida.Window.Top
	Tree["3"] = Instance.new("Frame", Tree["2"]);
	Tree["3"]["BorderSizePixel"] = 0;
	Tree["3"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
	Tree["3"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	Tree["3"]["Size"] = UDim2.new(0, 430, 0, 20);
	Tree["3"]["Position"] = UDim2.new(0.4996, 0, 0.03906, 0);
	Tree["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Tree["3"]["Name"] = [[Top]];


	-- StarterGui.aamida.Window.Top.UIStroke
	Tree["4"] = Instance.new("UIStroke", Tree["3"]);
	Tree["4"]["LineJoinMode"] = Enum.LineJoinMode.Miter;


	-- StarterGui.aamida.Window.Top.TextLabel
	Tree["5"] = Instance.new("TextLabel", Tree["3"]);
	Tree["5"]["TextStrokeTransparency"] = 0;
	Tree["5"]["BorderSizePixel"] = 0;
	Tree["5"]["TextSize"] = 12;
	Tree["5"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	Tree["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	Tree["5"]["FontFace"] = FONT;
	Tree["5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	Tree["5"]["BackgroundTransparency"] = 1;
	Tree["5"]["Size"] = UDim2.new(0, 426, 0, 20);
	Tree["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Tree["5"]["Text"] = options["title"];


	-- StarterGui.aamida.Window.Top.UIPadding
	Tree["6"] = Instance.new("UIPadding", Tree["3"]);
	Tree["6"]["PaddingLeft"] = UDim.new(0, 4);


	-- StarterGui.aamida.Window.Top.UIGradient
	Tree["7"] = Instance.new("UIGradient", Tree["3"]);
	Tree["7"]["Rotation"] = 90;
	Tree["7"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};
	
	-- StarterGui.aamida.Window.TabButtons
	Tree["9"] = Instance.new("Frame", Tree["2"]);
	Tree["9"]["BorderSizePixel"] = 0;
	Tree["9"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61); 
	Tree["9"]["Size"] = UDim2.new(0, 95, 0, 225);
	Tree["9"]["Position"] = UDim2.new(0.01163, 0, 0.10156, 0);
	Tree["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Tree["9"]["Name"] = [[TabButtons]];


	-- StarterGui.aamida.Window.TabButtons.UIStroke
	Tree["a"] = Instance.new("UIStroke", Tree["9"]);
	Tree["a"]["LineJoinMode"] = Enum.LineJoinMode.Miter;


	-- StarterGui.aamida.Window.TabButtons.UIListLayout
	Tree["b"] = Instance.new("UIListLayout", Tree["9"]);
	Tree["b"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
	Tree["b"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
	

	-- StarterGui.aamida.Window.TabButtons.UIGradient
	Tree["14"] = Instance.new("UIGradient", Tree["9"]);
	Tree["14"]["Rotation"] = 90;
	Tree["14"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

	
	Tree.Tabs = {}
	Tree.SelectedTab = nil

	-- drag the window by its Top bar
	do
		local dragging = false
		local dragStart, startPos

		Tree["3"].InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = Tree["2"].Position
			end
		end)

		userInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local scale = Tree["7e"].Scale
				local delta = (input.Position - dragStart) / scale
				Tree["2"].Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)

		userInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)
	end

	-- menu show/hide via a configurable toggle key (default RightShift)
	local toggleKey = options["toggleKey"]
	if type(toggleKey) == "string" then
		local ok, code = pcall(function() return Enum.KeyCode[string.upper(toggleKey)] end)
		toggleKey = ok and code or Enum.KeyCode.RightShift
	elseif typeof(toggleKey) ~= "EnumItem" then
		toggleKey = Enum.KeyCode.RightShift
	end

	local MENU_FADE = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	local menuOpen = true

	function Tree:SetOpen(open)
		if open == menuOpen then return end
		menuOpen = open
		if open then
			Tree["2"].Visible = true
			Tree["2"].GroupTransparency = 1
			tweenService:Create(Tree["2"], MENU_FADE, { GroupTransparency = 0 }):Play()
		else
			local fade = tweenService:Create(Tree["2"], MENU_FADE, { GroupTransparency = 1 })
			fade:Play()
			fade.Completed:Connect(function()
				if not menuOpen then Tree["2"].Visible = false end
			end)
		end
	end

	function Tree:ToggleMenu()
		Tree:SetOpen(not menuOpen)
	end

	userInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == toggleKey then
			Tree:ToggleMenu()
		end
	end)

	-- watermark: a standalone, draggable chip using the same styling as the Window Top bar
	function Tree:CreateWatermark(watermarkOptions)
		watermarkOptions = Library:validate({
			text = "aamida",
		}, watermarkOptions or {})

		-- parented to the ScreenGui (not the Window) so it stays visible and doesn't fade with the menu
		local watermark = Instance.new("Frame", Tree["1"]);
		watermark["BorderSizePixel"] = 0;
		watermark["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
		watermark["Size"] = UDim2.new(0, 0, 0, 20);
		watermark["AutomaticSize"] = Enum.AutomaticSize.X;
		watermark["Position"] = UDim2.fromOffset(16, 58);	-- fallback; corrected to the real inset below
		watermark["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		watermark["Name"] = [[Watermark]];

		-- Watermark.UIStroke
		local watermarkStroke = Instance.new("UIStroke", watermark);
		watermarkStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

		-- Watermark.UIGradient
		local watermarkGradient = Instance.new("UIGradient", watermark);
		watermarkGradient["Rotation"] = 90;
		watermarkGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

		-- Watermark.UIPadding
		local watermarkPadding = Instance.new("UIPadding", watermark);
		watermarkPadding["PaddingLeft"] = UDim.new(0, 6);
		watermarkPadding["PaddingRight"] = UDim.new(0, 6);

		-- Watermark.TextLabel
		local watermarkText = Instance.new("TextLabel", watermark);
		watermarkText["TextStrokeTransparency"] = 0;
		watermarkText["BorderSizePixel"] = 0;
		watermarkText["TextSize"] = 12;
		watermarkText["TextXAlignment"] = Enum.TextXAlignment.Left;
		watermarkText["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		watermarkText["FontFace"] = FONT;
		watermarkText["TextColor3"] = Color3.fromRGB(255, 255, 255);
		watermarkText["BackgroundTransparency"] = 1;
		watermarkText["Size"] = UDim2.new(0, 0, 1, 0);
		watermarkText["AutomaticSize"] = Enum.AutomaticSize.X;
		watermarkText["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		watermarkText["Text"] = watermarkOptions["text"];
		watermarkText["Name"] = [[Text]];

		-- Watermark.Accent (green underline, same accent colour as the slider fill)
		local watermarkAccent = Instance.new("Frame", watermark);
		watermarkAccent["BorderSizePixel"] = 0;
		watermarkAccent["BackgroundColor3"] = Color3.fromRGB(151, 201, 61);
		watermarkAccent["AnchorPoint"] = Vector2.new(0, 1);
		watermarkAccent["Position"] = UDim2.new(0, -6, 1, 0);	-- cancel the left padding
		watermarkAccent["Size"] = UDim2.new(1, 12, 0, 1);		-- +12 spans both padded edges, full width
		watermarkAccent["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		watermarkAccent["Name"] = [[Accent]];

		-- Watermark.Accent.UIGradient
		local watermarkAccentGradient = Instance.new("UIGradient", watermarkAccent);
		watermarkAccentGradient["Rotation"] = 90;
		watermarkAccentGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

		-- anchor just below the Roblox topbar using the real inset (58px new topbar, 36px old).
		-- IgnoreGuiInset is true so we offset manually; GetGuiInset can be 0 on the first frame,
		-- so we only apply it once it's populated and re-check when TopbarInset changes.
		local moved = false
		local function anchorBelowTopbar()
			if moved then return end
			local inset = guiService:GetGuiInset()
			if inset.Y > 0 then
				-- inset.X handles any left safe-area (notch); +16 matches the topbar's left button margin
				watermark.Position = UDim2.fromOffset(inset.X + 16, inset.Y + 4)
			end
		end
		anchorBelowTopbar()
		guiService:GetPropertyChangedSignal("TopbarInset"):Connect(anchorBelowTopbar)

		-- draggable, same as the Window
		do
			local dragging = false
			local dragStart, startPos

			watermark.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					moved = true	-- stop auto-anchoring once the user drags it
					dragStart = input.Position
					startPos = watermark.Position
				end
			end)

			userInputService.InputChanged:Connect(function(input)
				if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					local scale = Tree["7e"].Scale
					local delta = (input.Position - dragStart) / scale
					watermark.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				end
			end)

			userInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
			end)
		end

		local watermarkObj = {
			Frame = watermark,
			Label = watermarkText,
		}

		function watermarkObj:SetText(newText)
			watermarkText.Text = newText
		end

		-- smooth fade-in entrance (Frame can't group-fade, so we ease each part's transparency)
		local ENTER_TWEEN = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		watermark.BackgroundTransparency = 1
		watermarkStroke.Transparency = 1
		watermarkText.TextTransparency = 1
		watermarkText.TextStrokeTransparency = 1
		watermarkAccent.BackgroundTransparency = 1
		tweenService:Create(watermark, ENTER_TWEEN, { BackgroundTransparency = 0 }):Play()
		tweenService:Create(watermarkStroke, ENTER_TWEEN, { Transparency = 0 }):Play()
		tweenService:Create(watermarkText, ENTER_TWEEN, { TextTransparency = 0, TextStrokeTransparency = 0 }):Play()
		tweenService:Create(watermarkAccent, ENTER_TWEEN, { BackgroundTransparency = 0 }):Play()

		return watermarkObj
	end

	-- notifications: slide in from the left, stack, and line up under the watermark
	local notifications = {}	-- active list, index 1 = top (newest)
	local NOTIF_HEIGHT = 20
	local NOTIF_GAP = 6
	local NOTIF_OFFSCREEN = -500
	local NOTIF_TWEEN = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

	local function notifAnchor()
		local inset = guiService:GetGuiInset()
		local topY = (inset.Y > 0 and inset.Y or 58)
		-- inset.X + 16 lines up with the watermark; sit on the row just below it
		return inset.X + 16, topY + 4 + NOTIF_HEIGHT + NOTIF_GAP
	end

	local function reflowNotifications()
		local x, y = notifAnchor()
		for i, entry in ipairs(notifications) do
			local targetY = y + (i - 1) * (NOTIF_HEIGHT + NOTIF_GAP)
			tweenService:Create(entry.Frame, NOTIF_TWEEN, { Position = UDim2.fromOffset(x, targetY) }):Play()
		end
	end

	function Tree:Notify(notifyOptions)
		notifyOptions = Library:validate({
			text = "Notification",
			duration = 3,
			color = Color3.fromRGB(151, 201, 61),	-- accent colour
		}, notifyOptions or {})

		local _, y = notifAnchor()
		local startY = y + #notifications * (NOTIF_HEIGHT + NOTIF_GAP)	-- its row at the bottom of the stack

		-- notification frame (same styling as the watermark)
		local notif = Instance.new("Frame", Tree["1"]);
		notif["BorderSizePixel"] = 0;
		notif["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
		notif["Size"] = UDim2.new(0, 0, 0, NOTIF_HEIGHT);
		notif["AutomaticSize"] = Enum.AutomaticSize.X;
		notif["Position"] = UDim2.fromOffset(NOTIF_OFFSCREEN, startY);	-- start off-screen at its own row
		notif["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		notif["Name"] = [[Notification]];

		local notifStroke = Instance.new("UIStroke", notif);
		notifStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

		local notifGradient = Instance.new("UIGradient", notif);
		notifGradient["Rotation"] = 90;
		notifGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

		local notifPadding = Instance.new("UIPadding", notif);
		notifPadding["PaddingLeft"] = UDim.new(0, 6);
		notifPadding["PaddingRight"] = UDim.new(0, 6);

		local notifText = Instance.new("TextLabel", notif);
		notifText["TextStrokeTransparency"] = 0;
		notifText["BorderSizePixel"] = 0;
		notifText["TextSize"] = 12;
		notifText["TextXAlignment"] = Enum.TextXAlignment.Left;
		notifText["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		notifText["FontFace"] = FONT;
		notifText["TextColor3"] = Color3.fromRGB(255, 255, 255);
		notifText["BackgroundTransparency"] = 1;
		notifText["Size"] = UDim2.new(0, 0, 1, 0);
		notifText["AutomaticSize"] = Enum.AutomaticSize.X;
		notifText["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		notifText["Text"] = notifyOptions["text"];
		notifText["Name"] = [[Text]];

		local notifAccent = Instance.new("Frame", notif);
		notifAccent["BorderSizePixel"] = 0;
		notifAccent["BackgroundColor3"] = notifyOptions["color"];
		notifAccent["AnchorPoint"] = Vector2.new(0, 1);
		notifAccent["Position"] = UDim2.new(0, -6, 1, 0);
		notifAccent["Size"] = UDim2.new(1, 12, 0, 1);
		notifAccent["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		notifAccent["Name"] = [[Accent]];

		local notifAccentGradient = Instance.new("UIGradient", notifAccent);
		notifAccentGradient["Rotation"] = 90;
		notifAccentGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

		local entry = { Frame = notif }
		table.insert(notifications, entry)	-- newest at the bottom of the stack
		reflowNotifications()	-- slides the new one in at the bottom

		-- the accent line doubles as a countdown bar: deplete its width over the duration
		tweenService:Create(notifAccent, TweenInfo.new(notifyOptions["duration"], Enum.EasingStyle.Linear), {
			Size = UDim2.new(0, 0, 0, 1),
		}):Play()

		-- auto-dismiss: slide back out, then remove and reflow
		task.delay(notifyOptions["duration"], function()
			tweenService:Create(notif, NOTIF_TWEEN, { Position = UDim2.fromOffset(NOTIF_OFFSCREEN, notif.Position.Y.Offset) }):Play()
			task.wait(NOTIF_TWEEN.Time)
			for i, e in ipairs(notifications) do
				if e == entry then
					table.remove(notifications, i)
					break
				end
			end
			notif:Destroy()
			reflowNotifications()
		end)

		return entry
	end

	-- swap animation config
	local SELECTED_COLOR = Color3.fromRGB(41, 41, 41)
	local IDLE_COLOR = Color3.fromRGB(61, 61, 61)
	local CONTENT_POS = UDim2.new(0.24651, 0, 0.20313, 0)
	local BUTTON_TWEEN = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local PAGE_TWEEN = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	-- fade a tab/sub-tab button between its selected and idle grey
	local function tweenButton(button, selected)
		tweenService:Create(button, BUTTON_TWEEN, {
			BackgroundColor3 = selected and SELECTED_COLOR or IDLE_COLOR,
		}):Play()
		button.Name = selected and "SelectedButton" or "Button"
	end

	-- show a content page with a slide-in, or hide it instantly (pages overlap)
	local function setPageVisible(page, visible)
		if visible then
			if not page.Visible then
				page.Position = CONTENT_POS + UDim2.fromOffset(0, 8)
				page.Visible = true
				tweenService:Create(page, PAGE_TWEEN, { Position = CONTENT_POS }):Play()
			end
		else
			page.Visible = false
		end
	end

	function Tree:SelectTab(tab)
		for _, other in ipairs(Tree.Tabs) do
			local selected = other == tab
			tweenButton(other.Button, selected)
			other.SubTabBar.Visible = selected
			for _, sub in ipairs(other.SubTabs) do
				setPageVisible(sub.Content, selected and (sub == other.SelectedSubTab))
			end
		end
		Tree.SelectedTab = tab
	end

	function Tree:CreateTab(options)
		options = Library:validate({
			name = "Tab",	 -- this da first ui i coded :3 set a title retard
		}, options or {})

		-- StarterGui.aamida.Window.TabButtons.Button
		local button = Instance.new("Frame", Tree["9"]);
		button["BorderSizePixel"] = 0;
		button["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
		button["Size"] = UDim2.new(1, 0, 0, 20);
		button["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		button["Name"] = [[Button]];

		-- StarterGui.aamida.Window.TabButtons.Button.UIStroke
		local buttonStroke = Instance.new("UIStroke", button);
		buttonStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

		-- StarterGui.aamida.Window.TabButtons.Button.TextButton
		local buttonText = Instance.new("TextButton", button);
		buttonText["TextStrokeTransparency"] = 0;
		buttonText["BorderSizePixel"] = 0;
		buttonText["TextSize"] = 12;
		buttonText["TextColor3"] = Color3.fromRGB(255, 255, 255);
		buttonText["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		buttonText["FontFace"] = FONT;
		buttonText["BackgroundTransparency"] = 1;
		buttonText["Size"] = UDim2.new(1, 0, 1, 0);
		buttonText["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		buttonText["Text"] = options["name"];

		-- StarterGui.aamida.Window.TabButtons.Button.UIGradient
		local buttonGradient = Instance.new("UIGradient", button);
		buttonGradient["Rotation"] = 90;
		buttonGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

		-- StarterGui.aamida.Window.SubTabs
		local subTabBar = Instance.new("Frame", Tree["2"]);
		subTabBar["BorderSizePixel"] = 0;
		subTabBar["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
		subTabBar["Size"] = UDim2.new(0, 319, 0, 20);
		subTabBar["Position"] = UDim2.new(0.24651, 0, 0.09982, 0);
		subTabBar["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		subTabBar["Name"] = [[SubTabs]];
		subTabBar["Visible"] = false;

		-- StarterGui.aamida.Window.SubTabs.UIStroke
		local subTabBarStroke = Instance.new("UIStroke", subTabBar);
		subTabBarStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

		-- StarterGui.aamida.Window.SubTabs.UIListLayout
		local subTabBarLayout = Instance.new("UIListLayout", subTabBar);
		subTabBarLayout["HorizontalFlex"] = Enum.UIFlexAlignment.Fill;
		subTabBarLayout["SortOrder"] = Enum.SortOrder.LayoutOrder;
		subTabBarLayout["FillDirection"] = Enum.FillDirection.Horizontal;

		local tab = {
			Name = options["name"],
			Button = button,
			SubTabBar = subTabBar,
			SubTabs = {},
			SelectedSubTab = nil,
		}

		function tab:SelectSubTab(subtab)
			for _, sub in ipairs(tab.SubTabs) do
				local selected = sub == subtab
				tweenButton(sub.Button, selected)
				setPageVisible(sub.Content, selected and (Tree.SelectedTab == tab))
			end
			tab.SelectedSubTab = subtab
		end

		function tab:CreateSubTab(subOptions)
			subOptions = Library:validate({
				name = "Sub-Tab",
			}, subOptions or {})

			-- StarterGui.aamida.Window.SubTabs.Button
			local subButton = Instance.new("Frame", subTabBar);
			subButton["BorderSizePixel"] = 0;
			subButton["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
			subButton["Size"] = UDim2.new(0.19436, 0, 0, 20);
			subButton["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			subButton["Name"] = [[Button]];

			-- StarterGui.aamida.Window.SubTabs.Button.UIStroke
			local subButtonStroke = Instance.new("UIStroke", subButton);
			subButtonStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

			-- StarterGui.aamida.Window.SubTabs.Button.TextButton
			local subButtonText = Instance.new("TextButton", subButton);
			subButtonText["TextStrokeTransparency"] = 0;
			subButtonText["BorderSizePixel"] = 0;
			subButtonText["TextSize"] = 12;
			subButtonText["TextColor3"] = Color3.fromRGB(255, 255, 255);
			subButtonText["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			subButtonText["FontFace"] = FONT;
			subButtonText["BackgroundTransparency"] = 1;
			subButtonText["Size"] = UDim2.new(1, 0, 1, 0);
			subButtonText["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			subButtonText["Text"] = subOptions["name"];

			-- StarterGui.aamida.Window.SubTabs.Button.UIGradient
			local subButtonGradient = Instance.new("UIGradient", subButton);
			subButtonGradient["Rotation"] = 90;
			subButtonGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

			-- StarterGui.aamida.Window.Tab
			local content = Instance.new("Frame", Tree["2"]);
			content["BorderSizePixel"] = 0;
			content["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
			content["Size"] = UDim2.new(0, 319, 0, 199);
			content["Position"] = UDim2.new(0.24651, 0, 0.20313, 0);
			content["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			content["Name"] = [[Tab]];
			content["BackgroundTransparency"] = 1;
			content["Visible"] = false;

			-- StarterGui.aamida.Window.Tab.UIListLayout
			local contentLayout = Instance.new("UIListLayout", content);
			contentLayout["HorizontalFlex"] = Enum.UIFlexAlignment.Fill;
			contentLayout["VerticalFlex"] = Enum.UIFlexAlignment.Fill;
			contentLayout["Padding"] = UDim.new(0, 6);
			contentLayout["SortOrder"] = Enum.SortOrder.LayoutOrder;
			contentLayout["FillDirection"] = Enum.FillDirection.Horizontal;

			local subtab = {
				Name = subOptions["name"],
				Button = subButton,
				Content = content,
				Sections = {},
			}

			function subtab:CreateSection(sectionOptions)
				sectionOptions = Library:validate({
					name = "Section",
				}, sectionOptions or {})

				-- StarterGui.aamida.Window.Tab.Section
				local section = Instance.new("Frame", content);
				section["BorderSizePixel"] = 0;
				section["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
				section["Size"] = UDim2.new(0, 100, 0, 100);
				section["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				section["Name"] = [[Section]];

				-- StarterGui.aamida.Window.Tab.Section.UIStroke
				local sectionStroke = Instance.new("UIStroke", section);
				sectionStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

				-- StarterGui.aamida.Window.Tab.Section.Top
				local top = Instance.new("Frame", section);
				top["BorderSizePixel"] = 0;
				top["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
				top["Size"] = UDim2.new(1, 0, 0, 16);
				top["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				top["Name"] = [[Top]];

				-- StarterGui.aamida.Window.Tab.Section.Top.UIStroke
				local topStroke = Instance.new("UIStroke", top);
				topStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

				-- StarterGui.aamida.Window.Tab.Section.Top.TextLabel
				local topLabel = Instance.new("TextLabel", top);
				topLabel["TextStrokeTransparency"] = 0;
				topLabel["BorderSizePixel"] = 0;
				topLabel["TextSize"] = 12;
				topLabel["TextXAlignment"] = Enum.TextXAlignment.Left;
				topLabel["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				topLabel["FontFace"] = FONT;
				topLabel["TextColor3"] = Color3.fromRGB(255, 255, 255);
				topLabel["BackgroundTransparency"] = 1;
				topLabel["Size"] = UDim2.new(1, 0, 1, 0);
				topLabel["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				topLabel["Text"] = sectionOptions["name"];

				-- StarterGui.aamida.Window.Tab.Section.Top.UIPadding
				local topPadding = Instance.new("UIPadding", top);
				topPadding["PaddingLeft"] = UDim.new(0, 4);

				-- StarterGui.aamida.Window.Tab.Section.Top.UIGradient
				local topGradient = Instance.new("UIGradient", top);
				topGradient["Rotation"] = 90;
				topGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

				-- StarterGui.aamida.Window.Tab.Section.UIGradient
				local sectionGradient = Instance.new("UIGradient", section);
				sectionGradient["Rotation"] = 90;
				sectionGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

				-- StarterGui.aamida.Window.Tab.Section.Container
				local container = Instance.new("ScrollingFrame", section);
				container["BorderSizePixel"] = 0;
				container["Name"] = [[Container]];
				container["ScrollBarImageTransparency"] = 1;
				container["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				container["Selectable"] = false;
				container["Size"] = UDim2.new(0, 156, 0, 184);
				container["Position"] = UDim2.new(0, 0, 0.07538, 0);
				container["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				container["ScrollBarThickness"] = 0;
				container["BackgroundTransparency"] = 1;

				-- StarterGui.aamida.Window.Tab.Section.Container.UIListLayout
				local containerLayout = Instance.new("UIListLayout", container);
				containerLayout["Padding"] = UDim.new(0, 8);
				containerLayout["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.aamida.Window.Tab.Section.Container.UIPadding
				local containerPadding = Instance.new("UIPadding", container);
				containerPadding["PaddingTop"] = UDim.new(0, 6);
				containerPadding["PaddingRight"] = UDim.new(0, 6);
				containerPadding["PaddingLeft"] = UDim.new(0, 6);
				containerPadding["PaddingBottom"] = UDim.new(0, 6);

				local sectionObj = {
					Name = sectionOptions["name"],
					Frame = section,
					Container = container,
				}

				function sectionObj:CreateToggle(toggleOptions)
					toggleOptions = Library:validate({
						name = "Toggle",
						default = false,
						callback = function() end,
						colorpicker = false,	-- set true (or a Color3 default) to add the colorpicker swatch
						colorpickerCallback = function() end,
						keybind = false,		-- set true (or a key string like "e") to add the keybind button
					}, toggleOptions or {})

					-- StarterGui.aamida.Window.Tab.Section.Container.Toggle
					local toggle = Instance.new("Frame", container);
					toggle["BorderSizePixel"] = 0;
					toggle["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					toggle["Size"] = UDim2.new(1, 0, 0, 10);
					toggle["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					toggle["Name"] = [[Toggle]];
					toggle["BackgroundTransparency"] = 1;

					-- StarterGui.aamida.Window.Tab.Section.Container.Toggle.UIListLayout
					local toggleLayout = Instance.new("UIListLayout", toggle);
					toggleLayout["SortOrder"] = Enum.SortOrder.LayoutOrder;
					toggleLayout["FillDirection"] = Enum.FillDirection.Horizontal;
					toggleLayout["HorizontalFlex"] = Enum.UIFlexAlignment.SpaceBetween;	-- label left, buttons pinned right
					toggleLayout["VerticalAlignment"] = Enum.VerticalAlignment.Center;

					-- StarterGui.aamida.Window.Tab.Section.Container.Toggle.TextLabel
					local toggleLabel = Instance.new("TextLabel", toggle);
					toggleLabel["TextStrokeTransparency"] = 0;
					toggleLabel["BorderSizePixel"] = 0;
					toggleLabel["TextSize"] = 12;
					toggleLabel["TextXAlignment"] = Enum.TextXAlignment.Left;
					toggleLabel["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					toggleLabel["FontFace"] = FONT;
					toggleLabel["TextColor3"] = Color3.fromRGB(255, 255, 255);
					toggleLabel["BackgroundTransparency"] = 1;
					toggleLabel["Size"] = UDim2.new(0, 24, 0, 10);
					toggleLabel["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					toggleLabel["Text"] = toggleOptions["name"];
					toggleLabel["AutomaticSize"] = Enum.AutomaticSize.X;

					-- StarterGui.aamida.Window.Tab.Section.Container.Toggle.Buttons
					local buttons = Instance.new("Frame", toggle);
					buttons["BorderSizePixel"] = 0;
					buttons["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					buttons["Size"] = UDim2.new(0, 0, 0, 10);
					buttons["AutomaticSize"] = Enum.AutomaticSize.X;	-- shrink to fit only the buttons that exist
					buttons["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					buttons["Name"] = [[Buttons]];
					buttons["BackgroundTransparency"] = 1;

					-- StarterGui.aamida.Window.Tab.Section.Container.Toggle.Buttons.UIListLayout
					local buttonsLayout = Instance.new("UIListLayout", buttons);
					buttonsLayout["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;
					buttonsLayout["Padding"] = UDim.new(0, 4);
					buttonsLayout["SortOrder"] = Enum.SortOrder.LayoutOrder;
					buttonsLayout["FillDirection"] = Enum.FillDirection.Horizontal;

					-- StarterGui.aamida.Window.Tab.Section.Container.Toggle.Buttons.Toggle
					local indicator = Instance.new("Frame", buttons);
					indicator["BorderSizePixel"] = 0;
					indicator["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
					indicator["Size"] = UDim2.new(0, 10, 0, 10);
					indicator["Position"] = UDim2.new(0.88119, 0, 0, 0);
					indicator["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					indicator["Name"] = [[Toggle]];

					-- StarterGui.aamida.Window.Tab.Section.Container.Toggle.Buttons.Toggle.UIStroke
					local indicatorStroke = Instance.new("UIStroke", indicator);
					indicatorStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

					-- StarterGui.aamida.Window.Tab.Section.Container.Toggle.Buttons.Toggle.TextButton
					local indicatorButton = Instance.new("TextButton", indicator);
					indicatorButton["BorderSizePixel"] = 0;
					indicatorButton["TextSize"] = 14;
					indicatorButton["TextColor3"] = Color3.fromRGB(0, 0, 0);
					indicatorButton["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					indicatorButton["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					indicatorButton["BackgroundTransparency"] = 1;
					indicatorButton["Size"] = UDim2.new(1, 0, 1, 0);
					indicatorButton["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					indicatorButton["Text"] = [[]];

					-- StarterGui.aamida.Window.Tab.Section.Container.Toggle.Buttons.Toggle.UIGradient
					local indicatorGradient = Instance.new("UIGradient", indicator);
					indicatorGradient["Rotation"] = 90;
					indicatorGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

					-- StarterGui.aamida.Window.Tab.Section.Container.Toggle.Buttons.ColorPicker (optional)
					local colorPicker
					if toggleOptions["colorpicker"] then
						colorPicker = Instance.new("Frame", buttons);
						colorPicker["BorderSizePixel"] = 0;
						colorPicker["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						colorPicker["Size"] = UDim2.new(0, 10, 0, 10);
						colorPicker["Position"] = UDim2.new(0.88119, 0, 0, 0);
						colorPicker["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						colorPicker["Name"] = [[ColorPicker]];

						-- StarterGui.aamida.Window.Tab.Section.Container.Toggle.Buttons.ColorPicker.UIStroke
						local colorPickerStroke = Instance.new("UIStroke", colorPicker);
						colorPickerStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

						-- StarterGui.aamida.Window.Tab.Section.Container.Toggle.Buttons.ColorPicker.TextButton
						local colorPickerButton = Instance.new("TextButton", colorPicker);
						colorPickerButton["BorderSizePixel"] = 0;
						colorPickerButton["TextSize"] = 14;
						colorPickerButton["TextColor3"] = Color3.fromRGB(0, 0, 0);
						colorPickerButton["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						colorPickerButton["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						colorPickerButton["BackgroundTransparency"] = 1;
						colorPickerButton["Size"] = UDim2.new(1, 0, 1, 0);
						colorPickerButton["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						colorPickerButton["Text"] = [[]];

						-- HSV picker popup (built from scratch; the design only ships the swatch)
						local defaultColor = typeof(toggleOptions["colorpicker"]) == "Color3" and toggleOptions["colorpicker"] or Color3.fromRGB(255, 255, 255)
						local h, s, v = defaultColor:ToHSV()
						colorPicker.BackgroundColor3 = defaultColor

						local PICKER_TWEEN = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

						local picker = Instance.new("Frame", Tree["2"]);
						picker["BorderSizePixel"] = 0;
						picker["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
						picker["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						picker["Name"] = [[ColorPickerPopup]];
						picker["Size"] = UDim2.fromOffset(130, 0);
						picker["Visible"] = false;
						picker["ClipsDescendants"] = true;
						picker["ZIndex"] = 100;

						local pickerStroke = Instance.new("UIStroke", picker);
						pickerStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

						local pickerPadding = Instance.new("UIPadding", picker);
						pickerPadding["PaddingTop"] = UDim.new(0, 6);
						pickerPadding["PaddingBottom"] = UDim.new(0, 6);
						pickerPadding["PaddingLeft"] = UDim.new(0, 6);
						pickerPadding["PaddingRight"] = UDim.new(0, 6);

						-- saturation (x) / value (y) box
						local svBox = Instance.new("Frame", picker);
						svBox["BorderSizePixel"] = 0;
						svBox["BackgroundColor3"] = Color3.fromHSV(h, 1, 1);
						svBox["Size"] = UDim2.new(1, 0, 0, 64);
						svBox["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						svBox["Name"] = [[SV]];
						svBox["ZIndex"] = 101;

						local svStroke = Instance.new("UIStroke", svBox);
						svStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

						-- white overlay: left white -> right hue (saturation)
						local whiteOverlay = Instance.new("Frame", svBox);
						whiteOverlay["BorderSizePixel"] = 0;
						whiteOverlay["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						whiteOverlay["Size"] = UDim2.new(1, 0, 1, 0);
						whiteOverlay["ZIndex"] = 101;
						local whiteGrad = Instance.new("UIGradient", whiteOverlay);
						whiteGrad["Transparency"] = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)});

						-- black overlay: top transparent -> bottom black (value)
						local blackOverlay = Instance.new("Frame", svBox);
						blackOverlay["BorderSizePixel"] = 0;
						blackOverlay["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
						blackOverlay["Size"] = UDim2.new(1, 0, 1, 0);
						blackOverlay["ZIndex"] = 101;
						local blackGrad = Instance.new("UIGradient", blackOverlay);
						blackGrad["Rotation"] = 90;
						blackGrad["Transparency"] = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)});

						local svCursor = Instance.new("Frame", svBox);
						svCursor["BorderSizePixel"] = 1;
						svCursor["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						svCursor["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						svCursor["Size"] = UDim2.fromOffset(4, 4);
						svCursor["AnchorPoint"] = Vector2.new(0.5, 0.5);
						svCursor["ZIndex"] = 102;

						-- hue bar
						local hueBar = Instance.new("Frame", picker);
						hueBar["BorderSizePixel"] = 0;
						hueBar["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						hueBar["Size"] = UDim2.new(1, 0, 0, 10);
						hueBar["Position"] = UDim2.new(0, 0, 0, 70);
						hueBar["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						hueBar["Name"] = [[Hue]];
						hueBar["ZIndex"] = 101;

						local hueStroke = Instance.new("UIStroke", hueBar);
						hueStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

						local hueGrad = Instance.new("UIGradient", hueBar);
						hueGrad["Color"] = ColorSequence.new({
							ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
							ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
							ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
							ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
							ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
							ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
							ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0)),
						});

						local hueCursor = Instance.new("Frame", hueBar);
						hueCursor["BorderSizePixel"] = 1;
						hueCursor["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						hueCursor["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						hueCursor["Size"] = UDim2.new(0, 2, 1, 0);
						hueCursor["AnchorPoint"] = Vector2.new(0.5, 0);
						hueCursor["ZIndex"] = 102;

						local function updateColor(fire)
							local color = Color3.fromHSV(h, s, v)
							colorPicker.BackgroundColor3 = color
							svBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
							svCursor.Position = UDim2.new(s, 0, 1 - v, 0)
							hueCursor.Position = UDim2.new(h, 0, 0, 0)
							if fire then
								toggleOptions["colorpickerCallback"](color)
							end
						end

						local draggingSV, draggingHue = false, false

						local function applySV(input)
							s = math.clamp((input.Position.X - svBox.AbsolutePosition.X) / svBox.AbsoluteSize.X, 0, 1)
							v = 1 - math.clamp((input.Position.Y - svBox.AbsolutePosition.Y) / svBox.AbsoluteSize.Y, 0, 1)
							updateColor(true)
						end
						local function applyHue(input)
							h = math.clamp((input.Position.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
							updateColor(true)
						end

						svBox.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
								draggingSV = true
								applySV(input)
							end
						end)
						hueBar.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
								draggingHue = true
								applyHue(input)
							end
						end)
						userInputService.InputChanged:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
								if draggingSV then applySV(input) end
								if draggingHue then applyHue(input) end
							end
						end)
						userInputService.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
								draggingSV = false
								draggingHue = false
							end
						end)

						local pickerOpen = false

						local function openPicker()
							if pickerOpen then return end
							pickerOpen = true
							local scale = Tree["7e"].Scale
							local relX = (colorPicker.AbsolutePosition.X - Tree["2"].AbsolutePosition.X) / scale
							local relY = (colorPicker.AbsolutePosition.Y - Tree["2"].AbsolutePosition.Y) / scale
							local sw = colorPicker.AbsoluteSize.X / scale
							local sh = colorPicker.AbsoluteSize.Y / scale
							-- right-align the popup under the swatch so it doesn't run off the panel edge
							picker.Position = UDim2.fromOffset(relX + sw - 130, relY + sh + 2)
							picker.Size = UDim2.fromOffset(130, 0)
							picker.Visible = true
							tweenService:Create(picker, PICKER_TWEEN, { Size = UDim2.fromOffset(130, 92) }):Play()
						end

						local function closePicker()
							if not pickerOpen then return end
							pickerOpen = false
							local collapse = tweenService:Create(picker, PICKER_TWEEN, { Size = UDim2.fromOffset(130, 0) })
							collapse:Play()
							collapse.Completed:Connect(function()
								if not pickerOpen then picker.Visible = false end
							end)
						end

						colorPickerButton.MouseButton1Click:Connect(function()
							if pickerOpen then closePicker() else openPicker() end
						end)

						userInputService.InputBegan:Connect(function(input)
							if pickerOpen and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
								local pp, ps = picker.AbsolutePosition, picker.AbsoluteSize
								local inPicker = input.Position.X >= pp.X and input.Position.X <= pp.X + ps.X and input.Position.Y >= pp.Y and input.Position.Y <= pp.Y + ps.Y
								local cp, cs = colorPicker.AbsolutePosition, colorPicker.AbsoluteSize
								local inSwatch = input.Position.X >= cp.X and input.Position.X <= cp.X + cs.X and input.Position.Y >= cp.Y and input.Position.Y <= cp.Y + cs.Y
								if not inPicker and not inSwatch then
									closePicker()
								end
							end
						end)

						-- reflect the default without firing the callback
						updateColor(false)
					end

					-- StarterGui.aamida.Window.Tab.Section.Container.Toggle.Buttons.Keybind (optional)
					local keybind
					if toggleOptions["keybind"] then
						keybind = Instance.new("TextButton", buttons);
						keybind["TextStrokeTransparency"] = 0;
						keybind["BorderSizePixel"] = 0;
						keybind["TextSize"] = 12;
						keybind["TextColor3"] = Color3.fromRGB(255, 255, 255);
						keybind["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						keybind["FontFace"] = FONT;
						keybind["BackgroundTransparency"] = 1;
						keybind["AutomaticSize"] = Enum.AutomaticSize.X;
						keybind["Size"] = UDim2.new(0, 10, 0, 10);
						keybind["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						keybind["Text"] = type(toggleOptions["keybind"]) == "string" and ("[" .. toggleOptions["keybind"] .. "]") or "[ ]";
						keybind["Name"] = [[Keybind]];
						keybind["Position"] = UDim2.new(0.88119, 0, 0, 0);
					end

					-- on/off visuals: off is the design's 41,41,41 dark box; on lights up with the green accent (matches the slider Fill)
					local ON_COLOR = Color3.fromRGB(151, 201, 61)
					local OFF_COLOR = Color3.fromRGB(41, 41, 41)

					local toggleObj = {
						Name = toggleOptions["name"],
						Value = toggleOptions["default"] and true or false,
						Frame = toggle,
						ColorPicker = colorPicker,	-- nil unless enabled
						Keybind = keybind,			-- nil unless enabled
					}

					function toggleObj:Set(state)
						state = state and true or false
						toggleObj.Value = state
						tweenService:Create(indicator, BUTTON_TWEEN, {
							BackgroundColor3 = state and ON_COLOR or OFF_COLOR,
						}):Play()
						toggleOptions["callback"](state)
					end

					indicatorButton.MouseButton1Click:Connect(function()
						toggleObj:Set(not toggleObj.Value)
					end)

					-- reflect the default without firing the callback
					indicator.BackgroundColor3 = toggleObj.Value and ON_COLOR or OFF_COLOR

					-- keybind: click to rebind, press the key to flip the toggle
					if keybind then
						local boundKey = nil
						if type(toggleOptions["keybind"]) == "string" then
							local ok, code = pcall(function() return Enum.KeyCode[string.upper(toggleOptions["keybind"])] end)
							if ok then boundKey = code end
						end

						local listening = false

						local function render()
							if listening then
								keybind.Text = "[...]"
							elseif boundKey then
								keybind.Text = "[" .. boundKey.Name .. "]"
							else
								keybind.Text = "[ ]"
							end
						end
						render()

						keybind.MouseButton1Click:Connect(function()
							listening = true
							render()
						end)

						userInputService.InputBegan:Connect(function(input, gameProcessed)
							if listening then
								if input.UserInputType == Enum.UserInputType.Keyboard then
									-- Escape / Backspace clears the bind
									if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace then
										boundKey = nil
									else
										boundKey = input.KeyCode
									end
									listening = false
									render()
								end
								return
							end

							if gameProcessed then return end	-- ignore keys typed into textboxes etc.
							if boundKey and input.KeyCode == boundKey then
								toggleObj:Set(not toggleObj.Value)
							end
						end)

						toggleObj.Keybind = keybind
					end

					return toggleObj
				end

				function sectionObj:CreateSlider(sliderOptions)
					sliderOptions = Library:validate({
						name = "Slider",
						min = 0,
						max = 100,
						default = 50,
						decimals = 0,	-- 0 = integers, 1 = one decimal place, etc.
						callback = function() end,
					}, sliderOptions or {})

					local min = sliderOptions["min"]
					local max = sliderOptions["max"]
					local decimals = sliderOptions["decimals"]

					-- StarterGui.aamida.Window.Tab.Section.Container.Slider
					local slider = Instance.new("Frame", container);
					slider["BorderSizePixel"] = 0;
					slider["BackgroundColor3"] = Color3.fromRGB(81, 81, 81);
					slider["Size"] = UDim2.new(1, 0, 0, 25);
					slider["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					slider["Name"] = [[Slider]];
					slider["BackgroundTransparency"] = 1;

					-- StarterGui.aamida.Window.Tab.Section.Container.Slider.Bar
					local bar = Instance.new("Frame", slider);
					bar["BorderSizePixel"] = 0;
					bar["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
					bar["Size"] = UDim2.new(1, 0, 0, 10);
					bar["Position"] = UDim2.new(0, 0, 0.54545, 0);
					bar["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					bar["Name"] = [[Bar]];

					-- StarterGui.aamida.Window.Tab.Section.Container.Slider.Bar.Fill
					local fill = Instance.new("Frame", bar);
					fill["BorderSizePixel"] = 0;
					fill["BackgroundColor3"] = Color3.fromRGB(151, 201, 61);
					fill["Size"] = UDim2.new(0.5, 0, 1, 0);
					fill["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					fill["Name"] = [[Fill]];

					-- StarterGui.aamida.Window.Tab.Section.Container.Slider.Bar.Fill.UIStroke
					local fillStroke = Instance.new("UIStroke", fill);
					fillStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

					-- StarterGui.aamida.Window.Tab.Section.Container.Slider.Bar.Fill.UIGradient
					local fillGradient = Instance.new("UIGradient", fill);
					fillGradient["Rotation"] = 90;
					fillGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

					-- StarterGui.aamida.Window.Tab.Section.Container.Slider.Bar.UIStroke
					local barStroke = Instance.new("UIStroke", bar);
					barStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

					-- StarterGui.aamida.Window.Tab.Section.Container.Slider.Title
					local title = Instance.new("TextLabel", slider);
					title["TextStrokeTransparency"] = 0;
					title["BorderSizePixel"] = 0;
					title["TextSize"] = 12;
					title["TextXAlignment"] = Enum.TextXAlignment.Left;
					title["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					title["FontFace"] = FONT;
					title["TextColor3"] = Color3.fromRGB(255, 255, 255);
					title["BackgroundTransparency"] = 1;
					title["Size"] = UDim2.new(0, 24, 0, 10);
					title["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					title["Text"] = sliderOptions["name"];
					title["AutomaticSize"] = Enum.AutomaticSize.X;
					title["Name"] = [[Title]];

					-- StarterGui.aamida.Window.Tab.Section.Container.Slider.Amount
					local amount = Instance.new("TextLabel", slider);
					amount["TextStrokeTransparency"] = 0;
					amount["BorderSizePixel"] = 0;
					amount["TextSize"] = 12;
					amount["TextXAlignment"] = Enum.TextXAlignment.Right;
					amount["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					amount["FontFace"] = FONT;
					amount["TextColor3"] = Color3.fromRGB(255, 255, 255);
					amount["BackgroundTransparency"] = 1;
					amount["Size"] = UDim2.new(0, 43, 0, 10);
					amount["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					amount["Text"] = [[50]];
					amount["Name"] = [[Amount]];
					amount["Position"] = UDim2.new(0.69444, 0, 0, 0);

					local FILL_TWEEN = TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
					local FILL_COLOR = Color3.fromRGB(151, 201, 61)			-- resting green
					local FILL_ACTIVE = Color3.fromRGB(181, 231, 91)		-- brighter while grabbed

					-- round to the configured number of decimals
					local function round(value)
						local mult = 10 ^ decimals
						return math.floor(math.clamp(value, min, max) * mult + 0.5) / mult
					end

					local sliderObj = {
						Name = sliderOptions["name"],
						Value = round(sliderOptions["default"]),
						Frame = slider,
					}

					-- instant = true skips the fill tween (used while dragging for 1:1 response)
					function sliderObj:Set(value, instant)
						value = round(value)
						sliderObj.Value = value
						local alpha = (max > min) and (value - min) / (max - min) or 0
						local goal = UDim2.new(alpha, 0, 1, 0)
						if instant then
							fill.Size = goal
						else
							tweenService:Create(fill, FILL_TWEEN, { Size = goal }):Play()
						end
						amount.Text = tostring(value)
						sliderOptions["callback"](value)
					end

					-- dragging
					local dragging = false

					-- no instant flag here: let the fill tween so it smoothly chases the cursor
					local function updateFromInput(input)
						local alpha = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
						sliderObj:Set(min + (max - min) * alpha)
					end

					bar.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							dragging = true
							tweenService:Create(fill, FILL_TWEEN, { BackgroundColor3 = FILL_ACTIVE }):Play()
							updateFromInput(input)
						end
					end)

					userInputService.InputChanged:Connect(function(input)
						if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
							updateFromInput(input)
						end
					end)

					userInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							if dragging then
								tweenService:Create(fill, FILL_TWEEN, { BackgroundColor3 = FILL_COLOR }):Play()
							end
							dragging = false
						end
					end)

					-- reflect the default without firing the callback
					local alpha = (max > min) and (sliderObj.Value - min) / (max - min) or 0
					fill.Size = UDim2.new(alpha, 0, 1, 0)
					amount.Text = tostring(sliderObj.Value)

					return sliderObj
				end

				function sectionObj:CreateButton(buttonOptions)
					buttonOptions = Library:validate({
						name = "Button",
						callback = function() end,
					}, buttonOptions or {})

					-- StarterGui.aamida.Window.Tab.Section.Container.Button
					local button = Instance.new("Frame", container);
					button["BorderSizePixel"] = 0;
					button["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
					button["Size"] = UDim2.new(1, 0, 0, 10);
					button["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					button["Name"] = [[Button]];

					-- StarterGui.aamida.Window.Tab.Section.Container.Button.UIStroke
					local buttonStroke = Instance.new("UIStroke", button);
					buttonStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

					-- StarterGui.aamida.Window.Tab.Section.Container.Button.TextButton
					local textButton = Instance.new("TextButton", button);
					textButton["TextStrokeTransparency"] = 0;
					textButton["BorderSizePixel"] = 0;
					textButton["TextSize"] = 12;
					textButton["TextColor3"] = Color3.fromRGB(255, 255, 255);
					textButton["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					textButton["FontFace"] = FONT;
					textButton["BackgroundTransparency"] = 1;
					textButton["Size"] = UDim2.new(1, 0, 1, 0);
					textButton["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					textButton["Text"] = buttonOptions["name"];

					-- StarterGui.aamida.Window.Tab.Section.Container.Button.UIGradient
					local buttonGradient = Instance.new("UIGradient", button);
					buttonGradient["Rotation"] = 90;
					buttonGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

					-- press feedback: brighten on hold, settle back on release/leave
					local IDLE_COLOR = Color3.fromRGB(41, 41, 41)
					local PRESS_COLOR = Color3.fromRGB(61, 61, 61)

					textButton.MouseButton1Down:Connect(function()
						tweenService:Create(button, BUTTON_TWEEN, { BackgroundColor3 = PRESS_COLOR }):Play()
					end)
					textButton.MouseButton1Up:Connect(function()
						tweenService:Create(button, BUTTON_TWEEN, { BackgroundColor3 = IDLE_COLOR }):Play()
					end)
					textButton.MouseLeave:Connect(function()
						tweenService:Create(button, BUTTON_TWEEN, { BackgroundColor3 = IDLE_COLOR }):Play()
					end)

					textButton.MouseButton1Click:Connect(function()
						buttonOptions["callback"]()
					end)

					local buttonObj = {
						Name = buttonOptions["name"],
						Frame = button,
					}

					return buttonObj
				end

				function sectionObj:CreateDropdown(dropdownOptions)
					dropdownOptions = Library:validate({
						name = "Dropdown",
						options = {},
						default = nil,
						callback = function() end,
					}, dropdownOptions or {})

					-- StarterGui.aamida.Window.Tab.Section.Container.Dropdown
					local dropdown = Instance.new("Frame", container);
					dropdown["BorderSizePixel"] = 0;
					dropdown["BackgroundColor3"] = Color3.fromRGB(81, 81, 81);
					dropdown["Size"] = UDim2.new(1, 0, 0, 25);
					dropdown["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					dropdown["Name"] = [[Dropdown]];
					dropdown["BackgroundTransparency"] = 1;

					-- StarterGui.aamida.Window.Tab.Section.Container.Dropdown.Select
					local selectFrame = Instance.new("Frame", dropdown);
					selectFrame["BorderSizePixel"] = 0;
					selectFrame["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
					selectFrame["Size"] = UDim2.new(1, 0, 0, 10);
					selectFrame["Position"] = UDim2.new(0, 0, 0.54545, 0);
					selectFrame["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					selectFrame["Name"] = [[Select]];

					-- StarterGui.aamida.Window.Tab.Section.Container.Dropdown.Select.UIStroke
					local selectStroke = Instance.new("UIStroke", selectFrame);
					selectStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

					-- StarterGui.aamida.Window.Tab.Section.Container.Dropdown.Select.TextButton
					local selectButton = Instance.new("TextButton", selectFrame);
					selectButton["TextStrokeTransparency"] = 0;
					selectButton["BorderSizePixel"] = 0;
					selectButton["TextSize"] = 12;
					selectButton["TextColor3"] = Color3.fromRGB(255, 255, 255);
					selectButton["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					selectButton["FontFace"] = FONT;
					selectButton["BackgroundTransparency"] = 1;
					selectButton["Size"] = UDim2.new(1, 0, 1, 0);
					selectButton["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					selectButton["Text"] = [[option]];

					-- StarterGui.aamida.Window.Tab.Section.Container.Dropdown.Select.UIGradient
					local selectGradient = Instance.new("UIGradient", selectFrame);
					selectGradient["Rotation"] = 90;
					selectGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

					-- StarterGui.aamida.Window.Tab.Section.Container.Dropdown.Title
					local title = Instance.new("TextLabel", dropdown);
					title["TextStrokeTransparency"] = 0;
					title["BorderSizePixel"] = 0;
					title["TextSize"] = 12;
					title["TextXAlignment"] = Enum.TextXAlignment.Left;
					title["TextYAlignment"] = Enum.TextYAlignment.Bottom;
					title["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					title["FontFace"] = FONT;
					title["TextColor3"] = Color3.fromRGB(255, 255, 255);
					title["BackgroundTransparency"] = 1;
					title["Size"] = UDim2.new(0, 24, 0, 10);
					title["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					title["Text"] = dropdownOptions["name"];
					title["AutomaticSize"] = Enum.AutomaticSize.X;
					title["Name"] = [[Title]];

					-- StarterGui.aamida.Window.Tab.Section.Container.Dropdown.UIGradient
					local dropdownGradient = Instance.new("UIGradient", dropdown);
					dropdownGradient["Rotation"] = 90;
					dropdownGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(168, 168, 168))};

					-- option popup: built from scratch (the design only ships the closed Select)
					local OPTION_HEIGHT = 16
					local POPUP_TWEEN = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

					local popup = Instance.new("Frame", Tree["2"]);
					popup["BorderSizePixel"] = 0;
					popup["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
					popup["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					popup["Name"] = [[DropdownPopup]];
					popup["ClipsDescendants"] = true;
					popup["Visible"] = false;
					popup["ZIndex"] = 100;

					local popupStroke = Instance.new("UIStroke", popup);
					popupStroke["LineJoinMode"] = Enum.LineJoinMode.Miter;

					local popupLayout = Instance.new("UIListLayout", popup);
					popupLayout["SortOrder"] = Enum.SortOrder.LayoutOrder;

					local dropdownObj = {
						Name = dropdownOptions["name"],
						Value = nil,
						Frame = dropdown,
					}

					local isOpen = false

					local function isInside(gui, pos)
						local p, s = gui.AbsolutePosition, gui.AbsoluteSize
						return pos.X >= p.X and pos.X <= p.X + s.X and pos.Y >= p.Y and pos.Y <= p.Y + s.Y
					end

					local function selectOption(option)
						dropdownObj.Value = option
						selectButton.Text = tostring(option)
						dropdownOptions["callback"](option)
					end

					local function open()
						if isOpen then return end
						isOpen = true
						-- place the popup just under the Select, in the Window's local (unscaled) space
						local scale = Tree["7e"].Scale
						local relX = (selectFrame.AbsolutePosition.X - Tree["2"].AbsolutePosition.X) / scale
						local relY = (selectFrame.AbsolutePosition.Y - Tree["2"].AbsolutePosition.Y) / scale
						local w = selectFrame.AbsoluteSize.X / scale
						local h = selectFrame.AbsoluteSize.Y / scale
						popup.Position = UDim2.fromOffset(relX, relY + h + 2)
						popup.Size = UDim2.fromOffset(w, 0)
						popup.Visible = true
						tweenService:Create(popup, POPUP_TWEEN, { Size = UDim2.fromOffset(w, OPTION_HEIGHT * #dropdownOptions["options"]) }):Play()
					end

					local function close()
						if not isOpen then return end
						isOpen = false
						local collapse = tweenService:Create(popup, POPUP_TWEEN, { Size = UDim2.fromOffset(popup.AbsoluteSize.X / Tree["7e"].Scale, 0) })
						collapse:Play()
						collapse.Completed:Connect(function()
							if not isOpen then popup.Visible = false end
						end)
					end

					-- build the option rows
					for i, option in ipairs(dropdownOptions["options"]) do
						local optionButton = Instance.new("TextButton", popup);
						optionButton["BorderSizePixel"] = 0;
						optionButton["TextSize"] = 12;
						optionButton["TextColor3"] = Color3.fromRGB(255, 255, 255);
						optionButton["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
						optionButton["FontFace"] = FONT;
						optionButton["Size"] = UDim2.new(1, 0, 0, OPTION_HEIGHT);
						optionButton["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						optionButton["Text"] = tostring(option);
						optionButton["LayoutOrder"] = i;
						optionButton["ZIndex"] = 101;
						optionButton["AutoButtonColor"] = false;

						optionButton.MouseEnter:Connect(function()
							tweenService:Create(optionButton, BUTTON_TWEEN, { BackgroundColor3 = Color3.fromRGB(61, 61, 61) }):Play()
						end)
						optionButton.MouseLeave:Connect(function()
							tweenService:Create(optionButton, BUTTON_TWEEN, { BackgroundColor3 = Color3.fromRGB(41, 41, 41) }):Play()
						end)
						optionButton.MouseButton1Click:Connect(function()
							selectOption(option)
							close()
						end)
					end

					selectButton.MouseButton1Click:Connect(function()
						if isOpen then close() else open() end
					end)

					-- click anywhere outside the popup/select closes it
					userInputService.InputBegan:Connect(function(input)
						if isOpen and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
							if not isInside(popup, input.Position) and not isInside(selectFrame, input.Position) then
								close()
							end
						end
					end)

					function dropdownObj:Set(option)
						selectOption(option)
					end

					-- initial selection (defaults to first option), applied without firing the callback
					local default = dropdownOptions["default"]
					if default == nil and #dropdownOptions["options"] > 0 then
						default = dropdownOptions["options"][1]
					end
					if default ~= nil then
						dropdownObj.Value = default
						selectButton.Text = tostring(default)
					end

					return dropdownObj
				end

				function sectionObj:CreateKeybind(keybindOptions)
					keybindOptions = Library:validate({
						name = "Keybind",
						default = false,	-- a key string like "e", or false for unbound
						callback = function() end,
					}, keybindOptions or {})

					-- row (same label-left / control-right layout as the Toggle)
					local row = Instance.new("Frame", container);
					row["BorderSizePixel"] = 0;
					row["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					row["Size"] = UDim2.new(1, 0, 0, 10);
					row["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					row["Name"] = [[Keybind]];
					row["BackgroundTransparency"] = 1;

					local rowLayout = Instance.new("UIListLayout", row);
					rowLayout["SortOrder"] = Enum.SortOrder.LayoutOrder;
					rowLayout["FillDirection"] = Enum.FillDirection.Horizontal;
					rowLayout["HorizontalFlex"] = Enum.UIFlexAlignment.SpaceBetween;
					rowLayout["VerticalAlignment"] = Enum.VerticalAlignment.Center;

					local label = Instance.new("TextLabel", row);
					label["TextStrokeTransparency"] = 0;
					label["BorderSizePixel"] = 0;
					label["TextSize"] = 12;
					label["TextXAlignment"] = Enum.TextXAlignment.Left;
					label["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					label["FontFace"] = FONT;
					label["TextColor3"] = Color3.fromRGB(255, 255, 255);
					label["BackgroundTransparency"] = 1;
					label["Size"] = UDim2.new(0, 24, 0, 10);
					label["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					label["Text"] = keybindOptions["name"];
					label["AutomaticSize"] = Enum.AutomaticSize.X;

					local button = Instance.new("TextButton", row);
					button["TextStrokeTransparency"] = 0;
					button["BorderSizePixel"] = 0;
					button["TextSize"] = 12;
					button["TextColor3"] = Color3.fromRGB(255, 255, 255);
					button["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					button["FontFace"] = FONT;
					button["BackgroundTransparency"] = 1;
					button["AutomaticSize"] = Enum.AutomaticSize.X;
					button["Size"] = UDim2.new(0, 10, 0, 10);
					button["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					button["Text"] = "[ ]";
					button["Name"] = [[Keybind]];

					local keybindObj = {
						Name = keybindOptions["name"],
						Value = nil,
						Frame = row,
						Button = button,
					}

					local boundKey = nil
					if type(keybindOptions["default"]) == "string" then
						local ok, code = pcall(function() return Enum.KeyCode[string.upper(keybindOptions["default"])] end)
						if ok then boundKey = code end
					end

					local listening = false
					local function render()
						if listening then
							button.Text = "[...]"
						elseif boundKey then
							button.Text = "[" .. boundKey.Name .. "]"
						else
							button.Text = "[ ]"
						end
						keybindObj.Value = boundKey
					end
					render()

					button.MouseButton1Click:Connect(function()
						listening = true
						render()
					end)

					userInputService.InputBegan:Connect(function(input, gameProcessed)
						if listening then
							if input.UserInputType == Enum.UserInputType.Keyboard then
								-- Escape / Backspace clears the bind
								if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace then
									boundKey = nil
								else
									boundKey = input.KeyCode
								end
								listening = false
								render()
							end
							return
						end

						if gameProcessed then return end
						if boundKey and input.KeyCode == boundKey then
							keybindOptions["callback"]()
						end
					end)

					return keybindObj
				end

				table.insert(subtab.Sections, sectionObj)

				return sectionObj
			end

			table.insert(tab.SubTabs, subtab)

			subButtonText.MouseButton1Click:Connect(function()
				tab:SelectSubTab(subtab)
			end)

			-- first sub-tab created becomes the active one
			if #tab.SubTabs == 1 then
				tab:SelectSubTab(subtab)
			end

			return subtab
		end

		table.insert(Tree.Tabs, tab)

		buttonText.MouseButton1Click:Connect(function()
			Tree:SelectTab(tab)
		end)

		-- first tab created becomes the active one
		if #Tree.Tabs == 1 then
			Tree:SelectTab(tab)
		end

		return tab
	end

	return Tree
	
end

return Library
