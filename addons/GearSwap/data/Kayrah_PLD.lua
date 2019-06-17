function get_sets()

  mote_include_version = 2
  include('Mote-Include.lua')
  include('organizer-lib')

end

function job_setup()

  include('Kay-Include.lua')

  state.Buff['Copy Image (3)'] = buffactive['Copy Image (3)'] or false
  state.Buff['Copy Image (2)'] = buffactive['Copy Image (2)'] or false
  state.Buff['Copy Image (1)'] = buffactive['Copy Image'] or false

  initialize_job()

end

function user_setup()

  state.IdleMode:options('Normal','SuperMDT','SuperPDT')
  state.OffenseMode:options('Normal','Acc','Heavy','Wyrm')
  state.WeaponskillMode:options('Normal','Acc')
  state.PhysicalDefenseMode:options('PDT','Breath')
  state.MagicalDefenseMode:options('MDT')

  send_command('bind !f9 gs c cycle IdleMode')

  gear.main = player.equipment.main
  gear.sub = player.equipment.sub

end

function init_gear_sets()

  -- misc
  sets.enmity
   = {head="Aegishjalmr"
     ,neck="Ritter gorget"
     ,ear2="Hades earring +1"
     ,body="Valor surcoat"
     ,hands="Hydra moufles"
     ,ring1="Corneus ring"
     ,ring2="Hercules' ring"
     ,back="Cerberus mantle +1"
     ,waist="Trance belt"
     ,legs="Hydra brayettes"
     ,feet="Valor leggings"}

  sets.MND
   = {head="Maat's cap"
     ,neck="Gnole torque"
     ,ear1="Mamool Ja earring"
     ,ear2="Star earring"
     ,body="Crimson scale mail"     
     ,hands="Marine F gloves"               
     ,ring2="Star ring"
     ,waist="Ocean stone"
     ,legs="Jet seraweels"
     ,feet="Valor leggings"}

  -- buff

  -- precast ja
  sets.precast.JA
   = {}

  sets.precast.JA['Cover']
   = {} --head="Gallant coronet",body="Valor surcoat"
   
  sets.precast.JA['Rampart'] 
   = {} --head="Valor coronet"
   
  sets.precast.JA['Sentinel']
   = {feet="Valor leggings"}
   
  sets.precast.JA['Shield Bash']      
   = {ear1="Knightly earring"
     ,hands="Valor gauntlets"}
   
  sets.precast.JA['Holy Circle']      
   = {feet="Gallant leggings +1"}
   
  sets.precast.JA['Chivalry']      
   = set_combine(sets.enmity
                ,sets.MND
                ,{})

  -- precast magic
  sets.precast.FC
   = {ear2="Loquacious earring"
     ,legs="Homam cosciales"}

  -- midcast magic
  sets.midcast.FastRecast 		    
   = set_combine(sets.precast.FC
                ,{head="Walahra turban"
                 ,body=scorpion_harness['Haste']
                 ,hands="Dusk gloves +1"
                 ,waist="Ninurta's sash"
                 ,feet="Homam gambieras"})

  sets.midcast['Healing Magic'] 
   = set_combine(sets.MND
                ,sets.enmity
                ,{head="Valor coronet"
                 ,neck="Ritter gorget"
                 ,ear2="Knightly earring"
                 ,body="Avalon breastplate"
                 ,ring1="Corneus ring"})
                
  sets.midcast['Healing Magic'].self
   = set_combine(sets.midcast['Healing Magic']
                ,{ammo="Fenrir's stone"
                 ,ear1="Cassie earring"
                 ,ear2="Bloodbead earring"
                 ,body="Crimson scale mail"
                 ,ring2="Bloodbead ring"
                 ,back="Gigant mantle"
                 ,waist="Ocean sash"
                 ,legs="Koenig diechlings"
                 ,feet="Homam gambieras"})
                 
  sets.midcast['Enhancing Magic']
   = set_combine(sets.enmity
                ,sets.precast.FastRecast
                ,{legs="Gallant breeches"})
                
  sets.midcast['Divine Magic']
   = set_combine(sets.enmity
                ,sets.precast.FastRecast
                ,{body="Gallant surcoat"})

  sets.midcast['Utsusemi: Ni']
   = set_combine(sets.enmity
                ,sets.midcast.FastRecast
                ,{neck="Fortified chain"
                 ,ear1="Knight's earring"
                 ,back="Boxer's mantle"})
                 
  sets.midcast['Utsusemi: Ichi']
   = set_combine(sets.midcast['Utsusemi: Ni']
                ,{head="Kaiser schaller"
                 ,ear2="Knightly earring"
                 ,legs="Valor breeches"
                 ,feet="Gallant leggings +1"})

  sets.midcast['Flash']
   = set_combine(sets.enmity
                ,sets.midcast.FastRecast
                ,{ammo="Sturm's report"
                 ,head="Homam zucchetto"
                 ,hands="Homam manopolas"
                 ,waist="Velocious belt"
                 ,legs="Homam cosciales"
                 ,feet="Homam gambieras"})

  -- defense
  sets.defense.PDT
   = {head="Valhalla helm"
     ,neck="Ritter gorget"
     ,ear1="Ethereal earring"
     ,body="Valhalla breastplate"
     ,hands="Heavy gauntlets"
     ,ring1="Defending ring"
     ,ring2="Jelly ring"
     ,back="Shadow mantle"
     ,waist="Warwolf belt"
     ,legs="Darksteel subligar +1"
     ,feet="Kaiser schuhs"}
  
  sets.defense.MDT
   = set_combine(sets.MND
                ,{head="Valhalla helm"
                 ,ear1="Ethereal earring"
                 ,ear2="Merman's earring"
                 ,body="Avalon breastplate"
                 ,ring1="Defending ring"
                 ,ring2="Shadow ring"
                 ,waist="Resolute belt"
                 ,legs="Blood cuisses"})
  
  sets.defense.Breath
   = {head="Valhalla helm"
     ,body="Crimson scale mail"
     ,ring1="Defending ring"
     ,ring2="Dragon ring +1"}

  -- idle
  sets.idle
   = {ammo="Bibiki seashell"
     ,head="Valhalla helm"        
     ,neck="Chocobo whistle" 
     ,ear1="Ethereal earring"
     ,ear2="Merman's earring"
     ,body="Valhalla breastplate"
     ,hands="Heavy gauntlets"
     ,ring1="Defending ring" 
     ,ring2="Shadow ring"
     ,back="Shadow mantle"       
     ,waist="Lycopodium sash"
     ,legs="Blood cuisses"   
     ,feet="Kaiser schuhs"}
     
  sets.idle.Town
   = set_combine(sets.idle
                ,{neck="Orochi nodowa +1"
                 ,ring2="Warp ring"
                 ,back="Nexus cape"
                 ,waist="Ninurta's sash"})

  sets.idle.SuperPDT                 
   = set_combine(sets.idle
                ,sets.defense.PDT
                ,{head="Kaiser schaller"
                 ,feet="Gallant leggings +1"})
                 
  sets.idle.SuperMDT                 
   = set_combine(sets.idle
                ,sets.defense.MDT)

  sets.resting                       
   = {ammo="Bibiki seashell"
     ,head="Crimson mask"
     ,neck="Gnole torque"
     ,ear2="Relaxing earring"
     ,body="Vermillion cloak"
     ,ring2="Star ring"}

  -- engaged
  sets.engaged                       
   = {ammo="Bibiki seashell"
     ,head="Walahra turban"    
     ,neck="Fortitude torque"
     ,ear1="Ethereal earring"
     ,ear2="Brutal earring"
     ,body="Homam corazza"     
     ,hands="Dusk gloves +1"
     ,ring1=toreador_ring['Triple Attack (2)']
     ,ring2=toreador_ring['Triple Attack (1)']
     ,back="Cerberus mantle +1"
     ,waist="Ninurta's sash"
     ,legs="Homam cosciales"
     ,feet="Homam gambieras"}
     
  sets.engaged.Acc
   = set_combine(sets.engaged
                ,{head="Homam zucchetto"
                 ,hands="Homam manopolas"
                 ,back="Cuchulain's mantle"})
                 
  sets.engaged.Heavy                 
   = {head="Kaiser schaller"     
     ,neck="Fortified chain" 
     ,ear1="Ethereal earring"
     ,ear2="Knight's earring"
     ,body="Valhalla breastplate"
     ,hands="Koenig handschuhs"
     ,ring1="Defending ring" 
     ,ring2="Shadow ring"
     ,back="Boxer's mantle"
     ,waist="Warwolf belt"
     ,legs="Koenig diechlings"
     ,feet="Gallant leggings +1"}
     
  sets.engaged.Wyrm
   = set_combine(sets.engaged.Heavy
                ,{body="Crimson scale mail"
                 ,ring2="Dragon ring +1"})

  -- weaponskill
  sets.precast.WS
   = {head="Hecatomb cap +1"   
     ,neck="Fotia gorget"          
     ,ear1="Triumph earring"     
     ,ear2="Brutal earring"
     ,body="Hecatomb harness +1"  
     ,hands="Tarasque mitts +1"
     ,ring1="Rajas ring"
     ,ring2="Strigoi ring"
     ,back="Cerberus mantle +1"
     ,waist="Warwolf belt"         
     ,legs="Hecatomb subligar +1"
     ,feet="Hecatomb leggings +1"}
     
  sets.precast.WS.Acc
   = set_combine(sets.precast.WS
                ,{hands="Hecatomb mittens +1"
                 ,ring2="Mars's ring"
                 ,back="Cuchulain's mantle"})

  sets.precast.WS['Vorpal Blade']
   = set_combine(sets.precast.WS
                ,{body="Zahak's mail"
                 ,hands="Hecatomb mittens +1"})
   
  sets.precast.WS['Vorpal Blade'].Acc
   = set_combine(sets.precast.WS['Vorpal Blade']
                ,{back="Cuchulain's mantle"})

  sets.precast.WS['Requiescat']
   = set_combine(sets.precast.WS['Vorpal Blade']
                ,{})
                
  sets.precast.WS['Requiescat'].Acc
   = set_combine(sets.precast.WS['Vorpal Blade'].Acc
                ,{})

  sets.precast.WS['Atonement']
   = set_combine(sets.enmity
                ,{})
                
  sets.precast.WS['Atonement'].Acc
   = set_combine(sets.precast.WS['Atonement']
                ,{})

