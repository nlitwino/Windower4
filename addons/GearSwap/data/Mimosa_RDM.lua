function get_sets()

  mote_include_version = 2

  include('Mote-Include.lua')

end

function job_setup()

  include('Kay-Include.lua')

  initialize_job()


  gear.main = player.equipment.main
  gear.sub = player.equipment.sub

end

function user_setup()

  state.IdleMode:options('Normal','Combat')
  state.OffenseMode:options('Normal','DW')
  state.WeaponskillMode:options('Normal','HNM')
  state.PhysicalDefenseMode:options('PDT')
  state.MagicalDefenseMode:options('MDT')
  state.CastingMode:options('Normal','Acc','Combat')

  sleeps            = S{'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II', 'Bind'}
  elemental_debuffs = S{'Burn','Choke','Shock','Rasp','Drown','Frost'}

  spikes            = S{'Blaze Spikes','Shock Spikes','Ice Spikes'}

  casting_mode = ''

  send_command('bind !f9 gs c cycle IdleMode')

end

function init_gear_sets()

  -- misc
  sets.MND
   = {sub="Raptor leather strap +1"
     ,neck="Morgana's choker"
     ,ear1="Mamool Ja earring"
     ,ear2="Star earring"
     ,body="Errant houppelande"
     ,hands="Bricta's cuffs"
     ,ring1="Tamas ring"
     ,ring2="Star ring"
     ,back=prism_cape['Fast Cast'] 
     ,waist="Penitent's rope"    
     ,legs="Jet seraweels"
     ,feet="Duelist's boots"}
     
  sets.INT
   = {sub="Bugard leather strap +1"
     ,head="Warlock's chapeau"
     ,ear2="Abyssal earring"
     ,ear2="Morion earring +1"
     ,body="Errant houppelande"
     ,hands="Bricta's cuffs"
     ,ring1="Tamas ring"
     ,ring2="Snow ring"
     ,back=prism_cape['Fast Cast'] 
     ,waist="Penitent's rope"    
     ,legs="Mahatma slops"}
     
  -- grips
  sets.grip
   = {Fire 	    = {sub="Fire Grip"}
     ,Earth 		= {sub="Earth Grip"}
     ,Water 		= {sub="Water Grip"}
     ,Wind 		  = {sub="Wind Grip"}
     ,Ice 		  = {sub="Ice Grip"}
     ,Lightning = {sub="Lightning Grip"}
     ,Light 		= {sub="Light Grip"}
     ,Dark 		  = {sub="Dark Grip"}}
     
  -- idle
  sets.idle
   = {main="Terra's staff"
     ,sub="Bugard leather strap +1"
     ,ammo="Bibiki seashell"
     ,head="Duelist's chapeau"
     ,neck="Chocobo whistle"  
     ,ear1="Merman's earring"
     ,ear2="Merman's earring"
     ,body="Dalmatica"
     ,hands="Crimson finger gauntlets"
     ,ring1="Merman's ring"
     ,ring2="Merman's ring"
     ,back="Hexerei cape"
     ,waist="Resolute belt"
     ,legs="Crimson cuisses"
     ,feet="Duelist's boots"}
 
  sets.idle.Combat
   = set_combine(sets.idle,{main="",sub=""})
  
  sets.idle.Town
   = set_combine(sets.idle
                ,{neck="Orochi nodowa"
                ,ring2="Warp ring"
                ,back="Nexus cape"})
 
  sets.idle.Town.Combat                              
   = set_combine(sets.idle.Combat
                ,{neck="Orochi nodowa"
                 ,ring2="Warp ring"
                 ,back="Nexus cape"})
     
  sets.resting
   = {main="Chatoyant staff"
     ,ammo="Bibiki seashell"
     ,neck="Grandiose chain"
     ,ear1="Magnetic earring"
     --,ear1="Relaxing earring"
     ,body="Errant houppelande"
     ,ring2="Star ring"
     ,back="Invigorating cape"
     ,waist="Duelist's belt"
     ,feet="Avocat pigaches"}
  

  -- precast Magic
  sets.precast.FC
   = {head="Warlock's chapeau"
     ,ear2="Loquacious erring"
     ,body="Duelist's tabard"
     ,back=prism_cape['Fast Cast']}      
                                   
  -- midcast magic                                   
  sets.midcast.FastRecast
   = set_combine(sets.precast.FC
                ,{hands="Dusk gloves"
                 ,waist="Velocious belt"
                 --,legs="Nashira seraweels"
                 ,feet="Dusk ledelsens +1"})
                 
  sets.midcast['Utsusemi: Ni']
   = set_combine(sets.midcast.FastRecast
                ,{ear1="Magnetic earring"})
   
  sets.midcast['Utsusemi: Ichi']
   = set_combine(sets.midcast['Utsusemi: Ni']
                ,{body=scorpion_harness['Haste']
                 --,ring1="Defending ring"
                 ,waist="Resolute belt"
                 ,back=prism_cape['Spell Interrupt']})
  
                                                     
  sets.midcast['Healing Magic']
   = set_combine(sets.MND
                ,sets.midcast.FastRecast
                ,{ear1="Magnetic earring"})
                                                     
  sets.midcast['Divine Magic']
   = set_combine(sets.MND
                ,{})
                 
  sets.midcast['Divine Magic'].Acc
   = set_combine(sets.midcast['Divine Magic']
                ,{--[[ring2="Omega ring"
                 ,]]back=prism_cape['Magic Accuracy']})
                                                     
  sets.midcast['Enfeebling Magic']
   = {head="Duelist's chapeau"
     ,neck="Spider torque"
     ,body="Warlock's tabard"
     --,legs="Nashira seraweels"
     ,feet="Avocat pigaches"}
                                                     
  sets.midcast['Enfeebling Magic']['BlackMagic'] 
   = set_combine(sets.INT
                ,{})
   
  sets.midcast['Enfeebling Magic']['BlackMagic'].Acc
   = set_combine(sets.midcast['Enfeebling Magic']['BlackMagic']
                ,sets.midcast['Enfeebling Magic']
                ,{ammo="Sturm's report"
                 --,ring2="Omega ring"
                 ,back=prism_cape['Magic Accuracy']})
  
  sets.midcast['Enfeebling Magic']['WhiteMagic']
   = set_combine(sets.MND
                ,{})
   
  sets.midcast['Enfeebling Magic']['WhiteMagic'].Acc
   = set_combine(sets.midcast['Enfeebling Magic']['WhiteMagic']
                ,sets.midcast['Enfeebling Magic']
                ,{ammo="Sturm's report"
                 --,ring2="Omega ring"
                 ,back=prism_cape['Magic Accuracy']})
  
  sets.midcast['Elemental Magic']
   = set_combine(sets.INT
                ,{--[[ear1="Novio earring"
                 ,]]ear2="Moldavite earring"
                 ,hands="Zenith mitts"
                 ,feet="Duelist's boots"})
   
  sets.midcast['Elemental Magic'].Acc
   = set_combine(sets.midcast['Elemental Magic']
                ,{ammo="Sturm's report"
                 ,head="Warlock's chapeau"
                 ,hands="Duelist's gloves"
                 --,ring2="Omega ring"
                 ,back=prism_cape['Magic Accuracy']
                 ,legs="Duelist's tights"
                 ,feet="Nashira crackows"})
                                                     
  sets.midcast['Dark Magic']
   = set_combine(sets.INT
                ,{ammo="Sturm's report"
                 --,neck="Dark torque"
                 ,body="Glamor jupon"
                 ,hands="Crimson finger gauntlets"
                 --,ring2="Omega ring"
                 ,back=prism_cape['Fast Cast']})
                 
  sets.midcast['Dark Magic'].Acc
   = set_combine(sets.midcast['Dark Magic']
                ,{back=prism_cape['Magic Accuracy']})
                                                     
  sets.midcast['Enhancing Magic']
   = set_combine(sets.midcast.FastRecast
                ,{ear1="Magnetic earring"
                 ,hands="Duelist's gloves"
                 ,waist="Velocious belt"
                 ,legs="Warlock's tights"})
                                                     
  -- custom midcast magic                            
  sets.midcast['Stoneskin']
   = set_combine(sets.MND
                ,sets.midcast.FastRecast
                ,{ear1="Magnetic earring"
                 ,body="Warlock's tabard"
                 ,back=prism_cape['Spell Interrupt']
                 ,waist="Resolute belt"})
                 
  sets.midcast['Phalanx']
   = set_combine(sets.midcast['Stoneskin']
                ,{body="Glamor jupon"
                 ,hands="Duelist's gloves"
                 ,legs="Warlock's tights"})                 
                
  sets.midcast['Blink']
   = set_combine(sets.midcast['Stoneskin']
                ,{})
                
  sets.midcast['Aquaveil']
   = set_combine(sets.midcast['Stoneskin']
                ,{})
                 
  sets.midcast.Cure
   = set_combine(sets.midcast['Healing Magic']
                ,{--[[ammo="White tathlum"
                 ,]]neck="Fylgja torque +1"
                 --[[,ear1="Roundel earring"]]
                 ,body="Duelist's tabard"
                 ,hands="Bricta's cuffs"
                 ,back=prism_cape['Cure Potency']
                 ,legs="Warlock's tights"
                 ,feet="Errant pigaches"})

  sets.midcast['Cursna']
   = set_combine(sets.midcast['Healing Magic']
                ,{--[[ammo="White tathlum"]]})
                
  sets.midcast.Sleep
   = set_combine(sets.midcast.FastRecast
                ,sets.INT
                ,sets.midcast['Enfeebling Magic']
                ,{hands="Bricta's cuffs"
                 --,ring2="Omega ring"
                 ,back=prism_cape['Magic Accuracy']})
                
  sets.midcast.EleEnfeebs
   = set_combine(sets.INT
                ,{back=prism_cape['Magic Accuracy']})
                
  sets.midcast.Spikes
   = set_combine(sets.INT
                ,{back=prism_cape['Spell Interrupt']})
  
  -- engaged
  sets.engaged
   = {ammo="Bibiki seashell"
     ,head="Walahra turban"     
     ,neck="Peacock amulet" 
     ,ear1="Merman's earring"
     ,ear2="Brutal earring"
     ,body=scorpion_harness['Haste']
     ,hands="Dusk gloves"
     ,ring1="Sniper's ring +1"    
     ,ring2="Sniper's ring +1"
     ,back="Cerberus mantle +1" 
     ,waist="Velocious belt"
     ,legs="Dusk trousers"
     ,feet="Dusk ledelsens +1"}

  sets.engaged.DW
   = set_combine(sets.engaged,{ear1="Suppanomimi"})

  --Weaponskill Sets
  sets.precast.WS
   = {}

