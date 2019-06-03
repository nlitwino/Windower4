function get_sets()

  mote_include_version = 2
  include('Mote-Include.lua')
  include('organizer-lib')

end

function job_setup()

  include('Kay-Include.lua')

  state.Buff['Sneak Attack']       = buffactive['Sneak Attack'] or false
  state.Buff['Trick Attack']       = buffactive['Trick Attack'] or false
  state.Buff['Assassin\'s Charge'] = buffactive['Assassin\'s Charge'] or false

  single_hit_ws = S{'Wasp Sting','Shadowstitch','Viper Bite','Mercy Stroke','Mandalic Stab'}

  offhand_misc = S{'Ridill','Kraken Club'}
  offhand_daggers = S{'Thief\'s Knife','Mercurial Kris'}

  initialize_job()

end

function user_setup()

  include('Mote-TreasureHunter.lua')

  state.OffenseMode:options('Normal','HybridAcc','Acc','MDT')
  state.WeaponskillMode:options('Normal','Atk','Acc','AtkAcc')
  state.RangedMode:options('Normal','Acid','Bloody','Sleep','Throw')
  state.PhysicalDefenseMode:options('Evasion','PDT')
  state.MagicalDefenseMode:options('MDT')

  send_command('bind !f9 gs c cycle TreasureMode')

end

