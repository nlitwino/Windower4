function get_sets()

  mote_include_version = 2
  include('Mote-Include.lua')
  include('organizer-lib')

end

function job_setup()

  state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
                            buffactive['Aftermath: Lv.2'] or
                            buffactive['Aftermath: Lv.3'] or
                            false
  state.Buff['Seigan'] = buffactive['Seigan'] or false

  include('Kay-Include.lua')

  initialize_job()

  currentAM = 'GK'

end

function user_setup()

  state.OffenseMode:options('Normal','Acc')
  state.RangedMode:options('Normal','Acc')
  state.WeaponskillMode:options('Normal','MidAttack','HighAttack')
  state.PhysicalDefenseMode:options('PDT')
  state.MagicalDefenseMode:options('MDT')

end

function init_gear_sets()

  -- misc.
  sets.enmityUp
   = {head="Aegishjalmr"
     ,neck="Ritter gorget"
     ,body="Avalon breastplate"
     ,hands="Saotome kote"
     ,ring2="Corneus ring"
     ,back="Cerberus mantle +1"
     ,waist="Trance belt"
     ,legs="Saotome haidate"
     ,feet="Myochin sune-ate"}
     
  sets.enmityDown
   = {head="Zha'Go's barbut"
     ,ear1="Novia earring"
     ,ring1="Veela ring"
     ,waist="Buccaneer's belt"}

  -- precast ja
  sets.precast.JA['Meditate']
   = {head="Myochin kabuto"
     ,hands="Saotome kote"}
     
  sets.precast.JA['Warding Circle']
   = {head="Myochin kabuto"}

  -- precast magic
  sets.precast.FC
   = {ear2="Loquacious earring"}

  -- midcast magic
  sets.midcast.FastRecast
   = set_combine(sets.precast.FC
                ,{head="Walahra turban"
                 ,hands="Dusk gloves +1"
                 ,waist="Velocious belt"
                 ,legs="Byakko's haidate"
                 ,feet="Dusk ledelsens +1"})

  sets.midcast['Utsusemi: Ni']
   = set_combine(sets.midcast.FastRecast
                ,{neck="Fortified chain"
                 ,ear1="Magnetic earring"
                 ,body=scorpion_harness['Haste']
                 ,back="Boxer's mantle"})
                 
  sets.midcast['Utsusemi: Ichi']
   = set_combine(sets.midcast['Utsusemi: Ni']
                ,{waist="Resolute belt"})

  -- idle
  sets.idle 
  = {head="Arhat's jinpachi +1"
    ,neck="Chocobo whistle" 
    ,ear1="Merman's earring"     
    ,ear2="Merman's earring"
    ,body="Arhat's gi +1"      
    ,hands="Seiryu's kote"  
    ,ring1="Defending ring"      
    ,ring2="Shadow ring"
    ,back="Shadow mantle"      
    ,waist="Resolute belt"
    ,legs="Darksteel subligar +1"
    ,feet="Myochin sune-ate"}
    
  sets.idle.Town
   = set_combine(sets.idle
                ,{neck="Orochi nodowa"
                 ,ring2="Warp ring"
                 ,back="Nexus cape"})

  -- defense
  sets.defense.PDT
   = {head="Arhat's jinpachi +1"
     ,body="Arhat's gi +1"
     ,ring1="Defending ring"
     ,ring2="Jelly ring"
     ,back="Shadow mantle"
     ,legs="Darksteel subligar +1"}
  
  sets.defense.MDT
   = {ear1="Merman's earring"
     ,ear2="Merman's earring"
     ,body="Avalon breastplate"
     ,ring1="Defending ring"
     ,ring2="Shadow ring"}

  -- default engaged / 450 delay GKT (hagun/soboro)
  ------------------ WHITE TATHLUM ------------------
  sets.engaged 
  = {head="Walahra turban"     
    ,neck="Justice torque"  
    ,ear1="Bushinomimi"     
    ,ear2="Brutal earring"
    ,body="Hachiman domaru +1"
    ,hands="Dusk gloves +1" 
    ,ring1=toreador_ring['Triple Attack (2)']   
    ,ring2=toreador_ring['Triple Attack (1)']
    ,back="Cerberus mantle +1" 
    ,waist="Velocious belt"
    ,legs="Byakko's haidate"
    ,feet="Dusk ledelsens +1"}
    
  sets.engaged.Acc
   = set_combine(sets.engaged
                ,{body="Hachiryu haramaki"
                 ,ring1="Rajas ring"
                 ,back="Cuchulain's mantle"})

  -- amano engaged / 437 delay GKT
  sets.engaged.Amano                        = {}
  sets.engaged.Acc.Amano                    = {}

  sets.engaged.Amano.AM                     = {}
  sets.engaged.Acc.Amano.AM                 = {}

  -- nanatsu engaged /  420 delay GKT
  ---------------- ROSE STRAP / WHITE TATH ---------------
  sets.engaged.Nanatsu
   = set_combine(sets.engaged
                ,{body="Shinimusha hara-ate"
                 ,ring1="Rajas ring"})
   
  sets.engaged.Acc.Nanatsu
   = set_combine(sets.engaged.Nanatsu
                ,{back="Cuchulain's mantle"})

  

  -- ranged / yoichi
  sets.precast.RA
   = {head="Zha'Go's barbut" 
     ,neck="Peacock amulet"   
     ,ear1="Drone earring" 
     ,ear2="Drone earring"
     ,body=scorpion_harness['Rapid Shot']     
     ,hands="Seiryu's kote"   
     ,ring1="Cerberus ring +1"
     ,ring2="Dragon ring +1"
     ,back="Amemet mantle +1"
     ,waist="Buccaneer's belt"
     ,legs="Dusk trousers +1" 
     ,feet="Hachiryu sune-ate"}

  sets.midcast.RA
   = set_combine(sets.precast.RA
                ,{neck="Hope torque"
                 ,body="Kyudogi +1" })
  sets.midcast.RA.Acc
   = set_combine(sets.midcast.RA.Acc
                ,{ring1="Behemoth ring +1"})

  -- GK ws (186tp)
  sets.precast.WS 
   = {head="Gnadbhod's helm"
     ,neck="Fotia gorget"          
     ,ear1="Bushinomimi"     
     ,ear2="Brutal earring"
     ,body="Byrnie +1"         
     ,hands="Bandomusha kote"
     ,ring1="Rajas ring"     
     ,ring2="Strigoi ring"
     ,back="Cerberus mantle +1"
     ,waist="Swordbelt +1"         
     ,legs="Hachiryu haidate"
     ,feet="Rutter sabatons"}
     
  sets.precast.WS.MidAttack
   = set_combine(sets.precast.WS
                ,{hands="Alkyoneus's bracelets"
                 ,waist="Warwolf belt"})
     
  sets.precast.WS.HighAttack
   = set_combine(sets.precast.WS.MidAttack
                ,{head="Maat's cap"
                 ,body="Kirin's osode"})
   
  -- 75% STR / 2x attack
  sets.precast.WS['Tachi: Gekko']
   = set_combine(sets.precast.WS
                ,{}) 
                
  sets.precast.WS['Tachi: Gekko'].MidAttack
   = set_combine(sets.precast.WS['Tachi: Gekko']
                ,{hands="Alkyoneus's bracelets"
                 ,waist="Warwolf belt"})
                 
  sets.precast.WS['Tachi: Gekko'].HighAttack
   = set_combine(sets.precast.WS['Tachi: Gekko'].MidAttack
                ,{head="Maat's cap"
                 ,body="Kirin's osode"})
  
  -- 75% STR / 1.5x attack
  sets.precast.WS['Tachi: Kasha']
   = set_combine(sets.precast.WS
                ,{}) 
                
  sets.precast.WS['Tachi: Kasha'].MidAttack
   = set_combine(sets.precast.WS['Tachi: Kasha']
                ,{hands="Alkyoneus's bracelets"})
                 
  sets.precast.WS['Tachi: Kasha'].HighAttack
   = set_combine(sets.precast.WS['Tachi: Kasha'].MidAttack
                ,{head="Maat's cap"
                 ,body="Kirin's osode"
                 ,waist="Warwolf belt"})
  
  -- Kasha Clone
  sets.precast.WS['Tachi: Shoha']
   = set_combine(sets.precast.WS['Tachi: Kasha']
                ,{}) 
                
  sets.precast.WS['Tachi: Shoha'].MidAttack
   = set_combine(sets.precast.WS['Tachi: Kasha'].MidAttack
                ,{})
                 
  sets.precast.WS['Tachi: Shoha'].HighAttack
   = set_combine(sets.precast.WS['Tachi: Kasha'].HighAttack
                ,{})
  
  -- 60% STR / 1x attack
  sets.precast.WS['Tachi: Kaiten']
   = set_combine(sets.precast.WS
                ,{})
                
  sets.precast.WS['Tachi: Kaiten'].MidAttack
   = set_combine(sets.precast.WS['Tachi: Kaiten']
                ,{})
                
  sets.precast.WS['Tachi: Kaiten'].HighAttack
   = set_combine(sets.precast.WS['Tachi: Kaiten'].MidAttack
                ,{})
  
  -- 40% STR / 1x attack
  sets.precast.WS['Tachi: Rana']
   = set_combine(sets.precast.WS
                ,{ring1=toreador_ring['Triple Attack (2)']
                 ,ring2=toreador_ring['Triple Attack (1)']})
                
  sets.precast.WS['Tachi: Rana'].MidAttack
   = set_combine(sets.precast.WS['Tachi: Rana']
                ,{})
                
  sets.precast.WS['Tachi: Rana'].HighAttack
   = set_combine(sets.precast.WS['Tachi: Rana'].MidAttack
                ,{})
  
  -- Bow ws
  sets.precast.WS['Sidewinder']
   = {head="Maat's cap"      
     ,neck="Fotia gorget"     
     ,ear1="Drone earring"   
     ,ear2="Drone earring"
     ,body="Kirin's osode"   
     ,hands="Seiryu's kote"   
     ,ring1="Rajas ring"     
     ,ring2="Blobnag ring"
     ,back="Amemet mantle +1"
     ,waist="Buccaneer's belt"
     ,legs="Hachiryu haidate"
     ,feet="Hachiryu sune-ate"}
     
  sets.precast.WS['Sidewinder'].Acc
   = set_combine(sets.precast.WS['Sidewinder']
                ,{})

  sets.precast.WS['Jishnu\'s Radiance'] 	  = set_combine(sets.precast.WS['Sidewinder'],{})
  sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS['Sidewinder'].Acc,{})

  sets.precast.WS['Namas Arrow'] 		      = set_combine(sets.precast.WS['Sidewinder'],{ear1="Triumph earring",ring2="Strigoi ring"})
  sets.precast.WS['Namas Arrow'].Acc        = set_combine(sets.precast.WS['Sidewinder'],{})

