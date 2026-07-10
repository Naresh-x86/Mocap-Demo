
local proximityPrompt = script.Parent
local cframe = proximityPrompt.Parent.CFramePart
local event = game.ReplicatedStorage.Events.CameraManipulate

proximityPrompt.Triggered:Connect(function(player)
	local subject = "Head"
	event:FireClient(player, subject)
	proximityPrompt.Enabled = false
	local animation1 = script.Parent.Parent.CoinIn
	local animation2 = script.Parent.Parent.Pickup
	local animation3 = script.Parent.Parent.Drink
	local loadedanim = player.Character.Humanoid:LoadAnimation(animation1)
	local loadedanim2 = player.Character.Humanoid:LoadAnimation(animation2)
	local loadedanim3 = player.Character.Humanoid:LoadAnimation(animation3)
	player.Character.HumanoidRootPart.Anchored = true
	player.Character.HumanoidRootPart.CFrame = cframe.CFrame
	loadedanim:Play()
	script.Parent.Parent.Sound:Play()
	loadedanim.Stopped:Connect(function()
		local colaclone = game.ReplicatedStorage.Cola:Clone()
		colaclone.Parent = player.Character
		colaclone.CFrame = player.Character.LeftHand.CFrame
		local newweld = Instance.new("Weld")
		newweld.Parent = player.Character.LeftHand
		newweld.Part0 = player.Character.LeftHand
		newweld.Part1 = colaclone
		newweld.C0 = CFrame.new(0,-0.1,0)
		newweld.C1 = CFrame.Angles(math.rad(90),0,0)
		loadedanim2:Play()
		wait(0.4)
		script.Parent.Parent.DrinkSound:Play()
		loadedanim2.Stopped:Connect(function()
			event:FireClient(player, subject)
			newweld:Destroy()		
			player.Character.HumanoidRootPart.Anchored = false
			proximityPrompt.Enabled = true
			player.Character.Humanoid.Health = player.Character.Humanoid.Health+20	
			wait(5)
			if colaclone then
				colaclone:Destroy()
			end
		end)
	end)	
end)

proximityPrompt.Triggered:Connect(function(player)
	wait(10)
	proximityPrompt.Enabled = true
end)