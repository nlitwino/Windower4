function get_sets()

	--mote library settings
	mote_include_version = 2
	include('Mote-Include.lua')
  include('organizer-lib')
	
end

function job_setup()

	--kay library settings
	include('Kay-Include.lua')
	
	initialize_job()
	
end

function user_setup()

  state.OffenseMode:options('Normal','DW','HNM')
  state.RangedMode:options('Normal','HybridAcc','Acc')
  state.WeaponskillMode:options('Normal','Power','Acc')
  
  state.Luzaf = M(true, 'Luzaf')

  --get main and sub weapons for regear function
  gear.ammo = player.equipment.ammo
  
  send_command('wait 2;gs equip sets.lockstyle')
  send_command('wait 3;gs c setskin')
  
  -- custom state buffs
  state.Buff['Bust'] = buffactive['Bust'] or false
  
  current_dice = 'Chaos Roll' -- default
  
  --bind combat mode cycles
  send_command('bind !f9 gs c toggle Luzaf')
	
end

function init_gear_sets()

  -- misc.
  sets.enmityUp
   = {back="Cerberus mantle"
     ,feet="Hermes' sandals"}
     
  sets.enmityDown
   = {legs="Corsair's culottes"
     ,feet="Commodore bottes"}
     
  sets.MND
   = {neck="Morgana's choker"
     ,ear1="Star earring"
     ,ear2="Star earring"
     ,hands="Corsair's gants"
     ,waist="Velocious belt"
     ,legs="Custom pants"}
   
  sets.AGI
   = {head="Enkidu's cap"
     ,ear1="Drone earring"
     ,ear2="Drone earring"
     ,body="Antares harness"
     ,hands="Commodore gants"
     ,ring1="Breeze ring"
     ,ring2="Breeze ring"
     ,back="Commander's cape"
     ,waist="Scouter's Rope"
     ,legs="Commodore trews"
     ,feet="Enkidu's leggings"}
     
  sets.lockstyle
   = {main="Caver's shovel"
     ,range="Magnatus"}
     
  organizer_items
   = {echos="Echo drops"
     ,shihei="Shihei"
     ,corsair_bullet="Corsair bullet"
     ,cb_pouch="Corsair bullet pouch"
     ,trump_card="Trump card"
     ,trump_card_case="Trump card case"}
     
  -- precast ja
  sets.precast.JA['Phantom Roll']
   = {head="Commodore tricorne"}
  
  sets.precast.JA['Double-Up']
   = {head="Commodore tricorne"}
   
  sets.precast.JA['Random Deal']
   = {body="Commodore frac"}
   
  -- precast magic
  sets.precast.FC
   = {ear2="Loquacious earring"}
	
	-- midcast magic

  -- midcast magic
  sets.midcast.FastRecast
   = set_combine(sets.precast.FC
                ,{head="Walahra turban"
                ,hands="Dusk gloves"
                ,waist="Velocious belt"
                --,legs="Barbarossa's zerehs"
                ,feet="Dusk ledelsens +1"})
                
  sets.midcast['Utsusemi: Ni']
   = set_combine(sets.midcast.FastRecast
                ,{body=scorpion_harness['Rapid Shot']})
   
  sets.midcast['Utsusemi: Ichi']
   = set_combine(sets.midcast['Utsusemi: Ni']
                ,{ear1="Magnetic earring"
                 ,waist="Resolute belt"
                 ,legs="Commodore trews"
                 ,feet="Hermes' sandals"})
                 
  sets.midcast['Healing Magic']
   = set_combine(sets.MND
                ,sets.midcast.FastRecast
                ,{ear1="Magnetic earring"})
                
  sets.midcast['Stoneskin']
   = set_combine(sets.midcast.FastRecast
                ,sets.MND
                ,{})        
                 
  -- idle
  sets.idle
   = {head="Darksteel cap +1"
     ,neck="Chocobo whistle"
     ,ear1="Merman's earring"
     ,ear2="Merman's earring"
     ,body="Antares harness"
     ,hands="Crimson finger gauntlets"
     ,ring1="Merman's ring"
     ,ring2="Merman's ring"
     ,back="Cerberus mantle"
     ,waist="Resolute belt"
     ,legs="Crimson cuisses"
     ,feet="Hermes' sandals"}
     
  sets.idle.Town
   = set_combine(sets.idle
                ,{neck="Orochi nodowa"
                 ,ring2="Warp ring"
                 ,back="Nexus cape"}) 
                 
  -- defense TODO                                
  sets.defense.Evasion
   = {}
   
  sets.defense.PDT
   = {head="Darksteel cap +1"}
                                               
  sets.defense.MDT
   = {ear1="Merman's earring"
     ,ear2="Merman's earring"
     ,ring1="Merman's ring"
     ,ring2="Merman's ring"}
         
  -- engaged
  sets.engaged
   = {head="Walahra turban"    
     ,neck="Peacock amulet" 
     ,ear1="Suppanomimi"  
     ,ear2="Brutal earring"
     ,body=scorpion_harness['Rapid Shot']
     ,hands="Dusk gloves"
     ,ring1="Sniper's ring +1"
     ,ring2="Sniper's ring +1"
     ,back="Cuchulain's mantle"
     ,waist="Velocious belt"
     ,legs="Dusk trousers"
     ,feet="Dusk ledelsens +1"}
     
  -- precast ranged
  sets.precast.RA
   = {head="Enkidu's cap"
     ,neck="Peacock amulet"
     ,ear1="Drone earring"
     ,ear2="Drone earring"
     ,body=scorpion_harness['Rapid Shot']
     ,hands="Commodore gants"
     ,ring1="Merman's ring"
     ,ring2="Merman's ring"
     ,back="Amemet mantle"
     ,waist="Commodore belt"
     ,legs="Dusk trousers"
     ,feet="Corsair's bottes"}
     
  sets.midcast.RA
   = set_combine(sets.precast.RA
                ,{head="Commodore tricorne"
                 ,body="Commodore frac"
                 ,hands="Crimson finger gauntlets"
                 ,ring1="Behemoth ring +1"
                 ,ring2="Behemoth ring +1"
                 ,feet="Enkidu's leggings"})
                 
  sets.midcast.RA.HybridAcc
   = set_combine(sets.midcast.RA
                ,{head="Enkidu's cap"
                 ,body="Corsair's frac"})        
   
   sets.midcast.RA.Acc
    = set_combine(sets.midcast.RA.HybridAcc
                 ,{feet="Corsair's bottes"})
 
  -- quickdraw
  sets.precast.JA['CorsairShot']
   = set_combine(sets.AGI
                ,{head="Corsair's tricorne"
                 ,ear2="Moldavite earring"})
                  
  -- weaponskill
  sets.precast.WS
   = {head="Commodore tricorne"
     ,neck="Fotia gorget"
     ,ear1="Drone earring"
     ,ear2="Drone earring"
     ,body="Commodore frac"
     ,hands="Crimson finger gauntlets"
     ,ring1="Rajas ring"
     ,ring2="Merman's ring"
     ,back="Amemet mantle"
     ,waist="Commodore belt"
     ,legs="Commodore trews"
     ,feet="Enkidu's leggings"}
     
  sets.precast.WS.HybridAcc
   = set_combine(sets.precast.WS
                ,{head="Enkidu's cap"
                 ,body="Antares harness"
                 ,feet="Corsair's bottes"}) 
   
   sets.precast.WS.Acc
    = set_combine(sets.precast.WS.HybridAcc
                 ,{body="Corsair's frac"
                  ,ring1="Merman's ring"
                  ,legs="Dusk trousers"})
  
  -- TEST PURE INT VS PURE AGI                  
  sets.precast.WS['Leaden Salute']
   = set_combine(sets.AGI
                ,{neck="Fotia gorget"
                 ,ear2="Moldavite earring"
                 ,})  
   
   sets.precast.WS['Leaden Salute'].HybridAcc
    = set_combine(sets.precast.WS['Leaden Salute']
                 ,{})
   
   sets.precast.WS['Leaden Salute'].Acc
    = set_combine(sets.precast.WS['Leaden Salute'].HybridAcc
                 ,{})
       
