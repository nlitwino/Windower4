function get_sets()

  mote_include_version = 2

  include('Mote-Include.lua')
  
end

function job_setup()

  include('Kay-Include.lua')

  state.Buff['Pianissimo'] = buffactive['Pianissimo'] or false
  state.Buff['Nightingale'] = buffactive['Nightingale'] or false
  state.Buff['Troubadour'] = buffactive['Troubadour'] or false

  initialize_job()

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
  
  bard_debuffs      = S{'Lullaby','Elegy','Requiem','Threnody'}

  casting_mode = ''

  send_command('bind !f9 gs c cycle IdleMode')

end


-- Define sets and vars used by this job file.
function init_gear_sets()

  -- misc
  sets.MND
   = {sub="Raptor leather strap +1"
     ,head="Choral roundlet"            
     ,neck="Morgana's choker"            
     ,ear1="Mamool Ja earring"
     ,ear2="Star earring"
     ,body="Kirin's osode"              
     ,hands="Bricta's cuffs"       
     ,ring1="Tamas ring"      
     ,ring2="Star ring"
     ,back="Ixion cape"
     ,waist="Penitent's rope"          
     ,legs="Mahatma slops"    
     ,feet="Suzaku's sune-ate"}

  sets.INT
   = {sub="Bugard leather strap +1"
     ,ammo="Phantom tathlum"
     ,neck="Lemegeton medallion +1"
     ,ear1="Abyssal earring"
     ,ear2="Morion earring +1"
     ,body="Kirin's osode"         
     ,ring1="Tamas ring"    
     ,ring2="Snow ring"
     ,back="Ixion cape"         
     ,waist="Penitent's rope"                  
     ,legs="Mahatma slops"  
     ,feet="Rostrum pumps"}

  sets.CHR
   = {sub="Bugard leather strap +1"
     ,range="Gjallarhorn"
     ,head="Bard's roundlet" 
     ,neck="Piper's torque"        
     ,ear1="Melody earring +1"
     ,ear2="Melody earring +1"
     ,body="Kirin's osode"   
     ,hands="Choral cuffs +1"	     
     ,ring1="Light ring"      
     ,ring2="Light ring"
     ,back="Jester's cape +1"
     ,waist="Corsette +1"             
     ,legs="Mahatma slops"    
     ,feet="Sha'ir crackows"}

  sets.grip
   = {Fire 	    = {sub="Fire Grip"}
     ,Earth 	  = {sub="Earth Grip"}
     ,Water 	  = {sub="Water Grip"}
     ,Wind 	    = {sub="Wind Grip"}
     ,Ice 	    = {sub="Ice Grip"}
     ,Lightning = {sub="Thunder Grip"}
     ,Light 	  = {sub="Light Grip"}
     ,Dark 	    = {sub="Dark Grip"}}

  -- idle
  sets.idle
   = {main="Terra's staff"
     ,sub="Bugard leather strap +1"
     ,range="Gjallarhorn"
     ,head="Darksteel cap +1" 
     ,neck="Chocobo whistle"       
     ,ear1="Astral earring"
     ,ear2="Merman's earring"
     ,body="Dalmatica"    
     ,hands="Zenith mitts"         
     ,ring1="Merman's ring"      
     ,ring2="Serket ring"
     ,back="Hexerei cape" 
     ,waist="Resolute belt"      
     ,legs="Zenith slacks"    
     ,feet="Rostrum pumps"}
     
  sets.idle.Town
   = set_combine(sets.idle
                ,{neck="Orochi nodowa"
                 ,back="Nexus cape"
                 ,ring1="Warp ring"})

  sets.resting
   = {main="Chatoyant staff"
     ,ammo="Bibiki seashell"
     ,head="Oracle's cap"
     ,neck="Grandiose chain"
     ,ear1="Magnetic earring"
     ,body="Oracle's robe"
     ,hands="Oracle's gloves"
     ,ring2="Star ring"
     ,back="Invigorating cape"
     ,legs="Oracle's braconi"
     ,feet="Avocat pigaches"}

  -- precast magic
  sets.precast.FC
   = {ear2="Loquacious earring"
     ,feet="Rostrum pumps"
     ,back=prism_cape['Fast Cast']}

  sets.precast.FC['BardSong']
   = set_combine(sets.precast.FC
                ,{body="Sha'ir manteel"
                 ,ring1="Minstrel's ring"})

  -- midcast magic
  sets.midcast.FastRecast
   = set_combine(sets.precast.FC
                ,{head="Walahra turban"
                 ,hands="Dusk gloves"
                 ,legs="Byakko's haidate"
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
   = {neck="Spider torque"
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
                 ,hands="Zenith mitts"})
   
  sets.midcast['Elemental Magic'].Acc
   = set_combine(sets.midcast['Elemental Magic']
                ,{ammo="Sturm's report"
                 --,ring2="Omega ring"
                 ,back=prism_cape['Magic Accuracy']})
                                                     
  sets.midcast['Dark Magic']
   = set_combine(sets.INT
                ,{ammo="Sturm's report"
                 --,neck="Dark torque"
                 --,ring2="Omega ring"
                 ,back=prism_cape['Magic Accuracy']})
                 
  sets.midcast['Dark Magic'].Acc
   = set_combine(sets.midcast['Dark Magic']
                ,{})
                                                     
  sets.midcast['Enhancing Magic']
   = set_combine(sets.midcast.FastRecast
                ,{ear1="Magnetic earring"
                 ,hands="Duelist's gloves"
                 ,waist="Velocious belt"
                 ,legs="Warlock's tights"})
                                                     
  -- custom midcast magic                            
  sets.midcast['Stoneskin']
   = set_combine(sets.MND
                ,{head="Walahra turban"
                 ,back=prism_cape['Fast Cast']
                 ,legs="Byakko's haidate"
                 ,waist="Velocious belt"})
                 
  sets.midcast.Cure
   = set_combine(sets.midcast['Healing Magic']
                ,{neck="Fylgja torque +1"
                 --,ear1="Roundel earring"
                 ,body="Errant houppelande"
                 ,hands="Bricta's cuffs"
                 ,back=prism_cape['Cure Potency']
                 ,legs="Warlock's tights"
                 ,feet="Errant pigaches"})
                 
  sets.midcast.Curaga
   = set_combine(sets.midcast.Cure
                ,{})

  sets.midcast['Cursna']
   = set_combine(sets.midcast['Healing Magic']
                ,{--[[ammo="White tathlum"]]})
                 
  -- bard songs
  sets.midcast['BardSong']
   = set_combine(sets.midcast.FastRecast
                ,sets.CHR
                ,{head="Bard's roundlet"
                 ,neck="Wind torque"
                 ,ear1="Musical earring"
                 ,body="Minstrel's coat"
                 ,hands="Choral cuffs +1"
                 ,ring1="Nereid ring"
                 ,ring2="Nereid ring"
                 ,back="Astute cape"
                 ,legs="Choral cannions +1"
                 ,feet="Oracle's pigaches"})
                 
  sets.midcast.BardDebuff
   = set_combine(sets.CHR
                ,{neck="Piper's torque"
                 ,hands="Sheikh gages"})

  -- Defense sets
  sets.defense.PDT
   = {main="Terra's staff"
     ,head="Darksteel cap +1"
     ,back="Hexerei cape"}
     
  sets.defense.MDT
   = {ear1="Merman's earring"
     ,ear2="Merman's earring"
     ,ring1="Merman's ring"
     ,ring2="Merman's ring"
     ,back="Hexerei cape"}

  -- Engaged sets
  sets.engaged
   = {head="Walahra turban"
     ,neck="Peacock amulet"
     ,ear1="Pixie earring"
     ,ear2="Brutal earring"
     ,body="Sha'ir manteel"
     ,hands="Dusk gloves"
     ,ring1="Sniper's ring +1"
     ,ring2="Sniper's ring +1"
     ,back="Bard's cape"   
     ,waist="Velocious belt"
     ,legs="Byakko's haidate"
     ,feet="Dusk ledelsens +1"}

  -- WS sets
  sets.precast.WS
   = {head="Hecatomb cap"
     ,neck="Spike necklace"
     ,ear1="Merman's earring"
     ,ear2="Brutal earring"
     ,body="Kirin's osode"
     ,hands="Hecatomb mittens"
     --,ring1="Rajas ring"
     ,ring2="Flame ring"
     ,back="Forager's mantle"
     ,waist="Swordbelt +1"
     ,legs="Hecatomb subligar"
     ,feet="Dusk ledelsens +1"}
   
  sets.precast.WS.Acc
  	= set_combine(sets.precast.WS,{ring2="Sniper's ring +1"})

end

-- Auto-Pianissimo
function job_precast(spell,action,spellMap,eventArgs)
  
  if spell.type == 'BardSong' then
    if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and not state.Buff['Pianissimo'] then

      local spell_recasts = windower.ffxi.get_spell_recasts()
      if spell_recasts[spell.recast_id] < 2 then

        send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
        eventArgs.cancel = true
        return

      end

    end
    
  end

end

-- Enfeebling magic handling
function job_midcast(spell,action,spellMap,eventArgs)

  if spell.skill == 'Enfeebling Magic' then
    equip(sets.midcast[spell.skill][spell.type])
  else
    equip(sets.midcast[spell.skill])
  end

end

-- Obi and grip handling
function job_post_midcast(spell,action,spellMap,eventsArgs)

  if spellMap == 'Cure' then
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
        
      elseif spell.type == 'BardSong' then
        equip({main="Chatoyant staff",sub="Bugard leather strap +1"})
      elseif spell.english == 'Stoneskin' then
        equip({main="Alkalurops"})
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

function job_get_spell_map(spell,spellMap,default_spell_map)

  if spell.skill == 'Enfeebling Magic' and sleeps:contains(spell.english) then
    return 'Sleep'
  elseif spell.skill == 'Elemental Magic' and elemental_debuffs:contains(spell.english) then
    return 'EleEnfeebs'
  elseif spell.skill == 'Enhancing Magic' and spikes:contains(spell.english) then
    return 'Spikes'
  elseif bard_debuffs:contains(spellMap) or spell.english == 'Magic Finale' then
    return 'BardDebuff'
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
