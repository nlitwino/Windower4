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
	sets.MND 										   = {head="Maat's cap"             ,neck="Gnole torque"   ,ear1="Mamool Ja earring",ear2="Star earring"
													     ,body="Crimson scale mail"     ,hands="Bricta's cuffs",ring1="Tamas ring"	  ,ring2="Star ring"
													     ,back="Prism cape"             ,waist="Duelist's belt",legs="Mahatma slops"    ,feet="Mahatma pigaches"}
	sets.INT 										   = {head="Maat's cap"             ,neck="Lemegeton medallion +1",ear1="Abyssal earring",ear2="Morion earring +1"
													     ,body="Crimson scale mail"     ,hands="Errant cuffs"         ,ring1="Tamas ring"    ,ring2="Snow ring"
													     ,back="Prism cape"             ,waist="Duelist's belt"       ,legs="Mahatma slops"  ,feet="Wise pigaches"}
	
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
	sets.idle                                          = {main="Terra's staff"    ,sub="Bugard leather strap +1"                         ,ammo="Bibiki seashell"
				                                         ,head="Duelist's chapeau",neck="Chocobo whistle"        ,ear1="Merman's earring",ear2="Merman's earring"
				                                         ,body="Dalmatica"        ,hands="Blood finger gauntlets",ring1="Defending ring" ,ring2="Shadow ring"
				                                         ,back="Shadow mantle"    ,waist="Lycopodium sash"       ,legs="Blood cuisses"   ,feet="Duelist's boots"}
	sets.idle.Combat                                   = set_combine(sets.idle,{main="",sub=""})
	sets.idle.Town                                     = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
	sets.idle.Combat                                   = set_combine(sets.idle,{main="",sub=""})
	sets.idle.Town.Combat                              = set_combine(sets.idle.Combat,{ring2="Warp ring",back="Nexus cape"})
	
	sets.resting 									   = {main="Chatoyant staff",ammo="Bibiki seashell",neck="Gnole torque",ear1="Relaxing earring",ear2="Magnetic earring",body="Errant houppelande",ring2="Star ring",waist="Duelist's belt",feet="Avocat pigaches"}
	
	-- precast magic
	sets.precast.FC                                    = {head="Warlock's chapeau",ear1="Loquacious earring",body="Duelist's tabard"}
	                                                   
	-- midcast magic                                   
	sets.midcast.FastRecast                            = set_combine(sets.precast.FC,{hands="Dusk gloves +1",body="Nashira manteel",waist="Velocious belt",feet="Dusk ledelsens +1"})
	                                                   
	sets.midcast['Ninjutsu']                           = set_combine(sets.midcast.FastRecast,{ring2="Antica ring"})
	sets.midcast['Utsusemi: Ichi']                     = set_combine(sets.midcast['Ninjutsu'],{neck="Fortified chain",ear1="Magnetic earring",gear.HasteHarness,ring1="Defending ring",waist="Resolute belt",back="Prism cape"})
	sets.midcast['Utsusemi: Ni']                       = set_combine(sets.midcast['Ninjutsu'],{})
	                                                   
	sets.midcast['Healing Magic']                      = set_combine(sets.MND,{neck="Fylgja torque +1",ear1="Roundel earring",ear2="Magnetic earring",body="Duelist's tabard",legs="Warlock's tights"})
	                                                   
	sets.midcast['Divine Magic']                       = set_combine(sets.MND,{head="Elite beret"})
	                                                   
	sets.midcast['Enfeebling Magic']                   = {head="Duelist's chapeau",neck="Spider torque",body="Warlock's tabard",feet="Avocat pigaches"}
	                                                   
	sets.midcast['Enfeebling Magic']['BlackMagic']     = set_combine(sets.INT,{})
	sets.midcast['Enfeebling Magic']['BlackMagic'].Acc = set_combine(sets.midcast['Enfeebling Magic']['BlackMagic'],sets.midcast['Enfeebling Magic'],{ammo="Sturm's report"})
	
	sets.midcast['Enfeebling Magic']['WhiteMagic']     = set_combine(sets.MND,{ammo="Sturm's report"})
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Acc = set_combine(sets.midcast['Enfeebling Magic']['WhiteMagic'],sets.midcast['Enfeebling Magic'],{ammo="Sturm's report"})
	
	sets.midcast['Elemental Magic']					   = set_combine(sets.INT,{ear1="Moldavite earring",hands="Zenith mitts",feet="Duelist's boots"})
	sets.midcast['Elemental Magic'].Acc				   = set_combine(sets.midcast['Elemental Magic'],{ammo="Sturm's report",legs="Duelist's tights",feet="Nashira crackows"})
	                                                   
	sets.midcast['Dark Magic']						   = set_combine(sets.INT,{ammo="Sturm's report",neck="Dark torque",ear2="Loquacious earring",body="Nashira manteel",hands="Blood finger gauntlets"})
	                                                   
	sets.midcast['Enhancing Magic']                    = set_combine(sets.midcast.FastRecast,{ear2="Magnetic earring",hands="Duelist's gloves",waist="Velocious belt",legs="Warlock's tights"})
	                                                   
	-- custom midcast magic                            
	sets.midcast['Stoneskin']                          = set_combine(sets.MND,sets.midcast.FastRecast,{ear2="Magnetic earring"})
	sets.midcast['Erase']							   = set_combine(sets.midcast.FastRecast,{ear2="Magnetic earring"})
	
	-- engaged
	sets.engaged                                       = {ammo="Bibiki seashell"
														 ,head="Walahra turban"     ,neck="Peacock amulet" ,ear1="Merman's earring",ear2="Brutal earring"
														 ,body="Scorpion harness +1",hands="Dusk gloves +1",ring1=gear.TRing1      ,ring2=gear.TRing2
														 ,back="Cerberus mantle +1" ,waist="Velocious belt",legs="Duelist's tights",feet="Dusk ledelsens +1"}
	sets.engaged.DW                                    = set_combine(sets.engaged,{ear1="Suppanomimi"})
	
	-- ws
	sets.precast.WS                                    = {head="Maat's cap"         ,neck="Fotia gorget"          ,ear1="Merman's earring",ear2="Brutal earring"
					                                     ,body="Scorpion harness +1",hands="Alkyoneus's bracelets",ring1="Strigoi ring"     ,ring2=gear.TRing1
					                                     ,back="Cerberus mantle +1" ,waist="Warwolf belt"         ,legs="Dusk trousers"   ,feet="Rutter sabatons"}
	
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
			equip({main="Seveneyes",sub="Genbu's shield"})
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

	if spell.skill ~= 'Enhancing Magic' or spell.skill ~= 'Enfeebling Magic' then
		if spell.element == world.weather_element or spell.element == world.day_element then
			if world.weather_element ~= 'Dark' and spellMap == 'Cure' then
				equip({waist="Hachirin-no-obi"})
			end
		end
	end
	
end

function job_status_change(new,old)

	if new == 'Engaged' then
		send_command('gs c set IdleMode Combat;gs c set CastingMode Combat')
	end
	
end

function job_buff_change(name,gain)

	sleep_swap(name,gain)
	
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