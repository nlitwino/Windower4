function get_sets()
	--mote library settings
	mote_include_version = 2
	
	include('Mote-Include.lua')

end

function job_setup()

	-- kay library settings
	include('Kay-Include.lua')
	
	initialize_job()
	
	casting_mode = ''
	
	gear.main = player.equipment.main
	gear.sub = player.equipment.sub
	
end

function user_setup()

	state.IdleMode:options('Normal','Combat')
	state.OffenseMode:options('Normal','DW')
	state.WeaponskillMode:options('Normal','HNM')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.CastingMode:options('Normal','Acc','Combat')
	
	send_command('bind !f9 gs c cycle IdleMode')
	
end

function init_gear_sets()

	--Misc
	sets.MND 										   = {neck="Morgana's choker",body="Errant houppelande",hands="Devotee's mitts +1",back="Prism cape",waist="Penitent's rope",legs="Errant slops",feet="Errant pigaches"}
	sets.INT 										   = {ammo="Phantom tathlum",head="Warlock's chapeau",neck="Philomath stole",ear1="Abyssal earring",body="Errant houppelande",hands="Errant cuffs",ring1="Genius ring +1",ring2="Zircon ring",back="Prism cape",waist="Penitent's rope",legs="Errant slops",feet="Custom F boots"}
	
	-- grips														 	   
	sets.grip										   = {Fire 	      = {sub="Fire Grip"}
												         ,Earth 	  = {sub="Earth Grip"}
												         ,Water 	  = {sub="Water Grip"}
												         ,Wind 	      = {sub="Wind Grip"}
												         ,Ice 	      = {sub="Ice Grip"}
												         ,Lightning   = {sub="Thunder Grip"}
												         ,Light 	  = {sub="Light Grip"}
												         ,Dark 	      = {sub="Dark Grip"}}
	-- idle
	sets.idle                                          = {main="Terra's staff"      ,sub="Bugard leather strap +1"                        ,ammo="Bibiki seashell"
				                                         ,head="Warlock's chapeau",neck="Chocobo whistle"       ,ear1="Abyssal earring" ,ear2="Loquacious earring"
				                                         ,body="Dalmatica"        ,hands="Duelist's gloves"     ,ring1="Defending ring" ,ring2="Shadow ring"
				                                         ,back="Prism cape"       ,waist="Velocious belt"       ,legs="Warlock's tights",feet="Duelist's boots"}
	sets.idle.Combat                                   = set_combine(sets.idle,{main="",sub=""})
	sets.idle.Town                                     = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
	sets.idle.Combat                                   = set_combine(sets.idle,{main="",sub=""})
	sets.idle.Town.Combat                              = set_combine(sets.idle.Combat,{ring2="Warp ring",back="Nexus cape"})
	
	sets.resting 									   = {main="Chatoyant staff",ammo="Bibiki seashell",body="Errant houppelande",feet="Avocat pigaches"}
	
	-- precast magic
	sets.precast.FC                                    = {head="Warlock's chapeau",ear1="Loquacious earring"}
	                                                   
	-- midcast magic                                   
	sets.midcast.FastRecast                            = set_combine(sets.precast.FC,{hands="Dusk gloves",waist="Velocious belt",feet="Dusk ledelsens +1"})
	                                                   
	sets.midcast['Ninjutsu']                           = set_combine(sets.midcast.FastRecast,{})
	sets.midcast['Utsusemi: Ichi']                     = set_combine(sets.midcast['Ninjutsu'],{})
	sets.midcast['Utsusemi: Ni']                       = set_combine(sets.midcast['Ninjutsu'],{})
	                                                   
	sets.midcast['Healing Magic']                      = set_combine(sets.MND,{ear2="Loqacious earring",legs="Warlock's tights"})
	                                                   
	sets.midcast['Divine Magic']                       = set_combine(sets.MND,{})
	                                                   
	sets.midcast['Enfeebling Magic']                   = {neck="Spider torque",body="Warlock's tabard",feet="Avocat pigaches"}
	                                                   
	sets.midcast['Enfeebling Magic']['BlackMagic']     = set_combine(sets.INT,{})
	sets.midcast['Enfeebling Magic']['BlackMagic'].Acc = set_combine(sets.midcast['Enfeebling Magic']['BlackMagic'],sets.midcast['Enfeebling Magic'],{ammo="Sturm's report"})
	
	sets.midcast['Enfeebling Magic']['WhiteMagic']     = set_combine(sets.MND,{})
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Acc = set_combine(sets.midcast['Enfeebling Magic']['WhiteMagic'],sets.midcast['Enfeebling Magic'],{ammo="Sturm's report",hands="Bricta's cuffs"})
	
	sets.midcast['Elemental Magic']					   = set_combine(sets.INT,{ear1="Moldavite earring",feet="Duelist's boots"})
	sets.midcast['Elemental Magic'].Acc				   = set_combine(sets.midcast['Elemental Magic'],{ammo="Sturm's report",legs="Duelist's tights"})
	                                                   
	sets.midcast['Dark Magic']						   = set_combine(sets.INT,{ammo="Sturm's report",hands="Crimson finger gauntlets"})
	                                                   
	sets.midcast['Enhancing Magic']                    = set_combine(sets.midcast.FastRecast,{hands="Duelist's gloves",legs="Warlock's tights"})
	                                                   
	-- custom midcast magic                            
	sets.midcast['Stoneskin']                          = set_combine(sets.MND,sets.midcast.FastRecast,{})
	
	-- engaged
	sets.engaged                                       = {}
	sets.engaged.DW                                    = set_combine(sets.engaged,{})
	
	-- ws
	sets.precast.WS                                    = {}
	
end

function job_midcast(spell,action,spellMap,eventArgs)

	if spell.skill == 'Enfeebling Magic' then
		equip(sets.midcast[spell.skill][spell.type])
	else 
		equip(sets.midcast[spell.skill])
    end

end

function job_post_midcast(spell,action,spellMap,eventsArgs)
	
	if spell.skill == 'Enhancing Magic' then
		if player.status == 'Idle' and state.IdleMode.value == 'Normal' and state.CastingMode.value ~= 'Combat' then
			equip({main="Seveneyes",sub="Legion scutum"})
		end
	else
		if player.status == 'Idle' and state.IdleMode.value == 'Normal' and state.CastingMode.value ~= 'Combat' then
			if state.CastingMode.value == 'Normal' and spell.skill == 'Enfeebling Magic' then
				equip({main="Alkalurops"})
			else
				equip({main="Chatoyant staff"})
			end
			if state.CastingMode.value == 'Acc' and player.status ~= 'Engaged' then
				equip(sets.grip[spell.element])
			end
		end
	end

	-- if spell.skill ~= 'Enhancing Magic' or spell.skill ~= 'Enfeebling Magic' then
		-- if spell.element == world.weather_element or spell.element == world.day_element then
			-- if world.weather_element ~= 'Dark' and spellMap == 'Cure' then
				-- equip({waist="Hachirin-no-obi"})
			-- end
		-- end
	-- end
	
end

function job_status_change(new,old)

	if new == 'Engaged' then
		send_command('gs c set IdleMode Combat;gs c set CastingMode Combat')
	end
	
end

function job_buff_change(name,gain)

	-- sleep_swap(name,gain)
	
	if name == 'Elemental Seal' then
		if gain then
			casting_mode = state.CastingMode.value
			if (state.CastingMode.value ~= 'Normal' or state.CastingMode.value ~= 'Combat') then
				send_command('gs c set CastingMode Normal')
			end
		else
			send_command('gs c set CastingMode '..casting_mode)
		end
	end

end