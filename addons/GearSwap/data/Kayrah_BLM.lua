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

  --combat modes
  state.CastingMode:options('Normal','Accuracy','TH')
	
  state.MagicBurst = M(false, 'Magic Burst')
	
  helixes           = S{'Geohelix','Hydrohelix','Anemohelix','Pyrohelix','Cryohelix','Ionohelix','Noctohelix','Luminohelix'}
  sleeps            = S{'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II', 'Bind'}
  elemental_debuffs = S{'Burn','Choke','Shock','Rasp','Drown','Frost'}
  
  spikes            = S{'Blaze Spikes','Shock Spikes','Ice Spikes'}
	
  --bind combat mode cycles
  send_command('bind !f9 gs c toggle MagicBurst')
	
end

function init_gear_sets()

  --misc.
	sets.lowHP
	 = {hands="Zenith mitts"
	   ,ring1="Ether ring"
	   ,ring2="Serket ring"}

  --grips/obis														   
	sets.grip
   = {Fire 	    = {sub="Fire Grip"}
     ,Earth 	  = {sub="Earth Grip"}
     ,Water 	  = {sub="Water Grip"}
     ,Wind 	    = {sub="Wind Grip"}
     ,Ice 		  = {sub="Ice Grip"}
     ,Lightning = {sub="Thunder Grip"}
     ,Light 	  = {sub="Light Grip"}
     ,Dark 	    = {sub="Dark Grip"}}
 	
  --idle
	sets.idle 
	 = {main="Claustrum"
	   ,sub="Bugard leather strap +1"                        
	   ,ammo="Bibiki seashell"
	   ,head="Wizard's petasos"
	   ,neck="Chocobo whistle"       
	   ,ear1="Merman's earring"
	   ,ear2="Merman's earring"
	   ,body="Dalmatica"       
	   ,hands="Oracle's gloves"      
	   ,ring1="Defending ring" 
	   ,ring2="Shadow ring"
	   ,back="Shadow mantle"   
	   ,waist="Lycopodium sash"      
	   ,legs="Igqira lappas"   
	   ,feet="Herald's gaiters"}
															  
	sets.idle.Town
	 = set_combine(sets.idle
	              ,{neck="Orochi nodowa"
	               ,back="Nexus cape"
	               ,ring2="Warp ring"})
	
	sets.resting
	 = {main="Claustrum"                                                    
	   ,ammo="Bibiki seashell"
	   ,head="Oracle's cap" 
	   ,neck="Gnole torque"    
	   ,ear1="Relaxing earring"
	   ,ear2="Magnetic earring"
	   ,body="Oracle's robe"
	   ,hands="Oracle's gloves"                        
	   ,ring1="Star ring"
		 ,legs="Oracle's braconi"
		 ,feet="Avocat pigaches"}
	
  --base magic sets
	sets.MND
	 = {main="Alkalurops"
	   ,sub="Raptor leather strap +1"
	   ,head="Maat's cap"
	   ,neck="Gnole torque"
	   ,ear1="Mamool Ja earring"
	   ,ear2="Star earring"
	   ,body="Errant houppelande"
	   ,hands="Bricta's cuffs"       
	   ,ring1="Tamas ring"
	   ,ring2="Star ring"      
	   ,back="Ixion cape"                                      
	   ,legs="Mahatma slops"    
	   ,feet="Mahatma pigaches"}
															   
	sets.INT 
	 = {main="Claustrum"
	   ,sub="Bugard leather strap +1"                       
	   ,ammo="Phantom tathlum"
	   ,head="Maat's cap"        
	   ,neck="Lemegeton medallion +1"
	   ,ear1="Abyssal earring"
	   ,ear2="Morion earring +1"
	   ,body="Errant houppelande"
	   ,hands="Errant cuffs"         
	   ,ring1="Tamas ring"    
	   ,ring2="Snow ring"
	   ,back="Ixion cape"        
	   ,waist="Sorcerer's belt"      
	   ,legs="Mahatma slops" 
	   ,feet="Sorcerer's sabots +1"}
     
  --precast magic
  sets.precast.FC
   = {ear2="Loquacious earring"
     ,back=prism_cape['Fast Cast']
     ,feet="Rostrum pumps"}
     
  sets.midcast.FastRecast 
   = set_combine(sets.precast.FC
                ,{head="Walahra turban"
                 ,body="Nashira manteel"
                 ,hands="Nashira gages"
                 ,legs="Nashira seraweels"
                 ,feet="Nashira crackows"})
	
  --non-cure healing magic
	sets.midcast['Healing Magic']
	 = set_combine(sets.MND
	              ,sets.midcast.FastRecast
	              ,{main="Seveneyes"
                 ,sub="Genbu's shield"
                 ,ear1="Magnetic earring"})
	               
	sets.midcast['Divine Magic']
   = set_combine(sets.MND
                ,{head="Elite beret"
                 ,legs="Nashira manteel"})
	
	sets.midcast['Enfeebling Magic']
	 = {head="Sorcerer's petasos"
	   ,body="Wizard's coat"
	   ,legs="Igqira lappas"
	   ,feet="Avocat pigaches"}
	
	sets.midcast['Enfeebling Magic']['BlackMagic']
	 = set_combine(sets.INT
	              ,{})
	 
	sets.midcast['Enfeebling Magic']['BlackMagic'].Accuracy
	 = set_combine(sets.INT
	              ,sets.midcast['Enfeebling Magic']
	              ,{ammo="Sturm's report"
	               ,hands="Bricta's cuffs"
	               ,ring2="Omega ring"
	               ,back=prism_cape['Magic Accuracy']})
	
	sets.midcast['Enfeebling Magic']['WhiteMagic']
   = set_combine(sets.MND
                ,{ammo="Sturm's report"})
                
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Accuracy
	 = set_combine(sets.MND
	              ,sets.midcast['Enfeebling Magic']
	              ,{main="Chatoyant staff"
	               ,ammo="Sturm's report"
	               ,ring2="Omega ring"
	               ,back=prism_cape['Magic Accuracy']})
	
	sets.midcast['Elemental Magic']
	 = set_combine(sets.INT
	              ,{ear2="Moldavite earring"
	               ,body="Oracle's robe"
	               ,hands="Zenith mitts"
	               ,feet="Sorcerer's sabots +1"})
	
	sets.midcast['Elemental Magic'].Accuracy
	 = set_combine(sets.midcast['Elemental Magic']
	              ,{ammo="Sturm's report"
	               ,head="Sorcerer's petasos"
	               ,hands="Wizard's gloves +1"
	               ,ring2="Omega ring"
	               ,back=prism_cape['Magic Accuracy']})
	
	sets.midcast['Dark Magic']
   = set_combine(sets.INT
                ,{ammo="Sturm's report"
                 ,head="Nashira turban"
                 ,neck="Dark torque"
                 ,body="Nashira manteel"
                 ,hands="Sorcerer's gloves"
                 ,ring2="Omega ring"
                 ,back="Merciful cape"
                 ,legs="Wizard's tonban"
                 ,feet="Igqira huaraches"})
	
	sets.midcast['Enhancing Magic']
	 = {back="Merciful cape"
	   ,feet="Igqira huaraches"}
	               
  sets.midcast['Enhancing Magic']['WhiteMagic']
   = set_combine(sets.MND
                ,sets.midcast.FastRecast
                ,sets.midcast['Enhancing Magic']
                ,{main="Seveneyes"
                 ,sub="Genbu's shield"
                 ,ear1="Magnetic earring"
                 ,waist="Resolute belt"})
                 
  sets.midcast['Enhancing Magic']['BlackMagic']
   = set_combine(sets.INT
                ,sets.midcast.FastRecast
                ,{main="Seveneyes"
                 ,sub="Genbu's shield"
                 ,ear1="Magnetic earring"
                 ,waist="Resolute belt"
                 ,back=prism_cape['Spell Interrupt']})	   
                             
  -- custom midcast sets
  sets.midcast.Cure
   = set_combine(sets.MND
                ,{main="Chatoyant staff"
                 ,neck="Fylgja torque +1"
                 ,ear2="Roundel earring"
                 ,body="Nashira manteel"
                 ,back=prism_cape['Cure Potency']})
                 
	sets.midcast.Sleep
	 = set_combine(sets.midcast.FastRecast
	              ,sets.INT
	              ,sets.midcast['Enfeebling Magic']
	              ,{ring="Omega ring"
	               ,back=prism_cape['Magic Accuracy']})
	              
  sets.midcast.EleEnfeebs
   = set_combine(sets.INT
                ,{hands="Wizard's gloves +1"
                 ,ring2="Omega ring"
                 ,back=prism_cape['Magic Accuracy']})
                
  sets.midcast.Spikes
   = set_combine(sets.INT
                ,{back=prism_cape['Spell Interrupt']})
             
  sets.midcast['Cursna']
   = set_combine(sets.midcast['Healing Magic']
                ,{body="Nashira manteel"})
                
  sets.midcast['Stoneskin']
   = set_combine(sets.midcast['Enhancing Magic']['WhiteMagic']
                ,{hands="Bricta's cuffs"
                 ,back=prism_cape['Spell Interrupt']
                 ,legs="Mahatma slops"})
	
  --magic burst
	sets.magic_burst
	 = {hands="Sorcerer's gloves"
	   ,ear1="Static earring"}
	
