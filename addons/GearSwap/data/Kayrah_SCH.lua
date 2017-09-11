function get_sets()

	mote_include_version = 2
	
	include('Mote-Include.lua')

end

function job_setup()
	
	-- import useful shit
	include('Kay-Include.lua')
	
	-- buff states
	state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
	state.Buff['Dark Arts']              = buffactive['Dark Arts'] or buffactive['Addendum: Black'] or false
	state.Buff['Light Arts']             = buffactive['Light Arts'] or buffactive['Addendum: White'] or false
	state.Buff['Celerity']               = buffactive['Celerity'] or false
	state.Buff['Alacrity']               = buffactive['Alacrity'] or false
	
	-- custom spell groups
	helixes 							 = S{'Geohelix','Hydrohelix','Anemohelix','Pyrohelix','Cryohelix','Ionohelix','Noctohelix','Luminohelix'}
	sleeps  							 = S{'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II', 'Bind'}
	
	-- different spell skills for different arts
	dark_arts_skill                      = S{'Elemental Magic','Dark Magic','Enfeebling Magic'}
	light_arts_skill                     = S{'Divine Magic','Enhancing Magic','Healing Magic','Enfeebling Magic'}
	
	initialize_job()
	
	casting_mode = ''
	
	gear.main = player.equipment.main
	gear.sub = player.equipment.sub

end

function user_setup()

	state.CastingMode:options('Normal','Acc','TH')
	
end

function init_gear_sets()

	-- misc
	sets.sublimation = {main="Elder staff"          ,sub="Axe grip"                                 ,ammo="White tathlum"
					   ,head="Scholar's mortarboard",neck="Chocobo whistle",ear1="Bloodbead earring",ear2="Cassie earring"
					   ,body="Argute gown"          ,hands="Garden bangles",ring1="Bomb queen ring" ,ring2="Bloodbead ring"
					   ,back="Gigant mantle"        ,waist="Ocean sash"    ,legs="Argute pants"}
	sets.INT = {main="Alkalurops"        ,sub="Bugard leather strap +1"                       ,ammo="Phantom tathlum"
			   ,head="Maat's cap"        ,neck="Lemegeton medallion +1",ear1="Abyssal earring",ear2="Morion earring +1"
			   ,body="Errant houppelande",hands="Errant cuffs"         ,ring1="Tamas ring"    ,ring2="Snow ring"
			   ,back="Prism cape"        ,waist="Argute belt"          ,legs="Mahatma slops"  ,feet="Rostrum pumps"}
	sets.MND = {main="Alkalurops"        ,sub="Bugard leather strap +1"
	           ,head="Maat's cap"        ,neck="Gnole torque"          ,ear1="Mamool Ja earring",ear2="Star earring"
			   ,body="Errant houppelande",hands="Scholar's bracers +1" ,ring1="Tamas ring"      ,ring2="Star ring"
			   ,back="Prism cape"        ,waist="Argute belt"          ,legs="Mahatma slops"    ,feet="Mahatma pigaches"}
	
	sets.grips 										   = {Fire 	    = {sub="Fire Grip"}
				                                         ,Earth 	= {sub="Earth Grip"}
				                                         ,Water 	= {sub="Water Grip"}
				                                         ,Wind 	    = {sub="Wind Grip"}
				                                         ,Ice 		= {sub="Ice Grip"}
				                                         ,Lightning = {sub="Lightning Grip"}
				                                         ,Light 	= {sub="Light Grip"}
				                                         ,Dark 	    = {sub="Dark Grip"}}
	
	-- idle/resting
	sets.idle                                          = {main="Terra's staff",sub="Bugard leather strap +1"                  ,ammo="Bibiki seashell"
				                                                              ,neck="Chocobo whistle" ,ear1="Merman's earring",ear2="Merman's earring"
				                                         ,body="Ixion cloak"  ,hands="Garden bangles" ,ring1="Defending ring" ,ring2="Shadow ring"
				                                         ,back="Shadow mantle",waist="Lycopodium sash",legs="Argute pants"    ,feet="Herald's gaiters"}
	sets.idle.Town                                     = set_combine(sets.idle,{main="Elder staff",ring2="Warp ring",back="Nexus cape"})
	
	sets.resting                                       = {main="Chatoyant staff",ammo="Bibiki seashell",neck="Gnole torque",ear1="Magnetic earring",ear2="Relaxing earring",body="Errant houppelande",ring2="Star ring",feet="Avocat pigaches"}
	                                                   
	-- precast                                         
	sets.precast.FC                                    = {main="Elder staff",ear2="Loquacious earring",feet="Rostrum pumps"}
	
	-- midcast
	sets.midcast.FastRecast                            = set_combine(sets.precast.FC,{head="Walahra turban"})
	
	sets.midcast['Healing Magic']                      = set_combine(sets.MND,{main="Elder staff",ear2="Magnetic earring",feet="Argute loafers"})
	sets.midcast['Divine Magic']                       = set_combine(sets.MND,{main="Chatoyant staff"})
	
	sets.midcast['Enfeebling Magic']                   = {main="Chatoyant staff",hands="Argute bracers",feet="Avocat pigaches"}
	
	sets.midcast['Enfeebling Magic']['BlackMagic']     = set_combine(sets.INT,{})
	sets.midcast['Enfeebling Magic']['BlackMagic'].Acc = set_combine(sets.midcast['Enfeebling Magic']['BlackMagic'],sets.midcast['Enfeebling Magic'],{ammo="Sturm's report"})
	
	sets.midcast['Enfeebling Magic']['WhiteMagic']     = set_combine(sets.MND,{ammo="Sturm's report",hands="Bricta's cuffs"})
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Acc = set_combine(sets.midcast['Enfeebling Magic']['WhiteMagic'],sets.midcast['Enfeebling Magic'])
	
	sets.midcast['Elemental Magic']                    = set_combine(sets.INT,{main="Chatoyant staff",ear2="Moldavite earring",hands="Vicious mufflers"})
	sets.midcast['Elemental Magic'].Acc                = set_combine(sets.INT,{ammo="Sturm's report",hands="Errant cuffs"})
	
	sets.midcast['Dark Magic']                         = set_combine(sets.INT,{ear1="Loquacious earring",neck="Dark torque",hands="Bricta's cuffs",legs="Argute pants"})
	                                                   
	sets.midcast['Enhancing Magic']                    = set_combine(sets.midcast.FastRecast,{main="Seveneyes",sub="Genbu's shield",ear2="Magnetic earring",body="Argute gown"})
	
	-- custom midcast
	sets.midcast.Sleep                                 = set_combine(sets.midcast.FastRecast,sets.INT,sets.midcast['Enfeebling Magic'],{ammo="Sturm's report",neck="Spider torque"})

