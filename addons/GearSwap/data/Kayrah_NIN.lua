function get_sets()

  mote_include_version = 2
  include('Mote-Include.lua')
  include('organizer-lib')


end

function job_setup()

  include('Kay-Include.lua')

  state.Buff['Yonin'] = buffactive['Yonin'] or false
  state.Buff['Innin'] = buffactive['Innin'] or false
  state.Buff['Sange'] = buffactive['Sange'] or false
  
  offhand_katana = S{'Narigitsune','Mamushito +1','Shusui'}

  initialize_job()

end

function user_setup()

  state.OffenseMode:options('Normal','HybridAcc','Acc')
  state.WeaponskillMode:options('Normal','HNM')
  state.CastingMode:options('Normal','Enmity')
  state.RangedMode:options('Normal','HNM')
  state.PhysicalDefenseMode:options('Evasion', 'PDT')
  state.MagicalDefenseMode:options('MDT')

end

function init_gear_sets()

  -- misc.
  sets.INT
   = {head="Maat's cap"
     ,neck="Lemegeton medallion +1"
     ,ear2="Morion earring +1"
     ,body="Kirin's osode"
     ,ring2="Snow ring"
     ,waist="Ocean stone"
     ,legs="Yasha hakama"
     ,feet="Ninja kyahan +1"}
     
  sets.enmityUp
   = {head="Arhat's jinpachi +1"
     ,neck="Ritter gorget"
     ,ear1="Hades earring +1"
     ,body="Yasha samue +1"
     ,hands="Yasha tekko"
     ,ring1="Corneus ring"
     ,back="Cerberus mantle +1"
     ,waist="Trance belt"
     ,legs="Yasha hakama"}

  sets.enmityDown
   = {head="Zha'Go's barbut"
     ,ear1="Novia earring"
     ,ring1="Veela ring"
     ,waist="Buccaneer's belt"}

  -- precast ja

  -- precast magic
  sets.precast.FC                           
   = {ear2="Loquacious earring"}

  -- midcast magic
  sets.midcast.FastRecast
   = set_combine(sets.precast.FC
                ,{head="Walahra turban"
                 ,neck="Tiercel necklace"
                 ,body=scorpion_harness['Haste']
                 ,hands="Dusk gloves +1"
                 ,waist="Ninurta's sash"
                 ,legs="Byakko's haidate"
                 ,feet="Dusk ledelsens +1"}) 

  sets.midcast['Utsusemi: Ni']
   = set_combine(sets.midcast.FastRecast
                ,{ear1="Magnetic earring"
                 ,back="Boxer's mantle"})
                
  sets.midcast['Utsusemi: Ichi']
   = set_combine(sets.midcast['Utsusemi: Ni']
                ,{head="Gnole crown"
                 ,body="Yasha samue +1"
                 ,hands="Yasha tekko"
                 ,waist="Resolute belt"
                 ,legs="Yasha hakama"
                 ,feet="Hachiryu sune-ate"})
                 
  sets.midcast.NinjutsuDebuff
   = set_combine(sets.INT
                ,{ammo="Sturm's report"
                 ,head="Ninja hatsuburi +1"
                 ,hands="Yasha tekko"
                 ,ring1="Omega ring"
                 ,back="Astute cape"
                 ,feet="Koga kyahan +1"
                 ,back="Astute cape"})
                 
  sets.midcast.ElementalNinjutsu
   = set_combine(sets.midcast.NinjutsuDebuff
                ,{ear1="Moldavite earring"})

  -- idle
  sets.idle
   = {ammo="Bibiki seashell"
     ,head="Arhat's jinpachi +1"
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
     ,feet="Ninja kyahan +1"}

  sets.idle.Town
   = set_combine(sets.idle
                ,{neck="Orochi nodowa +1"
                 ,ring2="Warp ring"
                 ,back="Nexus cape"
                 ,waist="Ninurta's sash"})

  -- defense
  sets.defense.Evasion
   = {head="Gnole crown"        
     ,neck="Fortified chain"
     ,ear1="Novia earring"
     ,ear2="Drone earring"
     ,body=scorpion_harness['Haste']
     ,hands="Seiryu's kote"
     ,back="Boxer's mantle"
     ,legs="Koga hakama"
     ,feet="Hachiryu sune-ate"}
     
  sets.defense.PDT
   = {ammo="Bibiki seashell"
     ,head="Arhat's jinpachi +1"
     ,body="Arhat's gi +1"      
     ,ring1="Defending ring"      
     ,ring2="Jelly ring"
     ,back="Shadow mantle"      
     ,legs="Darksteel subligar +1"}

  sets.defense.MDT
   = {head="Genbu's kabuto"
     ,ear1="Merman's earring"
     ,ear2="Merman's earring"
     ,body="Kirin's osode"
     ,hands="Seiryu's kote"
     ,ring1="Defending ring"
     ,ring2="Shadow ring"
     ,waist="Resolute belt"
     ,legs="Byakko's haidate"
     ,feet="Suzaku's sune-ate"}

  -- engaged
  sets.engaged
   = {ammo="Bomb core"
     ,head="Walahra turban"    
     ,neck="Hope torque"    
     ,ear1="Suppanomimi"     
     ,ear2="Brutal earring"
     ,body="Ninja chainmail +1"
     ,hands="Dusk gloves +1"
     ,ring1=toreador_ring['Triple Attack (2)']     
     ,ring2=toreador_ring['Triple Attack (1)'] 
     ,back="Cerberus mantle +1"
     ,waist="Ninurta's sash"
     ,legs="Byakko's haidate"
     ,feet="Dusk ledelsens +1"}
     
  sets.engaged.HybridAcc
   = set_combine(sets.engaged
                ,{ammo="Fire bomblet"
                 ,neck="Ancient torque"
                 ,back="Cuchulain's mantle"})
                
  sets.engaged.Acc
   = set_combine(sets.engaged.HybridAcc
                ,{neck="Ancient torque"
                 ,body="Hachiryu haramaki"})
                 
  sets.engaged.Tank
   = set_combine(sets.engaged.Acc
                ,{ring1="Defending ring"
                 ,back="Boxer's mantle"})

  -- ranged
  sets.precast.RA
   = {head="Zha'Go's barbut"
     ,neck="Peacock amulet"
     ,ear1="Drone earring"
     ,ear2="Drone earring"
     ,body=scorpion_harness['Rapid Shot']
     ,hands="Ninja tekko +1"
     ,ring1="Behemoth ring +1"
     ,ring2="Dragon ring +1"
     ,back="Amemet mantle +1"
     ,waist="Buccaneer's belt" 
     ,legs="Ninja hakama +1"
     ,feet="Enkidu's leggings"}

  sets.midcast.RA 
   = set_combine(sets.precast.RA
                ,{body="Koga chainmail"})
  sets.midcast.RA.HNM
   = set_combine(sets.midcast.HNM
                ,{back="Mamool Ja mantle"
                ,hands="Seiryu's kote"
                ,feet="Hachiryu sune-ate"})

  --ws
  sets.precast.WS
   = {ammo="Bomb core"
     ,head="Gnadbhod's helm"        
     ,neck="Fotia gorget"   
     ,ear1="Merman's earring"
     ,ear2="Brutal earring"
     ,body="Haubergeon +1"     
     ,hands="Ninja tekko +1"
     ,ring1="Rajas ring"     
     ,ring2="Strigoi ring"
     ,back="Cerberus mantle +1"
     ,waist="Warwolf belt"  
     ,legs="Byakko's haidate"
     ,feet="Rutter sabatons"}
     
  sets.precast.WS.HNM
   = set_combine(sets.precast.WS
                ,{ammo="Fire bomblet"
                 ,hands="Bandomusha kote"
                 ,legs="Hachiryu haidate"})

  sets.precast.WS['Blade: Jin']
   = set_combine(sets.precast.WS
                ,{body="Hachiryu haramaki"
                 ,legs="Byakko's haidate"})
                
  sets.precast.WS['Blade: Jin'].HNM
   = set_combine(sets.precast.WS['Blade: Jin']
                ,{ammo="Fire bomblet"
                 ,hands="Bandomusha kote"
                 ,legs="Hachiryu haidate"})

  sets.precast.WS['Blade: Shun']
   = set_combine(sets.precast.WS['Blade: Jin']
                ,{})
                
  sets.precast.WS['Blade: Shun'].HNM
   = set_combine(sets.precast.WS['Blade: Jin'].HNM
                ,{})

  sets.precast.WS['Blade: Ku']
   = set_combine(sets.precast.WS
                ,{head="Gnadbhod's helm"
                 ,body="Hachiryu haramaki"
                 ,hands="Bandomusha kote"
                 ,waist="Swordbelt +1"})
   
  sets.precast.WS['Blade: Ku'].HNM
   = set_combine(sets.precast.WS['Blade: Ku']
                ,{ammo="Fire bomblet"
                 ,waist="Virtuoso belt"})

  sets.precast.WS['Blade: Metsu']
   = set_combine(sets.precast.WS
                ,{body="Haubergeon +1"})
                
  sets.precast.WS['Blade: Metsu'].HNM
   = set_combine(sets.precast.WS['Blade: Metsu']
                ,{ammo="Fire bomblet"
                 ,head="Gnadbhod's helm"
                 ,hands="Bandomusha kote"})

  sets.precast.WS['Blade: Kamu']
   = set_combine(sets.precast.WS
                ,{hands="Bandomusha kote"
                 ,legs="Hachiryu haidate"
                 ,feet="Rutter sabatons"})
                 
  sets.precast.WS['Blade: Kamu'].HNM
   = set_combine(sets.precast.WS['Blade: Kamu']
                ,{body="Haubergeon +1"})

