function get_sets()

	mote_include_version = 2
	include('Mote-Include.lua')

end

function job_setup()

	state.Buff['Sneak Attack'] 		 = buffactive['Sneak Attack'] or false
	state.Buff['Trick Attack'] 		 = buffactive['Trick Attack'] or false
	state.Buff['Assassin\'s Charge'] = buffactive['Assassin\'s Charge'] or false
	
	include('Kay-Include.lua')
	
	initialize_job()
	
end

function user_setup()

	include('Mote-TreasureHunter')

	state.OffenseMode:options('Normal','HybridAcc','Acc')
	state.WeaponskillMode:options('Normal','HNM')
	state.RangedMode:options('Normal')
	state.PhysicalDefenseMode:options('None','Evasion','PDT')
	state.MagicalDefenseMode:options('None','MDT')

	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind f10 gs c cycle TreasureMode; gs c custom_treasure_cycle')
	send_command('bind f11 gs c cycle WeaponskillMode')
	send_command('bind f12 gs c cycle PhysicalDefenseMode')
	send_command('bind ^f12 gs c cycle MagicalDefenseMode')
	
	send_command('bind !x gs c trade_earring1')
	send_command('bind !c gs c trade_earring2')
	send_command('bind !v gs c trade_ring')
	
	send_command('bind ^g gs c regear')
	
	gear.main = player.equipment.main
	gear.sub = player.equipment.sub

end

