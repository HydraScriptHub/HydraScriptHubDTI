local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))();
local player = game.Players.LocalPlayer;
local character = player.Character or player.CharacterAdded:Wait();
local humanoidRootPart = character:WaitForChild("HumanoidRootPart");
local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid");
local collectibleMoney = workspace:WaitForChild("CollectibleMoney");
local isFarmingEnabled = false;
local idlePosition = Vector3.new(77, 14, 92);
local farmingSpeed = 0.3;
local TPtargetUsername = "";
local rgbRunning = false;
local rainbowRunning = false;
local spamFacesRunning = false;
local originalAnimations = {walk=nil,idle1=nil,idle2=nil,run=nil,fall=nil};
local originalSpeed = nil;
local codes = {"1CON1CF4TMA","B3APL4YS_D0L1E","MEGANPLAYSBOOTS","CH00P1E_1S_B4CK","S3M_0W3N_Y4Y","UMOYAE","KREEK","FASHION","LANA","LANABOW","BELALASLAY","LANATUTU","IBELLASLAY","M3RM4ID","TEKKYOOZ","M0T0PRINCESSWAV","LABOOTS","ITSJUSTNICHOLAS","ASHLEYBUNNI","LEAHASHE","KITTYUUHH","C4LLMEHH4LEY","SUBM15CY","D1ORST4R"};
local Window = Rayfield:CreateWindow({Name="DThub",Icon=0,LoadingTitle="Loading DThub",LoadingSubtitle="V 3.1",Theme="Default",DisableRayfieldPrompts=false,DisableBuildWarnings=false,ConfigurationSaving={Enabled=false,FolderName="DThub",FileName="DThub"},Discord={Enabled=false,Invite="noinvitelink",RememberJoins=true},KeySystem=false,KeySettings={Title="Untitled",Subtitle="Key System",Note="No method of obtaining the key is provided",FileName="Key",SaveKey=true,GrabKeyFromSite=false,Key={"Hello"}}});
local FarmTab = Window:CreateTab("Farming", "dollar-sign");
local TeleportTab = Window:CreateTab("Teleportation", "person-standing");
local TrollingTab = Window:CreateTab("Trolling", "venetian-mask");
local AnimationsTab = Window:CreateTab("Animations", "smile");
local MiscTab = Window:CreateTab("Misc", "badge-plus");
local FarmSection = FarmTab:CreateSection("Farm Controls");
local CashFarmSpeedSlider = FarmTab:CreateSlider({Name="Cash Farming Speed",Range={0.1,1},Increment=0.1,Suffix="",CurrentValue=0.3,Callback=function(Value)
	farmingSpeed = Value;
end});
local FarmCashToggle = FarmTab:CreateToggle({Name="Farm Cash",CurrentValue=false,Callback=function(Value)
	isFarmingEnabled = Value;
	if isFarmingEnabled then
		task.spawn(function()
			local platform;
			local function createPlatform()
				if (platform and platform.Parent) then
					platform:Destroy();
				end
				platform = Instance.new("Part");
				platform.Size = Vector3.new(10, 1, 10);
				platform.Anchored = true;
				platform.CanCollide = true;
				platform.Transparency = 1;
				platform.Parent = workspace;
			end
			local function positionPlatform()
				if (platform and humanoidRootPart) then
					platform.CFrame = humanoidRootPart.CFrame - Vector3.new(0, humanoidRootPart.Size.Y + 1, 0);
				end
			end
			local function onCharacterAdded(newCharacter)
				character = newCharacter;
				humanoidRootPart = character:WaitForChild("HumanoidRootPart");
				if isFarmingEnabled then
					createPlatform();
				end
			end
			player.CharacterAdded:Connect(onCharacterAdded);
			createPlatform();
			while isFarmingEnabled do
				local foundPart = false;
				for i = 1, 78 do
					if not isFarmingEnabled then
						break;
					end
					local targetPart = collectibleMoney:FindFirstChild("Money" .. i);
					if (targetPart and targetPart:IsA("BasePart")) then
						local decalBack = targetPart:FindFirstChild("DecalBack");
						local decalFront = targetPart:FindFirstChild("DecalFront");
						if (decalBack and decalFront and (decalBack.Transparency == 0) and (decalFront.Transparency == 0)) then
							humanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 1, 0);
							positionPlatform();
							foundPart = true;
							task.wait(farmingSpeed);
							break;
						end
					end
				end
				if not foundPart then
					humanoidRootPart.CFrame = CFrame.new(idlePosition);
					positionPlatform();
					task.wait(0.1);
				end
			end
			if platform then
				platform:Destroy();
			end
		end);
	end
end});
local TeleportLocationsSection = TeleportTab:CreateSection("Predefined Locations");
local LobbyTPButton = TeleportTab:CreateButton({Name="Teleport to Lobby",Callback=function()
	humanoidRootPart.CFrame = CFrame.new(-489, 15, -559);
end});
local RoomTPButton = TeleportTab:CreateButton({Name="Teleport to Dressing Room",Callback=function()
	humanoidRootPart.CFrame = CFrame.new(-277, -2, 22);
end});
local VIPTPButton = TeleportTab:CreateButton({Name="Teleport to VIP Room",Callback=function()
	humanoidRootPart.CFrame = CFrame.new(-213, -2, 14);
end});
local RunwayTPButton = TeleportTab:CreateButton({Name="Teleport to Runway",Callback=function()
	humanoidRootPart.CFrame = CFrame.new(-71, 16, -327);
end});
local PlayerTeleportSection = TeleportTab:CreateSection("Player Teleport");
local PlayerUsernameTPInput = TeleportTab:CreateInput({Name="Player Username",CurrentValue="",PlaceholderText="Enter Player Username",Callback=function(Text)
	TPtargetUsername = Text;
end});
local PlayerTPButton = TeleportTab:CreateButton({Name="Teleport to Player",Callback=function()
	if (TPtargetUsername == "") then
		return warn("No username entered.");
	end
	local matchedPlayer;
	for _, plr in ipairs(game.Players:GetPlayers()) do
		if (plr.Name:lower():sub(1, #TPtargetUsername) == TPtargetUsername:lower()) then
			if matchedPlayer then
				return warn("Multiple players match. Be more specific.");
			end
			matchedPlayer = plr;
		end
	end
	if (matchedPlayer and matchedPlayer.Character and matchedPlayer.Character:FindFirstChild("HumanoidRootPart")) then
		humanoidRootPart.CFrame = matchedPlayer.Character.HumanoidRootPart.CFrame;
	else
		warn("No valid player found or player has no HumanoidRootPart.");
	end
end});
local SkinTrollingSection = TrollingTab:CreateSection("Skin Trolling");
local RGBSkinToggle = TrollingTab:CreateToggle({Name="RGB Skin (Flicker)",CurrentValue=false,Callback=function(Value)
	rgbRunning = Value;
	if rgbRunning then
		task.spawn(function()
			local replicatedStorage = game:GetService("ReplicatedStorage");
			local changeSkinEvent = replicatedStorage["Dress Up"].RemoteEvent;
			while rgbRunning do
				changeSkinEvent:FireServer("Change Skintone", Color3.new(math.random(), math.random(), math.random()));
				task.wait(0.05);
			end
		end);
	end
end});
local RainbowSkinToggle = TrollingTab:CreateToggle({Name="Rainbow Skin (Smooth)",CurrentValue=false,Callback=function(Value)
	rainbowRunning = Value;
	if rainbowRunning then
		task.spawn(function()
			local replicatedStorage = game:GetService("ReplicatedStorage");
			local changeSkinEvent = replicatedStorage["Dress Up"].RemoteEvent;
			while rainbowRunning do
				local t = tick();
				local rainbowColor = Color3.new(math.abs(math.sin(t)), math.abs(math.sin(t + ((2 * math.pi) / 3))), math.abs(math.sin(t + ((4 * math.pi) / 3))));
				changeSkinEvent:FireServer("Change Skintone", rainbowColor);
				task.wait(0.1);
			end
		end);
	end
end});
local AnimationTrollingSection = TrollingTab:CreateSection("Animation Trolling");
local function setPlayerSpeed(multiplier)
	local localHumanoid = player.Character:FindFirstChildOfClass("Humanoid");
	if localHumanoid then
		if not originalSpeed then
			originalSpeed = localHumanoid.WalkSpeed;
		end
		localHumanoid.WalkSpeed = originalSpeed * multiplier;
	end
end
local ZombieAnimationsToggle = TrollingTab:CreateToggle({Name="Zombie Animations",CurrentValue=false,Callback=function(Value)
	local animateScript = player.Character:WaitForChild("Animate");
	if Value then
		originalAnimations.walk = animateScript.walk.WalkAnim.AnimationId;
		originalAnimations.idle1 = animateScript.idle.Animation1.AnimationId;
		originalAnimations.idle2 = animateScript.idle.Animation2.AnimationId;
		originalAnimations.run = animateScript.run.RunAnim.AnimationId;
		originalAnimations.fall = animateScript.fall.FallAnim.AnimationId;
		animateScript.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=3489174223";
		animateScript.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=3489171152";
		animateScript.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=3489171152";
		animateScript.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=3489173414";
		animateScript.fall.FallAnim.AnimationId = originalAnimations.fall;
		setPlayerSpeed(1.5);
	else
		animateScript.walk.WalkAnim.AnimationId = originalAnimations.walk;
		animateScript.idle.Animation1.AnimationId = originalAnimations.idle1;
		animateScript.idle.Animation2.AnimationId = originalAnimations.idle2;
		animateScript.run.RunAnim.AnimationId = originalAnimations.run;
		animateScript.fall.FallAnim.AnimationId = originalAnimations.fall;
		setPlayerSpeed(1);
	end
end});
local LanaAnimationsToggle = TrollingTab:CreateToggle({Name="Lana Animations",CurrentValue=false,Callback=function(Value)
	local animateScript = player.Character:WaitForChild("Animate");
	if Value then
		originalAnimations.walk = animateScript.walk.WalkAnim.AnimationId;
		originalAnimations.run = animateScript.run.RunAnim.AnimationId;
		originalAnimations.fall = animateScript.fall.FallAnim.AnimationId;
		animateScript.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=656121766";
		animateScript.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852";
		animateScript.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476";
		setPlayerSpeed(1.5);
	else
		animateScript.walk.WalkAnim.AnimationId = originalAnimations.walk;
		animateScript.run.RunAnim.AnimationId = originalAnimations.run;
		animateScript.fall.FallAnim.AnimationId = originalAnimations.fall;
		setPlayerSpeed(1);
	end
end});
local FaceTrollingSection = TrollingTab:CreateSection("Face Trolling");
local SpamRandomFacesToggle = TrollingTab:CreateToggle({Name="Spam Random Faces",CurrentValue=false,Callback=function(Value)
	spamFacesRunning = Value;
	if spamFacesRunning then
		task.spawn(function()
			local replicatedStorage = game:GetService("ReplicatedStorage");
			local dressUpEvent = replicatedStorage["Dress Up"].RemoteEvent;
			while spamFacesRunning do
				local randomFaceNumber = math.random(1, 103);
				local faceStyle = "Classic Makeup";
				local faceColor = "Light";
				dressUpEvent:FireServer(faceStyle, randomFaceNumber, faceColor);
				task.wait(0.5);
			end
		end);
	end
end});
local function playAnimation(animationId)
	local localHumanoid = player.Character:FindFirstChildOfClass("Humanoid");
	if localHumanoid then
		local animation = Instance.new("Animation");
		animation.AnimationId = animationId;
		local success, animationTrack = pcall(function()
			return localHumanoid:LoadAnimation(animation);
		end);
		if (success and animationTrack) then
			animationTrack:Play();
			task.spawn(function()
				while animationTrack.IsPlaying do
					local moveDirection = localHumanoid.MoveDirection;
					if (moveDirection.Magnitude > 0) then
						animationTrack:Stop();
						break;
					end
					task.wait(0.1);
				end
			end);
		else
			warn("Failed to load or play animation with ID:", animationId);
		end
	else
		warn("Humanoid not found in character!");
	end
end
local BlackPinkSection = AnimationsTab:CreateSection("BLACKPINK Animations");
local PlayAnimationButton1 = AnimationsTab:CreateButton({Name="BLACKPINK - Lovesick Girls",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=16874472321");
end});
local PlayAnimationButton2 = AnimationsTab:CreateButton({Name="BLACKPINK Boombayah Emote",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=16553164850");
end});
local PlayAnimationButton3 = AnimationsTab:CreateButton({Name="BLACKPINK DDU-DU DDU-DU",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=16553170471");
end});
local PlayAnimationButton4 = AnimationsTab:CreateButton({Name="BLACKPINK Ice Cream",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=16181797368");
end});
local PlayAnimationButton5 = AnimationsTab:CreateButton({Name="BLACKPINK JENNIE You and Me",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=15439356296");
end});
local PlayAnimationButton6 = AnimationsTab:CreateButton({Name="BLACKPINK JISOO Flower",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=15439354020");
end});
local PlayAnimationButton7 = AnimationsTab:CreateButton({Name="BLACKPINK LISA Money",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=15679623052");
end});
local PlayAnimationButton8 = AnimationsTab:CreateButton({Name="BLACKPINK Pink Venom - Get em Get em Get em",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=14548619594");
end});
local PlayAnimationButton9 = AnimationsTab:CreateButton({Name="BLACKPINK Pink Venom - I Bring the Pain Like???",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=14548620495");
end});
local PlayAnimationButton10 = AnimationsTab:CreateButton({Name="BLACKPINK Pink Venom - Straight to Ya Dome",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=14548621256");
end});
local PlayAnimationButton11 = AnimationsTab:CreateButton({Name="BLACKPINK ROS?? On The Ground",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=15679624464");
end});
local PlayAnimationButton12 = AnimationsTab:CreateButton({Name="BLACKPINK Shut Down - Part 1",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=14901306096");
end});
local PlayAnimationButton13 = AnimationsTab:CreateButton({Name="BLACKPINK Shut Down - Part 2",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=14901308987");
end});
local BurberrySection = AnimationsTab:CreateSection("BURBERRY LOLA ATTITUDE");
local PlayAnimationButton14 = AnimationsTab:CreateButton({Name="BURBERRY LOLA ATTITUDE - NIMBUS",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=10147821284");
end});
local BabyQueenSection = AnimationsTab:CreateSection("Baby Queen Animations");
local PlayAnimationButton15 = AnimationsTab:CreateButton({Name="Baby Queen - Dramatic Bow",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=14352337694");
end});
local CucoSection = AnimationsTab:CreateSection("Cuco Animations");
local PlayAnimationButton16 = AnimationsTab:CreateButton({Name="Cuco - Levitate",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=15698404340");
end});
local ZaraSection = AnimationsTab:CreateSection("Zara Larsson Animations");
local PlayAnimationButton17 = AnimationsTab:CreateButton({Name="It Ain't My Fault - Zara Larsson",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=10714374267");
end});
local NickiSection = AnimationsTab:CreateSection("Nicki Minaj Animations");
local PlayAnimationButton18 = AnimationsTab:CreateButton({Name="Nicki Minaj Anaconda",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=15571450952");
end});
local PlayAnimationButton19 = AnimationsTab:CreateButton({Name="Nicki Minaj Boom Boom Boom",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=15571448688");
end});
local PlayAnimationButton20 = AnimationsTab:CreateButton({Name="Nicki Minaj Starships",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=15571453761");
end});
local PlayAnimationButton21 = AnimationsTab:CreateButton({Name="Nicki Minaj That's That Super Bass Emote",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=15571446961");
end});
local ParisSection = AnimationsTab:CreateSection("Paris Hilton Animations");
local PlayAnimationButton22 = AnimationsTab:CreateButton({Name="Paris Hilton - Checking My Angles",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=15392752812");
end});
local TwiceSection = AnimationsTab:CreateSection("TWICE Animations");
local PlayAnimationButton23 = AnimationsTab:CreateButton({Name="TWICE Feel Special",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=14899980745");
end});
local PlayAnimationButton24 = AnimationsTab:CreateButton({Name="TWICE LIKEY",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=14899979575");
end});
local PlayAnimationButton25 = AnimationsTab:CreateButton({Name="TWICE The Feels",Callback=function()
	playAnimation("http://www.roblox.com/asset/?id=12874447851");
end});
local CodesSection = MiscTab:CreateSection("Code Redemption");
local ClaimAllCodesButton = MiscTab:CreateButton({Name="Claim All Codes",Callback=function()
	local replicatedStorage = game:GetService("ReplicatedStorage");
	local claimEvent = replicatedStorage.Remotes.Codes.Claim;
	for _, code in ipairs(codes) do
		claimEvent:FireServer(code);
		task.wait(0.1);
	end
	print("All codes claimed!");
end});
local CharacterSection = MiscTab:CreateSection("Character Controls");
local WalkSpeedSlider = MiscTab:CreateSlider({Name="Walk speed (15 is default)",Range={0,100},Increment=1,Suffix="",CurrentValue=15,Callback=function(Value)
	local localHumanoid = player.Character:FindFirstChildOfClass("Humanoid");
	if localHumanoid then
		localHumanoid.WalkSpeed = Value;
	end
end});
local ResetButton = MiscTab:CreateButton({Name="Reset Character",Callback=function()
	local savedPosition = humanoidRootPart.CFrame;
	local function onCharacterAdded(newCharacter)
		character = newCharacter;
		humanoidRootPart = character:WaitForChild("HumanoidRootPart");
		task.wait(0.1);
		humanoidRootPart.CFrame = savedPosition;
	end
	player.CharacterAdded:Connect(onCharacterAdded);
	local localHumanoid = character:FindFirstChildOfClass("Humanoid");
	if localHumanoid then
		localHumanoid.Health = 0;
		WalkSpeedSlider:Set(15);
	end
end});

