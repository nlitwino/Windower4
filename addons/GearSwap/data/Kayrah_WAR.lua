function get_sets()

  mote_include_version = 2
  include('Mote-Include.lua')
  include('organizer-lib')

end

function job_setup()

  state.Buff['Mighty Strikes']    = buffactive['Mighty Strikes'] or false
  state.Buff['Warrior\'s Charge'] = buffactive['Warrior\'s Charge'] or false

  include('Kay-Include.lua')

  gaxe_singlehit = S{'Shield Break','Iron Tempest','Armor Break','Keen Edge','Weapon Break','Full Break','Steel Cyclone','Metatron Torment'}

  aggressor_mode = ''

  initialize_job()

end

function user_setup()

  state.OffenseMode:options('Normal','Acc')
  state.WeaponskillMode:options('Normal','HNM')
  state.PhysicalDefenseMode:options('PDT')
  state.MagicalDefenseMode:options('MDT')

end

function init_gear_sets()

  --Misc.
  sets.enmityUp
   = {head="Warrior's mask"
     ,neck="Ritter gorget"
     ,ear1="Hades earring +1"
     ,body="Warrior's lorica"
     ,hands="Warrior's mufflers"
     ,ring1="Corneus ring"
     ,ring2="Hercules' ring"
     ,back="Cerberus mantle +1"
     ,waist="Trance belt",
     legs="Warrior's cuisses"
     ,feet="Conte gambieras"}
     
  sets.enmityDown
   = {head="Zha'Go's barbut"
     ,ear1="Novia earring"
     ,hands="Heavy gauntlets"
     ,ring1="Veela ring"
     ,waist="Buccaneer's belt"}

  --Precast JAs
  sets.precast.JA['Provoke']
   = {}
  sets.precast.JA['Warcry']
   = {head="Warrior's mask"}

  sets.precast.JA['Tomahawk']
   = {ammo="Thr. Tomahawk"}
   
  -- Waltz set (chr and vit)
  sets.precast.Waltz
   = {head="Kaiser schaller"
     ,neck="Temperance torque"
     ,ear1="Cassie earring"
     ,ear2="Melody earring +1"
     ,body="Koenig cuirass"
     ,hands="Marine F gloves"
     ,ring1="Veela ring"
     ,ring2="Light ring"
     ,back="Shadow mantle"
     ,waist="Corsette +1"
     ,legs="Koenig Diechlings"
     ,feet="Kaiser schuhs"}

  sets.precast.WaltzSelf
   = set_combine(sets.precast.Waltz
                ,{ring2="Corneus ring"})

  --Precast Magic
  sets.precast.FC
   = {ear2="Loquacious earring"}

  --Midcast Magic
  sets.midcast.FastRecast
   = set_combine(sets.precast.FC
                ,{head="Walahra turban"
                 ,ear1="Magnetic earring"
                 ,body=scorpion_harness['Haste']
                 ,hands="Dusk gloves +1"
                 ,waist="Ninurta's sash"
                 ,legs="Byakko's haidate"
                 ,feet="Dusk ledelsens +1"})

  sets.midcast['Utsusemi: Ni']
   = set_combine(sets.midcast.FastRecast
                ,{neck="Fortified chain"
                 ,back="Shadow mantle"})
                 
  sets.midcast['Utsusemi: Ichi']
   = set_combine(sets.midcast['Utsusemi: Ni']
                ,{})

  --Idle Sets
  sets.idle
   = {ammo="Bibiki seashell"
     ,head="Valhalla helm" 
     ,neck="Chocobo whistle" 
     ,ear1="Merman's earring" 
     ,ear2="Merman's earring"
     ,body="Valhalla breastplate" 
     ,hands="Heavy gauntlets"
     ,ring1="Defending ring"  
     ,ring2="Shadow ring"
     ,back="Shadow mantle"  
     ,waist="Resolute belt"
     ,legs="Koenig diechlings"
     ,feet="Hermes' sandals"}
     
  sets.idle.Town
   = set_combine(sets.idle
                ,{neck="Orochi nodowa +1"
                 ,ring2="Warp ring"
                 ,back="Nexus cape"
                 ,waist="Ninurta's sash"})

  --Defense Sets
  sets.defense.PDT                       
   = {head="Valhalla helm"
     ,body="Valhalla breastplate"
     ,hands="Heavy gauntlets"
     ,ring1="Defending ring"
     ,ring2="Jelly ring"
     ,back="Shadow mantle"
     ,waist="Warwolf belt"
     ,legs="Darksteel subligar +1"
     ,feet="Kaiser schuhs"}
     
  sets.defense.MDT                       
   = {ammo="Bibiki seashell"
     ,body="Valhalla breastplate"
     ,ear1="Merman's earring"
     ,ear2="Merman's earring"
     ,ring1="Defending ring"
     ,ring2="Shadow ring"
     ,feet="Merman's leggings"}


  -- default engaged
  sets.engaged
   = {ammo="Bomb core"
     ,head="Walahra turban"    
     ,neck="Chivalrous chain"
     ,ear1="Triumph earring"     
     ,ear2="Brutal earring"
     ,body="Armada hauberk"    
     ,hands="Dusk gloves +1" 
     ,ring1=toreador_ring['Triple Attack (2)']     
     ,ring2=toreador_ring['Triple Attack (1)']     
     ,back="Cerberus mantle +1"
     ,waist="Ninurta's sash"
     ,legs="Byakko's haidate"
     ,feet="Dusk ledelsens +1"}
     
  sets.engaged.Acc
   = set_combine(sets.engaged
                ,{ammo="Fire bomblet"
                 ,neck="Ancient torque"
                 ,ear1="Fowling earring"
                 ,back="Cuchulain's mantle"
                 ,feet="Aurum sabatons"})

  -- bravura engaged (normal) [[Rose strap]]
  sets.engaged.Bravura
   = set_combine(sets.engaged
                ,{ammo="White tathlum"
                 ,neck="Fortitude torque"
                 ,body="Aurum cuirass"})
                 
  sets.engaged.Bravura.Acc
   = set_combine(sets.engaged.Bravura
                ,{neck="Ancient torque"
                 ,ear1="Fowling earring"
                 ,body="Armada hauberk"
                 ,ring1="Rajas ring"
                 ,back="Cuchulain's mantle"
                 ,feet="Aurum sabatons"})

  -- bravura engaged (SAM) [[Rose strap]]
  sets.engaged.Bravura.SAM
   = set_combine(sets.engaged
                ,{ammo="White tathlum"
                 ,neck="Almah torque"
                 ,body="Aurum cuirass"
                 ,ring1="Rajas ring"})
                 
  sets.engaged.Bravura.SAM.Acc
   = set_combine(sets.engaged.Bravura.SAM
                ,{ear1="Fowling earring"
                 ,back="Cuchulain's mantle"
                 ,feet="Aurum sabatons"})

  -- ragnarok engaged [[Rose strap]]
  sets.engaged.Ragnarok
   = {ammo="Bomb core"
     ,head="Walahra turban"   
     ,neck="Prudence torque"
     ,ear1="Triumph earring" 
     ,ear2="Brutal earring"
     ,body="Hachiryu haramaki"
     ,hands="Dusk gloves +1" 
     ,ring1=toreador_ring['Triple Attack (2)']     
     ,ring2=toreador_ring['Triple Attack (1)']   
     ,back="Cerberus mantle +1"     
     ,waist="Ninurta's sash"
     ,legs="Byakko's haidate"
     ,feet="Dusk ledelsens +1"}
     
  sets.engaged.Ragnarok.Acc
   = set_combine(sets.engaged.Ragnarok
                ,{ammo="Fire bomblet"
                 ,neck="Ancient torque"
                 ,ear1="Fowling earring"
                 ,back="Cuchulain's mantle"
                 ,feet="Aurum sabatons"})

  -- ragnarok engaged (SAM)
  sets.engaged.Ragnarok.SAM
   = {ammo="Bomb core"
     ,head="Walahra turban"    
     ,neck="Prudence torque"
     ,ear1="Triumph earring" 
     ,ear2="Brutal earring"
     ,body="Hachiryu haramaki"     
     ,hands="Dusk gloves +1" 
     ,ring1="Rajas ring"    
     ,ring2=toreador_ring['Triple Attack (1)']   
     ,back="Cerberus mantle +1"
     ,waist="Ninurta's sash"
     ,legs="Byakko's haidate"
     ,feet="Dusk ledelsens +1"}
     
  sets.engaged.Ragnarok.SAM.Acc
   = set_combine(sets.engaged.Ragnarok.SAM
                ,{ammo="Fire bomblet"
                 ,back="Cuchulain's mantle"
                 ,feet="Aurum sabatons"})

  -- dual wield engaged
  sets.engaged.DW
   = set_combine(sets.engaged
                ,{neck="Ancient torque"
                 ,ear1="Suppanomimi"
                 ,ear2="Fowling earring"
                 ,ring1="Rajas ring"
                 ,ring2="Strigoi ring"})
                 
  sets.engaged.DW.Acc
   = set_combine(sets.engaged.DW
                ,{ammo="Fire bomblet"
                 ,back="Cuchulain's mantle"
                 ,feet="Aurum sabatons"})

  --Weaponskill Sets
  sets.precast.WS
   = {ammo="Bomb core"
     ,head="Gnadbhod's helm"   
     ,neck="Fotia gorget"   
     ,ear1="Triumph earring"                               
     ,ear2="Brutal earring"
     ,body="Armada hauberk"    
     ,hands="Alkyoneus's bracelets"
     ,ring1="Rajas ring"     
     ,ring2="Strigoi ring"
     ,back="Cerberus mantle +1"
     ,waist="Warwolf belt"         
     ,legs="Hachiryu haidate"
     ,feet="Hecatomb leggings +1"}
     
  sets.precast.WS.Acc
   = set_combine(sets.precast.WS
                ,{ammo="Fire bomblet"
                 ,ear1="Fowling earring"
                 ,back="Cuchulain's mantle"
                 ,waist="Warrior's stone"})

  ----Sword
  sets.precast.WS['Vorpal Blade']
   = set_combine(sets.precast.WS
                ,{ear1="Suppanomimi"
                 ,body="Hachiryu haramaki"
                 ,hands="Hecatomb mittens +1"
                 ,waist="Swordbelt +1"
                 ,feet="Conte gambieras"})
                 
  sets.precast.WS['Vorpal Blade'].Acc
   = set_combine(sets.precast.WS['Vorpal Blade']
                ,{ammo="Fire bomblet"
                 ,ear1="Suppanomimi"
                 ,ring2="Mars's ring"
                 ,back="Cuchulain's mantle"
                 ,waist="Virtuoso belt"
                 ,legs="Armada breeches"})

  sets.precast.WS['Requiescat']
   = set_combine(sets.precast.WS['Vorpal Blade']
                ,{})
                
  sets.precast.WS['Requiescat'].Acc
   = set_combine(sets.precast.WS['Vorpal Blade'].Acc
                ,{})

  ----Sword MS
  sets.precast.WS['Vorpal Blade'].MS
   = set_combine(sets.precast.WS['Vorpal Blade']
                ,{body="Armada hauberk"
                 ,hands="Alkyoneus's bracelets"
                 ,waist="Swordbelt +1"
                 ,feet="Conte gambieras"})
                 
  sets.precast.WS['Vorpal Blade'].Acc.MS
   = set_combine(sets.precast.WS['Vorpal Blade'].MS
                ,{ammo="Fire bomblet"
                 ,back="Cuchulain's mantle"
                 ,waist="Virtuoso belt"
                 ,legs="Armada breeches"})

  sets.precast.WS['Requiescat'].MS
   = set_combine(sets.precast.WS['Vorpal Blade'].MS
                ,{})
                
  sets.precast.WS['Requiescat'].Acc.MS
   = set_combine(sets.precast.WS['Vorpal Blade'].Acc.MS
                ,{})

  ----Great Axe
  sets.precast.WS['Raging Rush']
   = set_combine(sets.precast.WS
                ,{body="Hachiryu haramaki"
                 ,hands="Hecatomb mittens +1"
                 ,waist="Swordbelt +1"
                 ,feet="Conte gambieras"})
                 
  sets.precast.WS['Raging Rush'].Acc
   = set_combine(sets.precast.WS['Raging Rush']
                ,{ammo="Fire bomblet"
                 ,ear1="Fowling earring"
                 ,back="Cuchulain's mantle"
                 ,waist="Virtuoso belt"
                 ,legs="Armada breeches"})

  sets.precast.WS['Upheaval']
   = set_combine(sets.precast.WS['Raging Rush']
                ,{})
                
  sets.precast.WS['Upheaval'].Acc
   = set_combine(sets.precast.WS['Raging Rush'].Acc
                ,{})

  sets.precast.WS['Metatron Torment']
   = set_combine(sets.precast.WS
                ,{waist="Warrior's stone"})
                
  sets.precast.WS['Metatron Torment'].Acc
   = set_combine(sets.precast.WS['Metatron Torment']
                ,{ammo="Fire bomblet"
                 ,ear1="Fowling earring"})

  sets.precast.WS['Steel Cyclone']
   = set_combine(sets.precast.WS
                ,{head="Maat's cap"
                 ,waist="Warwolf belt"})
                 
  sets.precast.WS['Steel Cyclone'].Acc
   = set_combine(sets.precast.WS['Steel Cyclone']
                ,{ammo="Fire bomblet"
                 ,ear2="Fowling earring"
                 ,back="Cuchulain's mantle"})

  ----Great Axe MS
  sets.precast.WS['Raging Rush'].MS
   = set_combine(sets.precast.WS['Raging Rush']
                ,{body="Armada hauberk"
                 ,hands="Alkyoneus's bracelets"})
                 
  sets.precast.WS['Raging Rush'].Acc.MS
   = set_combine(sets.precast.WS['Raging Rush'].MS
                ,{ammo="Fire bomblet"
                 ,ear1="Fowling earring"
                 ,back="Cuchulain's mantle"
                 ,waist="Virtuoso belt"
                 ,legs="Armada breeches"})

  sets.precast.WS['Upheaval'].MS 
   = set_combine(sets.precast.WS['Raging Rush'].MS
                ,{})
                
  sets.precast.WS['Upheaval'].Acc.MS
   = set_combine(sets.precast.WS['Raging Rush'].Acc.MS
                ,{})

  ----Greatsword
  sets.precast.WS['Scourge']
   = set_combine(sets.precast.WS,{})
   
  sets.precast.WS['Scourge'].Acc
   = set_combine(sets.precast.WS['Scourge']
                ,{})

  sets.precast.WS['Resolution']
   = set_combine(sets.precast.WS
                ,{ear1="Merman's earring"
                 ,hands="Tarasque mitts +1"
                 ,back="Cerberus mantle +1"
                 ,waist="Swordbelt +1"
                 ,feet="Conte gambieras"})
                 
  sets.precast.WS['Resolution'].Acc 
   = set_combine(sets.precast.WS['Resolution']
                ,{ammo="Fire bomblet"
                 ,ear1="Fowling earring"
                 ,ring2="Mars's ring"
                 ,back="Cuchulain's mantle"
                 ,waist="Virtuoso belt"
                 ,legs="Armada breeches"})

