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
	sleeps  							 = S{'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II'}
	
	-- different spell skills for different arts
	dark_arts_skill                      = S{'Elemental Magic','Dark Magic','Enfeebling Magic'}
	light_arts_skill                     = S{'Divine Magic','Enhancing Magic','Healing Magic','Enfeebling Magic'}
	
	initialize_job()

end

function user_setup()

	state.CastingMode:options('Normal','Acc','TH')
	
end

function init_gear_sets()
	
	-- misc.
	sets.sublimation                                   = {main="Seveneyes"            ,sub="Genbu's shield"    ,ammo="White tathlum"
					                                     ,head="Scholar's mortarboard",ear1="Bloodbead earring",ear2="Cassie earring"
					                                     ,body="Argute gown"          ,ring1="Bloodbead ring"  ,ring2="Bomb queen ring"
					                                     ,back="Gigant mantle"        ,legs="Argute pants"}
					   
	sets.INT                                           = {main="Chatoyant staff"   ,sub="Bugard leather strap +1"                          ,ammo="Phantom tathlum"
			                                             ,head="Maat's cap"        ,neck="Lemegeton medallion +1",ear1="Abyssal earring",ear2="Morion earring +1"
			                                             ,body="Errant houppelande",hands="Errant cuffs"         ,ring1="Tamas ring"    ,ring2="Snow ring"
			                                             ,back="Prism cape"        ,waist="Argute belt"          ,legs="Mahatma slops"  ,feet="Rostrum pumps"}
	                                                   
	sets.MND                                           = {main="Chatoyant staff"   ,sub="Bugard leather strap +1"
														 ,head="Maat's cap"        ,neck="Gnole torque"   ,ear1="Mamool Ja earring"
			                                             ,body="Errant houppelande",hands="Bricta's cuffs",ring1="Tamas ring"      ,ring2="Star ring"
			                                             ,back="Prism cape"        ,waist="Argute belt"   ,legs="Mahatma slops"    ,feet="Mahatma pigaches"}
	
	-- grips
	sets.grip 										   = {Fire 	    = {sub="Fire Grip"}
													     ,Earth 	= {sub="Earth Grip"}
													     ,Water 	= {sub="Water Grip"}
													     ,Wind 	    = {sub="Wind Grip"}
													     ,Ice 		= {sub="Ice Grip"}
													     ,Lightning = {sub="Lightning Grip"}
													     ,Light 	= {sub="Light Grip"}
													     ,Dark 	    = {sub="Dark Grip"}}

	-- idle
	sets.idle                                          = {main="Terra's staff",sub="Bugard leather strap +1",ammo="Bibiki seashell"
					                                                          ,neck="Chocobo whistle"  ,ear1="Merman's earring",ear2="Merman's earring"
					                                     ,body="Ixion cloak"  ,hands="Vicious mufflers",ring1="Defending ring" ,ring2="Shadow ring"
					                                     ,back="Shadow mantle",waist="Lycopodium sash" ,legs="Argute pants"    ,feet="Herald's gaiters"}
	
	sets.idle.Town                                     = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
	
	sets.resting                                       = {main="Chatoyant staff",ammo="Bibiki seashell",head="Elite beret",neck="Gnole torque",ear1="Magnetic earring",body="Errant houppelande",ring2="Star ring"}
	
	-- precast magic
	sets.precast.FC                                    = {ear1="Loquacious earring",feet="Rostrum pumps"}
	sets.precast.FastRecast                            = {head="Walahra turban"}
	
	-- midcast magic
	sets.midcast['Healing Magic']                      = set_combine(sets.MND,{ear2="Magnetic earring",feet="Argute loafers"})
	sets.midcast['Divine Magic']                       = set_combine(sets.MND,{})
	
	sets.midcast['Enfeebling Magic']                   = {hands="Argute bracers",feet="Avocat pigaches"}
	
	sets.midcast['Enfeebling Magic']['BlackMagic']     = set_combine(sets.INT,sets.midcast['Enfeebling Magic'])
	sets.midcast['Enfeebling Magic']['BlackMagic'].Acc = set_combine(sets.midcast['Enfeebling Magic']['BlackMagic'],{ammo="Sturm's report"})
	
	sets.midcast['Enfeebling Magic']['WhiteMagic']     = set_combine(sets.MND,sets.midcast['Enfeebling Magic'])
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Acc = set_combine(sets.midcast['Enfeebling Magic']['WhiteMagic'],{ammo="Sturm's report",hands="Bricta's cuffs"})
	
	sets.midcast['Elemental Magic']                    = set_combine(sets.INT,{ear1="Moldavite earring",hands="Vicious mufflers"})
	sets.midcast['Elemental Magic'].Acc                = set_combine(sets.midcast['Elemental Magic'],{ammo="Sturm's report",ear1="Abyssal earring",hands="Errant cuffs"})
	
	sets.midcast['Dark Magic']                         = set_combine(sets.INT,{ear1="Loquacious earring",neck="Dark torque",hands="Bricta's cuffs",legs="Argute pants"})
	
	sets.midcast['Enhancing Magic']                    = set_combine(sets.MND,{main="Seveneyes",sub="Genbu's shield",ear2="Magnetic earring",body="Argute gown"})
	
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

end

function job_post_midcast(spell,action,spellMap,eventArgs)
	
	-- weather/day element logic
	if (spell.skill == 'Elemental Magic' or spell.skill == 'Healing Magic') and not helixes:contains(spell.english) then
		if spell.element == world.weather_element or spell.element == world.day_element then
			equip({waist="Hachirin-no-obi"})
		end
		if state.CastingMode.value == 'TH' then
			equip({main="Lotus katana"})
		end
	elseif helixes:contains(spell.english) then
		if spell.element == world.day_element then
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
		equip({body="Scholar's gown"})
	elseif state.Buff['Light Arts'] and light_arts_skill:contains(spell.skill) then
		equip({legs="Scholar's pants"})
	end
	
	-- add grip if not engaged
	if state.CastingMode.value == 'Accuracy' then
		if player.status ~= 'Engaged' then
			equip(sets.grip[spell.element])
		end
	end
	
end

function customize_idle_set(idleSet)

    if state.Buff['Sublimation: Activated'] then
		idleSet = set_combine(idleSet,sets.sublimation)
    end
	
    return idleSet
	
end