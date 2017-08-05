function get_sets()

	mote_include_version = 2
	include('organizer-lib.lua')
	include('Mote-Include.lua')
	
end

function job_setup()

	state.Buff['Sneak Attack'] = buffactive['Sneak Attack'] or false
	state.Buff['Trick Attack'] = buffactive['Trick Attack'] or false
	
end

function user_setup()

	state.OffenseMode:options('Normal','Acc','HNM','Pure')
	state.WeaponskillMode:options('Normal','Acc','HNM')
	state.RangedMode:options('Normal','Acc')
	state.DefenseMode:options('Normal','Evasion','MDT','PDT')
	
	include('Mote-TreasureHunter')
	
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind f10 gs c cycle WeaponskillMode')
	send_command('bind f11 gs c cycle RangedMode')
	send_command('bind f12 gs c cycle DefenseMode')
    send_command('bind ^= gs c cycle treasuremode')

end

function init_gear_sets()
	
	--Misc.
	sets.resting 							 = {}
	sets.TreasureHunter 					 = {hands="Assassin's armlets"}
	                                         
	--Buff Sets                              
	sets.buff['Sneak Attack']  				 = {body="Dragon harness",back="Cuchulain's mantle",waist="Warwolf belt"}
	sets.buff['Trick Attack']  				 = {body="Enkidu's harness",back="Assassin's cape"}
	                                         
	--Precast JAs                            
	sets.precast.JA  						 = {waist="Buccaneer's belt"}
	sets.precast.JA['Flee']  				 = set_combine(sets.precast.JA,{feet="Rogue's poulaines"})
	sets.precast.JA['Steal']  				 = set_combine(sets.precast.JA,{hands="Rogue's armlets", head="Rogue's bonnet", legs="Rogue's culottes", feet="Rogue's poulaines"})
	sets.precast.JA['Mug']  				 = set_combine(sets.precast.JA,{head="Assassin's bonnet"})
	sets.precast.JA['Hide']  				 = set_combine(sets.precast.JA,{body="Rogue's vest"})
	                                         
	--Precast Magic                          
	sets.precast.FC 						 = {}
	                                         
	--Midcast Magic                          
	sets.midcast.FastRecast  				 = set_combine({head="Walahra turban",body="Rapparee harness",hands="Dusk gloves",waist="Velocious belt",legs="Bravo's subligar",feet="Dusk ledelsens +1"}, sets.precast.FC)
	sets.midcast['Ninjutsu']				 = set_combine(sets.midcast.FastRecast, {ring2="Antica ring"})
	                                         
	--Idle Sets                              
	sets.idle								 = {head="Gnole crown",neck="Chocobo whistle",ear1="Merman's earring",ear2="Merman's earring",body="Scorpion harness +1",hands="Assassin's armlets",ring1="Defending ring",ring2="Merman's ring",back="Kinesis mantle +1",waist="Lycopodium sash",legs="Hectaomb subligar +1",feet="Trotter boots"}
											  
	sets.idle.Town 							 = set_combine(sets.idle, {head="Dream hat +1",neck="Orochi nodowa",ear1="Merman's earring",ear2="Merman's earring",body="Rapparee harness",hands="Assassin's armlets",ring1="Defending ring",ring2="Merman's ring",back="Nexus cape",waist="Lycopodium sash",legs="Bravo's subligar",feet="Trotter boots"})
	                                         
	sets.Kiting 							 = {feet="Trotter boots"}
	                                         
	-- Defense sets                          
	sets.Defense.Evasion			 		 = {head="Gnole crown",neck="Fortified chain",body="Scorpion harness +1",back="Kinesis mantle +1"}
	sets.Defense.PDT				 		 = set_combine(sets.Defense.Evasion,{ring1="Defending ring",ring2="Jelly ring"})
	sets.Defense.MDT				 		 = {ear1="Merman's earring",ear2="Merman's earring",ring1="Defending ring",ring2="Merman's ring"}
	                                         
	-- TP sets	                             
	sets.engaged					 		 = {head="Walahra turban",neck="Peacock amulet",ear1="Suppanomimi",ear2="Pixie earring",body="Rapparee harness",hands="Dusk gloves",ring1="Rajas ring",ring2="Sniper's ring +1",back="Berberus mantle",waist="Velocious belt",legs="Bravo's subligar",feet="Dusk ledelsens +1"}
	sets.engaged.Acc				 		 = set_combine(sets.engaged,{head="Homam zucchetto",body="Homam corazza",ring1="Sniper's ring +1",back="Cuchulain's mantle",feet="Enkidu's leggings"})
	sets.engaged.HNM				 		 = set_combine(sets.engaged.Acc, {ear1="Bushinomimi"})
	sets.engaged.Pure    				     = set_combine(sets.engaged.HNM,{head="Enkidu's cap",hands="Enkidu's mittens",legs="Oily trousers"})
		                                     
	--Weaponskill Sets	                     
	sets.precast.WS 						 = {head="Hecatomb cap", neck="Spike necklace", ear1="Pixie earring", ear2="Merman's earring", body="Dragon harness", hands="Enkidu's mittens", ring1="Rajas ring", ring2="Flame ring", back="Amemet mantle +1", waist="Warwolf belt", legs="Hecatomb subligar +1", feet="Bounding boots"}
	sets.precast.WS.Acc 					 = set_combine(sets.precast.WS, {head="Enkidu's cap", neck="Peacock amulet", body="Scorpion harness +1", back="Cuchulain's mantle"})
		                                     
	-- Normal WS sets	                     
	sets.precast.WS					 		 = {head="Hecatomb cap",neck="Spike necklace",ear1="Merman's earring",ear2="Merman's earring",body="Dragon harness",hands="Enkidu's mittens",ring1="Rajas ring",ring2="Flame ring",back="Cerberus mantle",waist="Warwolf belt",legs="Hecatomb subligar +1",feet="Enkidu's leggings"}
	sets.precast.WS.Acc				  		 = set_combine(sets.precast.WS,{neck="Peacock amulet", ring2="Sniper's ring +1",back="Cuchulain's mantle"})
	sets.precast.WS.HNM				 		 = set_combine(sets.precast.WS.Acc,{ear1="Bushinomimi"})
	                                         
	sets.precast.WS['Mercy Stroke']			 = {head="Hecatomb cap",neck="Spike necklace", ear1="Merman's earring",ear2="Merman's earring",body="Enkidu's harness",hands="Alkyoneus's bracelets",ring1="Rajas ring",ring2="Flame ring",back="Cerberus mantle",waist="Warwolf belt",legs="Enkidu's subligar",feet="Rutter sabatons"}
	sets.precast.WS['Mercy Stroke'].Acc		 = set_combine(sets.precast.WS.MercyStroke,{neck="Soil gorget"})
	sets.precast.WS['Mercy Stroke'].HNM		 = set_combine(sets.precast.WS.MercyStroke.Acc,{ear1="Bushinomimi"})
	                                         
	sets.precast.WS['Shark Bite']			 = {head="Gnadbhod's helm",neck="Spike necklace",ear1="Merman's earring",ear2="Merman's earring",body="Dragon harness",hands="Enkidu's mittens",ring1="Rajas ring",ring2="Celerity ring",back="Cerberus mantle",waist="Warwolf belt",legs="Hecatomb subligar +1",feet="Enkidu's leggings"}
	sets.precast.WS['Shark Bite'].Acc		 = set_combine(sets.precast.WS.SharkBite,{neck="Breeze gorget"})
	sets.precast.WS['Shark Bite'].HNM		 = set_combine(sets.precast.WS.SharkBite.Acc,{})
	                                         
	sets.precast.WS['Dancing Edge']			 = {head="Gnadbhod's helm",neck="Breeze gorget",ear1="Merman's earring",ear2="Merman's earring",body="Dragon harness",hands="Enkidu's mittens",ring1="Rajas ring",ring2="Flame ring",back="Cerberus mantle",waist="Warwolf belt",legs="Hecatomb subligar +1",feet="Enkidu's leggings"}
	sets.precast.WS['Dancing Edge'].Acc		 = set_combine(sets.precast.WS.DancingEdge,{ring2="Sniper's ring +1",back="Cuchulain's mantle"})
	sets.precast.WS['Dancing Edge'].HNM		 = set_combine(sets.precast.WS.DancingEdge.Acc,{})
	                                         
	sets.precast.WS['Exenterator']			 = sets.precast.WS.DancingEdge
	sets.precast.WS['Exenterator'].Acc		 = sets.precast.WS.DancingEdge.Acc
	sets.precast.WS['Exenterator'].HNM		 = sets.precast.WS.DancingEdge.HNM
		                                     
	sets.precast.WS['Evisceration']	 		 = {head="Gnadbhod's helm",neck="Light gorget",ear1="Merman's earring",ear2="Merman's earring",body="Dragon harness",hands="Enkidu's mittens",ring1="Rajas ring",ring2="Flame ring",back="Cerberus mantle",waist="Warwolf belt",legs="Hecatomb subligar +1",feet="Enkidu's leggings"}
	sets.precast.WS['Evisceration'].Acc 	 = set_combine(sets.precast.WS.DancingEdge,{ring2="Sniper's ring +1"})
	sets.precast.WS['Evisceration'].HNM 	 = set_combine(sets.precast.WS.DancingEdge.Acc,{})
		                                     
	sets.precast.WS['Cyclone']				 = set_combine(sets.precast.WS,sets.TreasureHunter)
	                                         
	-- SA WS sets                            
	sets.precast.WS.SA                       = set_combine(sets.precast.WS,sets.buff['Sneak Attack'])			 
	sets.precast.WS.Acc.SA                   = set_combine(sets.precast.WS,sets.buff['Sneak Attack'])				  
	sets.precast.WS.HNM.SA                   = set_combine(sets.precast.WS,sets.buff['Sneak Attack'])					 
                                             
	sets.precast.WS['Mercy Stroke'].SA       = set_combine(sets.precast.WS['Mercy Stroke'],sets.buff['Sneak Attack'])		
	sets.precast.WS['Mercy Stroke'].Acc.SA   = set_combine(sets.precast.WS['Mercy Stroke'].Acc,sets.buff['Sneak Attack'])	
	sets.precast.WS['Mercy Stroke'].HNM.SA   = set_combine(sets.precast.WS['Mercy Stroke'].HNM,sets.buff['Sneak Attack'])	
                                             
	sets.precast.WS['Shark Bite'].SA         = set_combine(sets.precast.WS['Shark Bite'],sets.buff['Sneak Attack'])		
	sets.precast.WS['Shark Bite'].Acc.SA     = set_combine(sets.precast.WS['Shark Bite'].Acc,sets.buff['Sneak Attack'])	
	sets.precast.WS['Shark Bite'].HNM.SA     = set_combine(sets.precast.WS['Shark Bite'].HNM,sets.buff['Sneak Attack'])	
                                             
	sets.precast.WS['Dancing Edge'].SA       = set_combine(sets.precast.WS['Dancing Edge'],sets.buff['Sneak Attack'])	
	sets.precast.WS['Dancing Edge'].Acc.SA   = set_combine(sets.precast.WS['Dancing Edge'].Acc,sets.buff['Sneak Attack'])	
	sets.precast.WS['Dancing Edge'].HNM.SA   = set_combine(sets.precast.WS['Dancing Edge'].HNM,sets.buff['Sneak Attack'])	
                                             
	sets.precast.WS['Exenterator'].SA        = set_combine(sets.precast.WS['Exenterator'],sets.buff['Sneak Attack'])	
	sets.precast.WS['Exenterator'].Acc.SA    = set_combine(sets.precast.WS['Exenterator'].Acc,sets.buff['Sneak Attack'])	
	sets.precast.WS['Exenterator'].HNM.SA    = set_combine(sets.precast.WS['Exenterator'].HNM,sets.buff['Sneak Attack'])	
	                                         
	sets.precast.WS['Evisceration'].SA       = set_combine(sets.precast.WS['Evisceration'],sets.buff['Sneak Attack'])	
	sets.precast.WS['Evisceration'].Acc.SA   = set_combine(sets.precast.WS['Evisceration'].Acc,sets.buff['Sneak Attack'])	
	sets.precast.WS['Evisceration'].HNM.SA	 = set_combine(sets.precast.WS['Evisceration'].HNM,sets.buff['Sneak Attack'])	
	                                         
	-- TA WS sets                            
	sets.precast.WS.SA                       = set_combine(sets.precast.WS,sets.buff['Trick Attack'])			 
	sets.precast.WS.Acc.SA                   = set_combine(sets.precast.WS,sets.buff['Trick Attack'])				  
	sets.precast.WS.HNM.SA                   = set_combine(sets.precast.WS,sets.buff['Trick Attack'])					 
                                             
	sets.precast.WS['Mercy Stroke'].SA       = set_combine(sets.precast.WS['Mercy Stroke'],sets.buff['Trick Attack'])		
	sets.precast.WS['Mercy Stroke'].Acc.SA   = set_combine(sets.precast.WS['Mercy Stroke'].Acc,sets.buff['Trick Attack'])	
	sets.precast.WS['Mercy Stroke'].HNM.SA   = set_combine(sets.precast.WS['Mercy Stroke'].HNM,sets.buff['Trick Attack'])	
                                             
	sets.precast.WS['Shark Bite'].SA         = set_combine(sets.precast.WS['Shark Bite'],sets.buff['Trick Attack'])		
	sets.precast.WS['Shark Bite'].Acc.SA     = set_combine(sets.precast.WS['Shark Bite'].Acc,sets.buff['Trick Attack'])	
	sets.precast.WS['Shark Bite'].HNM.SA     = set_combine(sets.precast.WS['Shark Bite'].HNM,sets.buff['Trick Attack'])	
                                             
	sets.precast.WS['Dancing Edge'].SA       = set_combine(sets.precast.WS['Dancing Edge'],sets.buff['Trick Attack'])	
	sets.precast.WS['Dancing Edge'].Acc.SA   = set_combine(sets.precast.WS['Dancing Edge'].Acc,sets.buff['Trick Attack'])	
	sets.precast.WS['Dancing Edge'].HNM.SA   = set_combine(sets.precast.WS['Dancing Edge'].HNM,sets.buff['Trick Attack'])	
                                             
	sets.precast.WS['Exenterator'].SA        = set_combine(sets.precast.WS['Exenterator'],sets.buff['Trick Attack'])	
	sets.precast.WS['Exenterator'].Acc.SA    = set_combine(sets.precast.WS['Exenterator'].Acc,sets.buff['Trick Attack'])	
	sets.precast.WS['Exenterator'].HNM.SA    = set_combine(sets.precast.WS['Exenterator'].HNM,sets.buff['Trick Attack'])	
	                                         
	sets.precast.WS['Evisceration'].SA       = set_combine(sets.precast.WS['Evisceration'],sets.buff['Trick Attack'])	
	sets.precast.WS['Evisceration'].Acc.SA   = set_combine(sets.precast.WS['Evisceration'].Acc,sets.buff['Trick Attack'])	
	sets.precast.WS['Evisceration'].HNM.SA	 = set_combine(sets.precast.WS['Evisceration'].HNM,sets.buff['Trick Attack'])	
	
	-- SATA WS sets
	sets.precast.WS.SATA                     = set_combine(sets.precast.WS,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])			 
	sets.precast.WS.Acc.SATA                 = set_combine(sets.precast.WS,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])				  
	sets.precast.WS.HNM.SATA                 = set_combine(sets.precast.WS,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])					 

	sets.precast.WS['Mercy Stroke'].SATA     = set_combine(sets.precast.WS['Mercy Stroke'],sets.buff['Trick Attack'],sets.buff['Sneak Attack'])		
	sets.precast.WS['Mercy Stroke'].Acc.SATA = set_combine(sets.precast.WS['Mercy Stroke'].Acc,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])	
	sets.precast.WS['Mercy Stroke'].HNM.SATA = set_combine(sets.precast.WS['Mercy Stroke'].HNM,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])	

	sets.precast.WS['Shark Bite'].SATA       = set_combine(sets.precast.WS['Shark Bite'],sets.buff['Trick Attack'],sets.buff['Sneak Attack'])		
	sets.precast.WS['Shark Bite'].Acc.SATA   = set_combine(sets.precast.WS['Shark Bite'].Acc,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])	
	sets.precast.WS['Shark Bite'].HNM.SATA   = set_combine(sets.precast.WS['Shark Bite'].HNM,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])	

	sets.precast.WS['Dancing Edge'].SATA     = set_combine(sets.precast.WS['Dancing Edge'],sets.buff['Trick Attack'],sets.buff['Sneak Attack'])	
	sets.precast.WS['Dancing Edge'].Acc.SATA = set_combine(sets.precast.WS['Dancing Edge'].Acc,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])	
	sets.precast.WS['Dancing Edge'].HNM.SATA = set_combine(sets.precast.WS['Dancing Edge'].HNM,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])	

	sets.precast.WS['Exenterator'].SATA      = set_combine(sets.precast.WS['Exenterator'],sets.buff['Trick Attack'],sets.buff['Sneak Attack'])	
	sets.precast.WS['Exenterator'].Acc.SATA  = set_combine(sets.precast.WS['Exenterator'].Acc,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])	
	sets.precast.WS['Exenterator'].HNM.SATA  = set_combine(sets.precast.WS['Exenterator'].HNM,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])	
	
	sets.precast.WS['Evisceration'].SATA     = set_combine(sets.precast.WS['Evisceration'],sets.buff['Trick Attack'],sets.buff['Sneak Attack'])	
	sets.precast.WS['Evisceration'].Acc.SATA = set_combine(sets.precast.WS['Evisceration'].Acc,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])	
	sets.precast.WS['Evisceration'].HNM.SATA = set_combine(sets.precast.WS['Evisceration'].HNM,sets.buff['Trick Attack'],sets.buff['Sneak Attack'])
	
	-- Ranged sets
	sets.precast.RA					 		 = {}

	sets.midcast.RA					 		 = {head="Enkidu's cap",neck="Peacock amulet",ear1="Merman's earring",ear2="Merman's earring",body="Dragon harness",hands="Enkidu's mittens",ring1="Rajas ring",ring2="Merman's ring",back="Mamool Ja mantle",waist="Buccaneer's belt",legs="Bravo's subligar",feet="Enkidu's leggings"}
	sets.midcast.RA.Acc				 		 = set_combine(sets.midcast.RA, {ring1="Merman's ring"})

end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Cyclone' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)

    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
	
end

function job_buff_change(buff, gain)

    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
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

function job_handle_equipping_gear(playerStatus, eventArgs)
    
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
	
end

function check_buff(buff_name, eventArgs)

    if state.Buff[buff_name] then
        equip(sets.buff[buff_name])
		if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
	
end