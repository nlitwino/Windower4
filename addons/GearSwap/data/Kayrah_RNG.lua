function get_sets()

  -- Import Mote-Include
  mote_include_version = 2
  include('Mote-Include.lua')
  include('organizer-lib')

end

function job_setup()

  include('Kay-Include.lua')

  -- Establish flags for buffs
  state.Buff['Camouflage']     = buffactive['Camouflage'] or false
  state.Buff['Barrage']        = buffactive['Barrage'] or false
  state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false

  initialize_job()

  --get main and sub weapons for regear function
  gear.ammo = player.equipment.ammo

end

function user_setup()

  -- Setup appropriate modes
  state.OffenseMode:options('Normal','DW','HNM')
  state.RangedMode:options('Normal','HybridAcc','Acc')
  state.WeaponskillMode:options('Normal','Power','Acc','Test')

end

function init_gear_sets()

  -- misc.
  sets.enmityUp
   = {neck="Ritter gorget"
     ,ear1="Hades earring +1"
     ,body="Avalon breastplate"
     ,ring1="Corneus ring"
     ,back="Cerberus mantle +1"
     ,waist="Trance belt"}
  
  sets.enmityDown
   = {head="Zha'Go's barbut"
     ,ear1="Novia earring"
     ,body="Scout's jerkin"
     ,hands="Scout's bracers"
     ,ring1="Veela ring"
     ,waist="Buccaneer's belt"
     ,feet="Scout's socks +1"}

  -- buff
  sets.buff['Camouflage']
   = {body="Hunter's jerkin"}
   
  sets.buff['Barrage']
   = {hands="Hunter's bracers +1"}

  -- precast ja
  sets.precast.JA['Camoflage']
   = {body="Hunter's jerkin"}
   
  sets.precast.JA['Scavenge']
   = {feet="Hunter's socks +1"}
   
  sets.precast.JA['Shadowbind']
   = {hands="Hunter's bracers +1"}

  -- precast magic
  sets.precast.FC
   = {ear2="Loquacious earring"}

  -- midcast magic
  sets.midcast.FastRecast
   = set_combine(sets.precast.FC
                ,{head="Walahra turban"
                ,neck="Tiercel necklace" 
                ,hands="Dusk gloves +1"
                ,waist="Velocious belt"
                ,legs="Byakko's haidate"
                ,feet="Dusk ledelsens +1"})
                
  sets.midcast['Utsusemi: Ni']
   = set_combine(sets.midcast.FastRecast
                ,{ear1="Novia earring"
                ,body="Enkidu's harness"
                ,ring1="Defending ring"
                ,back="Shadow mantle"})
   
  sets.midcast['Utsusemi: Ichi']
   = set_combine(sets.midcast['Utsusemi: Ni']
                ,{neck="Ritter gorget"
                 ,ear1="Magnetic earring"
                 ,hands="Scout's bracers"
                 ,waist="Resolute belt"
                 ,feet="Hunter's socks +1"})

  -- idle
  sets.idle 
   = {head="Genbu's kabuto"
     ,neck="Chocobo whistle" 
     ,ear1="Merman's earring"
     ,ear2="Merman's earring"
     ,body="Kyudogi +1"   
     ,hands="Seiryu's kote"  
     ,ring1="Defending ring" 
     ,ring2="Shadow ring"
     ,back="Shadow mantle"
     ,waist="Resolute belt"
     ,legs="Blood cuisses" 
     ,feet="Trotter boots"}
    
  sets.idle.Town
   = set_combine(sets.idle
                ,{neck="Orochi nodowa"
                 ,ring2="Warp ring"
                 ,back="Nexus cape"})
                 
  -- defense                                   
  sets.defense.Evasion
   = {neck="Ritter gorget"   
     ,ear1="Novia earring"
     ,body=scorpion_harness['Haste']
     ,hands="Scout's bracers"
     ,back="Boxer's mantle"       
     ,feet="Hachiryu sune-ate"}
   
  sets.defense.PDT
   = {head="Genbu's kabuto"
     ,neck="Wivre gorget +1"
     ,body="Kirin's osode"                   
     ,ring1="Defending ring"      
     ,ring2="Jelly ring"
     ,back="Shadow mantle"                          
     ,legs="Dusk trousers +1"
     ,feet="Hachiryu sune-ate"}
                                               
  sets.defense.MDT
   = {head="Genbu's kabuto"
     ,ear1="Merman's earring"
     ,ear2="Merman's earring"
     ,body="Avalon breastplate"
     ,hands="Blood finger gauntlets"
     ,ring1="Defending ring"
     ,ring2="Shadow ring"
     ,waist="Resolute belt"
     ,legs="Blood cuisses"
     ,feet="Suzaku's sune-ate"}
         
  -- engaged
  sets.engaged
   = {head="Walahra turban"    
     ,neck="Ancient torque" 
     ,ear1="Hollow earring"  
     ,ear2="Brutal earring"
     ,body="Hachiryu haramaki" 
     ,hands="Dusk gloves +1"
     ,ring1=toreador_ring['Triple Attack (1)']   
     ,ring2=toreador_ring['Triple Attack (2)']
     ,back="Cuchulain's mantle"
     ,waist="Velocious belt"
     ,legs="Byakko's haidate"
     ,feet="Dusk ledelsens +1"}
     
  sets.engaged.DW                           
   = set_combine(sets.engaged
                ,{ear1="Suppanomimi"})
                
  sets.engaged.HNM                          
   = set_combine(sets.engaged
                ,{head="Genbu's kabuto"      
                 ,neck="Orochi nodowa" 
                 ,ear1="Merman's earring"
                 ,ear2="Merman's earring"
                 ,body="Avalon breastplate"
                 ,hands="Seiryu's kote"
                 ,ring1="Defending ring" 
                 ,ring2="Shadow ring"
                 ,back="Shadow mantle"     
                 ,waist="Resolute belt"
                 ,legs="Blood cuisses"   
                 ,feet="Suzaku's sune-ate"})

  -- precast ranged
  sets.precast.RA                           
   = {head="Hunter's beret +1"
     ,neck="Peacock amulet"
     ,ear1="Drone earring"   
     ,ear2="Drone earring"
     ,body="Scout's jerkin"   
     ,hands="Seiryu's kote"
     ,ring1="Rajas ring"     
     ,ring2="Behemoth ring +1"
     ,back="Mamool Ja mantle" 
     ,waist="Scout's belt" 
     ,legs="Dusk trousers +1"
     ,feet="Hachiryu sune-ate"}
     
  sets.precast.RA.Anni 
   = set_combine(sets.precast.RA
                ,{})
                
  sets.precast.RA.Yoichi					  
   = set_combine(sets.precast.RA
                ,{legs="Hachiryu haidate"})

  -- midcast ranged
  -- Vulcan
  sets.midcast.RA                           
   = {head="Zha'Go's barbut" 
     ,neck="Peacock amulet"           
     ,ear1="Drone earring"   
     ,ear2="Drone earring"
     ,body="Kyudogi +1"     
     ,hands="Blood finger gauntlets"
     ,ring1="Rajas ring"     
     ,ring2="Cerberus ring +1"
     ,back="Amemet mantle +1"
     ,waist="Scout's belt"          
     ,legs="Hachiryu haidate"
     ,feet="Scout's socks +1"}

  sets.midcast.RA.HybridAcc                 
  = set_combine(sets.midcast.RA
               ,{ear2="Hollow earring"
                ,ring2="Behemoth ring +1"
                ,feet="Hachiryu sune-ate"})
                
  sets.midcast.RA.Acc                       
  = set_combine(sets.midcast.RA.HybridAcc
               ,{hands="Seiryu's kote"
                ,back="Mamool Ja mantle"
                ,legs="Dusk trousers +1"})

  -- midcast anni (AXE GRIP)
  sets.midcast.RA.Anni
   = set_combine(sets.midcast.RA
                ,{neck="Faith torque"})
                
  sets.midcast.RA.Anni.HybridAcc
   = set_combine(sets.midcast.RA.HybridAcc
                ,{neck="Faith torque"})
                
  sets.midcast.RA.Anni.Acc                 
   = set_combine(sets.midcast.RA.Acc
                ,{ring1="Rajas ring"
                 ,ring2="Behemoth ring +1"})

  -- midcast yoichi (ROSE STRAP)
  sets.midcast.RA.Yoichi                    
   = set_combine(sets.midcast.RA,{neck="Hope torque",feet="Hachiryu sune-ate"})
   
  sets.midcast.RA.Yoichi.HybridAcc          
   = set_combine(sets.midcast.RA.Yoichi
                ,{ring2="Behemoth ring +1"})
   
  sets.midcast.RA.Yoichi.Acc                
   = set_combine(sets.midcast.RA.Yoichi.HybridAcc
                ,{hands="Seiryu's kote"
                 ,back="Mamool Ja mantle"})

  -- weaponskill
  sets.precast.WS                           
   = {head="Maat's cap"
     ,neck="Fotia gorget"   
     ,ear1="Drone earring"   
     ,ear2="Drone earring"
     ,body="Kirin's osode"   
     ,hands="Seiryu's kote" 
     ,ring1="Rajas ring"     
     ,ring2="Blobnag ring"
     ,back="Amemet mantle +1"
     ,waist="Scout's belt"
     ,legs="Hachiryu haidate"
     ,feet="Hachiryu sune-ate"}
     
  sets.precast.WS.Power
   = set_combine(sets.precast.WS
                ,{hands="Blood finger gauntlets"})
   
  sets.precast.WS.Acc
   = set_combine(sets.precast.WS
                ,{})

  -- sidewinder
  sets.precast.WS['Sidewinder']
   = set_combine(sets.precast.WS
                ,{hands="Blood finger gauntlets"})
   
  sets.precast.WS['Sidewinder'].Power
   = set_combine(sets.precast.WS['Sidewinder']
                ,{ring2="Cerberus ring +1"})
   
  sets.precast.WS['Sidewinder'].Acc
   = set_combine(sets.precast.WS['Sidewinder']
                ,{hands="Seiryu's kote"})

  -- jishnu's
  sets.precast.WS['Jishnu\'s Radiance']    
   = set_combine(sets.precast.WS['Sidewinder']
                ,{})
  sets.precast.WS['Jishnu\'s Radiance'].Power
   = set_combine(sets.precast.WS['Sidewinder'].Power
                ,{})
  sets.precast.WS['Jishnu\'s Radiance'].Acc
   = set_combine(sets.precast.WS['Sidewinder'].Acc
                 ,{})
  -- namas arrow
  sets.precast.WS['Namas Arrow']
   = set_combine(sets.precast.WS
                ,{hands="Blood finger gauntlets"
                 ,ear2="Triumph earring"
                 ,ring2="Blobnag ring"})
                 
  sets.precast.WS['Namas Arrow'].Power
   = set_combine(sets.precast.WS['Namas Arrow']
                ,{ring2="Strigoi ring"})
                 
  sets.precast.WS['Namas Arrow'].Acc
   = set_combine(sets.precast.WS['Namas Arrow']
                ,{ear1="Drone earring"
                 ,ear2="Drone earring"
                 ,hands="Seiryu's kote"})

  -- slug shot
  sets.precast.WS['Slug Shot']
   = set_combine(sets.precast.WS
                ,{ear2="Triumph earring"})
   
  sets.precast.WS['Slug Shot'].Power
   = set_combine(sets.precast.WS['Slug Shot']
                ,{hands="Blood finger gauntlets"
                 ,ring2="Cerberus ring +1"
                 ,feet="Scout's socks +1"})
   
  sets.precast.WS['Slug Shot'].Acc
   = set_combine(sets.precast.WS['Slug Shot']
                ,{ear2="Drone earring"
                 ,legs="Dusk trousers +1"})

  -- last stand
  sets.precast.WS['Last Stand']
   = set_combine(sets.precast.WS['Slug Shot'],{})
   
  sets.precast.WS['Last Stand'].Power
   = set_combine(sets.precast.WS['Slug Shot'].Power,{})
   
  sets.precast.WS['Last Stand'].Acc
   = set_combine(sets.precast.WS['Slug Shot'].Acc,{})
   
  -- coronach
  sets.precast.WS['Coronach']
   = set_combine(sets.precast.WS
                ,{ear2="Drone earring"
                 ,ring2="Cerberus ring +1"
                 ,feet="Hunter's socks +1"})
                
  sets.precast.WS['Coronach'].Power
   = set_combine(sets.precast.WS['Coronach']
                ,{ear1="Triumph earring"
                 ,hands="Blood finger gauntlets"
                 ,ring2="Cerberus ring +1"
                 ,feet="Scout's socks +1"})
  
  sets.precast.WS['Coronach'].Acc
   = set_combine(sets.precast.WS['Coronach']
                ,{ear2="Hollow earring"
                 ,feet="Hachiryu sune-ate"})
                 
  sets.precast.WS['Coronach'].Test
   = set_combine(sets.precast.WS['Coronach'].Power
                ,{ring2="Strigoi ring"})
                
  -- custom EES
  sets.precast.JA['Eagle Eye Shot']
    = set_combine(sets.midcast.RA
                 ,{})
    
  sets.precast.JA['Eagle Eye Shot'].HybridAcc
    = set_combine(sets.midcast.RA.HybridAcc
                 ,{})
                 
  sets.precast.JA['Eagle Eye Shot'].Acc
    = set_combine(sets.midcast.RA.Acc
                 ,{})
    -- custom EES (ANNI)
  sets.precast.JA['Eagle Eye Shot'].Anni
    = set_combine(sets.midcast.RA.Anni
                 ,{})
    
  sets.precast.JA['Eagle Eye Shot'].Anni.HybridAcc
    = set_combine(sets.midcast.RA.Anni.HybridAcc
                 ,{})
    
  sets.precast.JA['Eagle Eye Shot'].Anni.Acc
    = set_combine(sets.midcast.RA.Anni.Acc
                 ,{})
    -- custom EES (YOICHI)
  sets.precast.JA['Eagle Eye Shot'].Yoichi
    = set_combine(sets.midcast.RA.Yoichi
                 ,{})
    
  sets.precast.JA['Eagle Eye Shot'].Yoichi.HybridAcc
    = set_combine(sets.midcast.RA.Yoichi.HybridAcc
                 ,{})
    
  sets.precast.JA['Eagle Eye Shot'].Yoichi.Acc
    = set_combine(sets.midcast.RA.Yoichi.Acc
                 ,{})

