# news libray(notifications)

- creator higuysdorobloxjoaopk's
- email [luayrbx@gmail.com](luayrbx@gmail.com)
- ServerDiscord ~ [LuayDiscord](https://discord.gg/MwJGfBSXc9)
---

### advantages & features

- | Clean and clear system
- | Simple to use and understand
- | Frequent updates
- | Editable
- | Briefly smooth

---

### Installation

First, call the library using loadstring;
```luau
local News = loadstring(game:HttpGet("https://raw.githubusercontent.com/higuysdorobloxjoaopk-maker/BestScriptsLuay/refs/heads/main/Zadmin/NewsLib/Source.lua"))()
```
---

### How to use

Create a Notification
```luau
News:New({
    Text = "Error while loading",
    Icon = "Default",
    SoundId = "Default", -- or use a custom sound ID
    Sound = true
    LifeTime = 5,
    Id = "1" -- unique identifier
})
```
---

### Configuration
The library is designed to work out of the box, but you can control behavior using the available methods and parameters.
---

### Parameters

| Property   | Type    | Description |
|------------|--------|------------|
| Text       | string | Message displayed |
| SoundId    | string | Sound ID |
| LifeTime   | number | Duration in seconds |
| Sound      | true/false | whether the sound will play when the notification appears
| Id         | string | Identifier |
---

🔊 Sound Configuration

You now have full control over notification sounds.

Parameters

| Property  | Type    | Default             | Description                   |
|-----------|---------|---------------------|-------------------------------|
| Sound     | boolean | true                | Enable or disable sound       |
| SoundId   | string  | "137402801272072"   | Custom sound asset ID         |
---

Usage Examples
```luau
News:New({
    Text = "Default sound",
    Sound = true
})
```
```luau
News:New({
    Text = "Custom sound",
    Sound = true,
    SoundId = "123456789"
})
```
```luau
News:New({
    Text = "Silent notification",
    Sound = false
})
```
---

### Behavior

- Every notification always plays its own sound, including queued ones
- If "Sound = false", no sound will be played
- If "SoundId" is not provided, the default sound is used

---

### Icon Behavior Fix

- Notification icons now preserve correct proportions
- No more stretched or squashed images
- Uses fixed aspect ratio to maintain visual consistency

---

### Re-Execution Safety

- The library now detects existing UI instances
- Prevents duplicated interfaces when executed multiple times
- Ensures notifications stack correctly without overlapping
---

### Interaction

- Click any notification to dismiss it instantly
- Smooth closing animation included

---

### Control Functions

Minimize Notifications

Minimize specific notifications or all:
```luau
-- Minimize all
News:MinimizeNotifications({
    Notifications = "All"
})
```
```luau
-- Minimize specific IDs
News:MinimizeNotifications({
    Notifications = {"1", "2", "3"}
})
```
---

Enable / Disable Notifications
```luau
News:Notifications({
    Notifications = false -- disables system
})
```
```luau
News:Notifications({
    Notifications = true -- enables again
})
```

---

### Example
```luau
local News = loadstring(game:HttpGet("https://raw.githubusercontent.com/higuysdorobloxjoaopk-maker/BestScriptsLuay/refs/heads/main/Zadmin/NewsLib/Source.lua"))()

News:New({
    Text = "Welcome!",
    LifeTime = 3,
    Id = "welcome"
})

News:New({
    Text = "Something went wrong",
    Sound = "Default",
    LifeTime = 5,
    Id = "error"
})
```

---

Hey, the creator of this library really wants to keep creating, but it's not easy, much less quick, to do so. There are many bugs on top of each other. If you could help by sharing and giving a star, please let me know.<img width="507" height="492" alt="f49a8b111c6bcf86be6b503dd7b1e748-removebg-preview" src="https://github.com/user-attachments/assets/a9ffadc4-3e2b-4dea-8e6d-7b1dda524b31" />