function init_gear_sets()

	-- misc.
	sets.TreasureHunter 				     = {hands="Assassin's armlets"}
										      --sub="Thief's knife"
	-- buff                                  
	sets.buff['Sneak Attack']                = {head="Hecatomb cap",neck="Spike necklace",ear1="Pixie earring",hands="Enkidu's mittens",ring1="Rajas ring",legs="Hecatomb subligar",feet="Enkidu's leggings"}
	sets.buff['Trick Attack'] 		         = {head="Enkidu's cap",body="Enkidu's harness",hands="Assassin's armlets",ring2="Celerity ring",feet="Enkidu's leggings"}
	sets.buff['Assassin\'s Charge']			 = {ear2="Hollow earring"}
	                                         
	-- precast ja                            
	sets.precast.JA                          = {waist="Buccaneer's belt"}
	                                         
	sets.precast.JA['Flee']                  = set_combine(sets.precast.JA,{feet="Rogue's poulaines"})
	sets.precast.JA['Steal']                 = set_combine(sets.precast.JA,{hands="Rogue's armlets", head="Rogue's bonnet", legs="Rogue's culottes", feet="Rogue's poulaines"})
	sets.precast.JA['Mug']                   = set_combine(sets.precast.JA,{head="Assassin's bonnet"})
	sets.precast.JA['Hide']                  = set_combine(sets.precast.JA,{body="Rogue's vest"})
	                                         
	-- precast magic                         
	sets.precast.FC                          = {ear2="Loquacious earring",legs="Homam cosciales"}
	                                         
	-- midcast magic                         
	sets.midcast.FastRecast                  = set_combine(sets.precast.FC,{head="Walahra turban",body="Rapparee harness",hands="Dusk gloves",waist="Velocious belt",legs="Homam cosciales",feet="Dusk ledelsens"})
	sets.midcast['Ninjutsu']                 = set_combine(sets.midcast.FastRecast,{})
	                                         
	-- idle                                  
	sets.idle                                = {head="Hecatomb cap"  ,neck="Chocobo whistle"  ,ear1="Suppanomimi"      ,ear2="Hollow earring"
										       ,body="Homam corazza" ,hands="Hecatomb mittens",ring1="Rajas ring"      ,ring2="Celerity ring"
										       ,back="Cerberus cape" ,waist="Lycopodium sash" ,legs="Hecatomb subligar",feet="Trotter boots"}
	sets.idle.Town                           = set_combine(sets.idle,{back="Nexus cape",ring2="Warp ring"})
	                                         
	sets.resting                             = {}
	                                         
	-- defense                               
	sets.defense.Evasion                     = {}
	sets.defense.PDT                         = {}
	sets.defense.MDT                         = {waist="Resolute belt"}
	                                         
	-- engaged                               
	sets.engaged                             = {head="Walahra turban"  ,neck="Chivalrous chain" ,ear1="Suppanomimi"    ,ear2="Hollow earring"
										       ,body="Homam corazza",hands="Dusk gloves"  ,ring1="Rajas ring"    ,ring2="Sniper's ring +1"
										       ,back="Amemet mantle",waist="Velocious belt"  ,legs="Homam cosciales",feet="Dusk ledelsens"}
	sets.engaged.HybridAcc                   = set_combine(sets.engaged,{neck="Peacock amulet",ring1="Sniper's ring +1"})
	sets.engaged.Acc                         = set_combine(sets.engaged.HybridAcc,{body="Homam corazza",hands="Enkidu's mittens"})
	                                         
	-- ranged                                
	sets.precast.RA                          = {head="Zha'Go's barbut"}
	                                         
	sets.midcast.RA                          = {head="Zha'Go's barbut" ,neck="Peacock amulet"       ,ear1="Hollow earring",ear2="Drone earring"
										       ,body="Enkidu's harness",hands="Barbarossa's moufles",ring1="Merman's ring",ring2="Merman's ring"
										       ,back="Mamool Ja mantle",waist="Buccaneer's belt"    ,legs="Oily trousers" ,feet="Enkidu's leggings"}
	                                         
	-- ws                                    
	sets.precast.WS                          = {head="Hecatomb cap"     ,neck="Spike necklace"   ,ear1="Pixie earring"    ,ear2="Brutal earring"
										       ,body="Enkidu's harness" ,hands="Hecatomb mittens",ring1="Rajas ring"      ,ring2="Flame ring"
										       ,back="Amemet mantle"    ,waist="Warwolf belt"    ,legs="Hecatomb subligar",feet="Enkidu's leggings"}
	sets.precast.WS.HNM                      = set_combine(sets.precast.WS,{head="Hecatomb cap",ear1="Bushinomimi",body="Hecatomb harness",feet="Hecatomb leggings +1"})
	                                         
	sets.precast.WS['Cyclone']               = set_combine(sets.precast.WS,{neck="Breeze gorget",ear2="Moldavite earring",ring2="Snow ring"})
	                                         
	sets.precast.WS['Dancing Edge']          = set_combine(sets.precast.WS,{neck="Soil gorget",ear1="Pixie earring"})
	sets.precast.WS['Dancing Edge'].HNM      = set_combine(sets.precast.WS['Dancing Edge'],{head="Hecatomb cap",ear1="Bushinomimi",body="Hecatomb harness",feet="Hecatomb leggings +1"})
	                                         
	sets.precast.WS['Exenterator']           = set_combine(sets.precast.WS['Dancing Edge'],{})
	sets.precast.WS['Exenterator'].HNM       = set_combine(sets.precast.WS['Dancing Edge'].HNM,{})
	                                         
	sets.precast.WS['Shark Bite']            = set_combine(sets.precast.WS,{neck="Breeze gorget",ring2="Blobnag ring",back="Assassin's cape",feet="Enkidu's leggings"})
	sets.precast.WS['Shark Bite'].HNM        = set_combine(sets.precast.WS['Shark Bite'],{ear1="Bushinomimi",feet="Hecatomb leggings +1"})
	                                         
	sets.precast.WS['Evisceration']          = set_combine(sets.precast.WS,{head="Hecatomb cap",neck="Shadow gorget",back="Cuchulain's mantle",feet="Hecatomb leggings +1"})
	sets.precast.WS['Evisceration'].HNM      = set_combine(sets.precast.WS['Evisceration'],{ear1="Bushinomimi",back="Commander's cape"})
	                                         
	sets.precast.WS['Mercy Stroke']          = set_combine(sets.precast.WS,{head="Hecatomb cap"    ,neck="Soil gorget"           
										     							   ,body="Hecatomb harness"             
										     							   ,back="Amemet mantle"                              ,legs="Enkidu's subligar",feet="Hecatomb leggings +1"})
	sets.precast.WS['Mercy Stroke'].HNM      = set_combine(sets.precast.WS['Mercy Stroke'],{ear1="Bushinomimi",back="Cerberus mantle"})
	
	-- SA WS
	sets.precast.WS.SA                       = set_combine(sets.precast.WS,sets.buff['Sneak Attack'])
	sets.precast.WS.HNM.SA                   = set_combine(sets.precast.WS.HNM,sets.buff['Sneak Attack'])
	
	sets.precast.WS['Shark Bite'].SA         = set_combine(sets.precast.WS['Shark Bite'],sets.buff['Sneak Attack'])
	sets.precast.WS['Shark Bite'].HNM.SA     = set_combine(sets.precast.WS['Shark Bite'].HNM,sets.buff['Sneak Attack'])
	
	sets.precast.WS['Mercy Stroke'].SA       = set_combine(sets.precast.WS['Mercy Stroke'],{ear1="Pixie earring",hands="Hecatomb mittens",legs="Hecatomb subligar"})
	sets.precast.WS['Mercy Stroke'].HNM.SA   = set_combine(sets.precast.WS['Mercy Stroke'].HNM,{ear1="Bushinomimi",hands="Hecatomb mittens",legs="Hecatomb subligar"})
	
	-- TA WS
	sets.precast.WS.TA                       = set_combine(sets.precast.WS,sets.buff['Trick Attack'])
	sets.precast.WS.HNM.TA                   = set_combine(sets.precast.WS.HNM,sets.buff['Trick Attack'])
	
	sets.precast.WS['Shark Bite'].TA         = set_combine(sets.precast.WS['Shark Bite'],sets.buff['Trick Attack'])
	sets.precast.WS['Shark Bite'].HNM.TA     = set_combine(sets.precast.WS['Shark Bite'].HNM,sets.buff['Trick Attack'])
	
	sets.precast.WS['Mercy Stroke'].TA       = set_combine(sets.precast.WS['Mercy Stroke'],{body="Enkidu's harness",hands="Hecatomb mittens"})
	sets.precast.WS['Mercy Stroke'].HNM.TA   = set_combine(sets.precast.WS['Mercy Stroke'].HNM,{ear1="Bushinomimi",hands="Hecatomb mittens"})
	
	-- SATA WS
	sets.precast.WS.SATA                     = set_combine(sets.precast.WS,sets.buff['Sneak Attack'],sets.buff['Trick Attack'])
	sets.precast.WS.HNM.SATA                 = set_combine(sets.buff['Sneak Attack'],sets.buff['Trick Attack'],{head="Hecatomb cap",ear1="Bushinomimi",body="Hecatomb harness",feet="Hecatomb leggings +1"})
	
	sets.precast.WS['Shark Bite'].SATA       = set_combine(sets.precast.WS['Shark Bite'],{})
	sets.precast.WS['Shark Bite'].HNM.SATA   = set_combine(sets.precast.WS['Shark Bite'].HNM,{})
	
	sets.precast.WS['Mercy Stroke'].SATA     = set_combine(sets.precast.WS['Mercy Stroke'],{ear1="Pixie earring",hands="Hecatomb mittens",legs="Hecatomb subligar"})
	sets.precast.WS['Mercy Stroke'].HNM.SATA = set_combine(sets.precast.WS['Mercy Stroke'].HNM,{ear1="Pixie earring",hands="Hecatomb mittens",legs="Hecatomb subligar"})

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

	if spell.english == 'Cyclone' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif (state.Buff['Sneak Attack'] or state.Buff['Trick Attack']) and spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' then
            equip(sets.TreasureHunter)
        end
    end
	if spell.type == 'WeaponSkill' and state.Buff['Assassin\'s Charge'] then
		if player.equipment.ear1 ~= "Bushinomimi" then
			equip({ear2="Bushinomimi"})
		else
			equip({ear2="Hollow earring"})
		end
	end

end

function get_custom_wsmode(spell, spellMap, defaut_wsmode)

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

function check_buff(buff_name,eventArgs)
	
	if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
	
end

function custom_treasure_cycle()
	
	if state.TreasureMode.value == 'Fulltime' then
		equip(sets.TreasureHunter)
		disable('hands')
	else
		enable('hands')
	end
	
end