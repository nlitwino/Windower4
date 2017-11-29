function get_sets()
	
	mote_include_version = 2
	include('Mote-Include.lua')
	
end

function job_setup()
		
		state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
								  buffactive['Aftermath: Lv.2'] or
								  buffactive['Aftermath: Lv.3'] or
								  false
								  
		state.Buff['Dark Seal'] = buffactive['Dark Seal'] or false
		
		absorbs = S{'Absorb-STR', 'Absorb-DEX', 'Absorb-VIT', 'Absorb-AGI', 'Absorb-INT', 'Absorb-MND', 'Absorb-CHR', 'Absorb-Attri', 'Absorb-ACC'}
		sleeps = S{'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II', 'Bind'}
		
		include('Kay-Include.lua')
		
		initialize_job()
		
end

function user_setup()

	state.OffenseMode:options('Normal','Acc','Tank')
	state.WeaponskillMode:options('Normal','HNM')
	state.CastingMode:options('Normal','Acc')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	
end

function init_gear_sets()

	--misc.
	sets.INT                             = {ammo="Phantom tathlum"
			                               ,head="Maat's cap"        ,neck="Lemegeton medallion",ear1="Abyssal earring",ear2="Morion earring +1"
			                               ,body="Crimson scale mail",hands="Abyss gauntlets"   ,ring1="Snow ring"     ,ring2="Omega ring"
			                                                         ,waist="Ocean stone"       ,legs="Jet seraweels" }
	
	sets.enmityUp                        = {head="Aegishjalmr"         ,neck="Ritter gorget"   ,ear1="Hades earring +1"
	                                       ,body="Valhalla breastplate",hands="Homam manopolas"				           ,ring2="Corneus ring"
					                       ,back="Cerberus mantle +1"  ,waist="Trance belt"}
	sets.enmityDown                      = {ammo="White tathlum"
					                       ,head="Zha'Go's barbut",ear1="Novia earring"
					                     						  ,hands="Heavy gauntlets"                      ,ring2="Veela ring"
					                     						  ,waist="Buccaneer's belt",legs="Jet seraweels"}
	
	-- precast ja
	sets.precast.JA                      = {}
	
	sets.precast.JA['Last Resort']       = {feet="Abyss sollerets"}
	sets.precast.JA['Arcane Circle']     = {feet="Chaos sollerets"}
	sets.precast.JA['Weapon Bash']       = {hands="Chaos gauntlets"}
	
	-- precast magic
	sets.precast.FC                      = {ear2="Loquacious earring",legs="Homam cosciales"}
	
	-- midcast magic
	sets.midcast.FastRecast              = set_combine(sets.precast.FC,{head="Walahra turban",body=gear.HasteHarness,hands="Dusk gloves +1",waist="Velocious belt",feet="Dusk ledelsens +1"})
	
	sets.midcast['Utsusemi: Ni']         = set_combine(sets.midcast.FastRecast,{neck="Fortified chain",ear1="Novia earring",ring1="Defending ring",back="Shadow mantle"})
	sets.midcast['Utsusemi: Ichi']       = set_combine(sets.midcast['Utsusemi: Ni'],{waist="Resolute belt"})
	
	sets.midcast['Dark Magic']           = set_combine(sets.midcast.FastRecast,{ammo="Sturm's report"
										           							   ,head="Chaos burgeonet",neck="Dark torque"            ,ear1="Abyssal earring"
										           							   ,body="Demon's harness",hands="Blood finger gauntlets",ring1="Snow ring"     ,ring2="Omega ring"
										           							   ,back="Abyss cape" 								     ,legs="Abyss flanchard"})
	sets.midcast['Dark Magic'].Acc       = set_combine(sets.midcast['Dark Magic'],{body="Corselet"})
	
	sets.midcast['Elemental Magic']      = set_combine(sets.INT,{ear2="Moldavite earring",body="Abyss cuirass",hands="Vicious mufflers"})
	sets.midcast['Elemental Magic'].Acc  = set_combine(sets.midcast['Elemental Magic'],{ammo="Sturm's report",body="Corselet"})
	
	sets.midcast['Enfeebling Magic']     = set_combine(sets.INT,sets.midcast.FastRecast,{ammo="Sturm's report",back="Abyss cape"})
	sets.midcast['Enfeebling Magic'].Acc = set_combine(sets.midcast['Enfeebling Magic'],{head="Crimson mask",neck="Spider torque",body="Chaos cuirass",feet="Abyss sollerets"})
	
	sets.midcast.Absorb 				 = set_combine(sets.midcast['Dark Magic'].Acc,{hands="Vicious mufflers",legs="Onyx cuisses"})
	sets.midcast.Sleep  				 = set_combine(sets.midcast['Enfeebling Magic'].Acc,{body="Corselet"})
	                                     
	sets.midcast['Stun']                 = set_combine(sets.midcast['Dark Magic'].Acc,{head="Homam zucchetto"})
	sets.midcast['Dread Spikes']         = set_combine(sets.midcast['Dark Magic'],sets.midcast.FastRecast,{back="Shadow mantle"})
	                                     
	-- idle                              
	sets.idle                            = {ammo="Bibiki seashell"
				                           ,head="Valhalla helm"       ,neck="Chocobo whistle" ,ear1="Merman's earring",ear2="Ethereal earring"
				                           ,body="Valhalla breastplate",hands="Heavy gauntlets",ring1="Defending ring" ,ring2="Shadow ring"
				                           ,back="Shadow mantle"       ,waist="Resolute belt"  ,legs="Blood cuisses"   ,feet="Homam gambieras"}
	sets.idle.Town                       = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
	sets.resting                         = {ammo="Bibiki seashell",head="Crimson mask",ear1="Relaxing earring",ring2="Star ring"}
	                                     
	-- defense                           
	sets.defense.PDT                     = {ammo="Bibiki seashell"
					                       ,head="Valhalla helm"       ,neck="Wivre gorget"    ,ear1="Hades earring +1"
					                       ,body="Valhalla breastplate",hands="Heavy gauntlets",ring1="Defending ring"      ,ring2="Jelly ring"
					                       ,back="Shadow mantle"       ,waist="Warwolf belt"   ,legs="Darksteel subligar +1",feet="Dusk ledelsens +1"}
	sets.defense.MDT                     = {head="Valhalla helm"       ,neck="Gnole torque"  ,ear1="Star earring"
					                       ,body="Valhalla breastplate"                      ,ring1="Defending ring",ring2="Shadow ring"
					                                                   ,waist="Resolute belt",legs="Abyss flanchard"}
	                                     
	-- default engaged                   
	sets.engaged                         = {ammo="Bomb core"
				                           ,head="Walahra turban"    ,neck="Chivalrous chain",ear1="Ehereal earring",ear2="Brutal earring"
				                           ,body="Armada hauberk"    ,hands="Dusk gloves +1" ,ring1=gear.TRing1     ,ring2=gear.TRing2
				                           ,back="Cerberus mantle +1",waist="Velocious belt" ,legs="Homam cosciales",feet="Dusk ledelsens +1"}
	sets.engaged.Acc 	                 = set_combine(sets.engaged,{ammo="Fire bomblet",neck="Ancient torque",ear1="Fowling earring",back="Cuchulain's mantle",feet="Homam gambieras"})
	sets.engaged.Tank                    = set_combine(sets.engaged.Acc,{ring1="Defending ring",back="Shadow mantle"})
	                                     
	-- apoc engaged (no sam)             
	sets.engaged.Apocalypse              = {ammo="Bomb core"
								           ,head="Walahra turban"    ,neck="Chivalrous chain",ear1="Abyssal earring",ear2="Brutal earring"
								           ,body="Armada hauberk"    ,hands="Dusk gloves +1" ,ring1=gear.TRing1     ,ring2=gear.TRing2
								           ,back="Cerberus mantle +1",waist="Velocious belt" ,legs="Homam cosciales",feet="Dusk ledelsens +1"}
	sets.engaged.Apocalypse.Acc          = set_combine(sets.engaged.Apocalypse,{ammo="Fire bomblet",neck="Ancient torque",hands="Homam manopolas",back="Cuchulain's mantle",feet="Homam gambieras"})
	sets.engaged.Apocalypse.Tank         = set_combine(sets.engaged.Apocalypse.Acc,{ammo="Bibiki seashell",ear2="Ethereal earring",ring1="Defending ring",back="Shadow mantle"})
	                                     
	sets.engaged.Apocalypse.AM           = set_combine(sets.engaged.Apocalypse,{hands="Tarasque mitts +1",legs="Onyx cuisses"})
	sets.engaged.Apocalypse.Acc.AM       = set_combine(sets.engaged.Apocalypse.Acc,{hands="Tarasque mitts +1",legs="Armada Breeches",feet="Aurum sabatons"})
	sets.engaged.Apocalypse.Tank.AM      = set_combine(sets.engaged.Apocalypse.Tank,{body="Valhalla breastplate"})
	                                     
	-- apoc engaged (sam)                
	sets.engaged.Apocalypse.SAM          = {ammo="White tathlum"
								           ,head="Walahra turban"    ,neck="Almah torque"   ,ear1="Abyssal earring",ear2="Brutal earring"
								           ,body="Aurum cuirass"     ,hands="Dusk gloves +1",ring1=gear.TRing1     ,ring2=gear.TRing2
								           ,back="Cerberus mantle +1",waist="Velocious belt",legs="Homam cosciales",feet="Dusk ledelsens +1"}
	sets.engaged.Apocalypse.Acc.SAM 	 = set_combine(sets.engaged.Apocalypse.SAM,{hands="Homam manopolas",back="Cuchulain's mantle",feet="Homam gambieras"})
	sets.engaged.Apocalypse.Tank.SAM 	 = set_combine(sets.engaged.Apocalypse.Acc.SAM,{ear2="Ethereal earring",ring1="Defending ring",back="Shadow mantle"})
	                                     
	sets.engaged.Apocalypse.SAM.AM 		 = set_combine(sets.engaged.Apocalypse.SAM,{hands="Tarasque mitts +1",legs="Onyx cuisses"})
	sets.engaged.Apocalypse.Acc.SAM.AM 	 = set_combine(sets.engaged.Apocalypse.Acc.SAM,{hands="Tarasque mitts +1",legs="Armada Breeches",feet="Aurum sabatons"})
	sets.engaged.Apocalypse.Tank.SAM.AM  = set_combine(sets.engaged.Apocalypse.Tank.SAM,{body="Valhalla breastplate"})
	                                     
	-- rag engaged (no sam)              
	sets.engaged.Ragnarok                = {ammo="Bomb core"
							               ,head="Walahra turban"    ,neck="Chivalrous chain",ear1="Ethereal earring",ear2="Brutal earring"
							               ,body="Armada hauberk"    ,hands="Dusk gloves +1" ,ring1=gear.TRing1      ,ring2=gear.TRing2
							               ,back="Cerberus mantle +1",waist="Velocious belt" ,legs="Homam cosciales" ,feet="Dusk ledelsens +1"}
	sets.engaged.Ragnarok.Acc            = set_combine(sets.engaged.Ragnarok,{neck="Ancient torque",ear1="Fowling earring",hands="Homam manopolas",back="Cuchulain's mantle",feet="Homam gambieras"})
	                                     
	-- rag engaged (sam)                 
	sets.engaged.Ragnarok.SAM            = {ammo="White tathlum"
							               ,head="Walahra turban"    ,neck="Chivalrous chain",ear1="Ethereal earring",ear2="Brutal earring"
							               ,body="Armada hauberk"    ,hands="Dusk gloves +1" ,ring1=gear.TRing1      ,ring2=gear.TRing2
							               ,back="Cerberus mantle +1",waist="Velocious belt" ,legs="Homam cosciales" ,feet="Dusk ledelsens +1"}
	sets.engaged.Ragnarok.Acc.SAM        = set_combine(sets.engaged.Ragnarok,{neck="Ancient torque",ear1="Attila's earring",hands="Homam manopolas",back="Cuchulain's mantle",feet="Homam gambieras"})
	                                     
	-- zerg engaged                      
	sets.engaged.Zerg                    = {ammo="White tathlum"
						                   ,head="Walahra turban"   ,neck="Ritter gorget"  ,ear1="Bloodbead earring",ear2="Cassie earring"
						                   ,body="Gloom breastplate",hands="Dusk gloves +1",ring1="Bomb queen ring" ,ring2="Bloodbead ring"
						                   ,back="Gigant mantle"    ,waist="Velocious belt",legs="Homam cosciales"  ,feet="Homam gambieras"}
	-- default ws                        
	sets.precast.WS                      = {ammo="Bomb core"
					                       ,head="Hecatomb cap +1",neck="Fotia gorget",ear1="Triumph earring",ear2="Brutal earring"
					                       ,body="Armada hauberk",hands="Alkyoneus's bracelets",ring1="Rajas ring",ring2="Strigoi ring"
					                       ,back="Cerberus mantle +1",waist="Warwolf belt",legs="Onyx cuisses",feet="Hecatomb leggings +1"}
	sets.precast.WS.HNM                  = set_combine(sets.precast.WS,{ammo="Fire bomblet",ear1="Fowling earring",hands="Hecatomb mittens +1"})
	                                     
	-- ws scythe                         
	sets.precast.WS['Guillotine']        = set_combine(sets.precast.WS,{ear1="Abyssal earring"})
	sets.precast.WS['Guillotine'].HNM    = set_combine(sets.precast.WS['Guillotine'],{ammo="Fire bomblet",back="Cuchulain's mantle",hands="Hecatomb mittens +1"})
	                                     
	sets.precast.WS['Entropy']           = set_combine(sets.precast.WS['Guillotine'],{})
	sets.precast.WS['Entropy'].HNM       = set_combine(sets.precast.WS['Guillotine'].HNM,{})
	                                     
	sets.precast.WS['Catastrophe']       = set_combine(sets.precast.WS,{ear1="Abyssal earring"})
	sets.precast.WS['Catastrophe'].HNM   = set_combine(sets.precast.WS['Catastrophe'],{ammo="Fire bomblet"})