end

function job_post_precast(spell,action,spellMap,eventArgs)

	if (spell.type == 'BlackMagic' and state.Buff['Dark Arts']) or (spell.type == 'WhiteMagic' and state.Buff['Light Arts']) then
		equip({head="Argute mortarboard",feet="Scholar's loafers"})
	end
	
	if spell.element == world.weather_element and (state.Buff['Celerity'] or state.Buff['Alacrity']) then
		equip({feet="Argute loafers"})
	end
	
end

function job_midcast(spell,action,spellMap,eventArgs)

	if spell.skill == 'Enfeebling Magic' then
		equip(sets.midcast[spell.skill][spell.type])
	else 
		equip(sets.midcast[spell.skill])
    end
	
end

function job_buff_change(name,gain)

	sleep_swap(name,gain)
	
	if name == "Sublimation: Activated" then
		handle_equipping_gear()
	end
	
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

function job_get_spell_map(spell, default_spell_map)

    if spell.skill == 'Enfeebling Magic' and sleeps:contains(spell.english) then
		return 'Sleep'
    end
	
end

function job_post_midcast(spell,action,spellMap,eventArgs)

	-- midcast magic
	if spell.element == world.weather_element or spell.element == world.day_element then
		if spell.skill == 'Elemental Magic' then
			equip({waist="Hachirin-no-obi"})
		elseif (spell.skill == 'Healing Magic' or spell.skill == 'Divine Magic') and world.weather_element ~= 'Dark' then
			equip({waist="Hachirin-no-obi"})
		end
	end
	
	-- argute loafers logic
	if state.Buff['Alacrity'] or state.Buff['Celerity'] then
		if (spell.skill == 'Healing Magic' or spell.skill == 'Enhancing Magic') and spell.element == world.weather_element then
			equip({feet="Argute loafers"})
		end
	end
	
	-- midcast logic
	if state.Buff['Dark Arts'] and dark_arts_skill:contains(spell.skill) and spell.skill ~= 'Elemental Magic' then
		equip({main="Elder staff",body="Scholar's gown"})
	elseif state.Buff['Light Arts'] and light_arts_skill:contains(spell.skill) then
		if spell.skill == 'Enhancing Magic' then
			equip({legs="Scholar's pants"})
			if spell.name == 'Phalanx' then
				equip({main="Elder staff"})
			end
		else
			equip({main="Elder staff",legs="Scholar's pants"})
		end
	end
	
	-- add grip if not engaged
	if state.CastingMode.value == 'Acc' then
		if player.status ~= 'Engaged' then
			equip(sets.grip[spell.element])
		end
	end

end

function customize_idle_set(idleSet)

	if state.Buff['Sublimation: Activated'] then
		idleSet = set_combine(idleSet,sets.sublimation)
	else
		if player.mpp > 75 then 
			idleSet = set_combine(idleSet,{main="Terra's staff"})
		end
	end
	
    return idleSet
	
end