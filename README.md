# Mocap-Demo

I originally put this together in 2022 as a *small* technical demonstration to test out the capabilities of Roblox Studio's Video to Motion Capture (Mocap) feature.

I also created this specific repository as a testing ground for one of my other open-source side projects, [xlx2tree](https://github.com/NonoNegative/xlx2tree).

> [!TIP]
> `xlx2tree` is a command-line utility I built that parses monolithic `.rbxlx` XML place files and extracts them into a structured directory hierarchy. This makes it infinitely easier to track Roblox places on version control systems like Git, as each `RbxInstance` is split into its own independent directory or file.

## Demonstrations

Here are a few clips I recorded during development:

### Scene to Wireframe Translation
https://github.com/user-attachments/assets/34b68a95-49f7-4a67-ac56-2fdcd32ba4c3

### Wireframe Animation Solo
https://github.com/user-attachments/assets/35c4df30-39eb-4771-bed5-e3fa7c7611a6

### In-Game Third Person Camera View
https://github.com/user-attachments/assets/ea5dbea5-bcc4-40b4-9f13-8b86b51fa7dd

> [!NOTE]
> Depending on your markdown viewer or browser, you might need to open the raw `.mp4` files inside the `.media/` directory directly if the embedded videos above do not render correctly.

<br>
 
## What's in here?

The interaction logic is driven by a combination of server-side state management and client-side camera manipulation.

### Server-Side Logic (`Script.server.lua`)
Located within the vending machine model (`Workspace/VendingMachine.MeshPart/ProximityPrompt/Script`), this script handles the core interaction sequence when a player triggers the `ProximityPrompt`:
1. **Camera Event:** Fires a `RemoteEvent` (`CameraManipulate`) to the client to shift the camera focus to the player's head for a cinematic view.
2. **Animation Sequences:** Loads and plays three sequential mocap animations:
   - `CoinIn`: The character inserts a coin.
   - `Pickup`: The character retrieves the dispensed item.
   - `Drink`: The character consumes the item.
3. **Weld Constraints:** Clones a Cola tool from `ReplicatedStorage`, welds it to the character's `LeftHand` using `CFrame` math, and manages its lifecycle through the animation keyframes.
4. **State Restoration:** Restores the player's mobility, grants health (+20 HP), signals the client to reset the camera view, and destroys the welded item upon completion.

### Client-Side Logic (`ManipulateCamera.client.lua`)
Located in `StarterGui/ManipulateCamera.LocalScript`, this script listens for the `CameraManipulate` remote event. It toggles the `workspace.CurrentCamera.CameraSubject` between the default `Humanoid` and a specified character part (the `Head`), switching to a dynamic camera ONLY during the animation sequence.

<br>
 
## Original Files

If you just want to grab the place file and load it into Studio without dealing with all this, check out the [**Releases**](https://github.com/Naresh-x86/Mocap-Demo/releases/) page on this repository. You'll find the original `.rbxl` and `.rbxlx` files available for download!
