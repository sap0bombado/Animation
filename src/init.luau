--!strict
--[[

--]]
local Animation = {}
Animation.__index = Animation

type ClassData = {
	animator: Animator,
	animationTracks: { [string]: AnimationTrack },
	animationPlayed: RBXScriptSignal,
}

export type ClassType = typeof(setmetatable({} :: ClassData, Animation))

function Animation.new(character: Model, autoLoadAnimations: { Animation }?): ClassType
	local humanoid = character:FindFirstChildWhichIsA("Humanoid") :: Humanoid
	local animator = humanoid:FindFirstChildWhichIsA("Animator") :: Animator

	local self = {
		animator = animator,
		animationTracks = {} :: { [string]: AnimationTrack },
		animationPlayed = animator.AnimationPlayed :: RBXScriptSignal,
	}

	setmetatable(self, Animation)

	if autoLoadAnimations then
		self:loadAnimations(autoLoadAnimations)
	end

	return self
end

function Animation.getAnimationTrack(self: ClassType, animationName: string): AnimationTrack?
	return self.animationTracks[animationName]
end

function Animation.isLoaded(self: ClassType, animationName: string): boolean
	return not not self.animationTracks[animationName]
end

function Animation.loadAnimations(self: ClassType, animations: { Animation })
	for _, animationInstance: Animation in animations do
		self:loadAnimation(animationInstance :: Animation)
	end
end

function Animation.loadAnimation(self: ClassType, animationInstance: Animation)
	assert(not self.animationTracks[animationInstance.Name], `{animationInstance.Name} is already loaded`)
	self.animationTracks[animationInstance.Name] = self.animator:LoadAnimation(animationInstance)
end

function Animation.playAnimation(
	self: ClassType,
	animationName: string,
	fadeTime: number?,
	weight: number?,
	speed: number?
)
	local animationTrack = assert(self.animationTracks[animationName], `{animationName} is not loaded`)
	animationTrack:Play(fadeTime, weight, speed)
end

function Animation.destroy(self: ClassType)
	for _, animationTrack in pairs(self.animationTracks) do
		if animationTrack.IsPlaying then
			animationTrack:Stop()
		end

		animationTrack:Destroy()
	end
end

return Animation
