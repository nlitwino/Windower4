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

	include('Mote-TreasureHunter.lua')

	state.OffenseMode:options('Normal','HybridAcc','Acc')
	state.WeaponskillMode:options('Normal','HNM')
	state.RangedMode:options('Normal')
	state.PhysicalDefenseMode:options('Evasion','PDT')
	state.MagicalDefenseMode:options('MDT')
	
	send_command('bind !f9 gs c cycle TreasureMode')

end

function init_gear_sets()

	-- misc.
	sets.TreasureHunter 				     = {hands="Assassin's armlets"}
										      --sub="Thief's knife"
	-- buff                                  
	sets.buff['Sneak Attack']                = {head="Maat's cap"        ,neck="Spike necklace"   ,ear1="Pixie earring"  
								               ,body="Antares harness"   ,hands="Enkidu's mittens",ring1="Rajas ring",ring2=gear.TRing1       
								               ,back="Cuchulain's mantle",waist="Warwolf belt"    ,legs="Hecatomb subligar +1",feet="Enkidu's leggings"}
	sets.buff['Trick Attack'] 		         = {head="Maat's cap"                                                     ,ear2="Drone earring"
									           ,body="Antares harness",hands="Rogue's armlets +1",ring1=gear.TRing2  ,ring2="Blobnag ring"
									           ,back="Assassin's cape",waist="Warwolf belt"      ,legs="Oily trousers",feet="Enkidu's leggings"}
	sets.buff['Assassin\'s Charge']			 = {ear2="Hollow earring"}
	                                         
	-- precast ja                            
	sets.precast.JA                          = {waist="Buccaneer's belt"}
	                                         
	sets.precast.JA['Flee']                  = set_combine(sets.precast.JA,{feet="Rogue's poulaines"})
	sets.precast.JA['Steal']                 = set_combine(sets.precast.JA,{head="Rogue's bonnet",hands="Rogue's armlets",legs="Rogue's culottes",feet="Rogue's poulaines"})
	sets.precast.JA['Mug']                   = set_combine(sets.precast.JA,{head="Assassin's bonnet"})
	sets.precast.JA['Hide']                  = set_combine(sets.precast.JA,{body="Rogue's vest"})
	                                         
	-- precast magic                         
	sets.precast.FC                          = {ear2="Loquacious earring",legs="Homam cosciales"}
	                                         
	-- midcast magic                         
	sets.midcast.FastRecast                  = set_combine(sets.precast.FC,{head="Walahra turban"  ,neck="Fortified chain",ear1="Drone earring"  ,ear2="Magnetic earring"
	                                                                       ,body="Rapparee harness",hands="Dusk gloves +1",ring1="Defending ring"                     
																		   ,back="Shadow mantle"   ,waist="Velocious belt",legs="Homam cosciales",feet="Dusk ledelsens +1"})
	sets.midcast['Utsusemi: Ni']             = set_combine(sets.midcast.FastRecast,{ring2="Antica ring"})
	sets.midcast['Utsusemi: Ichi']           = set_combine(sets.midcast.FastRecast,{body="Scorpion harness +1",waist="Resolute belt"})                                         
	-- idle                                  
	sets.idle                                = {head="Gnole crown"  ,neck="Chocobo whistle"     ,ear1="Merman's earring"    ,ear2="Merman's earring"
										       ,body="Homam corazza",hands="Hecatomb mittens +1",ring1="Defending ring"     ,ring2="Shadow ring"
										       ,back="Shadow mantle",waist="Lycopodium sash"    ,legs="Hecatomb subligar +1",feet="Trotter boots"}
	sets.idle.Town                           = set_combine(sets.idle,{back="Nexus cape",ring2="Warp ring"})
	                                         
	sets.resting                             = {}
	                                         
	-- defense                               
	sets.defense.Evasion                     = {head="Gnole crown",neck="Fortified chain",body="Scorpion harness +1",back="Boxer's mantle",legs="Raven hose"}
	sets.defense.PDT                         = {body="Darksteel harness +1",ring1="Defending ring",ring2="Jelly ring",back="Shadow mantle",legs="Darksteel subligar +1"}
	sets.defense.MDT                         = {ear1="Merman's earring",ear2="Merman's earring",body="Avalon breastplate",ring1="Defending ring",ring2="Shadow ring",waist="Resolute belt",feet="Merman's leggings"}
	                                         
	-- engaged                               
	sets.engaged                             = {head="Walahra turban"  ,neck="Chivalrous chain" ,ear1="Suppanomimi"    ,ear2="Brutal earring"
										       ,body="Rapparee harness",hands="Dusk gloves +1"  ,ring1=gear.TRing2     ,ring2=gear.TRing1
										       ,back="Cerberus mantle +1",waist="Velocious belt",legs="Homam cosciales",feet="Dusk ledelsens +1"}
	sets.engaged.HybridAcc                   = set_combine(sets.engaged,{neck="Peacock amulet",hands="Homam manopolas",back="Cuchulain's mantle",feet="Homam gambieras"})
	sets.engaged.Acc                         = set_combine(sets.engaged.HybridAcc,{head="Homam zucchetto",body="Homam corazza"})
	                                         
	-- ranged                                
	sets.precast.RA                          = {head="Zha'Go's barbut"}
	                                         
	sets.midcast.RA                          = {head="Zha'Go's barbut" ,neck="Peacock amulet"       ,ear1="Drone earring",ear2="Drone earring"
										       ,body="Enkidu's harness",hands="Barbarossa's moufles",ring1="Merman's ring",ring2="Merman's ring"
										       ,back="Mamool Ja mantle",waist="Buccaneer's belt"    ,legs="Oily trousers" ,feet="Enkidu's leggings"}
	                                         
	-- ws                                    
	sets.precast.WS                          = {head="Maat's cap"      ,neck="Fotia gorget"        ,ear1="Pixie earring"       ,ear2="Brutal earring"
										       ,body="Hecatomb harness",hands="Hecatomb mittens +1",ring1="Rajas ring"         ,ring2="Flame ring"
										       ,back="Commander's cape",waist="Warwolf belt"       ,legs="Hecatomb subligar +1",feet="Enkidu's leggings"}
	sets.precast.WS.HNM                      = set_combine(sets.precast.WS,{head="Hecatomb cap",neck="Peacock amulet",ear1="Bushinomimi",body="Hecatomb harness",feet="Hecatomb leggings +1"})
	                                         
	sets.precast.WS['Cyclone']               = set_combine(sets.precast.WS,{ear2="Moldavite earring",ring2="Snow ring"})
	                                         
	sets.precast.WS['Dancing Edge']          = set_combine(sets.precast.WS,{ear1="Pixie earring",feet="Hecatomb leggings +1"})
	sets.precast.WS['Dancing Edge'].HNM      = set_combine(sets.precast.WS['Dancing Edge'],{head="Hecatomb cap",ear1="Bushinomimi"})
	                                         
	sets.precast.WS['Exenterator']           = set_combine(sets.precast.WS['Dancing Edge'],{})
	sets.precast.WS['Exenterator'].HNM       = set_combine(sets.precast.WS['Dancing Edge'].HNM,{})
	                                         
	sets.precast.WS['Shark Bite']            = set_combine(sets.precast.WS,{body="Antares harness",ring2="Blobnag ring",back="Assassin's cape",feet="Enkidu's leggings"})
	sets.precast.WS['Shark Bite'].HNM        = set_combine(sets.precast.WS['Shark Bite'],{ear1="Bushinomimi",feet="Hecatomb leggings +1"})
	                                         
	sets.precast.WS['Evisceration']          = set_combine(sets.precast.WS,{head="Hecatomb cap",back="Cuchulain's mantle",feet="Hecatomb leggings +1"})
	sets.precast.WS['Evisceration'].HNM      = set_combine(sets.precast.WS['Evisceration'],{ear1="Bushinomimi",back="Commander's cape"})
	                                         
	sets.precast.WS['Mercy Stroke']          = set_combine(sets.precast.WS,{head="Hecatomb cap"                                  ,ear1="Merman's earring" 
										     							   ,body="Hecatomb harness",hands="Alkyoneus's bracelets"              
										     							   ,back="Cerberus mantle +1"                                                    ,feet="Hecatomb leggings +1"})
	sets.precast.WS['Mercy Stroke'].HNM      = set_combine(sets.precast.WS['Mercy Stroke'],{ear1="Bushinomimi",back="Cerberus mantle +1"})
	
	-- SA WS
	sets.precast.WS.SA                       = set_combine(sets.precast.WS,sets.buff['Sneak Attack'])
	sets.precast.WS.HNM.SA                   = set_combine(sets.precast.WS.HNM,sets.buff['Sneak Attack'])
	
	sets.precast.WS['Shark Bite'].SA         = set_combine(sets.precast.WS['Shark Bite'],sets.buff['Sneak Attack'])
	sets.precast.WS['Shark Bite'].HNM.SA     = set_combine(sets.precast.WS['Shark Bite'].HNM,sets.buff['Sneak Attack'])
	
	sets.precast.WS['Mercy Stroke'].SA       = set_combine(sets.precast.WS['Mercy Stroke'],{ear1="Pixie earring",hands="Hecatomb mittens +1",back="Cuchulain's mantle"})
	sets.precast.WS['Mercy Stroke'].HNM.SA   = set_combine(sets.precast.WS['Mercy Stroke'].HNM,{ear1="Bushinomimi",hands="Hecatomb mittens +1",back="Cuchulain's mantle"})
	
	-- TA WS
	sets.precast.WS.TA                       = set_combine(sets.precast.WS,sets.buff['Trick Attack'])
	sets.precast.WS.HNM.TA                   = set_combine(sets.precast.WS.HNM,sets.buff['Trick Attack'])
	
	sets.precast.WS['Shark Bite'].TA         = set_combine(sets.precast.WS['Shark Bite'],sets.buff['Trick Attack'])
	sets.precast.WS['Shark Bite'].HNM.TA     = set_combine(sets.precast.WS['Shark Bite'].HNM,sets.buff['Trick Attack'])
	
	sets.precast.WS['Mercy Stroke'].TA       = set_combine(sets.precast.WS['Mercy Stroke'],{head="Maat's cap",ear1="Drone earring",hands="Rogue's armlets +1",ring2="Blobnag ring"})
	sets.precast.WS['Mercy Stroke'].HNM.TA   = set_combine(sets.precast.WS['Mercy Stroke'].HNM,{head="Maat's cap",ear1="Bushinomimi",hands="Rogue's armlets +1",ring2="Blobnag ring"})
	
	-- SATA WS
	sets.precast.WS.SATA                     = set_combine(sets.precast.WS,sets.buff['Sneak Attack'],sets.buff['Trick Attack'])
	sets.precast.WS.HNM.SATA                 = set_combine(sets.buff['Sneak Attack'],sets.buff['Trick Attack'],{head="Hecatomb cap",ear1="Bushinomimi",body="Hecatomb harness",feet="Hecatomb leggings +1"})
	
	sets.precast.WS['Shark Bite'].SATA       = set_combine(sets.precast.WS['Shark Bite'],{})
	sets.precast.WS['Shark Bite'].HNM.SATA   = set_combine(sets.precast.WS['Shark Bite'].HNM,{})
	
	sets.precast.WS['Mercy Stroke'].SATA     = set_combine(sets.precast.WS['Mercy Stroke'],{head="Maat's cap",ear1="Pixie earring",body="Antares harness",hands="Rogue's armlets +1",back="Commander's cape",legs="Hecatomb subligar +1"})
	sets.precast.WS['Mercy Stroke'].HNM.SATA = set_combine(sets.precast.WS['Mercy Stroke'].HNM,{head="Maat's cap",ear1="Pixie earring",hands="Rogue's armlets +1",back="Commander's cape",legs="Hecatomb subligar +1"})

end

function job_post_aftercast()

	if state.TreasureMode.value == 'Fulltime' then
		equip(sets.TreasureHunter)
	end

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
		if player.inventory['Bushinomimi'] then
			equip({ear2="Bushinomimi"})
		else
			if state.Buff['Trick Attack'] then
				equip({ear2="Drone earring"})
			else
				equip({ear2="Merman's earring"})
			end
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

function customize_melee_set(meleeSet)

	if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
	
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