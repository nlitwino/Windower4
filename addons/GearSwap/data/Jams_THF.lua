function get_sets()

	mote_include_version = 2
	include('Mote-Include.lua')
	
end

function job_setup()
	state.Buff['Sneak Attack'] = buffactive['Sneak Attack'] or false
	state.Buff['Trick Attack'] = buffactive['Trick Attack'] or false
	
end

function user_setup()

	include('Mote-TreasureHunter')

end

function init_gear_sets()

	--miscellaneuousfdfereree
	sets.TreasureHunter = {hands="Assassin's armlets"}
							
	--IDLE MOTHER FUCKER
	sets.idle = {main="Azoth",ranged="Power crossbow",ammo=""
				,head="Walahra turban",neck="Chocobo Whistle" ,ear1="Spike earring"  ,ear2="Beetle earring +1"
				,body="Scorpion harness",hands="Assassin's armlets",ring1="Sniper's ring" ,ring2="Sniper's ring"
				,back="Amemet mantle",waist="Velocious belt",legs="Garrison hose"  ,feet="Bounding boots"}
				
	sets.idle.Town = set_combine(sets.idle, {back="Nexus Cape", ring2="Warp Ring"})

	--Marry Me
	sets.engaged = set_combine(sets.idle, {hands="Dusk gloves", feet="Dusk ledelsens", neck="Spike necklace"})

	sets.precast.WS = set_combine(sets.engaged, {head="Empress hairpin"})
				
end