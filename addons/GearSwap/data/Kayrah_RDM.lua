function get_sets()
	--mote library settings
	mote_include_version = 2
	
	include('Mote-Include.lua')

end

function job_setup()
	-- kay library settings
	include('Kay-Include.lua')
	
	initialize_job()

end

function user_setup()
	--combat modes
	state.OffenseMode:options('Normal', 'Acc','DW')
	state.CastingMode:options('Normal','Resistant')
	
	--bind combat mode cycles
	state.OffenseMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal','Acc','HNM')
	
end

function init_gear_sets()

	--Misc
	sets.MND 												 = {ammo="Bugard leather strap +1",head="Maat's cap",neck="Gnole torque",ear1="Mamool Ja earring",body="Crimson scale mail",hands="Bricta's cuffs",ring1="Tamas ring",back="Prism cape",waist="Duelist's belt",legs="Jet seraweels",feet="Duelist's boots"}
	sets.INT 												 = {ammo="Bugard leather strap +1",ammo="Phantom tathlum",head="Maat's cap",neck="Lemegeton medallion +1",ear1="Abyssal earring",ear2="Morion earring +1",body="Crimson scale mail",hands="Duelist's gloves",ring1="Tamas ring",ring2="Snow ring",back="Prism cape",waist="Duelist's belt",legs="Jet seraweels",feet="Numerist pumps"}
	sets.resting 											 = {ammo="Bibiki seashell",neck="Gnole torque",ear2="Magnetic earring",body="Errant houppelande",waist="Duelist's belt",feet="Avocat pigaches"}
	
	-- grips														 	   
	sets.grip												 = {Fire 	= {sub="Fire Grip"},
															 Earth 		= {sub="Earth Grip"},
															 Water 		= {sub="Water Grip"},
															 Wind 		= {sub="Wind Grip"},
															 Ice 		= {sub="Ice Grip"},
															 Lightning 	= {sub="Lightning Grip"},
															 Light 		= {sub="Light Grip"},
															 Dark 		= {sub="Dark Grip"}}
															
	--Precast magic
	sets.precast.FC											 = {head="Warlock's chapeau",ear2="Loquacious earring",body="Duelist's tabard"}
	
	--Midcast magic
	sets.midcast['Enhancing Magic']							 = {hands="Duelist's gloves",legs="Warlock's tights"}
	sets.midcast['Enfeebling Magic']						 = {head="Duelist's chapeau",body="Warlock's tabard",feet="Avocat pigaches"}
	
	sets.midcast['Healing Magic']							 = set_combine(sets.MND,{ear2="Magnetic earring",body="Duelist's tabard",legs="Warlock's tights"})
	
	sets.midcast['Divine Magic']							 = set_combine(sets.MND,{ear2="Magnetic earring"})
	sets.midcast['Divine Magic'].Resistant					 = set_combine(sets.MND,{ear2="Magnetic earring"})
	
	sets.midcast['Enfeebling Magic']['WhiteMagic']			 = set_combine(sets.MND,sets.midcast['Enfeebling Magic'],{ear2="Magnetic earring"})
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Resistant = set_combine(sets.MND,sets.midcast['Enfeebling Magic'],{ear2="Magnetic earring"})
	
	sets.midcast['Enfeebling Magic']['BlackMagic']			 = set_combine(sets.INT,sets.midcast['Enfeebling Magic'],{ear2="Magnetic earring"})
	sets.midcast['Enfeebling Magic']['BlackMagic'].Resistant = set_combine(sets.INT,sets.midcast['Enfeebling Magic'],{ear2="Magnetic earring"})
	
	sets.midcast['Dark Magic']								 = set_combine(sets.INT,{ear1="Abyssal earring",hands="Blood finger gauntlets"})
	sets.midcast['Elemental Magic']							 = set_combine(sets.INT,{head="Warlock's chapeau",ear2="Moldavite earring",hands="Zenith mitts",feet="Duelist's boots",back="Hecate's cape"})
	sets.midcast['Elemental Magic'].Resistant				 = set_combine(sets.midcast['Elemental Magic'],{legs="Duelist's tights",feet="Numerist pumps"})
	
	--IdleMode
	sets.idle												 = {ammo="Bibiki seashell",head="Duelist's chapeau",neck="Chocobo whistle",ear1="Merman's earring",ear2="Merman's earring",body="Dalmatica",hands="Blood finger gauntlets",ring1="Defending ring",ring2="Shadow ring",back="Shadow mantle",waist="Lycopodium sash",legs="Blood cuisses",feet="Duelist's boots"}
	sets.idle.Town											 = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
	
	sets.Kiting												 = {legs="Blood cuisses"}
	
	sets.idle.PDT											 = {ring1="Defending ring",ring2="Jelly ring"}
	sets.idle.MDT											 = {ear1="Merman's ring",ear2="Merman's ring",body="Dalmatica",hands="Duelist's gloves",ring1="Defending ring",ring2="Shadow ring",back="Shadow mantle",waist="Resolute belt"}
	
	--Engaged sets
	sets.engaged											 = {head="Walahra turban",neck="Peacock amulet",ear1="Merman's earring",ear2="Brutal earring",body="Crimson scale mail",hands="Dusk gloves +1",ring1="Lava's ring",ring2="Kusha's ring",back="Amemet mantle +1",waist="Velocious belt",legs="Duelist's tights",feet="Dusk ledelsens +1"}
	sets.engaged.Acc										 = {}
	sets.engaged.DW											 = {}
	
	--Weaponskill sets
	sets.precast.WS											 = {}

end

function job_status_change(new,old)

	if new == "Engaged" then
		disable("main","sub")
	else
		enable("main","sub")
	end
	
	gear.main = player.equipment.main
	gear.sub = player.equipment.sub
	
end	

function job_post_midcast(spell,action,spellMap,eventArgs)

	-- Apply Obi
	if spell.skill == 'Elemental Magic' then 
		if spell.element == world.weather_element or spell.element == world.day_element then
			equip({waist="Hachirin-no-obi"})
		end
	end
	
	if spellMap == 'Cure' then
		if not (world.weather_element == 'Dark' or world.day_element == 'Dark') then
			equip({waist="Hachirin-no-obi"})
		end
	end
	
	-- dont swap grip if engaged
	if player.status ~= 'Engaged' and state.CastingMode.value == 'Resistant' then
		equip(sets.grip[spell.element])
	end

end

function job_midcast(spell,action,spellMap,eventArgs)

	if spell.skill == 'Enfeebling Magic' then
		equip(sets.midcast[spell.skill][spell.type])
	else 
		equip(sets.midcast[spell.skill])
    end

end