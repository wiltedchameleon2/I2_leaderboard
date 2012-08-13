--[[
	This work copyright (c) Ashley Davies (Trappingnoobs) 2012

	This work is widely listed under the Creative Commons Attribution-NonCommercial 3.0 (CC BY-NC 3.0) license, however the author
		reserves the right to deny permission to any person for any reason to use, reproduce by any digital or physical means,
		and manipulate/modify this document at any time for any reason.

	The above notice must stay intact across all modifications of the program, and may not be modified.
]]

_G.i2LB = {}
_G.innovation2Leaderboard = _G.i2LB
_G.innovation2LB = _G.i2LB
_G.innovationSquaredLeaderBoard = _G.i2LB
_G.innovationSquaredLB = _G.i2LB
_G.standardLeaderboard = _G.i2LB
_G.leaderboard = _G.i2LB
_G.leaderBoard = _G.i2LB
_G.LEADERBOARD = _G.i2LB
_G.LeaderBoard = _G.i2LB 

_G.i2LB.players = {}
_G.i2LB.stats = {}
_G.i2LB.core = {}

_G.i2LB.timeBetweenChecks = 30

_G.i2LB.core.addPlayer = function(player, leaderstats)
	_G.i2LB.players[player.Name] = {
		["player"] = player,
		["leaderstats"] = leaderstats,
		["realstats"] = {}
	}

	_G.i2LB.core.addAllStatsToPlayer(player)
end

_G.i2LB.core.addStat = function(statName, default)
	_G.i2LB.stats[statName] = {
		["name"] = statName
		["default"] = default or 0
	}

	for _, player in pairs(_G.i2LB.players) do
		_G.i2LB.core.addStatToPlayer(player, _G.i2LB.stats[statName])
	end
end

_G.i2LB.core.addStatToPlayer = function(player, stat)
	local statObject = Instance.new("IntValue", player.leaderstats)
	statObject.Name = stat.name
	statObject.value = stat.default
	player.realstats[stat.name] = stat.default
end

_G.i2LB.core.addAllStatsToPlayer = function(player)
	for _, stat in pairs(_G.i2LB.core.stats) do
		_G.i2LB.core.addStatToPlayer(player, stat)
	end
end


-- Public API

_G.i2LB.addStat = function(statName, default)
	-- Wrapper for back-end manipulation
	_G.i2LB.core.addStat(statName, default)
end

_G.i2LB.incrStat = function(player, statName, amount)
	player = (player.IsA and player or game.Players:GetPlayer(player))
	stat = _G.i2LB.stat[statName]

	assert(stat, "Stat does not exist (Are you sure you created it with the i2 leaderboard API?)")
	_G.i2LB.core.incrStat(player, stat, amount)
end

-- Other stuff

game.Players.PlayerAdded:connect(function(player)
	wait() -- Foolproof
	local leaderstats = player:FindFirstChild("leaderstats") or (Instance.new("IntValue", player).Name = "leaderstats")
	_G.i2LB.core.addPlayer(player, leaderstats)
end)

_G.i2LB.isLoaded = true