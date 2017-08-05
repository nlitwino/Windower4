function get_sets()

	mote_include_version = 2
	include('organizer-lib.lua')
	include('Mote-Include.lua')
	
end

function job_setup()

	--state.MagicBurst = M(false, 'Magic Burst')
	
end

function user_setup()

	state.CastingMode:options('Normal', 'Resistant')
	
	send_command('bind f9 gs c cycle CastingMode')

end

function init_gear_sets()
	
	--Misc.
	sets.MND 												= {main="Chatoyant staff",sub="Bugard leather strap +1",head="Garrison sallet",neck="Holy phial",ear1="Mamool Ja earring",ear2="Star earring",body="Errant houppelande",hands="Bricta's cuffs",ring1="Tamas ring",ring2="Star ring",back="Prism cape",waist="Steppe rope",legs="Jet seraweels",feet="Garrison boots"}
	sets.INT 												= {main="Chatoyant staff",sub="Bugard leather strap +1",ammo="Phantom tathlum",head="Wizard's petasos",ear1="Abyssal earring",neck="Lemegeton medallion +1",body="Errant houppelande",hands="Garrison gloves",ring1="Tamas ring",ring2="Snow ring",back="Prism cape",waist="Sorcerer's belt",legs="Jet seraweels",feet="Sorcerer's sabots"}
	
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
	
	--Idle Sets
	sets.idle 												 = {head="Cait sith cap",neck="Chocobo whistle",ear1="Abyssal earring",ear2="Star earring",body="Dalmatica",hands="Sorcerer's gloves",ring1="Tamas ring",ring2="Star ring",back="Prism cape",waist="Lycopodium sash",legs="Jet seraweels",feet="Sorcerer's sabots"}
	sets.idle.Town											 = set_combine(sets.idle, {})
						 
	sets.Kiting 											 = {}
						 
	sets.resting 											 = set_combine(sets.idle,{main="Chatoyant staff",head="Oracle's cap",neck="Grandiose chain",hands="Oracle's gloves",body="Oracle's robe",ring2="Star ring",legs="Oracle's braconi",feet="Numerist pumps"})
						 
	--Precast Magic					 
	sets.precast.FC 										 = {feet="Wizard's sabots",waist="Sorcerer's belt",feet="Rostrum pumps"}
						 
	--Midcast Magic					 
	sets.midcast['Enhancing Magic']	    					 = {main="Seveneyes",sub="Genbu's shield"}
	sets.midcast['Enfeebling Magic'] 						 = {head="Sorcerer's petasos",neck="Enfeebling torque",body="Wizard's coat",hands="Oracle's gloves",legs="Igqira lappas",feet="Avocat pigaches"}
						 
	sets.midcast['Healing Magic'] 							 = set_combine(sets.MND, {neck="Healing torque"})
	sets.midcast['Divine Magic'] 							 = set_combine(sets.MND, {})
	
	sets.midcast['Enfeebling Magic']['WhiteMagic'] 			 = set_combine(sets.MND, sets.midcast['Enfeebling Magic'])
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Resistant = set_combine(sets.midcast['Enfeebling Magic']['WhiteMagic'], {})
	
	sets.midcast['Dark Magic'] 								 = set_combine(sets.INT, {neck="Dark torque",hands="Sorcerer's gloves",legs="Wizard's tonban"})
	sets.midcast['Dark Magic'].Resistant 					 = set_combine(sets.midcast['Dark Magic'], {})
	
	sets.midcast['Elemental Magic'] 						 = set_combine(sets.INT, {ear2="Moldavite earring",body="Igqira weskit",hands="Zenith mitts"})
	sets.midcast['Elemental Magic'].Resistant 				 = set_combine(sets.midcast['Elemental Magic'], {})
	
	sets.midcast['Enfeebling Magic']['BlackMagic'] 			 = set_combine(sets.INT, sets.midcast['Enfeebling Magic'])
	sets.midcast['Enfeebling Magic']['BlackMagic'].Resistant = set_combine(sets.midcast['Enfeebling Magic']['BlackMagic'], {})
	
	--sets.magic_burst								 		 = {hands="Sorcerer's Gloves"}
	
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Apply Obi
	if spell.skill == 'Elemental Magic' then 
		if spell.element == world.weather_element or spell.element == world.day_element then
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