function init_gear_sets()
  
  -- misc sets
  sets.postPrecast
  = {}
  
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
   = {head="Zha'Go's barbut"
     ,ear1="Novia earring"
     ,ring2="Veela ring"
     ,waist="Buccaneer's belt"
     ,legs="Raven hose"}
                
  sets['Acid']
  = {range="Staurobow"
    ,ammo="Acid bolt"}
                
  sets['Bloody']
  = {range="Staurobow"
    ,ammo="Bloody bolt"}
                
  sets['Sleep']
  = {range="Staurobow"
    ,ammo="Sleep bolt"}
                
  sets['Throw']
  = {range="Ungur boomerang"
    ,ammo=empty}
     
  sets.idle['Regen']
  = {neck="Orochi nodowa +1"}

  sets.idle['Regen'].daytime
  = set_combine(sets.idle['Regen']
    ,{hands="Garden bangles"
     ,waist="Lycopodium sash"})

  -- buff
  sets.buff['Sneak Attack']
  = {head="Hecatomb cap +1"   
    ,neck="Love torque"         
    ,ear1="Pixie earring"
    ,body="Antares harness"   
    ,hands="Hecatomb mittens +1"  
    ,ring1=toreador_ring['Triple Attack (1)']         
    ,ring2=toreador_ring['Triple Attack (3)']
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
    ,ring1=toreador_ring['Triple Attack (1)']         
    ,ring2=toreador_ring['Triple Attack (3)'] 
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
    
  sets.precast.Waltz
   = {head="Maat's cap"
     ,neck="Temperance torque"
     ,ear2="Melody earring +1"
     ,body="Avalon breastplate"
     ,hands="Assassin's armlets"
     ,ring1="Veela ring"
     ,ring2="Light ring"
     ,waist="Corsette +1"
     ,legs="Barbarossa's zerehs"
     ,feet="Volunteer's nails"}

  sets.precast.WaltzSelf
   = set_combine(sets.precast.Waltz
                ,{hands="Etoile bangles +1"
                 ,legs="Barbarossa's zerehs"
                 ,ring2="Corneus ring"})

  -- midcast magic
  sets.midcast.FastRecast
  = set_combine(sets.precast.FC
               ,{head="Walahra turban"
                ,neck="Tiercel necklace"
                ,body="Rapparee harness"
                ,hands="Dusk gloves +1"
                ,waist="Ninurta's sash"
                ,feet="Dusk ledelsens +1"})

  sets.midcast['Utsusemi: Ni']
  = set_combine(sets.midcast.FastRecast
               ,{neck="Fortified chain"
                ,ear1="Magnetic earring"
                ,ring1="Defending ring"
                ,back="Boxer's mantle"})
                 
  sets.midcast['Utsusemi: Ichi']
  = set_combine(sets.midcast['Utsusemi: Ni']
               ,{body=scorpion_harness['Haste']})

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
               ,{neck="Orochi nodowa +1"
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
    ,ring1=toreador_ring['Triple Attack (1)']         
    ,ring2=toreador_ring['Triple Attack (3)']
    ,back="Cerberus mantle +1"
    ,waist="Ninurta's sash"
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
               ,body="Homam corazza"
               ,ring2=toreador_ring['Triple Attack (2)']})
                
  sets.engaged.MDT
  = set_combine(sets.engaged.Acc
               ,{ear1="Merman's earring"
                ,ear2="Merman's earring"
                ,body="Avalon breastplate"
                ,ring1="Defending ring"})

  -- ranged
  sets.precast.RA
  = {head="Zha'Go's barbut"
    ,body=scorpion_harness['Rapid Shot']}
     
  sets.midcast.RA
  = {head="Zha'Go's barbut"
    ,neck="Peacock amulet"       
    ,ear1="Drone earring"    
    ,ear2="Drone earring"
    ,body="Enkidu's harness"
    ,hands="Barbarossa's moufles"
    ,ring1="Behemoth ring +1"
    ,ring2="Dragon ring +1"
    ,back="Mamool Ja mantle"
    ,waist="Buccaneer's belt"    
    ,legs="Oily trousers" 
    ,feet="Homam gambieras"}
  
  -- BASE WEAPONSKILL SETS
  sets.precast.WS
  = {head="Maat's cap"
    ,neck="Fotia gorget"
    ,ear1="Pixie earring"
    ,ear2="Brutal earring"
    ,body="Antares harness"
    ,hands="Hecatomb mittens +1"
    ,ring1="Rajas ring"
    ,ring2=toreador_ring['Triple Attack (3)']
    ,back="Cuchulain's mantle"
    ,waist="Warwolf belt"
    ,legs="Hecatomb subligar +1"
    ,feet="Hecatomb leggings +1"}
    
  sets.precast.WS['Cyclone'] 
  = set_combine(sets.precast.WS
               ,{ear1="Moldavite earring"
                ,ear2="Novio earring"
                ,body="Antares harness"
                ,hands="Assassin's armlets"
                ,ring1="Snow ring"
                ,ring2="Omega ring"}) 
  
  sets.precast.WS['Dancing Edge'] 
  = set_combine(sets.precast.WS) 
  
  sets.precast.WS['Exenterator'] 
  = set_combine(sets.precast.WS['Dancing Edge'] 
               ,{}) 
                
  sets.precast.WS['Evisceration'] 
  = set_combine(sets.precast.WS['Dancing Edge'] 
               ,{}) 
  
  sets.precast.WS['Shark Bite'] 
  = set_combine(sets.precast.WS['Dancing Edge'] 
               ,{back="Assassin's cape"
                ,legs="Oily trousers"}) 
  
  sets.precast.WS['Mandalic Stab'] 
  = set_combine(sets.precast.WS
               ,{}) 
  
  sets.precast.WS['Mercy Stroke'] 
  = set_combine(sets.precast.WS
               ,{head="Hecatomb cap +1"
                ,ear1="Triumph earring"
                ,body="Hecatomb harness +1"
                ,hands="Alkyoneus's bracelets"
                ,ring2="Strigoi ring"
                ,legs="Enkidu's subligar"}) 
                
  -- -- sneak attack              
  sets.precast.WS['Shark Bite'].SA
  = set_combine(sets.precast.WS['Shark Bite']
               ,{feet="Enkidu's leggings"})
               
  sets.precast.WS['Mandalic Stab'].SA
  = set_combine(sets.precast.WS['Mandalic Stab']
               ,{})
               
  sets.precast.WS['Mercy Stroke'].SA
  = set_combine(sets.precast.WS['Mercy Stroke']
               ,{ear1="Pixie earring"
                ,hands="Hecatomb mittens +1"})
                
  -- -- trick attack
  sets.precast.WS['Shark Bite'].TA
  = set_combine(sets.precast.WS['Shark Bite']
               ,{ear1="Drone earring"
                ,hands="Rogue's armlets +1"
                ,feet="Enkidu's leggings"})
               
  sets.precast.WS['Mandalic Stab'].TA
  = set_combine(sets.precast.WS['Mandalic Stab']
               ,{ear1="Drone earring"
                ,hands="Rogue's armlets +1"
                ,ring2="Blobnag ring"
                ,back="Assassin's cape"
                ,feet="Enkidu's leggings"})
               
  sets.precast.WS['Mercy Stroke'].TA
  = set_combine(sets.precast.WS['Mercy Stroke']
               ,{head="Maat's cap"
                ,ear1="Drone earring"
                ,hands="Rogue's armlets +1"
                ,legs="Oily trousers"})
               
  -- -- sata
  sets.precast.WS['Shark Bite'].SATA
  = set_combine(sets.precast.WS['Shark Bite'].TA
               ,{ear1="Pixie earring"})
               
  sets.precast.WS['Mandalic Stab'].SATA
  = set_combine(sets.precast.WS['Mandalic Stab'].TA
               ,{ear1="Pixie earring"
                ,back="Assassin's cape"
                ,ring2="Zilant ring"})
               
  sets.precast.WS['Mercy Stroke'].SATA
  = set_combine(sets.precast.WS['Mercy Stroke'].TA
               ,{ear1="Pixie earring"
                ,back="Assassin's cape"})
    
  -- HIGH ATTACK/STR WEAPONSKILL SETS SETS           
  sets.precast.WS.Atk 
  = set_combine(sets.precast.WS
               ,{head="Hecatomb cap +1"
                ,ear1="Triumph earring"
                ,body="Hecatomb harness +1"
                ,ring2="Strigoi ring"
                ,back="Cerberus mantle +1"
                ,waist="Swordbelt +1"})
                
  sets.precast.WS['Dancing Edge'].Atk 
  = set_combine(sets.precast.WS.Atk)
                
  sets.precast.WS['Exenterator'].Atk 
  = set_combine(sets.precast.WS['Dancing Edge'].Atk)
                
  sets.precast.WS['Evisceration'].Atk 
  = set_combine(sets.precast.WS['Dancing Edge'].Atk)
                
  sets.precast.WS['Shark Bite'].Atk 
  = set_combine(sets.precast.WS['Dancing Edge'].Atk
               ,{head="Maat's cap"})
                
  sets.precast.WS['Mandalic Stab'].Atk 
  = set_combine(sets.precast.WS.Atk)
                
  sets.precast.WS['Mercy Stroke'].Atk 
  = set_combine(sets.precast.WS['Mercy Stroke']
               ,{head="Gnadbhod's helm"
                ,back="Cerberus mantle +1"
                ,legs="Hecatomb subligar +1"})

  -- -- sneak attack
  sets.precast.WS['Shark Bite'].Atk.SA
  = set_combine(sets.precast.WS['Shark Bite'].Atk
               ,{head="Hecatomb cap +1"
                ,ear1="Pixie earring"
                ,waist="Warwolf belt"})
  
  sets.precast.WS['Mandalic Stab'].Atk.SA
  = set_combine(sets.precast.WS['Mandalic Stab'].Atk
               ,{ear1="Pixie earring"
                ,waist="Warwolf belt"})
               
  sets.precast.WS['Mercy Stroke'].Atk.SA
  = set_combine(sets.precast.WS['Mercy Stroke'].Atk
               ,{head="Hecatomb cap +1"
                ,hands="Hecatomb mittens +1"})
  
  -- -- trick attack             
  sets.precast.WS['Shark Bite'].Atk.TA
  = set_combine(sets.precast.WS['Shark Bite'].TA
               ,{body="Enkidu's harness"
                ,back="Cerberus mantle +1"
                ,legs="Hecatomb subligar +1"
                ,feet="Hecatomb leggings +1"
                ,waist="Swordbelt +1"})
               
  sets.precast.WS['Mandalic Stab'].Atk.TA
  = set_combine(sets.precast.WS['Mandalic Stab'].TA
               ,{ring2="Strigoi ring"
                ,back="Cerberus mantle +1"})
               
  sets.precast.WS['Mercy Stroke'].Atk.TA
  = set_combine(sets.precast.WS['Mercy Stroke'].TA
               ,{legs="Hecatomb subligar +1"
                ,back="Cerberus mantle +1"})
  
  -- -- sata          
  sets.precast.WS['Shark Bite'].Atk.SATA
  = set_combine(sets.precast.WS['Shark Bite'].Atk.TA
               ,{ear1="Pixie earring"
                ,body="Hecatomb harness +1"
                ,waist="Warwolf belt"})
               
  sets.precast.WS['Mandalic Stab'].Atk.SATA
  = set_combine(sets.precast.WS['Mandalic Stab'].Atk.TA
               ,{ear1="Pixie earring"
                ,body="Hecatomb harness +1"
                ,waist="Warwolf belt"})
               
  sets.precast.WS['Mercy Stroke'].Atk.SATA
  = set_combine(sets.precast.WS['Mercy Stroke'].Atk.TA
               ,{body="Hecatomb harness +1"
                ,waist="Warwolf belt"})
  
  -- HIGH ACCURACY WS             
  sets.precast.WS.Acc 
  = set_combine(sets.precast.WS
               ,{head="Hecatomb cap +1"
                ,hands="Enkidu's mittens"
                ,ring2=toreador_ring['Triple Attack (1)']})
                
  sets.precast.WS['Dancing Edge'].Acc 
  = set_combine(sets.precast.WS.Acc
               ,{waist="Virtuoso belt"})
                
  sets.precast.WS['Exenterator'].Acc 
  = set_combine(sets.precast.WS['Dancing Edge'].Acc)
                
  sets.precast.WS['Evisceration'].Acc 
  = set_combine(sets.precast.WS['Dancing Edge'].Acc)
                
  sets.precast.WS['Shark Bite'].Acc 
  = set_combine(sets.precast.WS['Dancing Edge'].Acc
               ,{head="Maat's cap"})
                
  sets.precast.WS['Mandalic Stab'].Acc 
  = set_combine(sets.precast.WS.Acc)
                
  sets.precast.WS['Mercy Stroke'].Acc 
  = set_combine(sets.precast.WS.Acc
               ,{ear1="Triumph earring"
                ,body="Hecatomb harness +1"
                ,hands="Hecatomb mittens +1"
                ,waist="Virtuoso belt"
                ,legs="Hecatomb subligar +1"})
  
  -- -- SA              
  sets.precast.WS['Shark Bite'].Acc.SA
  = set_combine(sets.precast.WS['Shark Bite'].Acc
               ,{head="Hecatomb cap +1"})
               
  sets.precast.WS['Mandalic Stab'].Acc.SA
  = set_combine(sets.precast.WS['Mandalic Stab'].Acc
               ,{})
               
  sets.precast.WS['Mercy Stroke'].Acc.SA
  = set_combine(sets.precast.WS['Mercy Stroke'].Acc
               ,{ear1="Pixie earring"})
  
  -- -- TA             
  sets.precast.WS['Shark Bite'].Acc.TA
  = set_combine(sets.precast.WS['Shark Bite'].Acc
               ,{hands="Rogue's armlets +1"
                ,legs="Oily trousers"})
               
  sets.precast.WS['Mandalic Stab'].Acc.TA
  = set_combine(sets.precast.WS['Mandalic Stab'].Acc
               ,{head="Maat's cap"
                ,hands="Rogue's armlets +1"})
               
  sets.precast.WS['Mercy Stroke'].Acc.TA
  = set_combine(sets.precast.WS['Mercy Stroke'].Acc
               ,{head="Maat's cap"
                ,body="Enkidu's harness"
                ,hands="Rogue's armlets +1"})
  
  -- SATA             
  sets.precast.WS['Shark Bite'].Acc.SATA
  = set_combine(sets.precast.WS['Shark Bite'].Acc.TA
               ,{legs="Oily trousers"
                ,waist="Virtuoso belt"})
               
  sets.precast.WS['Mandalic Stab'].Acc.SATA
  = set_combine(sets.precast.WS['Mandalic Stab'].Acc.TA
               ,{legs="Oily trousers"})
  
  sets.precast.WS['Mercy Stroke'].Acc.SATA
  = set_combine(sets.precast.WS['Mercy Stroke'].Acc.TA
               ,{body="Antares harness"
                ,legs="Oily trousers"})
               
