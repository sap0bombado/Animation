
# Animation Wrapper (Luau)

A lightweight wrapper class for Roblox’s `Animator` object.
It simplifies loading, storing, and playing animation tracks on a Humanoid, while keeping your animation logic organized and easy to maintain.

---

## Installation

Add the module to your project (e.g., in `ReplicatedStorage`), then require it:

```lua
local Animation = require(path.to.Animation)
```
---

## Usage Example

```lua
local animationController = Animation.new(character, {
    character.Animations.Idle,
    character.Animations.Run,
})

animationController:playAnimation("Idle")
```

---

# API Reference

### `Animation.new(character: Model, autoLoadAnimations: { Animation }?) → Animation`

Creates a new wrapper bound to the character’s `Humanoid` → `Animator`.
Optionally loads animations on initialization.

---

### `Animation:loadAnimation(animation: Animation)`

Loads a single animation instance and stores its corresponding track.
Throws if the animation name is already loaded.

---

### `Animation:loadAnimations(animations: { Animation })`

Loads multiple animation instances at once.

---

### `Animation:getAnimationTrack(name: string) → AnimationTrack?`

Returns the stored animation track for the given name, or `nil` if not loaded.

---

### `Animation:isLoaded(name: string) → boolean`

Checks whether the animation has already been loaded.

---

### `Animation:playAnimation(name: string, fadeTime: number?, weight: number?, speed: number?)`

Plays an already-loaded animation track.

---

### `Animation:destroy()`

Stops all playing tracks and destroys them.
Call this when cleaning up the object (e.g., character death or script shutdown).

---