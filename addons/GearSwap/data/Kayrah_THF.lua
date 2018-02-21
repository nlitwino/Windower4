function get_sets()

  mote_include_version = 2
  include('Mote-Include.lua')
  include('organizer-lib')

end

function job_setup()

  include('Kay-Include.lua')

  state.Buff['Sneak Attack'] 		   = buffactive['Sneak Attack'] or false
  state.Buff['Trick Attack'] 		   = buffactive['Trick Attack'] or false
  state.Buff['Assassin\'s Charge'] = buffactive['Assassin\'s Charge'] or false

  single_hit_ws = S{'Wasp Sting','Shadowstitch','Viper Bite','Mercy Stroke','Mandalic Stab'}

  offhand_misc = S{'Ridill','Kraken Club'}
  offhand_daggers = S{'Thief\'s Knife','Mercurial Kris'}

  initialize_job()

end

function user_setup()

  include('Mote-TreasureHunter.lua')

  state.OffenseMode:options('Normal','HybridAcc','Acc','MDT')
  state.WeaponskillMode:options('Normal','Power','Acc')
  state.RangedMode:options('Normal','Acid','Bloody','Sleep')
  state.PhysicalDefenseMode:options('Evasion','PDT')
  state.MagicalDefenseMode:options('MDT')

  send_command('bind !f9 gs c cycle TreasureMode')
  send_command('bind !f12 gs c toggle Range;gs c lock_ranged')

end