end

function job_post_precast(spell,action,spellMap,eventsArgs)
  
  if spell.type == 'WeaponSkill' then
  
    if state.Buff['Warrior\'s Charge'] then
      if daytime then
        equip({ear2="Fenrir's earring"})
      else
        equip({ear2="Merman's earring"})
      end
    else
      if daytime then
        equip({ear1="Fenrir's earring"})
      else
        equip({ear1="Merman's earring"})
      end
    end
    
    if player.sub_job == 'SAM' then
      if gaxe_singlehit:contains(spell.english) then
        equip({body="Aurum cuirass"})
      end
    end
    
  elseif spell.type == 'JobAbility' then
    if state.Tank.value then
      equip(set_combine(sets.enmityUp,sets.precast.JA[spell.english]) or sets.enmityUp)
    else
      equip(set_combine(sets.enmityDown,sets.precast.JA[spell.english]) or sets.enmityDown)
    end
  elseif spell.type == 'Waltz' and spell.target.type == 'SELF' then
    
    equip(sets.precast.WaltzSelf)
    
    if world.day_element == 'Dark' then
      equip({back="Shadow mantle"})
    
    end
  end

end

function job_buff_change(name,gain)

  sleep_swap(name,gain)
  
  if name == 'Aggressor' then
    if gain then
      aggressor_mode = state.OffenseMode.value
      if state.OffenseMode.value ~= 'Normal' then
        send_command('gs c set OffenseMode Normal')
      end
    else
      send_command('gs c set OffenseMode '..aggressor_mode)
    end
  end

