function get_sets()

    mote_include_version = 2
    include('Mote-Include.lua')

end

function job_setup()
	
	include('Kay-Include.lua')
	
	state.Buff['Copy Image (3)'] = buffactive['Copy Image (3)'] or false
    state.Buff['Copy Image (2)'] = buffactive['Copy Image (2)'] or false
    state.Buff['Copy Image (1)'] = buffactive['Copy Image'] or false
	
	JA_Types = S{'Flourish1','Flourish2','JobAbility'}
	
	initialize_job()
	
end

function user_setup()

    state.OffenseMode:options('Normal','HybridAcc','OffTank','Tank')
    state.WeaponskillMode:options('Normal', 'Power')
	state.PhysicalDefenseMode:options('Evasion','PDT')
	state.MagicalDefenseMode:options('MDT')

end

function init_gear_sets()

	-- misc
	sets.enmityUp                                = {neck="Ritter gorget",ear1="Hades earring +1",body="Avalon breastplate",hands="Etoile bangles",ring2="Corneus ring",back="Cerberus mantle",waist="Trance belt"}
	sets.enmityDown							     = {ammo="White tathlum",head="Zha'Go's barbut",ear1="Novia earring",body="Dancer's casaque",waist="Buccaneer's belt",legs="Raven hose"}
	
	-- precast ja
	sets.precast.Step                            = {ammo="Black tathlum"
						                           ,head="Enkidu's cap",neck="Ancient torque"  ,ear2="Pixie earring"
						                           ,body="Scorpion harness +1",hands="Dancer's bangles +1",ring1=gear.TRing2,ring2=gear.TRing1
						                           ,back="Etoile cape",waist="Lycopodium sash",legs="Oily trousers",feet="Etoile toeshoes"}
	    -- Waltz set (chr and vit)
    sets.precast.Waltz                           = {head="Etoile tiara"    ,neck="Flower necklace"
						                           ,body="Dancer's casaque"     
						                           ,back="Etoile cape"                            ,legs="Dancer's tights",feet="Volunteer's nails"}
	sets.precast.WaltzSelf                       = set_combine(sets.precast.Waltz,{ear2="Cassie earring",ring2="Corneus ring",waist="Warwolf belt"})
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz']          = {}
	                                             
    sets.precast.Samba                           = {head="Dancer's tiara"}
	                                             
    sets.precast.Jig                             = {legs="Etoile tights", feet="Dancer's toe shoes"}
	                                             
    sets.precast.JA['Violent Flourish']          = {head="Walahra turban",neck="Chivalrous chain"    ,ear1="Triumph earring"  ,ear2="Brutal earring"
	                                               ,body="Etoile casaque",hands="Dancer's bangles +1",ring1="Rajas ring"
												   ,back="Bushido cape"  ,waist="Warwolf belt"       ,legs="Enkidu's subligar",feet="Rutter sabatons"}
    sets.precast.JA['Desperate Flourish']        = set_combine(sets.precast.Step,{hands="Enkidu's mittens"})
	sets.precast.JA['Wild Flourish']             = set_combine(sets.precast.JA['Desperate Flourish'])
	
	-- precast magic
	sets.precast.FC                              = {ear1="Loquacious earring"}          
	-- midcast magic                                 
	sets.midcast.FastRecast                      = set_combine(sets.precast.FC,{head="Walahra turban",body="Rapparee harness",hands="Dusk gloves +1",waist="Velocious belt",legs="Etoile tights",feet="Dusk ledelsens +1"})
	                                             
	sets.midcast['Utsusemi: Ni']                 = set_combine(sets.midcast.FastRecast,{ear2="Magnetic earring",ring1="Defending ring",ring2="Antica ring",back="Boxer's mantle"})
	sets.midcast['Utsusemi: Ichi']               = set_combine(sets.midcast['Utusemi: Ni'],{head="Gnole crown",neck="Fortified chain",ear1="Novia earring",body="Scorpion harness +1",waist="Resolute belt",legs="Raven hose",feet="Dancer's toe shoes"})
	                                             
	-- idle                                          
	sets.idle                                    = {ammo="Bibiki seashell"
				                                   ,head="Gnole crown",neck="Chocobo whistle",ear1="Merman's earring",ear2="Merman's earring"
				                                   ,body="Avalon breastplate",hands="Garden bangles",ring1="Defending ring",ring2="Shadow ring"
				                                   ,back="Shadow mantle",waist="Lycopodium sash",legs="Darksteel subligar +1",feet="Merman's leggings"}
				                                 
	sets.idle.Town                               = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
	                                             
	-- defense                                   
	sets.defense.Evasion                         = {head="Gnole crown"        ,neck="Fortified chain",ear1="Novia earring"
						                           ,body="Scorpion harness +1",hands="Etoile bangles"
						                           ,back="Boxer's mantle"                            ,legs="Raven hose",feet="Dancer's toe shoes"}
	sets.defense.PDT                             = {ammo="Bibiki seashell"
												   ,head="Darksteel cap +1",neck="Wivre gorget +1"
	                                               ,body="Darksteel harness +1"                   ,ring1="Defending ring"      ,ring2="Jelly ring"
					                               ,back="Shadow mantle"                          ,legs="Darksteel subligar +1"}
	                                             
	sets.defense.MDT                             = {ammo="Bibiki seashell",ear1="Merman's earring",ear2="Merman's earring",body="Avalon breastpalte",ring1="Defending ring",ring2="Shadow ring",waist="Resolute belt",feet="Merman's leggings"}
	                                             
	-- engaged                                   
	sets.engaged                                 = {ammo="Black tathlum"
				                                   ,head="Walahra turban"    ,neck="Ancient torque",ear1="Suppanomimi"  ,ear2="Brutal earring"
				                                   ,body="Rapparee harness"  ,hands="Dusk gloves +1" ,ring1=gear.TRing2   ,ring2=gear.TRing1
				                                   ,back="Cerberus mantle +1",waist="Velocious belt" ,legs="Etoile tights",feet="Dusk ledelsens +1"}
	sets.engaged.HybridAcc                       = set_combine(sets.engaged,{back="Cuchulain's mantle",feet="Enkidu's leggings"})
	sets.engaged.OffTank                         = set_combine(sets.engaged.HybridAcc,{ring1="Defending ring",back="Boxer's mantle"})
	sets.engaged.Tank                            = set_combine(sets.engaged.OffTank,{body="Scorpion harness +1",back="Etoile cape"})
	                                               
	-- ws                                            
	sets.precast.WS                              = {ammo="Black tathlum"
					                               ,head="Maat's cap"        ,neck="Fotia gorget"        ,ear1="Triumph earring",ear2="Brutal earring"
					                               ,body="Etoile casaque"    ,hands="Dancer's bangles +1",ring1="Rajas ring"    ,ring2="Flame ring"
					                               ,back="Cerberus mantle +1",waist="Warwolf belt"       ,legs="Dusk trousers"  ,feet="Rutter sabatons"}
	sets.precast.WS.Power                        = set_combine(sets.precast.WS,{hands="Enkidu's mittens",ring2="Zilant ring"})
	                                             
	sets.precast.WS['Dancing Edge']              = set_combine(sets.precast.WS,{ear1="Pixie earring",ring2="Zilant ring",back="Etoile cape",feet="Enkidu's leggings"})
	sets.precast.WS['Dancing Edge'].Power        = set_combine(sets.precast.WS.Power,{head="Gnadbhod's helm",ring2="Flame ring"})
	                                             
	sets.precast.WS['Exenterator']               = set_combine(sets.precast.WS['Dancing Edge'],{})
	sets.precast.WS['Exenterator'].Power         = set_combine(sets.precast.WS['Dancing Edge'].Power,{})
	                                             
	sets.precast.WS['Evisceration']              = set_combine(sets.precast.WS,{ring2="Zilant ring"})
	sets.precast.WS['Evisceration'].Power        = set_combine(sets.precast.WS.Power,{ring2="Flame ring"})
	                                             
	sets.precast.WS['Pyrrhic Kleos']             = set_combine(sets.precast.WS,{head="Gnadbhod's helm",hands="Alkyoneus's bracelets"})
	sets.precast.WS['Pyrrhic Kleos'].Power       = set_combine(sets.precast.WS['Pyrrhic Kleos'],{})
	
end

function job_post_precast(spell,action,spellMap,eventArgs)
	
	if JA_Types:contains(spell.type) then
		if state.OffenseMode.value:contains('Tank') then
			equip(set_combine(sets.enmityUp,sets.precast.JA[spell.english]) or sets.enmityUp)
		else
			equip(set_combine(sets.enmityDown,sets.precast.JA[spell.english]) or sets.enmityDown)
		end
	end
	if spell.type == 'Waltz' and spell.target.type == 'SELF' then
		equip(sets.precast.WaltzSelf)
	end
	if (spell.type == 'WeaponSkill' or spell.name == 'Violent Flourish') and daytime then
		equip({ear1="Fenrir's earring"})
	end
	
end

function job_buff_change(name,gain)

	sleep_swap(name,gain)
	
	if name:contains('Copy Image') then
		state.Buff[name] = gain
		handle_equipping_gear(player.status)
	end

end

function customize_melee_set(meleeSet)

	if state.OffenseMode.value:contains('Tank') then
		if state.Buff['Copy Image (3)'] or state.Buff['Copy Image (2)'] or state.Buff['Copy Image'] then
			meleeSet = set_combine(sets.engaged.HybridAcc)
		end
	end
	
	return meleeSet
	
end