end

function job_post_precast(spell,action,spellMap,eventArgs)

	if spell.type == 'WeaponSkill' and daytime then
		if (state.WeaponskillMode.value == 'Normal' and state.CombatWeapon.value == 'Apocalypse') or state.CombatWeapon.value == 'Ragnarok' then
			equip({ear1="Fenrir's earring"})
		end
	end
	if spell.type == 'JobAbility' then
		if state.Tank.value then
			equip(set_combine(sets.enmityUp,sets.precast.JA[spell.english]) or sets.enmityUp)
		else
			equip(set_combine(sets.enmityDown,sets.precast.JA[spell.english]) or sets.enmityDown)
		end
	end
	
end

function job_buff_change(name,gain)

	sleep_swap(name,gain)
	
	if name:startswith('Aftermath') and player.equipment.main == 'Apocalypse' then
		if gain then
			add_to_chat("Equipping AM Up set.")
		else
			add_to_chat("Equipping AM Down set.")
		end
		adjust_melee_groups()
		handle_equipping_gear(player.status)
    end

end

function job_post_midcast(spell,action,spellMap,eventArgs)

	if spell.skill == 'Elemental Magic' or (spell.name == 'Drain' or spell.name == 'Drain II' or spell.name == 'Aspir') then
		if spell.element == world.day_element or spell.element == world.weather_element then
			equip({waist="Hachirin-no-obi"})
		end
	end
	
	if spell.skill == 'Dark Magic' and state.Buff['Dark Seal'] and state.CastingMode.value == 'Acc' then
		equip(sets.midcast['Dark Magic'])
	end

