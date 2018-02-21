function get_sets()
	--mote library settings
	mote_include_version = 2
	
	include('Mote-Include.lua')

end

function job_setup()

	-- kay library settings
	include('Kay-Include.lua')
	
	--initialize_job()
	sleeps = S{'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II', 'Bind'}
	
	casting_mode = ''
	
	gear.main = player.equipment.main
	gear.sub = player.equipment.sub
	
end

function user_setup()

	state.IdleMode:options('Normal','HNM','Combat')
	state.WeaponskillMode:options('Normal','HNM')
	state.CastingMode:options('Normal','Acc','TH','Combat')
		
	state.MagicBurst = M(false, 'Magic Burst')
	
	--bind combat mode cycles
	send_command('bind !f9 gs c toggle MagicBurst')
	send_command('bind !f10 gs c cycle IdleMode')
	
end

function init_gear_sets()

	--base sets
	sets.MND = {sub="Bugard leather strap +1",back="Prism cape",legs="Mahatma slops"}
	sets.INT = {main="Claustrum",sub="Bugard leather strap +1",ammo="Phantom tathlum"
			   ,head="Baron's chapeau",neck="Lemegeton medallion +1",ear1="Morion earring"
			   ,ring1="Snow ring",ring2="Snow ring"
			   ,back="Prism cape",waist="Sorcerer's belt",legs="Mahatma slops",feet="Sorcerer's sabots"}
	
	-- grips/obis
	sets.obi												 = {Fire 	  = {waist="Karin Obi"}
															   ,Earth  	  = {waist="Dorin Obi"}
															   ,Water	  = {waist="Suirin Obi"}
															   ,Wind 	  = {waist="Furin Obi"}
															   ,Ice 	  = {waist="Hyorin Obi"}
															   ,Lightning = {waist="Rairin Obi"}
															   ,Light  	  = {waist="Korin Obi"}
															   ,Dark 	  = {waist="Anrin Obi"}}
															 	   
	sets.grip												 = {Fire 	  = {sub="Fire Grip"}
															   ,Earth 	  = {sub="Earth Grip"}
															   ,Water 	  = {sub="Water Grip"}
															   ,Wind 	  = {sub="Wind Grip"}
															   ,Ice 	  = {sub="Ice Grip"}
															   ,Lightning = {sub="Lightning Grip"}
															   ,Light 	  = {sub="Light Grip"}
															   ,Dark 	  = {sub="Dark Grip"}}

	-- idle
	sets.idle = {head="Sorcerer's petasos",neck="Chocobo whistle",ear1="Morion earring",ear2="Crapaud earring"
				,body="Dalmatica",hands="Oracle's gloves",ring1="Snow ring",ring2="Snow ring"
				,back="Prism cape",waist="Sorcerer's belt",legs="Sorcerer's tonban",feet="Avocat pigaches"}
	sets.idle.HNM = set_combine(sets.idle,{}) --MDT/PDT set
	
	sets.idle.Town = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
	sets.idle.Town.HNM = set_combine(sets.idle.HNM,{ring2="Warp ring",back="Nexus cape"})
	
	sets.resting = {main="Claustrum",head="Oracle's cap",body="Oracle's robe",hands="Oracle's gloves",legs="Oracle's braconi",feet="Avocat pigaches"}
	
	-- precast magic
	sets.precast.FC = {} --loq/rostrum
	
	-- midcast magic
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{head="Walahra turban"})
	
	sets.midcast['Ninjutsu'] = set_combine(sets.midcast.FastRecast,{waist="Sorcerer's belt"})
	sets.midcast['Utsusemi: Ichi'] = set_combine(sets.midcast.FastRecast,{waist="Sorcerer's belt"})
	sets.midcast['Utsusemi: Ni'] = set_combine(sets.midcast.FastRecast,{waist="Sorcerer's belt"})
	
	sets.midcast['Healing Magic'] = set_combine(sets.midcast.FastRecast,sets.MND,{})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.FastRecast,sets.MND,{})
	
	sets.midcast['Enfeebling Magic'] = {head="Sorcerer's petasos",hands="Oracle's gloves",feet="Avocat pigaches"} -- just skill
	
	sets.midcast['Enfeebling Magic']['BlackMagic'] = set_combine(sets.midcast.FastRecast,sets.INT,{})
	sets.midcast['Enfeebling Magic']['BlackMagic'].Acc = set_combine(sets.midcast['Enfeebling Magic']['BlackMagic'],sets.midcast['Enfeebling Magic'])
	
	sets.midcast['Enfeebling Magic']['WhiteMagic'] = set_combine(sets.midcast.FastRecast,sets.MND,{})
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Acc = set_combine(sets.midcast['Enfeebling Magic']['WhiteMagic'],sets.midcast['Enfeebling Magic'])
	
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.FastRecast,sets.INT,{head="Sorcerer's petasos",ear1="Crapaud earring",ear2="Moldavite earring",body="Genie weskit",hands="Zenith mitts"})
	sets.midcast['Elemental Magic'].Acc = set_combine(sets.midcast['Elemental Magic'],{hands="Wizard's gloves"})
	
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.FastRecast,sets.INT,{hands="Sorcerer's gloves"})
	
	sets.midcast['Enhancing Magic'] = {}
	
	-- custom midcast magic
	sets.midcast['Stoneskin'] = set_combine(sets.midcast.FastRecast,sets.MND,{})
	
	sets.midcast.Sleep = set_combine(sets.midcast['Enfeebling Magic']['BlackMagic'].Acc,{})
	
	sets.midcast['Stun'] = set_combine(sets.midcast['Dark Magic'],{})
	
end

function job_midcast(spell,action,spellMap,eventArgs)

	if spell.skill == 'Enfeebling Magic' then
		equip(sets.midcast[spell.skill][spell.type])
	else 
		equip(sets.midcast[spell.skill])
    end

end

function job_post_midcast(spell,action,spellMap,eventArgs)

	if spell.skill == 'Elemental Magic' then
		if spell.element == world.weather_element and spell.element == world.day_element then
			equip(set_combine(sets.obi[spell.element],{legs="Sorcerer's tonban"})) --main="Chatoyant staff"
		elseif spell.element == world.day_element then
			equip(set_combine(sets.obi[spell.element],{main="Claustrum",legs="Sorcerer's tonban"}))
		elseif spell.element == world.weather_element then
			equip(set_combine(sets.obi[spell.element],{})) --main="Chatoyant staff"
		end
		if state.CastingMode.value == 'TH' then
			equip({main="Lotus Katana"})
		end
	end
	
	if spellMap == 'Cure' then
		if not (world.weather_element == 'Dark' or world.day_element == 'Dark') then
			equip(set_combine(sets.obi[spell.element]))
		end
	end
		
	if state.MagicBurst.value then
		equip(sets.magic_burst)
	end

	if state.CastingMode.value == 'Acc' then
		if player.status ~= 'Engaged' then
			equip(sets.grip[spell.element])
		end
	end

end

function job_get_spell_map(spell, default_spell_map)

    if spell.skill == 'Enfeebling Magic' and sleeps:contains(spell.english) then
		return 'Sleep'
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

function job_aftercast(spell,action,spellMap,eventArgs)

	if spell.skill == 'Elemental Magic' then
		state.MagicBurst:reset()
	end
	
end