end



function job_midcast(spell,action,spellMap,eventArgs)

  if spell.skill == 'Enfeebling Magic' then
    equip(sets.midcast[spell.skill][spell.type])
  else 
    equip(sets.midcast[spell.skill])
  end

end

function job_post_midcast(spell,action,spellMap,eventsArgs)

  if state.IdleMode.value == 'Combat' and state.CastingMode.value == 'Combat' then
  
  end

  if spell.skill == 'Enhancing Magic' or (spell.skill == 'Healing Magic' and spellMap ~= 'Cure') then
    if player.status == 'Idle' and state.IdleMode.value == 'Normal' and state.CastingMode.value ~= 'Combat' then
      equip({main="Seveneyes",sub="Genbu's shield"})
    end
  elseif spellMap == 'Cure' then
    equip({main="Chatoyant staff",sub="Raptor leather strap +1"})
  else
    if player.status == 'Idle' and state.IdleMode.value == 'Normal' and state.CastingMode.value ~= 'Combat' then
      
      if spell.skill == 'Enfeebling Magic' then
        
        if state.CastingMode.value == 'Normal' then
          equip({main="Alkalurops"})
        else
          equip({main="Chatoyant staff"})
        end
        
        if spell.type == 'WhiteMagic' then
          equip({sub="Raptor leather strap +1"})
        elseif spell.type == 'BlackMagic' then
          equip({sub="Bugard leather strap +1"})
        end 
        
      end
      
      if state.CastingMode.value == 'Acc' and player.status ~= 'Engaged' then
        equip(sets.grip[spell.element])
      end
      
    end
  end

  if spell.skill ~= 'Enhancing Magic' or spell.skill ~= 'Enfeebling Magic' then
    if spell.element == world.weather_element or spell.element == world.day_element then
      
      if world.weather_element ~= 'Dark' and spellMap == 'Cure' then
        equip({waist="Hachirin-no-obi"})
      end
      
      if spell.skill == 'Elemental Magic' then
        equip({waist="Hachirin-no-obi"})
      end
      
    end
  end
  
end

function job_get_spell_map(spell, default_spell_map)

  if spell.skill == 'Enfeebling Magic' and sleeps:contains(spell.english) then
    return 'Sleep'
  elseif spell.skill == 'Elemental Magic' and elemental_debuffs:contains(spell.english) then
    return 'EleEnfeebs'
  elseif spell.skill == 'Enhancing Magic' and spikes:contains(spell.english) then
    return 'Spikes'
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

function customize_idle_set(idleSet)

  if daytime then 
    idleSet = set_combine(idleSet,{waist="Lycopodium sash"})
  end

  return idleSet
  
end