-- HIGH ATTACK/ACCURACY WS             
  sets.precast.WS.AtkAcc 
  = set_combine(sets.precast.WS
               ,{head="Gnadbhod's helm"
                ,body="Hecatomb harness +1"
                ,ring2=toreador_ring['Triple Attack (1)']
                ,back="Cerberus mantle +1"
                ,waist="Swordbelt +1"})
                
  sets.precast.WS['Dancing Edge'].AtkAcc 
  = set_combine(sets.precast.WS.AtkAcc)
                
  sets.precast.WS['Exenterator'].AtkAcc 
  = set_combine(sets.precast.WS['Dancing Edge'].AtkAcc)
                
  sets.precast.WS['Evisceration'].AtkAcc 
  = set_combine(sets.precast.WS['Dancing Edge'].AtkAcc)
                
  sets.precast.WS['Shark Bite'].AtkAcc 
  = set_combine(sets.precast.WS['Dancing Edge'].AtkAcc
               ,{head="Maat's cap"})
                
  sets.precast.WS['Mandalic Stab'].AtkAcc 
  = set_combine(sets.precast.WS.AtkAcc)
                
  sets.precast.WS['Mercy Stroke'].AtkAcc 
  = set_combine(sets.precast.WS.AtkAcc
               ,{ear1="Triumph earring"})
  
  -- -- SA              
  sets.precast.WS['Shark Bite'].AtkAcc.SA
  = set_combine(sets.precast.WS['Shark Bite'].AtkAcc
               ,{head="Hecatomb cap +1"
                ,back="Cuchulain's mantle"
                ,waist="Warwolf belt"})
               
  sets.precast.WS['Mandalic Stab'].AtkAcc.SA
  = set_combine(sets.precast.WS['Mandalic Stab'].AtkAcc
               ,{head="Hecatomb cap +1"
                ,waist="Warwolf belt"})
               
  sets.precast.WS['Mercy Stroke'].AtkAcc.SA
  = set_combine(sets.precast.WS['Mercy Stroke'].AtkAcc
               ,{head="Hecatomb cap +1"
                ,ear1="Pixie earring"
                ,waist="Warwolf belt"})
  
  -- -- TA             
  sets.precast.WS['Shark Bite'].AtkAcc.TA
  = set_combine(sets.precast.WS['Shark Bite'].AtkAcc
               ,{hands="Rogue's armlets +1"})
               
  sets.precast.WS['Mandalic Stab'].AtkAcc.TA
  = set_combine(sets.precast.WS['Mandalic Stab'].AtkAcc
               ,{head="Maat's cap"
                ,hands="Rogue's armlets +1"})
               
  sets.precast.WS['Mercy Stroke'].AtkAcc.TA
  = set_combine(sets.precast.WS['Mercy Stroke'].AtkAcc
               ,{body="Enkidu's harness"
                ,hands="Rogue's armlets +1"})
  
  -- SATA             
  sets.precast.WS['Shark Bite'].AtkAcc.SATA
  = set_combine(sets.precast.WS['Shark Bite'].AtkAcc.TA
               ,{back="Cuchulain's mantle"
                ,waist="Warwolf belt"
                ,legs="Hecatomb subligar +1"})
               
  sets.precast.WS['Mandalic Stab'].AtkAcc.SATA
  = set_combine(sets.precast.WS['Mandalic Stab'].AtkAcc.TA
               ,{head="Maat's cap"
                ,back="Cuchulain's mantle"
                ,waist="Warwolf belt"})
  
  sets.precast.WS['Mercy Stroke'].AtkAcc.SATA
  = set_combine(sets.precast.WS['Mercy Stroke'].AtkAcc.TA
               ,{head="Maat's cap"
                ,body="Hecatomb harness +1"
                ,back="Cuchulain's mantle"
                ,waist="Warwolf belt"})
  
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

  if spell.type == 'WeaponSkill' then  -- extra weaponskill handling

    if state.RangedMode.value == 'Normal' then  -- if no boomerang or crossbow equipped
      if spell.english == 'Cyclone' or state.Buff['Sneak Attack'] then
        sets.postPrecast = set_combine(sets.postPrecast,{ammo="Black tathlum"})  -- always black tath when sneak attacking
      else
        if state.WeaponskillMode.value == 'Normal' then
          sets.postPrecast = set_combine(sets.postPrecast,{ammo="Bomb core"})
        elseif state.WeaponskillMode.value == 'Atk' then
          sets.postPrecast = set_combine(sets.postPrecast,{ammo="Bomb core"})
        elseif state.WeaponskillMode.value == 'Acc' then
          sets.postPrecast = set_combine(sets.postPrecast,{ammo="Fire bomblet"})
        elseif state.WeaponskillMode.value == 'AtkAcc' then
          sets.postPrecast = set_combine(sets.postPrecast,{ammo="Fire bomblet"})
        end
      end
    end

    if state.Buff['Assassin\'s Charge'] then
      if single_hit_ws:contains(spell.name) then  -- only for single hit ws's
        if daytime then
          sets.postPrecast = set_combine(sets.postPrecast,{ear2="Fenrir's earring"})
        else
          sets.postPrecast = set_combine(sets.postPrecast,{ear2="Merman's earring"})
        end
        if state.WeaponskillMode.value == 'Atk' then
          sets.postPrecast = set_combine(sets.postPrecast,{ring2="Strigoi ring"})
        elseif state.WeaponskillMode.value == 'Acc' then
          sets.postPrecast = set_combine(sets.postPrecast,{ring2="Zilant ring"})
        elseif state.WeaponskillMode.value == 'AtkAcc' then
          sets.postPrecast = set_combine(sets.postPrecast,{ring2="Mars's ring"})
        end
      else
        if daytime and (state.WeaponskillMode.value == 'Atk' or state.WeaponskillMode.value == 'AtkAcc')then
          sets.postPrecast = set_combine(sets.postPrecast,{ear1="Merman's earring"})
        end
      end
    else
      if daytime and (state.WeaponskillMode.value == 'Atk' or state.WeaponskillMode.value == 'AtkAcc')then
        sets.postPrecast = set_combine(sets.postPrecast,{ear1="Merman's earring"})
      end
    end
    
    if (state.Buff['Sneak Attack'] or state.Buff['Trick Attack']) and (state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime') then
      sets.postPrecast = set_combine(sets.postPrecast,sets.TreasureHunter)
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

  if state.TreasureMode.value == 'Fulltime' then
    meleeSet = set_combine(meleeSet, sets.TreasureHunter)
  end

  if state.RangedMode.value == 'Normal' then
    meleeSet = set_combine(meleeSet, sets[state.OffenseMode.value])
  else
    meleeSet = set_combine(meleeSet, sets[state.RangedMode.value])
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

  if player.hpp <= 75 then
    if daytime then
      idleSet = set_combine(idleSet,sets.idle['Regen'].daytime)
    else
      idleSet = set_combine(idleSet,sets.idle['Regen'])
    end
  end

  if state.RangedMode.value ~= 'Normal' then
    idleSet = set_combine(idleSet, sets[state.RangedMode.value])
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