end

function job_post_precast(spell,action,spellMap,eventArgs)

  if spell.name == 'Namas Arrow' then
    currentAM = 'Bow'
  elseif spell.name == 'Tachi: Kaiten' then
    currentAM = 'GK'
  end
  
  if spell.name:startswith('Tachi') then
    if player.equipment.ranged == 'empty' then
      if state.CombatWeapon.value == 'Nanatsu' and spell.name ~= 'Tachi: Rana' then
      
        equip({feet="Hachiman sune-ate +1"})
        
        if state.WeaponskillMode.value == 'HighAttack' then
          equip({ammo="Black tathlum",body="Hachiman domaru +1"})
        else
          equip({ammo="White tathlum",body="Hachiryu haramaki"})
        end
        
      else
        equip({ammo="Black tathlum"})
      end
    else
      if state.CombatWeapon.value == 'Nanatsu' and spell.name ~= 'Tachi: Rana' then
        equip({body="Hachiman domaru +1",feet="Hachiman sune-ate +1"})
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

  if spell.type == 'WeaponSkill' then
    if spell.skill == 'Archery' then
      if daytime then
        equip({ear1="Ladybug earring +1",ear2="Ladybug earring +1"})
      else
        equip({ear1="Fenrir's earring"})
      end
    elseif state.WeaponskillMode.value == 'HighAttack' and daytime then
      equip({ear1="Fenrir's earring"})
    end
  end