end

function job_precast(spell,action,spellMap,eventArgs)

  if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
    ammo_recharge()
  end
end

function job_post_precast(spell,action,spellMap,eventsArgs)

  if player.equipment.range == 'Annihilator' then
    state.CombatWeapon:set('Anni')
  elseif player.equipment.range == 'Yoichinoyumi' then
    state.CombatWeapon:set('Yoichi')
  end

  if spell.type == 'JobAbility' then
    if state.Tank.value then
      equip(set_combine(sets.enmityUp,sets.precast.JA[spell.english]) or sets.enmityUp)
    else
      equip(set_combine(sets.enmityDown,sets.precast.JA[spell.english]) or sets.enmityDown)
    end
  end

  if spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
    if state.WeaponskillMode.value == 'Power' then
      if daytime then
        equip({ear1="Ladybug earring +1",ear1="Ladybug earring +1"})
      else
        equip({ear1="Fenrir's earring"})
      end
    end
  end
  
  if spell.name == 'Eagle Eye Shot' then
    if daytime then
      equip({ear1="Ladybug earring +1",ear2="Ladybug earring +1"})
    else
      equip({ear1="Fenrir's earring"})
    end
  end

  if state.Buff['Unlimited Shot'] and spell.type == 'WeaponSkill' and spell.skill == 'Archery' then
    equip({ammo="Combat Caster's arrow"})
  end

end

function job_post_aftercast(spell,action,spellMap,eventArgs)

  if player.equipment.ammo == 'Cmb.Cst. Arrow' then
    add_to_chat("Re-equipping "..gear.ammo.."s.")
    equip({ammo=gear.ammo})
  end

end

function job_post_midcast(spell,action,spellMap,eventsArgs)

  if spell.action_type == 'Ranged Attack' then
  
    if state.Buff['Barrage'] then
      equip(sets.buff['Barrage'])
    end
    
    if daytime then
      equip({ear1="Ladybug earring +1"})
      if state.RangedMode.value == 'Normal' then
        equip({ear2="Ladybug earring +1"})
      end
    else
      equip({ear1="Fenrir's earring"})
    end
    
  end

end

function job_buff_change(buff,gain)

  sleep_swap(name,gain)

  if buff == "Camouflage" then
    if gain then
      equip(sets.buff['Camouflage'])
      disable('body')
    else
      enable('body')
    end
  end

end

function customize_idle_set(idleSet)

  if player.hpp < 75 and daytime then
    idleSet = set_combine(idleSet,{head="Crimson mask",hands="Garden bangles",waist="Lycopodium sash"})
  end
  
  return idleSet
  
end