function init_gear_sets()

  -- misc.
  sets.TreasureHunter
   = {hands="Assassin's armlets"}

  sets.enmityUp
   = {head="Assassin's bonnet"
     ,neck="Ritter gorget"
     ,ear1="Hades earring +1"
     ,body="Avalon breastplate"
     ,hands="Assassin's armlets"
     ,ring2="Corneus ring"
     ,back="Assassin's cape"
     ,waist="Trance belt"
     ,legs="Assassin's culottes"}
     
  sets.enmityDown
   = {ammo="White tathlum"
     ,head="Zha'Go's barbut"
     ,ear1="Novia earring"
     ,ring2="Veela ring"
     ,waist="Buccaneer's belt"
     ,legs="Raven hose"}

  -- buff
  sets.buff['Sneak Attack']
   = {head="Hecatomb cap +1"   
     ,neck="Love torque"         
     ,ear1="Pixie earring"
     ,body="Antares harness"   
     ,hands="Hecatomb mittens +1"
     ,ring1="Rajas ring"         
     ,ring2=toreador_ring['Critical Damage']
     ,back="Cuchulain's mantle"
     ,waist="Warwolf belt"       
     ,legs="Hecatomb subligar +1"
     ,feet="Hecatomb leggings +1"}
     
  sets.buff['Trick Attack']
   = {head="Maat's cap"        
     ,neck="Hope torque"        
     ,ear1="Drone earring"
     ,body="Antares harness"   
     ,hands="Rogue's armlets +1" 
     ,ring1="Blobnag ring"       
     ,ring2=toreador_ring['Critical Damage']
     ,back="Assassin's cape"   
     ,waist="Warwolf belt"       
     ,legs="Oily trousers"       
     ,feet="Enkidu's leggings"}

  -- precast ja
  sets.precast.JA['Flee']
   = {feet="Rogue's poulaines +1"}
   
  sets.precast.JA['Steal']
   = {head="Rogue's bonnet"
     ,hands="Rogue's armlets +1"
     ,legs="Assassin's culottes"
     ,feet="Rogue's poulaines +1"}
     
  sets.precast.JA['Mug']
   = {head="Assassin's bonnet"}
   
  sets.precast.JA['Hide']
   = {body="Rogue's vest +1"}

  -- precast magic
  sets.precast.FC
   = {ear2="Loquacious earring"
     ,legs="Homam cosciales"}

  -- midcast magic
  sets.midcast.FastRecast
   = set_combine(sets.precast.FC
                ,{head="Walahra turban"
                 ,body="Rapparee harness"
                 ,hands="Dusk gloves +1"
                 ,waist="Velocious belt"
                 ,feet="Dusk ledelsens +1"})

  sets.midcast['Utsusemi: Ni']
   = set_combine(sets.midcast.FastRecast
                ,{neck="Fortified chain"
                 ,ear1="Magnetic earring"
                 ,ring1="Defending ring"
                 ,back="Boxer's mantle"})
                 
  sets.midcast['Utsusemi: Ichi']
   = set_combine(sets.midcast['Utsusemi: Ni']
                ,{body=scorpion_harness['Haste']
                 ,waist="Resolute belt"})

  -- idle
  sets.idle
   = {ammo="Bibiki seashell"
     ,head="Gnole crown"       
     ,neck="Chocobo whistle"    
     ,ear1="Novia earring"        
     ,ear2="Merman's earring"
     ,body="Avalon breastplate"
     ,hands="Assassin's armlets"
     ,ring1="Defending ring"      
     ,ring2="Shadow ring"
     ,back="Shadow mantle"     
     ,waist="Resolute belt"     
     ,legs="Darksteel subligar +1"
     ,feet="Trotter boots"}
     
  sets.idle.Town                           
   = set_combine(sets.idle
                ,{neck="Orochi nodowa"
                 ,ring2="Warp ring"
                 ,back="Nexus cape"})

  -- defense
  sets.defense.Evasion
   = {head="Gnole crown"
     ,neck="Fortified chain"
     ,ear1="Novia earring"
     ,body=scorpion_harness['Haste']
     ,back="Boxer's mantle"
     ,legs="Raven hose"}
     
  sets.defense.PDT
   = {ammo="Bibiki seashell"
     ,head="Darksteel cap +1"
     ,body="Darksteel harness +1"
     ,hands="Homam manopolas"
     ,ring1="Defending ring"
     ,ring2="Jelly ring"
     ,back="Shadow mantle"
     ,waist="Warwolf belt"
     ,legs="Darksteel subligar +1"
     ,feet="Homam gambieras"}
     
  sets.defense.MDT
   = {ammo="Bibiki seashell"
     ,ear1="Merman's earring"
     ,ear2="Merman's earring"
     ,body="Avalon breastplate"
     ,ring1="Defending ring"
     ,ring2="Shadow ring"
     ,waist="Resolute belt"
     ,feet="Merman's leggings"}

  -- engaged
  sets.engaged
   = {ammo="Bomb core"
     ,head="Walahra turban"    
     ,neck="Love torque"    
     ,ear1="Suppanomimi"        
     ,ear2="Brutal earring"
     ,body="Rapparee harness"  
     ,hands="Dusk gloves +1"
     ,ring1=toreador_ring['Triple Attack (2)']         
     ,ring2=toreador_ring['Triple Attack (1)']
     ,back="Cerberus mantle +1"
     ,waist="Velocious belt"
     ,legs="Barbarossa's zerehs"
     ,feet="Dusk ledelsens +1"}
     
  sets.engaged.HybridAcc
   = set_combine(sets.engaged
                ,{ammo="Fire bomblet"
                 ,hands="Homam manopolas"
                 ,back="Cuchulain's mantle"
                 ,legs="Homam cosciales"
                 ,feet="Homam gambieras"})
                 
  sets.engaged.Acc
   = set_combine(sets.engaged.HybridAcc
                ,{head="Homam zucchetto"
                ,neck="Ancient torque"
                ,body="Homam corazza"})
                
  sets.engaged.MDT
   = set_combine(sets.engaged.Acc
                ,{ear1="Merman's earring"
                 ,ear2="Merman's earring"
                 ,body="Avalon breastplate"
                 ,ring1="Defending ring"})

  -- ranged
  sets.precast.RA
   = {head="Zha'Go's barbut"
     ,scorpion_harness['Rapid Shot']}
     
  sets.midcast.RA
   = {head="Zha'Go's barbut"
     ,neck="Peacock amulet"       
     ,ear1="Drone earring"    
     ,ear2="Drone earring"
     ,body="Rapparee harness"
     ,hands="Barbarossa's moufles"
     ,ring1="Behemoth ring +1"
     ,ring2="Dragon ring +1"
     ,back="Mamool Ja mantle"
     ,waist="Buccaneer's belt"    
     ,legs="Dusk trousers +1" 
     ,feet="Homam gambieras"}

  -- WS
  sets.precast.WS
   = {ammo="Bomb core"
     ,head="Maat's cap"        
     ,neck="Fotia gorget"        
     ,ear1="Triumph earring"     
     ,ear2="Brutal earring"
     ,body="Antares harness"   
     ,hands="Hecatomb mittens +1"
     ,ring1="Rajas ring"         
     ,ring2="Strigoi ring"
     ,back="Cerberus mantle +1"
     ,waist="Warwolf belt"       
     ,legs="Hecatomb subligar +1"
     ,feet="Hecatomb leggings +1"}
     
  sets.precast.WS.Power
   = set_combine(sets.precast.WS      
                ,{head="Gnadbhod's helm"
                 ,body="Hecatomb harness"})
                
  sets.precast.WS.Acc
   = set_combine(sets.precast.WS.Power
                ,{ammo="Fire bomblet"
                 ,hands="Enkidu's mittens"
                 ,back="Cuchulain's mantle"})

  sets.precast.WS['Cyclone']
   = set_combine(sets.precast.WS
                ,{ammo="Black tathlum"
                 ,ear1="Moldavite earring"
                 ,ear2="Morion earring +1"
                 ,ring1="Snow ring"
                 ,ring2="Omega ring"
                 ,back="Cuchulain's mantle"})

  sets.precast.WS['Shark Bite']
   = set_combine(sets.precast.WS
                ,{back="Assassin's cape"})
                
  sets.precast.WS['Shark Bite'].Power
   = set_combine(sets.precast.WS.Power
                ,{})
                
  sets.precast.WS['Shark Bite'].Acc
   = set_combine(sets.precast.WS.Acc
                ,{ammo="Fire bomblet"
                 ,ear1="Pixie earring"
                 ,back="Cuchulain's mantle"})

  sets.precast.WS['Mercy Stroke']
   = set_combine(sets.precast.WS                
                ,{head="Hecatomb cap +1"
                ,body="Hecatomb harness"
                ,hands="Alkyoneus's bracelets"})
                
  sets.precast.WS['Mercy Stroke'].Power
   = set_combine(sets.precast.WS['Mercy Stroke']
                ,{})
                
  sets.precast.WS['Mercy Stroke'].Acc
   = set_combine(sets.precast.WS['Mercy Stroke']
                ,{ammo="Fire bomblet"
                 ,hands="Enkidu's mittens"
                 ,back="Cuchulain's mantle"})

  sets.precast.WS['Mandalic Stab']
   = set_combine(sets.precast.WS      
                ,{head="Hecatomb cap +1"})
                
  sets.precast.WS['Mandalic Stab'].Power
   = set_combine(sets.precast.WS.Power
                ,{})
   
  sets.precast.WS['Mandalic Stab'].Acc
   = set_combine(sets.precast.WS.Acc  
                ,{ammo="Fire bomblet"
                 ,hands="Enkidu's mittens"
                 ,back="Cuchulain's mantle"})

  -- SA WS
  sets.precast.WS.SA
   = set_combine(sets.precast.WS      
                ,{ear1="Pixie earring"
                 ,ring2=toreador_ring['Critical Damage']})
   
  sets.precast.WS.Power.SA
   = set_combine(sets.precast.WS.Power
                ,{ear1="Pixie earring"
                 ,ring2=toreador_ring['Critical Damage']})
   
  sets.precast.WS.Acc.SA
   = set_combine(sets.precast.WS.Acc  
                ,{ear1="Pixie earring"
                 ,ring2=toreador_ring['Critical Damage']})

  sets.precast.WS['Shark Bite'].SA
   = set_combine(sets.precast.WS['Shark Bite']
                ,{ear1="Pixie earring"
                 ,ring2=toreador_ring['Critical Damage']})
                
  sets.precast.WS['Shark Bite'].Power.SA
   = set_combine(sets.precast.WS['Shark Bite'].Power
                ,{ear1="Pixie earring"
                 ,body="Hecatomb harness"
                 ,ring2=toreador_ring['Critical Damage']})
                
  sets.precast.WS['Shark Bite'].Acc.SA
   = set_combine(sets.precast.WS['Shark Bite'].Acc 
                ,{ear1="Pixie earring"
                 ,ring2=toreador_ring['Critical Damage']})

  sets.precast.WS['Mercy Stroke'].SA
   = set_combine(sets.precast.WS['Mercy Stroke']      
                ,{ear1="Pixie earring"
                 ,hands="Hecatomb mittens +1"
                 ,ring2=toreador_ring['Critical Damage']})
                
  sets.precast.WS['Mercy Stroke'].Power.SA
   = set_combine(sets.precast.WS['Mercy Stroke'].Power
                ,{ear1="Pixie earring"
                 ,hands="Hecatomb mittens +1"
                 ,ring2=toreador_ring['Critical Damage']})
                
  sets.precast.WS['Mercy Stroke'].Acc.SA
   = set_combine(sets.precast.WS['Mercy Stroke'].Acc  
                ,{ear1="Pixie earring"
                 ,ring2=toreador_ring['Critical Damage']})

  sets.precast.WS['Mandalic Stab'].SA
   = set_combine(sets.precast.WS['Mandalic Stab']      
                ,{ear1="Pixie earring"
                 ,ring2=toreador_ring['Critical Damage']})
                
  sets.precast.WS['Mandalic Stab'].Power.SA
   = set_combine(sets.precast.WS['Mandalic Stab'].Power
                ,{ear1="Pixie earring"
                 ,body="Hecatomb harness"
                 ,ring2=toreador_ring['Critical Damage']})
                
  sets.precast.WS['Mandalic Stab'].Acc.SA
   = set_combine(sets.precast.WS['Mandalic Stab'].Acc  
                ,{ear1="Pixie earring"
                 ,body="Hecatomb harness"
                 ,ring2=toreador_ring['Critical Damage']})

  -- TA WS
  sets.precast.WS.TA
   = set_combine(sets.precast.WS      
                ,{head="Maat's cap"
                 ,ear1="Drone earring"
                 ,hands="Rogue's armlets +1"
                 ,ring2=toreador_ring['Critical Damage']})
   
  sets.precast.WS.Power.TA
   = set_combine(sets.precast.WS.Power
                ,{head="Maat's cap"
                 ,ear1="Drone earring"
                 ,hands="Rogue's armlets +1"
                 ,ring2=toreador_ring['Critical Damage']})
   
  sets.precast.WS.Acc.TA
   = set_combine(sets.precast.WS.Acc  
                ,{head="Maat's cap"
                 ,ear1="Drone earring"
                 ,hands="Rogue's armlets +1"
                 ,ring2=toreador_ring['Critical Damage']})

  sets.precast.WS['Shark Bite'].TA
   = set_combine(sets.precast.WS['Shark Bite']
                ,{ear1="Drone earring"
                 ,hands="Rogue's armlets +1"
                 ,ring2=toreador_ring['Critical Damage']})
                 
  sets.precast.WS['Shark Bite'].Power.TA
   = set_combine(sets.precast.WS['Shark Bite'].Power
                ,{head="Maat's cap"
                 ,ear1="Drone earring"
                 ,hands="Rogue's armlets +1"
                 ,ring2=toreador_ring['Critical Damage']})
                 
  sets.precast.WS['Shark Bite'].Acc.TA
   = set_combine(sets.precast.WS['Shark Bite'].Acc  
                ,{head="Maat's cap"
                 ,ear1="Drone earring"
                 ,body="Antares harness"
                 ,hands="Rogue's armlets +1"
                 ,ring2=toreador_ring['Critical Damage']})

  sets.precast.WS['Mercy Stroke'].TA
   = set_combine(sets.precast.WS['Mercy Stroke']      
                ,{head="Maat's cap"
                 ,ear1="Drone earring"
                 ,hands="Rogue's armlets +1"
                 ,ring2=toreador_ring['Critical Damage']})
                 
  sets.precast.WS['Mercy Stroke'].Power.TA
   = set_combine(sets.precast.WS['Mercy Stroke'].Power
                ,{head="Maat's cap"
                 ,ear1="Drone earring"
                 ,hands="Rogue's armlets +1"
                 ,ring2=toreador_ring['Critical Damage']})
                 
  sets.precast.WS['Mercy Stroke'].Acc.TA
   = set_combine(sets.precast.WS['Mercy Stroke'].Acc  
                ,{head="Maat's cap"
                 ,ear1="Drone earring"
                 ,hands="Rogue's armlets +1"
                 ,ring2=toreador_ring['Critical Damage']})

  sets.precast.WS['Mandalic Stab'].TA
   = set_combine(sets.precast.WS['Mandalic Stab']
                ,{head="Maat's cap"
                 ,ear1="Drone earring"
                 ,hands="Rogue's armlets +1"
                 ,ring2=toreador_ring['Critical Damage']
                 ,back="Assassin's cape"})
  
  sets.precast.WS['Mandalic Stab'].Power.TA
   = set_combine(sets.precast.WS['Mandalic Stab'].Power
                ,{head="Maat's cap"
                 ,ear1="Drone earring"
                 ,hands="Rogue's armlets +1"
                 ,ring2=toreador_ring['Critical Damage']
                 ,back="Assassin's cape"})
  
  sets.precast.WS['Mandalic Stab'].Acc.TA
   = set_combine(sets.precast.WS['Mandalic Stab'].Acc
                ,{head="Maat's cap"
                 ,ear1="Drone earring"
                 ,body="Antares harness"
                 ,hands="Rogue's armlets +1"
                 ,ring2=toreador_ring['Critical Damage']
                 ,back="Assassin's cape"})

  -- SATA WS
  sets.precast.WS.SATA
   = set_combine(sets.precast.WS.TA
                ,{back="Assassin's cape"})
                
  sets.precast.WS.Power.SATA
   = set_combine(sets.precast.WS.Power.TA
                ,{ear1="Pixie earring"
                 ,hands="Hecatomb mittens +1"
                 ,back="Assassin's cape"})
                 
  sets.precast.WS.Acc.SATA
   = set_combine(sets.precast.WS.Acc.TA
                ,{})

  sets.precast.WS['Shark Bite'].SATA
   = set_combine(sets.precast.WS['Shark Bite'].TA
                ,{})
   
  sets.precast.WS['Shark Bite'].Power.SATA
   = set_combine(sets.precast.WS['Shark Bite'].Power.TA
                ,{})
   
  sets.precast.WS['Shark Bite'].Acc.SATA
   = set_combine(sets.precast.WS['Shark Bite'].Acc.TA
                ,{})

  sets.precast.WS['Mercy Stroke'].SATA
   = set_combine(sets.precast.WS['Mercy Stroke'].TA
                ,{body="Antares harness"
                 ,back="Assassin's cape"})
                 
  sets.precast.WS['Mercy Stroke'].Power.SATA
   = set_combine(sets.precast.WS['Mercy Stroke'].Power.TA
                ,{head="Hecatomb cap +1"
                 ,back="Assassin's cape"})
   
  sets.precast.WS['Mercy Stroke'].Acc.SATA
   = set_combine(sets.precast.WS['Mercy Stroke'].Acc.TA
                ,{})

  sets.precast.WS['Mandalic Stab'].SATA
   = set_combine(sets.precast.WS['Mandalic Stab'].TA
                ,{ear1="Pixie earring"})
                
  sets.precast.WS['Mandalic Stab'].Power.SATA
   = set_combine(sets.precast.WS['Mandalic Stab'].Power.TA
                ,{ear1="Pixie earring"})
                
  sets.precast.WS['Mandalic Stab'].Acc.SATA  
   = set_combine(sets.precast.WS['Mandalic Stab'].Acc.TA
                ,{ear1="Pixie earring"})