end

function job_status_change(new,old)

  if new == "Engaged" then
    if player.equipment.main == 'Bravura' or player.equipment.main == 'Ragnarok' then
      state.CombatWeapon:set(player.equipment.main)
    elseif player.equipment.main == 'Ridill' then
      state.CombatWeapon:set('DW')
    else
      state.CombatWeapon:reset()
    end
    adjust_melee_groups()
  end

end

function get_custom_wsmode(spell,spellMap,default_wsmode)

  local wsmode = ''
  if state.Buff['Mighty Strike'] then
    wsmode = wsmode .. 'MS'
  end
  if wsmode ~= '' then
    return wsmode
  end

end

function customize_idle_set(idleSet)

  if player.hpp < 51 then
    idleSet = set_combine(idleSet,{ring2="Hercules' ring"})
  end
  
  if daytime and player.hpp < 75 then
    idleSet = set_combine(idleSet,{waist="Lycopodium sash"})
  end

  return idleSet
  
end

function customize_melee_set(meleeSet)

  if daytime and state.OffenseMode.value == 'Normal' and state.CombatWeapon.value ~= 'DW' then
    meleeSet = set_combine(meleeSet,{ear1="Fenrir's earring"})
  end

  return meleeSet

end

function adjust_melee_groups()

  classes.CustomMeleeGroups:clear()
  
  if player.sub_job == 'SAM' then
    classes.CustomMeleeGroups:append('SAM')
  end

end
