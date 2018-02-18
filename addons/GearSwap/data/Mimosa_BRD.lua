function get_sets()
    mote_include_version = 2
    
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

	include('Kay-Include.lua')
	
    state.Buff['Pianissimo'] = buffactive['Pianissimo'] or false
	state.Buff['Nightingale'] = buffactive['Nightingale'] or false
	state.Buff['Troubadour'] = buffactive['Troubadour'] or false
	
	initialize_job()
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()

    state.OffenseMode:options('Normal','Acc')
	state.CastingMode:options('Normal','Resistant')
	state.WeaponskillMode:options('Normal','Acc')
	state.PhysicalDefenseMode:options('None','PDT')
	state.MagicalDefenseMode:options('None','MDT')

end


-- Define sets and vars used by this job file.
function init_gear_sets()

	-- Misc.
	sets.MND 												 = {main="Chatoyant staff"            ,sub="Bugard leather strap +1"
	                                                           ,head="Choral roundlet"            ,neck="Holy phial"            ,ear1="Mamool Ja earring",ear2="Star earring"
															   ,body="Kirin's osode"              ,hands="Bricta's cuffs"       ,ring1="Tamas ring"      ,ring2="Star ring"
															   ,back=prism_cape['Magic Accuracy'],waist="Steppe rope"          ,legs="Mahatma slops"    ,feet="Suzaku's sune-ate"}
															   
	sets.INT												 = {main="Chatoyant staff"            ,sub="Bugard leather strap +1"                       ,ammo="Phantom tathlum"
															                                                                    ,ear1="Abyssal earring"
															   ,body="Kirin's osode"              ,hands="Garrison gloves"      ,ring1="Tamas ring"    ,ring2="Snow ring"
															   ,back=prism_cape['Magic Accuracy']                              ,legs="Mahatma slops"  ,feet="Rostrum pumps"}
															   
	sets.CHR												 = {main="Chatoyant staff" ,sub="Bugard leather strap +1",range="Gjallarhorn"
															   ,head="Bard's roundlet" ,neck="Piper's torque"        ,ear1="Melody earring +1",ear2="Melody earring +1"
															   ,body="Kirin's osode"   ,hands="Choral cuffs +1"	     ,ring1="Light ring"      ,ring2="Light ring"
															   ,back="Jester's cape +1",waist="Corsette"             ,legs="Mahatma slops"    ,feet="Sha'ir crackows"}
	                                                         
	sets.obi												 = {Fire 	  = {waist="Karin Obi"}
															   ,Earth  	  = {waist="Dorin Obi"}
															   ,Water	  = {waist="Suirin Obi"}
															   ,Wind 	  = {waist="Furin Obi"}
															   ,Ice 	  = {waist="Hyorin Obi"}
															   ,Lightning = {waist="Rairin Obi"}
															   ,Light  	  = {waist="Korin Obi"}
															   ,Dark 	  = {waist="Anrin Obi"}}
															 	   
	sets.grip												 = {Fire 	  = {sub="Fire Grip"}
															   ,Earth 	  = {sub="Earth Grip"}
															   ,Water 	  = {sub="Water Grip"}
															   ,Wind 	  = {sub="Wind Grip"}
															   ,Ice 	  = {sub="Ice Grip"}
															   ,Lightning = {sub="Lightning Grip"}
															   ,Light 	  = {sub="Light Grip"}
															   ,Dark 	  = {sub="Dark Grip"}}
	
	-- Precast magic
    sets.precast.FC 										 = {ear2="Loquacious earring",feet="Rostrum pumps",back=prism_cape['Fast Cast']}
    sets.precast.JA				 							 = {head="Bard's roundlet",body="Errant houppelande",hands="Bard's cuffs",ring1="Tamas ring",back="Ixion cape",legs="Choral cannions",feet="Avocat pigaches"}
	
    sets.precast.Waltz 										 = set_combine(sets.CHR,{})

    sets.precast.FC['BardSong'] 							 = set_combine(sets.precast.FC,{main="Chatoyant staff",head="Genbu's kabuto",body="Sha'ir manteel",hands="Seiryu's kote",ring1="Light ring",ring2="Minstrel's ring",back="Ixion cape",legs="Bard's cannions"})
	
	-- Midcast magic
	sets.midcast['Enhancing Magic'] 						 = {hands="Oracle's gloves"}
	sets.midcast['Enfeebling Magic'] 						 = {neck="Enfeebling torque",feet="Avocat pigaches"}
	sets.midcast['Healing Magic'] 							 = set_combine(sets.MND, {neck="Healing torque"})
	sets.midcast['Divine Magic'] 							 = set_combine(sets.MND, {})
	sets.midcast['Dark Magic']								 = set_combine(sets.INT, {neck="Dark torque"})
	
	
	sets.midcast['BardSong']								 = set_combine(sets.CHR,{head="Bard's roundlet",neck="Wind torque",ear1="Musical earring",body="Minstrel's coat",hands="Choral cuffs +1",ring1="Nereid ring",ring2="Nereid ring",legs="Choral cannions +1",feet="Oracle's pigaches"})
	
	sets.midcast['Lullaby']									 = set_combine(sets.CHR,{neck="Piper's torque",hands="Sheikh gages"})
	sets.midcast['Magic Finale']							 = set_combine(sets.midcast['Lullaby'],{neck="Piper's torque",hands="Sheikh gages"})
	sets.midcast['Elegy']									 = set_combine(sets.midcast['Lullaby'],{neck="Piper's torque",hands="Sheikh gages"})
	sets.midcast['Requiem']									 = set_combine(sets.midcast['Lullaby'],{neck="Piper's torque",hands="Choral cuffs +1"})
	sets.midcast['Threnody']								 = set_combine(sets.midcast['Lullaby'],{neck="Piper's torque",hands="Choral cuffs +1"})
	
	
	sets.midcast['Enfeebling Magic']['WhiteMagic'] 			 = set_combine(sets.MND,sets.midcast['Enfeebling Magic'])
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Resistant = set_combine(sets.MND,sets.midcast['Enfeebling Magic'])
	
	sets.midcast['Elemental Magic'] 						 = set_combine(sets.INT,{head="Oracle's cap",neck="Elemental torque",hands="Zenith mitts",back="Ixion cape"})
	sets.midcast['Elemental Magic'].Resistant 				 = set_combine(sets.midcast['Elemental Magic'],{})
	
	sets.midcast['Enfeebling Magic']['BlackMagic'] 			 = set_combine(sets.MND,sets.midcast['Enfeebling Magic'])
	sets.midcast['Enfeebling Magic']['BlackMagic'].Resitant  = set_combine(sets.MND,sets.midcast['Enfeebling Magic'])
	
	sets.midcast.FastRecast 								 = set_combine(sets.precast.FC,{head="Walahra turban",legs="Byakko's haidate"})
	
	sets.midcast['Stoneskin']								 = set_combine(sets.MND,sets.midcast['Enhancing Magic'],{head="Walahra turban",waist="Velocious belt",})
	
	-- Idle sets
	sets.idle 												 = {main="Terra's staff",sub="Bugard leather strap +1",range="Gjallarhorn"
															   ,head="Hecatomb cap" ,neck="Chocobo whistle"       ,ear1="Mamool Ja earring",ear2="Star earring"
															   ,body="Dalmatica"    ,hands="Zenith mitts"         ,ring1="Ether ring"      ,ring2="Serket ring"
															   ,back="Hexerei cape" ,waist="Lycopodium sash"      ,legs="Zenith slacks"    ,feet="Rostrum pumps"}
	sets.idle.Town 											 = set_combine(sets.idle,{back="Nexus cape",ring2="Warp ring"})
	
	sets.resting											 = {main="Chatoyant staff",head="Oracle's cap",neck="Orochi nodowa",body="Oracle's robe",hands="Oracle's gloves",ring2="Star ring",back="Invigorating cape",legs="Oracle's braconi",feet="Numerist pumps"}
	
	-- Defense sets
	sets.defense.PDT										 = {}
	sets.defense.MDT 										 = {ring1="Merman's ring",ring2="Merman's ring"}
	
	-- Engaged sets
	sets.engaged											 = {head="Walahra turban",neck="Peacock amulet",ear1="Pixie earring",ear2="Brutal earring"
															   ,body="Sha'ir manteel",hands="Dusk gloves",ring1="Sniper's ring +1",ring2="Sniper's ring +1"
															   ,back="Bard's cape"   ,waist="Velocious belt",legs="Byakko's haidate",feet="Dusk ledelsens +1"}
	sets.engaged.Acc										 = set_combine(sets.engaged,{})
	sets.engaged.HNM 										 = set_combine(sets.engaged.Acc, {})
	
	-- WS sets
	sets.precast.WS 										 = {body="Kirin's osode"}
	sets.precast.WS.Acc										 = set_combine(sets.precast.WS,{})
	
    sets.precast.WS['Evisceration'] 						 = set_combine(sets.precast.WS,{})
	sets.precast.WS['Evisceration'].Acc 					 = set_combine(sets.precast.WS,{})
	
    sets.precast.WS['Exenterator'] 							 = set_combine(sets.precast.WS,{})
	sets.precast.WS['Exenterator'].Acc 						 = set_combine(sets.precast.WS,{})

    sets.precast.WS['Mercy Stroke'] 						 = set_combine(sets.precast.WS,{})
    sets.precast.WS['Mercy Stroke'].Acc 					 = set_combine(sets.precast.WS,{})
	
end

-- Auto-Pianissimo
function job_precast(spell, action, spellMap, eventArgs)

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
function job_midcast(spell, action, spellMap, eventArgs)
	
	if spell.skill == 'Enfeebling Magic' then
		equip(sets.midcast[spell.skill][spell.type])
	else 
		equip(sets.midcast[spell.skill])
    end
	
end

-- Obi and grip handling
function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Apply Obi
	if spell.skill == 'Elemental Magic' then 
		if spell.element == world.weather_element or spell.element == world.day_element then
			equip(sets.obi[spell.element])
		end
	end
	
	if spellMap == 'Cure' then
		if not (world.weather_element == 'Dark' or world.day_element == 'Dark') then
			equip(sets.obi[spell.element])
		end
	end
	
end

function job_status_change(new,old)

	if new == 'Engaged' then
		disable("main","sub","range","ammo")
	else
		enable("main","sub","range","ammo")
	end

end