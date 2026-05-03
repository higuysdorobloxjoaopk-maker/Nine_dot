# Notification Library (Roblox Lua)

A lightweight, clean notification system built for Roblox.
It keeps your original UI style intact while adding queue control, smooth animations, and flexible APIs.

---

✨ Features

- ✔️ Clean and minimal notification design (based on your original UI)
- ✔️ Queue system (max 3 notifications on screen)
- ✔️ Smooth open/close animations
- ✔️ Click to dismiss
- ✔️ Optional lifetime (auto-remove)
- ✔️ Sound support (custom or default)
- ✔️ Notification control by ID
- ✔️ Enable / disable system globally
- ✔️ Minimize specific or all notifications

---

📦 Installation

Upload your script somewhere accessible (GitHub, Pastebin, etc.) and load it using:
```luau
local News = loadstring(game:HttpGet("https://raw.githubusercontent.com/higuysdorobloxjoaopk-maker/BestScriptsLuay/refs/heads/main/Zadmin/NewsLib/Source.lua"))()
```
---

🚀 Usage

Create a Notification
```luau
News:New({
    Text = "Error while loading",
    Icon = "Default", -- (currently visual is fixed, reserved for future)
    Sound = "Default", -- or use a custom sound ID
    LifeTime = 5, -- seconds (optional)
    Id = "1" -- unique identifier (optional but recommended)
})
```
---

⚙️ Configuration
The library is designed to work out of the box, but you can control behavior using the available methods and parameters.
---

🧾 Parameters

| Property   | Type    | Description |
|------------|--------|------------|
| Text       | string | Message displayed |
| Sound      | string | Sound ID |
| LifeTime   | number | Duration in seconds |
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

Behavior

- Every notification always plays its own sound, including queued ones
- If "Sound = false", no sound will be played
- If "SoundId" is not provided, the default sound is used

---

🖼️ Icon Behavior Fix

- Notification icons now preserve correct proportions
- No more stretched or squashed images
- Uses fixed aspect ratio to maintain visual consistency

---

♻️ Re-Execution Safety

- The library now detects existing UI instances
- Prevents duplicated interfaces when executed multiple times
- Ensures notifications stack correctly without overlapping
---

📚 Queue System

- Maximum 3 notifications visible at the same time
- Extra notifications are automatically queued
- When one closes, the next one appears

---

🖱️ Interaction

- Click any notification to dismiss it instantly
- Smooth closing animation included

---

🧩 Control Functions

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

🧠 Notes

- IDs are optional but strongly recommended if you want control
- The system will still work without IDs (auto-generated internally)
- UI structure is preserved from the original design
- Built to be simple and easy to integrate into any script

---

📌 Example
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

🛠️ Future Improvements (optional ideas)

- Custom icons
- Notification types (success, warning, error)
- Position control (top/bottom)
- Progress bar for lifetime

---

📄 License

Free to use and modify. Attribution is optional but appreciated.

---

👤 Author

Made for performance, simplicity, and control.