end

function job_buff_change(name,gain)

  sleep_swap(name,gain)

  if state.Buff[name] ~= nil then
    if not midaction() then
      handle_equipping_gear(player.status)
    end
  end

end

function job_post_precast(spell,action,spellMap,eventArgs)

  -- no archery handling cuz lul
  if spell.action_type == 'Ranged Attack' then
    if state.Range.value then
      local ammunition
      if state.RangedMode.value ~= 'Normal' then
        enable("ammo")
        ammunition = tostring(state.RangedMode.value)..' Bolt'
        send_command('find '..ammunition)
        equip({ammo=ammunition})
        disable("ammo")
      end
    else
      cancel_spell()
    end
  end

  if spell.english == 'Cyclone' and state.TreasureMode.value ~= 'None' then
    equip(sets.TreasureHunter)
  elseif (state.Buff['Sneak Attack'] or state.Buff['Trick Attack']) and spell.type == 'WeaponSkill' then
    if state.TreasureMode.value == 'SATA' then
      equip(sets.TreasureHunter)
    end
  end

  if spell.type == 'WeaponSkill' then
    if daytime then
      if state.Buff['Assassin\'s Charge'] then
        if single_hit_ws:contains(spell.name) then
          equip({ear2="Fenrir's earring"})
        else
          equip({ear1="Fenrir's earring"})
        end
      else
        equip({ear1="Fenrir's earring"})
      end
    else
      if state.Buff['Assassin\'s Charge'] then
        if single_hit_ws:contains(spell.name) then
          equip({ear2="Merman's earring"})
        end
      end
    end
  elseif spell.type == 'JobAbility' then
    if state.Tank.value then
      equip(set_combine(sets.enmityUp,sets.precast.JA[spell.english]) or sets.enmityUp)
    else
      equip(set_combine(sets.enmityDown,sets.precast.JA[spell.english]) or sets.enmityDown)
    end
  end