end

function job_buff_change(name,gain)

  sleep_swap(name,gain)

end

function job_post_precast(spell)

  if spell.type == 'JobAbility' then
    if state.Tank.value then
      equip(set_combine(sets.enmityUp,sets.precast.JA[spell.english]) or sets.enmityUp)
    else
      equip(set_combine(sets.enmityDown,sets.precast.JA[spell.english]) or sets.enmityDown)
    end
  end
  
  if spell.type == 'WeaponSkill' and not daytime then
    if state.WeaponskillMode.value == 'Normal' then
      equip({feet="Koga kyahan +1"})
    end
  end

end

function job_post_midcast(spell,default_spell_map)

  if spell.skill == 'Ninjutsu' then
    if spell.element == world.weather_element or spell.element == world.day_element then
      equip({waist="Hachirin-no-obi"})
    end
  end

end

function job_get_spell_map(spell,default_spell_map)

  if spell.skill == "Ninjutsu" then
    if not default_spell_map then
      if spell.target.type == 'SELF' then
        return 'NinjutsuBuff'
      else
        return 'NinjutsuDebuff'
      end
    end
  end

end

function customize_idle_set(idleSet)

  if daytime then
    idleSet = set_combine(idleSet,{waist="Lycopodium sash"})
  end
  
  return idleSet

end

function customize_melee_set(meleeSet)

  if player.hpp < 75 and state.OffenseMode.value == 'Normal' then
    meleeSet = set_combine(meleeSet,{ring1="Shinobi ring",legs="Koga hakama"})
  end
  
  if not daytime then
    meleeSet = set_combine(meleeSet,{hands="Koga tekko"})
  end
  
  if not offhand_katana:contains(player.equipment.sub) then
    meleeSet = set_combine(meleeSet,{neck="Ancient torque"})
  end
  
  return meleeSet

end
