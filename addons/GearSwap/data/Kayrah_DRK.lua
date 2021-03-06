function get_sets()

  mote_include_version = 2
  include('Mote-Include.lua')
  include('organizer-lib')

end

function job_setup()

  include('Kay-Include.lua')

  state.Buff['Dark Seal'] = buffactive['Dark Seal'] or false

  absorbs = S{'Absorb-STR', 'Absorb-DEX', 'Absorb-VIT', 'Absorb-AGI', 'Absorb-INT', 'Absorb-MND', 'Absorb-CHR', 'Absorb-Attri', 'Absorb-ACC'}
  sleeps = S{'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II', 'Bind'}
  
  scythe_singlehit = S{'Slice','Dark Harvest','Shadow of Death','Nightmare Scythe','Spinning Scythe','Vorpal Scythe','Spiral Hell','Catastrophe'}
  gs_singlehit = S{'Hard Slash','Power Slash','Frostbite','Freezebite','Shockwave','Crescent Moon','Spinning Slash','Ground Strike','Scourge'}

  casting_mode = ''

  initialize_job()

end

function user_setup()

  state.OffenseMode:options('Normal','HybridAcc','Tank')
  state.WeaponskillMode:options('Normal','MOD','ACC','ATSMOD','ATSACC','MODACC')
  state.CastingMode:options('Normal','Acc')
  state.PhysicalDefenseMode:options('PDT')
  state.MagicalDefenseMode:options('MDT')

end