end

function customize_melee_set(meleeSet)

  if state.TreasureMode.value == 'Fulltime' then
    meleeSet = set_combine(meleeSet, sets.TreasureHunter)
  end
  
  if state.OffenseMode.value == 'Normal' or state.OffenseMode.value == 'HybridAcc' then
      if offhand_misc:contains(player.equipment.sub) then
        meleeSet = set_combine(meleeSet,{neck="Ancient torque"})
      else
        meleeSet = set_combine(meleeSet,{neck="Love torque"})
      end
  end
  
  return meleeSet

end

function customize_idle_set(idleSet)

  if daytime then
    idleSet = set_combine(idleSet,{hands="Garden bangles",waist="Lycopodium sash"})
  end
  
  return idleSet

end

function get_custom_wsmode(spell,spellMap,default_wsmode)

  local wsmode
  
  if state.Buff['Sneak Attack'] then
    wsmode = 'SA'
  end
  
  if state.Buff['Trick Attack'] then
    wsmode = (wsmode or '') .. 'TA'
  end
  
  return wsmode

end

function job_handle_equipping_gear(status,eventArgs)

  check_buff('Sneak Attack', eventArgs)
  check_buff('Trick Attack', eventArgs)
  check_buff('Assassin\'s Charge', eventArgs)

end

function check_buff(name,eventArgs)

  if state.Buff[name] then
    equip(sets.buff[name] or {})
    if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
      equip(sets.TreasureHunter)
    end
    eventArgs.handled = true
  end

end
