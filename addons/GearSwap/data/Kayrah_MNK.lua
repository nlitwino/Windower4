function get_sets()

	mote_include_version = 2
	include('Mote-Include.lua')
  include('organizer-lib')

end

function job_setup()
	
	include('Kay-Include.lua')

  state.Buff['Footwork'] = buffactive['Footwork'] or false
  state.Buff['Hundred Fists'] = buffactive['Hundred Fists'] or false
  state.Buff['Focus'] = buffactive['Focus'] or false

  state.Buff['Copy Image (3)'] = buffactive['Copy Image (3)'] or false
  state.Buff['Copy Image (2)'] = buffactive['Copy Image (2)'] or false
  state.Buff['Copy Image (1)'] = buffactive['Copy Image'] or false
	
	initialize_job()

end

function user_setup()

	state.OffenseMode:options('Normal','HybridAcc','Acc','Tank')
	state.WeaponskillMode:options('Normal','Atk','Acc','AtkAcc')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	
end

function init_gear_sets()

  -- misc sets
  sets.postPrecast
  = {}
  
  sets.enmityUp
  = {head="Arhat's jinpachi +1"
    ,ear1="Hades earring +1"
    ,body="Arhat's gi +1"
    ,ring2="Corneus ring"
    ,back="Cerberus mantle +1"
    ,waist="Warwolf belt"
    ,feet="Hermes' sandals +1"}
  
  sets.enmityDown
  = {head="Zha'Go's barbut"
    ,ear1="Novia earring"
    ,ring2="Veela ring"
    ,waist="Buccaneer's belt"
    ,legs="Raven hose"}
  
  sets.Regen
  = {neck="Orochi nodowa +1"
    ,body="Melee cyclas"}
  
  sets.Regen.daytime
  = set_combine(sets.Regen
               ,{hands="Garden bangles"
                ,waist="Lycopodium sash"})
                
  -- precast jas
  sets.precast['Boost']
  = {hands="Temple gloves"}
                
  sets.precast['Focus']
  = {head="Temple crown"}
  
  sets.precast['Dodge']
  = {feet="Temple gaiters"}
  
  sets.precast['Counterstance']
  = {feet="Melee gaiters"}
  
  sets.precast['Chi Blast']
  = {head="Maat's cap"
    ,neck="Faith torque"
    ,ear1="Mamool Ja earring"
    ,ear2="Celestial earring"
    ,body="Kirin's osode"
    ,hands="Marine F gloves"
    ,ring1="Star ring"
    ,ring2="Omega ring"
    ,back="Melee cape"
    ,waist="Ocean stone"
    ,feet="Suzaku's sune-ate"}
  
  sets.precast['Chakra']
  = {ammo="Bibiki seashell"
    ,head="Genbu's kabuto"
    ,neck="Fortitude torque"
    ,ear2="Cassie earring"
    ,body="Temple cyclas"
    ,hands="Melee gloves"
    ,ring2="Corneus ring"
    ,back="Melee cape"
    ,waist="Warwolf belt"
    ,legs="Kensei sitabaki"}
    
  sets.precast.Waltz
  = {head="Maat's cap"
    ,neck="Temperance torque"
    ,ear1="Melody earring +1"
    ,body="Kirin's osode"
    ,hands="Marine F gloves"
    ,ring1="Veela ring"
    ,waist="Corsette +1"}
    
  sets.precast.WaltzSelf
  = set_combine(sets.precast.Waltz
               ,{ammo="Bibiki seashell"
                ,head="Genbu's kabuto"
                ,ear2="Cassie earring"
                ,hands="Garden bangles"
                ,ring1="Corneus ring"
                ,back="Melee cape"
                ,legs="Kensei sitabaki"})
                
  -- precast magic
  sets.precast.FC
  = {ear2="Loquacious earring"}
  
  -- midcast magic
  sets.midcast.FastRecast
  = set_combine(sets.precast.FC
               ,{head="Walahra turban"
                ,neck="Tiercel necklace"
                ,body=scorpion_harness['Haste']
                ,waist="Black belt"
                ,legs="Byakko's haidate"
                ,feet="Sarutobi kyahan"})

  sets.midcast['Utsusemi: Ni']
  = set_combine(sets.midcast.FastRecast
               ,{neck="Fortified chain"
                ,ear1="Magnetic earring"
                ,hands="Seiryu's kote"
                ,ring1="Defending ring"
                ,back="Boxer's mantle"})
                 
  sets.midcast['Utsusemi: Ichi']
  = set_combine(sets.midcast['Utsusemi: Ni']
               ,{head="Gnole crown"
                ,ear2="Novia earring"
                ,waist="Ninurta's sash"
                ,legs="Raven hose"
                ,feet="Hachiryu sune-ate"})
  
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
    ,waist="Black belt"
    ,legs="Darksteel subligar +1"
    ,feet="Hermes' sandals +1"}
    
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
    ,ear1="Drone earring"
    ,ear2="Drone earring"
    ,body=scorpion_harness['Haste']
    ,hands="Seiryu's kote"
    ,ring1="Defending ring"
    ,ring2="Jelly ring"
    ,back="Boxer's mantle"
    ,legs="Raven hose"
    ,feet="Hachiryu sune-ate"}
  
  sets.defense.PDT
  = set_combine(sets.defense.Evasion
               ,{ammo="Bibiki seashell"
                ,head="Arhat's jinpachi +1"
                ,neck="Wivre gorget"
                ,body="Arhat's gi +1"
                ,ring1="Defending ring"
                ,ring2="Jelly ring"
                ,back="Shadow mantle"
                ,waist="Black belt"
                ,legs="Darksteel subligar +1"})
  
  sets.defense.MDT
  = {head="Genbu's kabuto"
    ,ear1="Merman's earring"
    ,ear2="Merman's earring"
    ,body="Avalon breastplate"
    ,hands="Seiryu's kote"
    ,ring1="Defending ring"
    ,ring2="Shadow ring"
    ,waist="Resolute belt"
    ,legs="Byakko's haidate"
    ,feet="Suzaku's sune-ate"}
    
  -- engaged
  sets.engaged 
  = {ammo="Black tathlum"
    ,head="Walahra turban"
    ,neck="Faith torque"
    ,ear1="Merman's earring"
    ,ear2="Brutal earring"
    ,body="Hachiryu haramaki"
    ,hands="Bandomusha kote"
    ,ring1=toreador_ring['Triple Attack (1)']         
    ,ring2=toreador_ring['Triple Attack (3)']
    ,back="Cerberus mantle +1"
    ,waist="Black belt"
    ,legs="Byakko's haidate"
    ,feet="Sarutobi kyahan"}
  
  sets.engaged.HybridAcc 
  = set_combine(sets.engaged
               ,{neck="Peacock amulet"
                ,hands="Hachiryu kote"
                ,back="Cuchulain's mantle"})
  
  sets.engaged.Acc 
  = set_combine(sets.engaged.HybridAcc
               ,{ring2=toreador_ring['Triple Attack (2)']})
  
  sets.engaged.Tank 
  = set_combine(sets.engaged
               ,{ammo="Bibiki seashell"
                ,body="Arhat's gi +1"
                ,hands="Melee gloves"
                ,ring1="Defending ring"
                ,back="Shadow mantle"})
                
  sets.engaged['Hundred Fists']
  = set_combine(sets.engaged
               ,{head="Gnadbhod's helm"
                ,legs="Hachiryu haidate"
                ,feet="Rasetsu sune-ate"})
                
  -- base weaponskill sets
  sets.precast.WS 
  = {ammo="Black tathlum"
    ,head="Maat's cap"
    ,neck="Fotia gorget"
    ,ear1="Merman's earring"
    ,ear2="Brutal earring"
    ,body="Kirin's osode"
    ,hands="Bandomusha kote"
    ,ring1="Rajas ring"
    ,ring2=toreador_ring['Triple Attack (3)']
    ,back="Cerberus mantle +1"
    ,waist="Warwolf belt"
    ,legs="Hachiryu haidate"
    ,feet="Rasetsu sune-ate"}
    
  sets.precast.WS.Atk
  = set_combine(sets.precast.WS
               ,{body="Hachiryu haramaki"})
    
  sets.precast.WS.Acc
  = set_combine(sets.precast.WS
               ,{body="Hachiryu haramaki"
                ,hands="Hachiryu kote"
                ,ring2=toreador_ring['Triple Attack (2)']
                ,waist="Virtuoso belt"})
    
  sets.precast.WS.AtkAcc
  = set_combine(sets.precast.WS
               ,{body="Hachiryu haramaki"
                ,ring2=toreador_ring['Triple Attack (2)']
                ,waist="Virtuoso belt"})
                
  -- asuran fists
  sets.precast.WS['Asuran Fists']
  = {ammo="Black tathlum"
    ,head="Maat's cap"
    ,neck="Fotia gorget"
    ,ear1="Triumph earring"
    ,ear2="Cassie earring"
    ,body="Kirin's osode"
    ,hands="Alkyoneus's bracelets"
    ,ring1="Rajas ring"
    ,ring2="Strigoi ring"
    ,back="Cerberus mantle +1"
    ,waist="Black belt"
    ,legs="Hachiryu haidate"
    ,feet="Rasetsu sune-ate"}
  
  sets.precast.WS['Asuran Fists'].Atk
  = set_combine(sets.precast.WS['Asuran Fists'] 
               ,{head="Gnadbhod's helm"
                ,ear1="Merman's earring"
                ,body="Hachiryu haramaki"
                ,hands="Bandomusha kote"
                ,ring1="Mars's ring"
                ,ring2="Strigoi ring"})
  
  sets.precast.WS['Asuran Fists'].Acc
  = set_combine(sets.precast.WS['Asuran Fists'] 
               ,{head="Hissho hachimaki"
                ,ear1="Merman's earring"
                ,body="Hachiryu haramaki"
                ,hands="Bandomusha kote"
                ,ring1="Mars's ring"
                ,ring2="Strigoi ring"
                ,waist="Virtuoso belt"})
  
  sets.precast.WS['Asuran Fists'].AtkAcc
  = set_combine(sets.precast.WS['Asuran Fists'] 
               ,{head="Hissho hachimaki"
                ,ear1="Merman's earring"
                ,body="Hachiryu haramaki"
                ,hands="Bandomusha kote"
                ,ring1="Mars's ring"
                ,ring2="Strigoi ring"
                ,waist="Virtuoso belt"})
                
  -- VS
  sets.precast.WS['Victory Smite']
  = sets.precast.WS['Asuran Fists']
  
  sets.precast.WS['Victory Smite'].Atk
  = sets.precast.WS['Asuran Fists'].Atk
  
  sets.precast.WS['Victory Smite'].Acc
  = sets.precast.WS['Asuran Fists'].Acc
  
  sets.precast.WS['Victory Smite'].AtkAcc
  = sets.precast.WS['Asuran Fists'].AtkAcc
  
  -- Final heaven
  sets.precast.WS['Final Heaven']
  = {ammo="Bibiki seashell"
    ,head="Genbu's kabuto"
    ,neck="Fotia gorget"
    ,ear1="Merman's earring"
    ,ear2="Brutal earring"
    ,body="Kirin's osode"
    ,hands="Bandomusha kote"
    ,ring1="Corneus ring"
    ,ring2=toreador_ring['Triple Attack (3)']
    ,back="Melee cape"
    ,waist="Warwolf belt"
    ,legs="Kensei sitabaki"
    ,feet="Rasetsu sune-ate"}
  
  sets.precast.WS['Final Heaven'].Atk
  = set_combine(sets.precast.WS['Final Heaven']
               ,{ammo="Black tathlum"
                ,head="Maat's cap"
                ,ring1="Strigoi ring"
                ,back="Cerberus mantle +1"
                ,legs="Hachiryu haidate"})
  
  sets.precast.WS['Final Heaven'].Acc
  = set_combine(sets.precast.WS['Final Heaven']
               ,{ammo="Black tathlum"
                ,head="Maat's cap"
                ,body="Hachiryu haramaki"
                ,ring1="Mars's ring"
                ,back="Cerberus mantle +1"
                ,waist="Virtuoso belt"
                ,legs="Hachiryu haidate"})
  
  sets.precast.WS['Final Heaven'].AtkAcc
  = set_combine(sets.precast.WS['Final Heaven']
               ,{ammo="Black tathlum"
                ,head="Hissho hachimaki"
                ,body="Hachiryu haramaki"
                ,ring1="Strigoi ring"
                ,back="Cerberus mantle +1"
                ,waist="Virtuoso belt"
                ,legs="Hachiryu haidate"})
  
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

  if spell.type == 'WeaponSkill' and state.WeaponskillMode.value ~= 'Normal' then
    
    if state.Buff['Focus'] then
      if state.WeaponskillMode.value == 'Acc' then
        sets.postPrecast = sets.precast.WS[spell.english].AtkAcc
      elseif state.WeaponskillMode.value == 'AtkAcc' then 
        sets.postPrecast = sets.precast.WS[spell.english].Atk
      end
    end
    
    if daytime then
      if spell.english ~= 'Asuran Fists' or spell.english ~= 'Victory Smite' then 
        sets.postPrecast = set_combine(sets.postPrecast,{ear1="Fenrir's earring"})
      else
        sets.postPrecast = set_combine(sets.postPrecast,{ear2="Fenrir's earring"})
      end
    end
    
  elseif spell.type == 'JobAbility' then  -- job ability handling
  
    if state.Tank.value then
      sets.postPrecast = set_combine(sets.enmityUp,sets.precast.JA[spell.english]) or sets.enmityUp
    else
      sets.postPrecast = set_combine(sets.enmityDown,sets.precast.JA[spell.english]) or sets.enmityDown
    end
    
  elseif spell.type == 'Waltz' and spell.target.type == 'SELF' then
  
    sets.postPrecast = set_combine(sets.postPrecast,sets.precast.WaltzSelf)
    
    if world.day_element == 'Dark' then
      sets.postPrecast = set_combine(sets.postPrecast,{back="Shadow mantle"})
    end
    
  end

  equip(sets.postPrecast)
  sets.postPrecast = {}