function init_gear_sets()

  --misc.
  sets.INT
   = {ammo="Phantom tathlum"
     ,head="Maat's cap"        
     ,neck="Lemegeton medallion +1"
     ,ear1="Abyssal earring"
     ,ear2="Morion earring +1"
     ,body="Crimson scale mail"
     ,hands="Abyss gauntlets"   
     ,ring1="Snow ring"     
     ,ring2="Omega ring"
     ,waist="Ocean stone"       
     ,legs="Jet seraweels"}

  sets.enmityUp                       
   = {head="Aegishjalmr"         
     ,neck="Ritter gorget"   
     ,ear1="Hades earring +1"
     ,body="Valhalla breastplate"
     ,hands="Hydra moufles"         
     ,ring2="Corneus ring"
     ,back="Cerberus mantle +1"  
     ,waist="Trance belt"
     ,legs="Hydra brayettes"}
     
  sets.enmityDown                     
   = {ammo="White tathlum"
     ,head="Zha'Go's barbut"
     ,ear1="Novia earring"
     ,hands="Heavy gauntlets"                      
     ,ring2="Veela ring"
     ,waist="Buccaneer's belt"
     ,legs="Jet seraweels"}

  --precast ja
  sets.precast.JA['Last Resort']      
   = {feet="Abyss sollerets"}
   
  sets.precast.JA['Arcane Circle'] 
   = {feet="Chaos sollerets"}
   
  sets.precast.JA['Weapon Bash']      
   = {hands="Chaos gauntlets"}

  --precast magic
  sets.precast.FC                     
   = {ear2="Loquacious earring"
     ,legs="Homam cosciales"}

  --midcast magic
  sets.midcast.FastRecast             
   = set_combine(sets.precast.FC
                ,{head="Walahra turban"
                 ,body=scorpion_harness['Haste']
                 ,hands="Dusk gloves +1"
                 ,waist="Ninurta's sash"
                 ,feet="Homam gambieras"})

  sets.midcast['Utsusemi: Ni']
   = set_combine(sets.midcast.FastRecast
                ,{neck="Fortified chain"
                 ,ear1="Novia earring"
                 ,ear2="Ethereal earring"
                 ,ring1="Defending ring"
                 ,back="Shadow mantle"})
                 
  sets.midcast['Utsusemi: Ichi']
   = set_combine(sets.midcast['Utsusemi: Ni']
                ,{waist="Ninurta's sash"})

  sets.midcast['Dark Magic']
   = set_combine(sets.INT
                ,sets.midcast.FastRecast
                ,{ammo="Sturm's report"
                 ,head="Chaos burgeonet"
                 ,neck="Dark torque"            
                 ,ear1="Abyssal earring"
                 ,ear2="Loquacious earring"
                 ,body="Demon's harness"
                 ,hands="Blood finger gauntlets"	
                 ,back="Merciful cape"							     
                 ,legs="Abyss flanchard"})
                 
  sets.midcast['Dark Magic'].Acc      
   = set_combine(sets.midcast['Dark Magic']
                ,{body="Corselet"
                ,back="Abyss cape"})

  sets.midcast['Elemental Magic']
   = set_combine(sets.INT
                ,{ear2="Moldavite earring"
                 ,body="Abyss cuirass"
                 ,hands="Vicious mufflers"})
   
  sets.midcast['Elemental Magic'].Acc
   = set_combine(sets.midcast['Elemental Magic']
                ,{ammo="Sturm's report"
                 ,body="Corselet"})

  sets.midcast['Enfeebling Magic']    
   = set_combine(sets.INT
                ,sets.midcast.FastRecast
                ,{ammo="Sturm's report"
                 ,back="Abyss cape"})
                 
  sets.midcast['Enfeebling Magic'].Acc
   = set_combine(sets.midcast['Enfeebling Magic']
                ,{head="Crimson mask"
                 ,neck="Spider torque"
                 ,body="Chaos cuirass"
                 ,feet="Abyss sollerets"})

  sets.midcast.Absorb 				
   = set_combine(sets.midcast['Dark Magic'].Acc
                ,{hands="Vicious mufflers"
                 ,legs="Onyx cuisses"
                 ,feet="Onyz sollerets"})
                 
  sets.midcast.Sleep  				
   = set_combine(sets.midcast['Enfeebling Magic'].Acc
                ,{body="Corselet"})

  sets.midcast['Stun']                
   = set_combine(sets.midcast['Dark Magic'].Acc
                ,{head="Homam zucchetto"
                 ,hands="Dusk gloves +1"
                 ,legs="Homam cosciales"})
                 
  sets.midcast['Dread Spikes']        
   = set_combine(sets.midcast.FastRecast
                ,{ammo="Fenrir's stone"
                 ,neck="Bloodbead gorget"
                 ,ear1="Bloodbead earring"
                 ,ear2="Crimson earring"
                 ,ring1="Bomb queen ring"
                 ,ring2="Bloodbead ring"
                 ,back="Gigant mantle"})

  --idle
  sets.idle                            
   = {ammo="Bibiki seashell"
     ,head="Valhalla helm"       
     ,neck="Chocobo whistle" 
     ,ear1="Merman's earring"
     ,ear2="Ethereal earring"
     ,body="Valhalla breastplate"
     ,hands="Heavy gauntlets"
     ,ring1="Defending ring" 
     ,ring2="Shadow ring"
     ,back="Shadow mantle"       
     ,waist="Resolute belt"  
     ,legs="Blood cuisses"   
     ,feet="Homam gambieras"}
     
  sets.idle.Town
   = set_combine(sets.idle
                ,{neck="Orochi nodowa +1"
                 ,ring2="Warp ring"
                 ,back="Nexus cape"
                 ,waist="Ninurta's sash"})
  sets.resting                        
   = {ammo="Bibiki seashell"
     ,head="Crimson mask"
     ,ear1="Relaxing earring"
     ,ring2="Star ring"}

  --defense
  sets.defense.PDT
   = {ammo="Bibiki seashell"
     ,head="Valhalla helm"
     ,neck="Wivre gorget +1"    
     ,ear1="Hades earring +1"
     ,body="Valhalla breastplate"
     ,hands="Heavy gauntlets"
     ,ring1="Defending ring"      
     ,ring2="Jelly ring"
     ,back="Shadow mantle"       
     ,waist="Warwolf belt"   
     ,legs="Darksteel subligar +1"
     ,feet="Dusk ledelsens +1"}
     
  sets.defense.MDT                    
   = {head="Valhalla helm"       
     ,neck="Gnole torque"  
     ,ear1="Star earring"
     ,body="Valhalla breastplate"                      
     ,ring1="Defending ring"
     ,ring2="Shadow ring"
     ,waist="Resolute belt"
     ,legs="Abyss flanchard"}

  --default engaged
  sets.engaged
   = {ammo="Bomb core"
     ,head="Walahra turban"    
     ,neck="Chivalrous chain"
     ,ear1="Ethereal earring"
     ,ear2="Brutal earring"
     ,body="Armada hauberk"    
     ,hands="Dusk gloves +1" 
     ,ring1=toreador_ring['Triple Attack (2)']  
     ,ring2=toreador_ring['Triple Attack (1)']
     ,back="Cerberus mantle +1"
     ,waist="Ninurta's sash"
     ,legs="Homam cosciales"
     ,feet="Dusk ledelsens +1"}
     
  sets.engaged.HybridAcc 	                
   = set_combine(sets.engaged
                ,{ammo="Fire bomblet"
                 ,neck="Ancient torque"
                 ,ear1="Fowling earring"
                 ,back="Cuchulain's mantle"
                 ,feet="Homam gambieras"})
                
  sets.engaged.Tank                   
   = set_combine(sets.engaged.HybridAcc
                ,{ring1="Defending ring"
                 ,back="Shadow mantle"})

  --apoc engaged ROSE STRAP
  sets.engaged.Apocalypse
   = {ammo="Bomb core"
     ,head="Walahra turban"    
     ,neck="Justice torque"
     ,ear1="Abyssal earring"
     ,ear2="Brutal earring"
     ,body="Armada hauberk"    
     ,hands="Dusk gloves +1" 
     ,ring1=toreador_ring['Triple Attack (2)']  
     ,ring2=toreador_ring['Triple Attack (1)']
     ,back="Cerberus mantle +1"
     ,waist="Ninurta's sash"
     ,legs="Homam cosciales"
     ,feet="Dusk ledelsens +1"}
     
  sets.engaged.Apocalypse.HybridAcc         
   = set_combine(sets.engaged.Apocalypse
                ,{ammo="Fire bomblet"
                 ,hands="Homam manopolas"
                 ,back="Cuchulain's mantle"
                 ,feet="Homam gambieras"})
                 
  sets.engaged.Apocalypse.Tank        
   = set_combine(sets.engaged.Apocalypse.HybridAcc
                ,{ammo="Bibiki seashell"
                 ,ear2="Ethereal earring"
                 ,ring1="Defending ring"
                 ,back="Shadow mantle"})

  --apoc engaged (sam) ROSE STRAP
  sets.engaged.Apocalypse.SAM
   = {ammo="White tathlum"
     ,head="Walahra turban"    
     ,neck="Chivalrous chain"
     ,ear1="Abyssal earring"
     ,ear2="Brutal earring"
     ,body="Aurum cuirass"     
     ,hands="Dusk gloves +1"
     ,ring1=toreador_ring['Triple Attack (2)']  
     ,ring2=toreador_ring['Triple Attack (1)']
     ,back="Cerberus mantle +1"
     ,waist="Ninurta's sash"
     ,legs="Homam cosciales"
     ,feet="Dusk ledelsens +1"}
     
  sets.engaged.Apocalypse.HybridAcc.SAM 	
   = set_combine(sets.engaged.Apocalypse.SAM
                ,{hands="Homam manopolas"
                 ,back="Cuchulain's mantle"
                 ,feet="Homam gambieras"})
                 
  sets.engaged.Apocalypse.Tank.SAM 	
   = set_combine(sets.engaged.Apocalypse.HybridAcc.SAM
                ,{ear2="Ethereal earring"
                 ,ring1="Defending ring"
                 ,back="Shadow mantle"})

  --rag engaged (no sam) ROSE STRAP
  sets.engaged.Ragnarok
   = {ammo="Bomb core"
     ,head="Walahra turban"    
     ,neck="Prudence torque"
     ,ear1="Merman's earring"
     ,ear2="Brutal earring"
     ,body="Armada hauberk"    
     ,hands="Dusk gloves +1" 
     ,ring1=toreador_ring['Triple Attack (2)']  
     ,ring2=toreador_ring['Triple Attack (1)']
     ,back="Cerberus mantle +1"
     ,waist="Ninurta's sash"
     ,legs="Homam cosciales" 
     ,feet="Dusk ledelsens +1"}
     
  sets.engaged.Ragnarok.HybridAcc           
   = set_combine(sets.engaged.Ragnarok
                ,{neck="Ancient torque"
                 ,ear1="Fowling earring"
                 ,hands="Homam manopolas"
                 ,back="Cuchulain's mantle"
                 ,feet="Homam gambieras"})

  --rag engaged (sam)
  sets.engaged.Ragnarok.SAM
   = {ammo="White tathlum"
     ,head="Walahra turban"    
     ,neck="Chivalrous chain"
     ,ear1="Ethereal earring"
     ,ear2="Brutal earring"
     ,body="Armada hauberk"    
     ,hands="Dusk gloves +1" 
     ,ring1=toreador_ring['Triple Attack (2)']  
     ,ring2=toreador_ring['Triple Attack (1)']
     ,back="Cerberus mantle +1"
     ,waist="Ninurta's sash"
     ,legs="Homam cosciales" 
     ,feet="Dusk ledelsens +1"}
     
  sets.engaged.Ragnarok.HybridAcc.SAM
   = set_combine(sets.engaged.Ragnarok
                ,{hands="Homam manopolas"
                 ,back="Cuchulain's mantle"
                 ,feet="Homam gambieras"})

  --zerg engaged
  sets.engaged.Zerg
   = {ammo="White tathlum"
     ,head="Walahra turban"   
     ,neck="Bloodbead gorget"  
     ,ear1="Bloodbead earring"
     ,ear2="Cassie earring"
     ,body="Gloom breastplate"
     ,hands="Dusk gloves +1"
     ,ring1="Bomb queen ring" 
     ,ring2="Bloodbead ring"
     ,back="Gigant mantle"    
     ,waist="Velocious belt"
     ,legs="Homam cosciales"  
     ,feet="Homam gambieras"}
  
  --[[
    * ATS - attack/str
    * ACC - accuracy
    * MOD - modifiers
  ]]
  
  --no MOD sets for default set
  sets.precast.WS
   = {ammo="Bomb core"
     ,head="Hecatomb cap +1"   
     ,neck="Fotia gorget"          
     ,ear1="Triumph earring"
     ,ear2="Brutal earring"
     ,body="Armada hauberk"    
     ,hands="Onyx gadlings"
     ,ring1="Rajas ring"    
     ,ring2="Strigoi ring"
     ,back="Cerberus mantle +1"
     ,waist="Swordbelt +1"         
     ,legs="Onyx cuisses"   
     ,feet="Onyx sollerets"}
     
  sets.precast.WS.ACC
   = set_combine(sets.precast.WS
                ,{ammo="Fire bomblet"
                 ,ring2=toreador_ring['Triple Attack (1)']
                 ,back="Cuchulain's mantle"
                 ,waist="Virtuoso belt"
                 ,legs="Armada breeches"})
                  
  sets.precast.WS.ATSACC
   = set_combine(sets.precast.WS
                ,{ammo="Fire bomblet"
                 ,waist="Virtuoso belt"})
     
   --Scythe specific
   --[[Guillotine (ERA)
       MODS: 25% STR, 25% MND
       HITS: 4
       xATT: 1.0 ]]
  sets.precast.WS['Guillotine']
   = set_combine(sets.precast.WS
                ,{ear1="Abyssal earring"})
                
  sets.precast.WS['Guillotine'].MOD
   = set_combine(sets.precast.WS['Guillotine']
                ,{hands="Alkyoneus's bracelets"
                 ,waist="Warwolf belt"
                 ,feet="Hecatomb leggings +1"})
                
  sets.precast.WS['Guillotine'].ACC
   = set_combine(sets.precast.WS.Acc
                ,{ear1="Abyssal earring"
                 ,ring1="Mars's ring"})
                
  sets.precast.WS['Guillotine'].ATSMOD
   = set_combine(sets.precast.WS['Guillotine']
                ,{})
                
  sets.precast.WS['Guillotine'].ATSACC
   = set_combine(sets.precast.WS['Guillotine']
                ,{ammo="Fire bomblet"
                 ,waist="Virtuoso belt"
                 ,ring1="Strigoi ring"
                 ,ring2=toreador_ring['Triple Attack (1)']
                 ,legs="Armada breeches"})
                
  sets.precast.WS['Guillotine'].MODACC
   = set_combine(sets.precast.WS['Guillotine'].MOD
                ,{ammo="Fire bomblet"
                 ,ring1="Strigoi ring"
                 ,ring2=toreador_ring['Triple Attack (1)']
                 ,legs="Armada breeches"})
                 
   --[[Entropy (ERA)
       MODS: 25% STR, 25% DEX
       HITS: 4
       xATT: 1.0 ]]
  sets.precast.WS['Entropy']
   = set_combine(sets.precast.WS['Guillotine']
                ,{})
  
  sets.precast.WS['Entropy'].MOD
   = set_combine(sets.precast.WS['Guillotine'].MOD
                ,{hands="Hecatomb mittens +1"
                 ,legs="Hecatomb subligar +1"})
  
  sets.precast.WS['Entropy'].ACC
   = set_combine(sets.precast.WS['Guillotine'].ACC
                ,{})
  
  sets.precast.WS['Entropy'].ATSMOD
   = set_combine(sets.precast.WS['Guillotine'].ATSMOD
                ,{})
  
  sets.precast.WS['Entropy'].ATSACC
   = set_combine(sets.precast.WS['Guillotine'].ATSACC
                ,{})
  
  sets.precast.WS['Entropy'].MODACC
   = set_combine(sets.precast.WS['Guillotine'].MODACC
                ,{hands="Hecatomb mittens +1"
                 ,ring1="Rajas ring"
                 ,back="Cuchulain's mantle"
                 ,legs="Aurum sabatons"})
                 
   --[[Catastrophe (ERA)
       MODS: 40% AGI, 40% INT
       HITS: 1
       xATT: 1.0 ]]
  sets.precast.WS['Catastrophe']
   = set_combine(sets.precast.WS
                ,{head="Maat's cap"
                 ,ear1="Abyssal earring"}) 
                 
  sets.precast.WS['Catastrophe'].MOD
   = set_combine(sets.precast.WS
                ,{head="Maat's cap"
                 ,ear1="Abyssal earring"
                 ,ring2="Snow ring"}) 
  
  sets.precast.WS['Catastrophe'].ACC
   = set_combine(sets.precast.WS.ACC
                ,{})
  
  sets.precast.WS['Catastrophe'].ATSMOD
   = set_combine(sets.precast.WS['Catastrophe'].MOD
                ,{ring2="Strigoi ring"})
  
  sets.precast.WS['Catastrophe'].ATSACC
   = set_combine(sets.precast.WS.ATSACC
                ,{ring2=toreador_ring['Triple Attack (1)']})
  
  sets.precast.WS['Catastrophe'].MODACC
   = set_combine(sets.precast.WS['Catastrophe'].ACC
                ,{})
                
  --Greatsword specific
  --[[Resolution (ERA)
      MODS: 30% STR, 30% INT
      HITS: 1
      xATT: 1.5 ]]
  sets.precast.WS['Resolution']
   = set_combine(sets.precast.WS
                ,{})  
                
  sets.precast.WS['Resolution'].MOD
   = set_combine(sets.precast.WS
                ,{head="Maat's cap"
                 ,waist="Warwolf belt"})  
                
  sets.precast.WS['Resolution'].ACC
   = set_combine(sets.precast.WS.ACC
                ,{})  
                
  sets.precast.WS['Resolution'].ATSMOD
   = set_combine(sets.precast.WS
                ,{})  
                
  sets.precast.WS['Resolution'].ATSACC
   = set_combine(sets.precast.WS
                ,{})  
                
  sets.precast.WS['Resolution'].MODACC
   = set_combine(sets.precast.WS
                ,{})  
                
  --[[Ground Strike (ERA)
      MODS: 50% STR, 50% INT
      HITS: 1
      xATT: 1.75 ]]
  sets.precast.WS['Ground Strike']
   = set_combine(sets.precast.WS
                ,{})  
                
  sets.precast.WS['Ground Strike'].MOD
   = set_combine(sets.precast.WS
                ,{head="Maat's cap"
                 ,waist="Warwolf belt"})  
                
  sets.precast.WS['Ground Strike'].ACC
   = set_combine(sets.precast.WS
                ,{})  
                
  sets.precast.WS['Ground Strike'].ATSMOD
   = set_combine(sets.precast.WS
                ,{})  
                
  sets.precast.WS['Ground Strike'].ATSACC
   = set_combine(sets.precast.WS
                ,{})  
                
  sets.precast.WS['Ground Strike'].MODACC
   = set_combine(sets.precast.WS
                ,{})  
                
  --[[Scourge (ERA)
      MODS: 40% MND, 40% CHR
      HITS: 1
      xATT: 1.0 ]]
  sets.precast.WS['Scourge']
   = set_combine(sets.precast.WS
                ,{})  
                
  sets.precast.WS['Scourge'].MOD
   = set_combine(sets.precast.WS
                ,{head="Maat's cap"})  
                
  sets.precast.WS['Scourge'].ACC
   = set_combine(sets.precast.WS.ACC
                ,{})  
                
  sets.precast.WS['Scourge'].ATSMOD
   = set_combine(sets.precast.WS
                ,{})  
                
  sets.precast.WS['Scourge'].ATSACC
   = set_combine(sets.precast.WS
                ,{})  
                
  sets.precast.WS['Scourge'].MODACC
   = set_combine(sets.precast.WS
                ,{})
  
