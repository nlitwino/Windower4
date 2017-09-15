function get_sets()

	--mote library settings
	mote_include_version = 2
	
	include('Mote-Include.lua')
	
end

function job_setup()

	--kay library settings
	include('Kay-Include.lua')
	
	initialize_job()
	
end

function user_setup()

	--combat modes
	state.CastingMode:options('Normal','Accuracy','Hybrid','TH')
	
	state.MagicBurst = M(false, 'Magic Burst')
	
	--bind combat mode cycles
	send_command('bind !f9 gs c toggle MagicBurst')
	
end

function init_gear_sets()

	--misc.
	sets.lowHP 												= {hands="Zenith mitts",ring1="Ether ring",ring2="Serket ring"}

	--grips/obis														   
	sets.grip 												= {Fire 	 = {sub="Fire Grip"}
															  ,Earth 	 = {sub="Earth Grip"}
															  ,Water 	 = {sub="Water Grip"}
															  ,Wind 	 = {sub="Wind Grip"}
															  ,Ice 		 = {sub="Ice Grip"}
															  ,Lightning = {sub="Thunder Grip"}
															  ,Light 	 = {sub="Light Grip"}
															  ,Dark 	 = {sub="Dark Grip"}}
	
	--idle
	sets.idle 												= {                        sub="Bugard leather strap +1"                        ,ammo="Bibiki seashell"
															  ,head="Wizard's petasos",neck="Chocobo whistle"       ,ear1="Merman's earring",ear2="Merman's earring"
															  ,body="Dalmatica"       ,hands="Oracle's gloves"      ,ring1="Defending ring" ,ring2="Merman's ring"
															  ,back="Shadow mantle"   ,waist="Lycopodium sash"      ,legs="Igqira lappas"   ,feet="Herald's gaiters"}
															  
	sets.idle.Town 											= set_combine(sets.idle,{back="Nexus cape",ring2="Warp ring"})
	
	sets.resting 											= {main="Claustrum"                                                    ,ammo="Bibiki seashell"
															  ,head="Oracle's cap" ,neck="Gnole torque"    ,ear1="Relaxing earring",ear2="Magnetic earring"
															  ,body="Oracle's robe",hands="Oracle's gloves"                        ,ring2=""
															                                               ,legs="Oracle's braconi",feet="Avocat pigaches"}
	--precast magic
	sets.precast.FC 										= {ear2="Loquacious earring",feet="Rostrum pumps"}
	sets.precast.FastRecast 								= {head="Walahra turban"}
	
	--midcast magic
	sets.MND 												= {                          sub="Bugard leather strap +1" 
															  ,head="Maat's cap"        ,neck="Gnole torque"          ,ear1="Mamool Ja earring",ear2="Static earring"
															  ,body="Errant houppelande",hands="Bricta's cuffs"       ,ring1="Tamas ring"      
															  ,back="Prism cape"                                      ,legs="Mahatma slops"    ,feet="Rostrum pumps"}
															   
	sets.INT 												= {                          sub="Bugard leather strap +1"                       ,ammo="Phantom tathlum"
															  ,head="Maat's cap"        ,neck="Lemegeton medallion +1",ear1="Abyssal earring",ear2="Morion earring +1"
															  ,body="Errant houppelande",hands="Errant cuffs"         ,ring1="Tamas ring"    ,ring2="Snow ring"
															  ,back="Prism cape"        ,waist="Sorcerer's belt"      ,legs="Mahatma slops"  ,feet="Rostrum pumps"}
	
	sets.midcast['Healing Magic'] 							= set_combine(sets.MND,{})
	sets.midcast['Divine Magic'] 							= set_combine(sets.MND,{})
	
	sets.midcast['Enfeebling Magic']      					= {head="Sorcerer's petasos",body="Wizard's coat",legs="Igqira lappas",feet="Avocat pigaches"}
	
	sets.midcast['Enfeebling Magic']['BlackMagic']          = set_combine(sets.INT,{})
	sets.midcast['Enfeebling Magic']['BlackMagic'].Accuracy = set_combine(sets.INT,sets.midcast['Enfeebling Magic'],{hands="Bricta's cuffs"})
	sets.midcast['Enfeebling Magic']['BlackMagic'].Hybrid   = set_combine(sets.INT,{head="Sorcerer's petasos",legs="Avocat pigaches"})
	
	sets.midcast['Enfeebling Magic']['WhiteMagic']          = set_combine(sets.MND,{})
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Accuracy = set_combine(sets.MND,sets.midcast['Enfeebling Magic'])
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Hybrid   = set_combine(sets.MND,{head="Sorcerer's petasos",legs="Avocat pigaches"})
	
	sets.midcast['Elemental Magic']            				= set_combine(sets.INT,{ear2="Moldavite earring",body="Oracle's robe",hands="Zenith mitts",feet="Sorcerer's sabots"})
	sets.midcast['Elemental Magic'].Accuracy 				= set_combine(sets.INT,{head="Sorcerer's petasos",body="Oracle's robe",hands="Wizard's gloves"})
	sets.midcast['Elemental Magic'].Hybrid 					= set_combine(sets.INT,{back="Hecate's cape",feet="Numerist pumps"})
	
	sets.midcast['Dark Magic'] 								= set_combine(sets.INT,{neck="Dark torque",hands="Sorcerer's gloves",legs="Wizard's tonban",feet="Igqira huaraches"})
	
	sets.midcast['Enhancing magic']							= set_combine(sets.MND,sets.precast.FastRecast,{ear2="Magnetic earring",waist="Sorcerer's belt",feet="Igqira huaraches"})
	
	--magic burst
	sets.magic_burst 										= {hands="Sorcerer's gloves",ear1="Static earring"}
	
end

function job_midcast(spell,action,spellMap,eventArgs)

	-- handle different equipsets for White and Black magic
	if spell.skill == 'Enfeebling Magic' then
		equip(sets.midcast[spell.skill][spell.type])
	else 
		equip(sets.midcast[spell.skill])
    end
	
end

function job_post_midcast(spell,action,spellMap,eventArgs)

	if spell.skill == 'Elemental Magic' then
		if spell.element == world.weather_element and spell.element == world.day_element then
			equip({waist="Hachirin-no-obi",main="Chatoyant staff",legs="Sorcerer's tonban"})
		elseif spell.element == world.day_element then
			equip({waist="Hachirin-no-obi",main="Claustrum",legs="Sorcerer's tonban"})
		elseif spell.element == world.weather_element then
			equip({waist="Hachirin-no-obi",main="Chatoyant staff"})
		end
		if state.CastingMode.value == 'TH' then
			equip({main="Lotus Katana"})
		end
	end
	
	if spellMap == 'Cure' then
		if not (world.weather_element == 'Dark' or world.day_element == 'Dark') then
			equip({waist="Hachirin-no-obi"})
		end
	end
		
	if state.MagicBurst.value then
		equip(sets.magic_burst)
	end

	if state.CastingMode.value == 'Accuracy' then
		if player.status ~= 'Engaged' then
			equip(sets.grip[spell.element])
		end
	end

end

function job_aftercast(spell,action,spellMap,eventArgs)

	if spell.skill == 'Elemental Magic' then
		state.MagicBurst:reset()
	end
	
end