end

function job_buff_change(name,gain)

  sleep_swap(name,gain)
  
  if name:startswith('Aftermath') and currentAM == 'GK' then
    state.Buff['Aftermath'] = gain
    adjust_melee_groups()
    handle_equipping_gear(player.status)
  elseif name == 'Seigan' then
    state.Buff[name] = gain
    handle_equipping_gear(player.status)
  end

end

function adjust_melee_groups()

  if state.Buff['Aftermath'] then
    classes.CustomMeleeGroups:append('AM')
  end

end

function customize_idle_set(idleSet)

  if daytime then
    idleSet = set_combine(idleSet,{waist="Lycopodium sash"})
  end
  
  if player.equipment.ranged == 'empty' then
    idleSet = set_combine(idleSet,{ammo="Bibiki seashell"})
  end
  
  return idleSet

end

function customize_melee_set(meleeSet)
  
  if player.equipment.ranged == 'empty' then
    if state.CombatWeapon.value == 'Nanatsu' or state.OffenseMode.value ~= 'Normal' then
      meleeSet = set_combine(meleeSet,{ammo="White tathlum"})
    else
      meleeSet = set_combine(meleeSet,{ammo="Black tathlum"})
    end
  end
  
  if state.Buff['Seigan'] then
    meleeSet = set_combine(meleeSet,{legs="Saotome haidate"})
  end
  
  return meleeSet

end

function job_status_change(new,old)
  
  if new == "Engaged" then

    if player.equipment.main == 'Nanatsusaya' then
      state.CombatWeapon:set('Nanatsu')
    elseif player.equipment.main == 'Amanomurakumo' then
      state.CombatWeapon:set('Amano')
    else
      state.CombatWeapon:reset()
    end
    
    adjust_melee_groups()
    
  end

end