end

function job_post_precast(spell,action,spellMap,eventArgs)

  if spell.type == 'WeaponSkill' then
  
    if daytime then
      if (state.WeaponskillMode.value == 'Normal' and state.CombatWeapon.value == 'Apocalypse') or state.CombatWeapon.value == 'Ragnarok' then
        equip({ear1="Fenrir's earring"})
      end
    end
    
    if player.sub_job == 'SAM' then
      if state.CombatWeapon.value == 'Apocalypse' and scythe_singlehit:contains(spell.english) then
        equip({ammo="White tathlum"})
      --elseif state.CombatWeapon.value == 'Ragnarok' and gs_singlehit:contains(spell.english) then
       -- equip({body="Aurum cuirass"})
      end
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
  
  if name == 'Aftermath' and player.equipment.main == 'Apocalypse' then
      handle_equipping_gear(player.status)
  end
  
  if name == 'Dark Seal' then
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
  
  if player.hpp < 75 then
  
    idleSet = set_combine(idleSet,{head="Crimson mask"})
  
    if daytime then
      idleSet = set_combine(idleSet,{hands="Garden bangles",waist="Lycopodium sash"})
    end
  
  end

  if player.mpp < 50 and player.hpp >= 85 then
    idleSet = set_combine(idleSet,{neck="Parade gorget"})
  end
  
  return idleSet
  