end

function job_midcast(spell,action,spellMap,eventArgs)

  -- handle different equipsets for White and Black magic
  if spell.skill == 'Enfeebling Magic' then
    equip(sets.midcast[spell.skill][spell.type])
  else 
    equip(sets.midcast[spell.skill])
  end
  
end

function job_post_midcast(spell,action,spellMap,eventArgs)

  if (spell.skill == 'Elemental Magic' or spell.skill == 'Dark Magic') and not elemental_debuffs:contains(spell.english) then
    if spell.element == world.weather_element and spell.element == world.day_element then
      if spell.skill == 'Elemental Magic' then
        equip({legs="Sorcerer's tonban"})
      end
      equip({waist="Hachirin-no-obi",main="Chatoyant staff"})
    elseif spell.element == world.day_element then
      if spell.skill == 'Elemental Magic' then
        equip({legs="Sorcerer's tonban"})
      end
      equip({waist="Hachirin-no-obi",main="Claustrum"})
    elseif spell.element == world.weather_element then
      equip({waist="Hachirin-no-obi",main="Chatoyant staff"})
    end
		
    if state.CastingMode.value == 'TH' then
      equip({main="Lotus Katana"})
    end	
    
  end  
	
  if spellMap == 'Cure' then
    if not (world.weather_element == 'Dark' or world.day_element == 'Dark') then
      equip({waist="Hachirin-no-obi"})
    end
  end
		
  if state.MagicBurst.value then
    equip(sets.magic_burst)
  end

  if state.CastingMode.value == 'Accuracy' and not elemental_debuffs:contains(spell.english) then
    if player.status ~= 'Engaged' then
		  equip(sets.grip[spell.element])
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

function job_aftercast(spell,action,spellMap,eventArgs)

	if spell.skill == 'Elemental Magic' then
		state.MagicBurst:reset()
	end
	
end

function customize_idle_set(idleSet)

  if player.mpp > 95 then 
    idleSet = set_combine(idleSet,{main="Terra's staff"})
  end

  return idleSet
  
end