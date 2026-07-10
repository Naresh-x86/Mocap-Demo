local enabled = false
local plr = game.Players.LocalPlayer
local chr = plr.Character
local event = game.ReplicatedStorage.Events.CameraManipulate

event.OnClientEvent:Connect(function(subject)
	local part = chr:FindFirstChild(subject)
	if part then
		if not enabled then
			workspace.CurrentCamera.CameraSubject = part
			enabled = true
		else
			workspace.CurrentCamera.CameraSubject = chr.Humanoid
			enabled = false
		end
	end
end)