end

function job_post_precast(spell,action,spellMap,eventArgs)
  
  if spell.type == 'JobAbility' then
    if state.Tank.value then
      equip(set_combine(sets.enmity,sets.precast.JA[spell.english]) or sets.enmity)
    else
      equip(set_combine(sets.enmity,sets.precast.JA[spell.english]) or sets.enmity)
    end
  end
  
end

function job_buff_change(name,gain)

  sleep_swap(name,gain)

  if name:contains('Copy Image') then
    state.Buff[name] = gain
    handle_equipping_gear(player.status)
  end

end

function customize_melee_set(meleeSet)

  if state.Buff['Copy Image (3)'] or state.Buff['Copy Image (2)'] or state.Buff['Copy Image'] then
    if state.OffenseMode.value == 'Heavy' then
      meleeSet = set_combine(sets.engaged.Acc,{body="Avalon breastplate",ring1="Defending ring"})
    elseif state.OffenseMode.value == 'Wyrm' then
      meleeSet = set_combine(sets.engaged.Acc,{body="Crimson scale mail",ring1="Defending ring"})
    end
  end

  return meleeSet

end

function job_post_midcast(spell,action,spellMap,eventArgs)

  if spellMap == 'Cure' and spell.target.type == 'SELF' then
    equip(sets.midcast['Healing Magic'].self)
  end

  if spell.skill == 'Healing Magic' or spell.skill == 'Divine Magic' then
    if spell.element == world.weather_element or spell.element == world.day_element and world.weather_element ~= 'Dark' then
      equip({waist="Hachirin-no-obi"})
    end
  end

end

function job_status_change(new,old)

  gear.main = player.equipment.main
  gear.sub = player.equipment.sub

end

function customize_idle_set(idleSet)

  if state.IdleMode.value ~= 'Normal' then
    if player.hpp < 75 then
      idleSet = set_combine(idleSet,{head="Crimson mask"})
      if daytime then
        idleSet = set_combine(idleSet,{waist="Lycopodium sash"})
      end
      if player.hpp < 50 then
        idleSet = set_combine(idleSet,{ring2="Hercules' ring"})
      end
    elseif (player.hpp >= 85 and player.mpp < 50) then
      idleSet = set_combine(idleSet,{neck="Parade gorget"})
    end
  end
  
  return idleSet

end