end

function job_precast(spell,action,spellMap,eventArgs)

  if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
    ammo_recharge()
  end
  
end

function job_post_precast(spell,action,spellMap,eventArgs)

	if spell.type == 'CorsairRoll' or spell.english == 'Double-Up' then
		
		if state.Luzaf.value then
		  equip({ring2="Luzaf's ring"})
		end
		
		if spell.type == 'CorsairRoll' then
			current_dice = spell.english
		end
		
		handle_cor_rolls(current_dice)
		
	elseif spell.type == 'CorsairShot' and (spell.element == world.weather_element or spell.element == world.day_element) then
	  
	  if spell.element ~= 'Light' and spell.element ~= 'Dark' then
	    equip({waist="Hachirin-no-obi"})
	  end
	  
	end
	
	
  if spell.type == 'JobAbility' then
    if state.Tank.value then
      equip(set_combine(sets.enmityUp,sets.precast.JA[spell.english]) or sets.enmityUp)
    else
      equip(set_combine(sets.enmityDown,sets.precast.JA[spell.english]) or sets.enmityDown)
    end
  end

  if spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
  
    if state.WeaponskillMode.value ~= 'Acc' then
      if daytime then
        equip({ear1="Ladybug earring"})
        if state.WeaponskillMode.value == 'HybridAcc' then
          equip({ear2="Ladybug earring"})
        end
      else
        equip({ear1="Fenrir's earring"})
      end
    end
    
  end
	
	
end

function job_post_midcast(spell,action,spellMap,eventsArgs)

  if spell.action_type == 'Ranged Attack' then
    
    if daytime then
      equip({ear1="Ladybug earring"})
      if state.RangedMode.value == 'Normal' then
        equip({ear2="Ladybug earring"})
      end
    else
      equip({ear1="Fenrir's earring"})
    end
    
  end

end

function job_buff_change(name,gain)

	sleep_swap(name,gain)

end

function customize_idle_set(idleSet)

  if player.hpp < 75 and daytime then
    
    idleSet = set_combine(idleSet,{head="Crimson mask"})
    
    --[[if daytime then
      idleSet = set_combine(idleSet,{hands="Garden bangles",waist="Lycopodium sash"})
    end]]
    
  end
  
  return idleSet
  
end

function handle_shot()

  local element = ''

  if world.day_element ~= 'Dark' and world.day_element ~= 'Light' then
    if world.weather_element ~= 'Dark' and world.weather_element ~= 'Light' then
      if world.weather_element ~= 'None' and (get_weather_intensity() > 0 or world.weather_element ~= elements.weak_to[world.day_element]) then
        element = world.weather_element
      elseif world.weather_element == 'None' then
        element = world.day_element
      else
        element = 'Earth'
      end
    else
      element = world.day_element
    end
  else
    element = 'Earth'
  end

  if element == 'Lightning' then
    element = 'Thunder'
  end

  send_command('input /ja "'..element..' Shot" <t>')

end