end

function customize_melee_set(meleeSet)

  if state.OffenseMode.value == 'Tank' then
    if state.Buff['Copy Image (3)'] or state.Buff['Copy Image (2)'] or state.Buff['Copy Image'] then
      meleeSet = set_combine(sets.engaged.Tank,{body="Avalon breastplate"})
    end
  else
    if state.Buff['Focus'] then
      if state.OffenseMode.value == 'Acc' then
        meleeSet = sets.engaged.HybridAcc
      elseif state.OffenseMode.value == 'HybridAcc' then
        meleeSet = sets.engaged
      end
    end
  end
  
  if state.Buff['Hundred Fists'] then
    meleeSet = set_combine(meleeSet,sets.engaged['Hundred Fists'])
  end

  if daytime then
    meleeSet = set_combine(meleeSet,{ear1="Fenrir's earring"})
  end
  
  return meleeSet
	
end

function customize_idle_set(idleSet)

  if player.hpp <= 75 then
    if daytime then
      idleSet = set_combine(idleSet,sets.Regen.daytime)
    else
      idleSet = set_combine(idleSet,sets.Regen)
    end
  end
 
  if state.Ranged.value then
    idleSet = set_combine(idleSet, sets[state.RangedMode.value])
  end

  return idleSet

end

function adjust_melee_groups()
	
end