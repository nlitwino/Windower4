function get_sets()

	mote_include_version = 2

	include('Mote-Include.lua')
	
end

function job_setup()
	
	include('Kay-Include.lua')
		
	initialize_job()
	
end

function user_setup()

	state.OffenseMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal','Resistant')
	state.IdleMode:options('Normal', 'PDT', 'MDT')
	
end

function init_gear_sets()

	--Misc.
	sets.MND 												= {sub="Bugard leather strap +1", neck="Holy phial", ear1="Star earring", body="Errant houppelande", hands="Bricta's cuffs", ring1="Tamas ring", ring2="Star ring", back="Prism cape", waist="Duelist's belt", legs="Jet seraweels", feet="Duelist's boots"}
	sets.INT 												= {sub="Bugard leather strap +1", head="Warlock's chapeau", ear2="Abyssal earring", body="Errant houppelande", hands="Bricta's cuffs", ring1="Tamas ring", ring2="Snow ring", back="Prism cape", waist="Duelist's belt", legs="Jet seraweels"}
	sets.resting 											= {main="Chatoyant staff", sub="Bugard leather strap +1", ammo="Bibiki seashell", body="Errant houppelande",back="Invigorating cape"}

	sets.obi												= {Fire 	= {waist="Karin Obi"},
															Earth 		= {waist="Dorin Obi"},
															Water	 	= {waist="Suirin Obi"},
															Wind 		= {waist="Furin Obi"},
															Ice 		= {waist="Hyorin Obi"},
															Lightning	= {waist="Rairin Obi"},
															Light 		= {waist="Korin Obi"},
															Dark 		= {waist="Anrin Obi"}}
																   
	sets.grip												= {Fire 	= {sub="Fire Grip"},
															Earth 		= {sub="Earth Grip"},
															Water 		= {sub="Water Grip"},
															Wind 		= {sub="Wind Grip"},
															Ice 		= {sub="Ice Grip"},
															Lightning 	= {sub="Lightning Grip"},
															Light 		= {sub="Light Grip"},
															Dark 		= {sub="Dark Grip"}}
	
	--Precast Magic
	sets.precast.FC 										 = {main="Chatoyant Staff", sub="Magic strap", head="Duelist's chapeau", ear2="Loquacious erring", body="Duelist's tabard", feet="Rostrum pumps"}
	
	--Midcast magic
	sets.midcast['Enhancing Magic'] 						 = {main="Seveneyes",sub="Genbu's shield",body="Glamor jupon", hands="Duelist's gloves", legs="Warlock's tights"}
	sets.midcast['Enfeebling Magic'] 						 = {neck="Enfeebling torque",body="Warlock's tabard",feet="Avocat pigaches"}
	
	sets.midcast['Healing Magic']							 = set_combine(sets.MND, {neck="Fylgja torque +1",body="Duelist's tabard", legs="Warlock's tights"})
	
	sets.midcast['Divine Magic'] 							 = set_combine(sets.MND, {})
	sets.midcast['Divine Magic'].Resistant 					 = set_combine(sets.MND, {})
	
	sets.midcast['Enfeebling Magic']['WhiteMagic']			 = set_combine(sets.MND, sets.midcast['Enfeebling Magic'])
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Resistant = set_combine(sets.MND, sets.midcast['Enfeebling Magic'])
	
	sets.midcast['Dark Magic']								 = set_combine(sets.INT, {hands="Crimson finger gauntlets"})
	sets.midcast['Elemental Magic']							 = set_combine(sets.INT, {legs="Duelist's tights", feet="Duelist's boots"})
	
	sets.midcast['Enfeebling Magic']['BlackMagic']		 	 = 	set_combine(sets.INT, sets.midcast['Enfeebling Magic'])
	sets.midcast['Enfeebling Magic']['BlackMagic'].Resistant = 	set_combine(sets.INT, sets.midcast['Enfeebling Magic'])
	
	sets.midcast.FastRecast 								 = set_combine(sets.precast.FC, {})
	
	sets.midcast['Stoneskin']								 = set_combine(sets.MND,sets.midcast['Enhancing Magic'],sets.midcast.FastRecast)
	
	--Idle Sets
	sets.idle 												 = {main="Terra's staff", sub="Bugard leather strap +1", ammo="Phantom tathlum", head="Duelist's chapeau", neck="Chocobo whistle", ear1="Star earring", ear2="Mamool Ja earring", body="Dalmatica", hands="Duelist's gloves", ring1="Merman's ring", ring2="Merman's ring", back="Hexerei cape", waist="Lycopodium sash", legs="Warlock's tights", feet="Duelist's boots"}
	sets.idle.Town 											 = set_combine(sets.idle, {})
	
	sets.Kiting 											 = {legs="Blood cuisses"}
	
	sets.idle.PDT 											 = set_combine(sets.idle, {})
	sets.idle.MDT 											 = set_combine(sets.idle, {})
	
	--Engaged Sets
	sets.engaged 											= {}
	sets.engaged.Acc 										= {}
	
	sets.engaged.DW 										= {}
	sets.engaged.DW.Acc 									= {}
	
	--Weaponskill Sets
	sets.precast.WS 										= {}

end

function job_post_midcast(spell, action, spellMap, eventArgs)

	-- Apply Obi
	if spell.skill == 'Elemental Magic' then 
		if spell.element == world.weather_element or spell.element == world.day_element then
			equip(sets.obi[spell.element])
		end
	end
	
	if spellMap == 'Cure' then
		if not (world.weather_element == 'Dark' or world.day_element == 'Dark') then
			equip(sets.obi[spell.element])
		end
	end
	
	-- dont swap grip if engaged
	if player.status ~= 'Engaged' and state.CastingMode.value == 'Resistant' then
		equip(sets.grip[spell.element])
	end
	
end

function job_midcast(spell, action, spellMap, eventArgs)
	
	if spell.skill == 'Enfeebling Magic' then
		equip(sets.midcast[spell.skill][spell.type])
	else 
		equip(sets.midcast[spell.skill])
    end
	
end

function job_state_change(stateField, newValue, oldValue)

	if stateField == 'Offense Mode' then
		if newValue == 'None' then
			enable('main', 'sub', 'range')
		else
			disable('main', 'sub', 'range')
		end
	end
	
end

function display_current_job_state(eventArgs)

	display_current_caster_state()
	eventArgs.handled = true
	
end