end

function adjust_melee_groups()

  classes.CustomMeleeGroups:clear()
  
  if player.sub_job == 'SAM' then
    classes.CustomMeleeGroups:append('SAM')
  end

end

function customize_melee_set(meleeSet)

  if state.OffenseMode.value == 'Normal' and daytime then
    meleeSet = set_combine(meleeSet, {ear1="Fenrir's earring"})
  end
  
  if state.CombatWeapon.value == 'Zerg' and daytime then
    meleeSet = set_combine(meleeSet,{ammo="Fenrir's stone"})
  end
  
  if buffactive['Aftermath'] and state.CombatWeapon.value == 'Apocalypse' then
    if state.Tank.value then
    
      if state.OffenseMode.value == 'Tank' then
        meleeSet = set_combine(meleeSet, {body="Valhalla body"})
      else
        meleeSet = set_combine(meleeSet, {legs="Dusk trousers +1",feet="Aurum sabatons"})
      end
      
    else
    
      if state.OffenseMode.value == 'Tank' then
        meleeSet = set_combine(meleeSet, {body="Valhalla body"})
      elseif state.OffenseMode.value == 'Accuracy' then
        meleeSet = set_combine(meleeSet, {legs="Armada breeches",feet="Aurum sabatons"})
      else
        meleeSet = set_combine(meleeSet, {legs="Onyx cuisses",feet="Onyx sollerets"})
      end
      
    end
  end

  return meleeSet

end

function job_status_change(new,old)

  if new == "Engaged" then

    if player.equipment.main == 'Apocalypse' or player.equipment.main == 'Ragnarok' then
      state.CombatWeapon:set(player.equipment.main)
    elseif player.equipment.main == 'Kraken Club' or player.equipment.main == 'Mercurial Kris' then
      state.CombatWeapon:set('Zerg')
    else
      state.CombatWeapon:reset()
    end
    adjust_melee_groups()
  end

end