end

function job_get_spell_map(spell, default_spell_map)

    if spell.skill == 'Dark Magic' and absorbs:contains(spell.english) then
        return 'Absorb'
	elseif spell.skill == 'Enfeebling Magic' and sleeps:contains(spell.english) then
		return 'Sleep'
    end
	
end

function customize_idle_set(idleSet)
	if daytime then
		idleSet = set_combine(idleSet,{hands="Garden bangles",waist="Lycopodium sash"})
	end
	
    if player.mpp < 50 and player.hpp >= 85 then
        idleSet = set_combine(idleSet,{neck="Parade gorget"})
    end
    if player.hpp < 75 then
        idleSet = set_combine(idleSet,{head="Crimson mask",neck="Orochi nodowa"})
    end
    return idleSet
end

function adjust_melee_groups()

	classes.CustomMeleeGroups:clear()
	if player.sub_job == 'SAM' then
		classes.CustomMeleeGroups:append('SAM')
	end
	if state.Buff.Aftermath then
		classes.CustomMeleeGroups:append('AM')
	end
	
end

function customize_melee_set(meleeSet)

	if state.OffenseMode.value == 'Normal' and daytime then
        meleeSet = set_combine(meleeSet, {ear1="Fenrir's earring"})
    end

    return meleeSet
	
end

function job_status_change(new,old)

	if new == "Engaged" then
	
		if player.equipment.main == 'Apocalypse' or player.equipment.main == 'Ragnarok' then
            state.CombatWeapon:set(player.equipment.main)
        elseif player.equipment.main == 'Kraken Club' or 'Mercurial Kris' then
            state.CombatWeapon:set('Zerg')
		else
            state.CombatWeapon:reset()
        end
		adjust_melee_groups()
	end
	
end