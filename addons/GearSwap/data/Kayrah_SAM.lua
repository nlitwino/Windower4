function get_sets()
	
	mote_include_version = 2
	include('Mote-Include.lua')
	
end

function job_setup()

	state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
							  buffactive['Aftermath: Lv.2'] or
							  buffactive['Aftermath: Lv.3'] or
							  false
	state.Buff['Seigan'] = buffactive['Seigan'] or false
	
	include('Kay-Include.lua')
	
	initialize_job()
	
	currentAM = 'GK'

end

function user_setup()

	state.OffenseMode:options('Normal','Acc','Tank')
	state.RangedMode:options('Normal','Acc')
	state.WeaponskillMode:options('Normal','Acc')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')

end

function init_gear_sets()

	-- misc.
	sets.enmity                               = {head="Aegishjalmr",neck="Ritter gorget",body="Avalon breastplate",hands="Saotome kote",ring2="Corneus ring",back="Cerberus mantle +1",waist="Trance belt",legs="Saotome haidate",feet="Myochin sune-ate"}
	
	-- precast ja
	sets.precast.JA                           = {}
	                                          
	sets.precast.JA['Meditate']               = {head="Myochin kabuto",hands="Saotome kote"}
	sets.precast.JA['Warding Circle']         = {head="Myochin kabuto"}
	                                          
	-- precast magic                          
	sets.precast.FC                           = {ear2="Loquacious earring"}
	                                          
	-- midcast magic                          
	sets.midcast.FastRecast                   = {head="Walahra turban",ear1="Wyvern earring",ear2="Loquacious earring",hands="Dusk gloves +1",waist="Velocious belt",legs="Byakko's haidate",feet="Dusk ledelsens +1"}
	                                          
	sets.midcast['Ninjutsu']                  = set_combine(sets.midcast.FastRecast,{ring2="Antica ring"})
	sets.midcast['Utsusemi: Ni']              = set_combine(sets.midcast['Ninjutsu'],{neck="Fortified chain",ear2="Magnetic earring",back="Shadow mantle"})
	sets.midcast['Utsusemi: Ichi']            = set_combine(sets.midcast['Utsusemi: Ni'],{waist="Resolute belt"})
	                                          
	-- idle                                   
	sets.idle                                 = {head="Arhat's jinpachi +1",neck="Chocobo whistle" ,ear1="Merman's earring"     ,ear2="Merman's earring"
												,body="Arhat's gi +1"      ,hands="Seiryu's kote"  ,ring1="Defending ring"      ,ring2="Shadow ring"
												,back="Shadow mantle"      ,waist="Lycopodium sash",legs="Darksteel subligar +1",feet="Myochin sune-ate"}
	sets.idle.Town                            = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
	                                          
	sets.resting                              = {}
	                                          
	-- defense                                
	sets.defense.PDT                          = {head="Arhat's jinpachi +1",body="Arhat's gi +1",ring1="Defending ring",ring2="Jelly ring",back="Shadow mantle",legs="Darksteel subligar +1"}
	sets.defense.MDT                          = {ear1="Merman's earring",ear2="Merman's earring",body="Avalon breastplate",ring1="Defending ring",ring2="Shadow ring"}
	
	-- default engaged / 450 delay GKT (hagun/soboro) 
	------------------ WHITE TATHLUM ------------------
	sets.engaged                              = {head="Walahra turban"    ,neck="Chivalrous chain",ear1="Bushinomimi"     ,ear2="Brutal earring"
												,body="Hachiman domaru +1",hands="Dusk gloves +1" ,ring1="Rajas ring"     ,ring2=gear.TRing1
												,back="Cerberus mantle +1",waist="Velocious belt" ,legs="Byakko's haidate",feet="Dusk ledelsens +1"}
	------------------ NEED ROSE FOR ACC SETUP ------------------
	sets.engaged.Acc                          = set_combine(sets.engaged,{body="Hachiryu haramaki",hands="Hachiryu kote",back="Cuchulain's mantle"})
	sets.engaged.Tank                         = set_combine(sets.engaged,{head="Arhat's jinpachi +1",body="Arhat's gi +1",neck="Fortified chain",ring1="Defending ring",ring2="Corneus ring"})
	
	------------------ BLACK TATH ------------------
	sets.engaged.DRG                          = set_combine(sets.engaged,{ear1="Wyvern earring",body="Hachiryu haramaki",hands="Hachiman kote +1"})
	sets.engaged.Acc.DRG                      = set_combine(sets.engaged.Acc,{ear1="Wyvern earring"})
	sets.engaged.Tank.DRG                     = set_combine(sets.engaged.Tank,{ear1="Wyvern earring"})
	
	-- amano engaged / 437 delay GKT
	sets.engaged.Amano                        = {}
	sets.engaged.Acc.Amano                    = {}
	sets.engaged.Tank.Amano                   = {}
	                                          
	sets.engaged.Amano.DRG                    = {}
	sets.engaged.Acc.Amano.DRG                = {}
	sets.engaged.Tank.Amano.DRG               = {}
	                                          
	sets.engaged.Amano.AM                     = {}
	sets.engaged.Acc.Amano.AM                 = {}
	sets.engaged.Tank.Amano.AM                = {}
	                                          
	sets.engaged.Amano.DRG.AM                 = {}
	sets.engaged.Acc.Amano.DRG.AM             = {}
	sets.engaged.Tank.Amano.DRG.AM            = {}
	
	-- nanatsu engaged /  420 delay GKT
	---------------- ROSE STRAP / WHITE TATH ---------------
	sets.engaged.Nanatsu                      = set_combine(sets.engaged,{hands="Hachiman kote +1"})
	sets.engaged.Acc.Nanatsu                  = set_combine(sets.engaged.Nanatsu,{back="Cuchulain's mantle"})
	sets.engaged.Tank.Nanatsu                 = set_combine(sets.engaged.Tank,{head="Arhat's jinpachi +1",body="Arhat's gi +1",neck="Fortified chain",ring1="Defending ring",ring2="Corneus ring"})
	
	sets.engaged.Nanatsu.DRG                  = set_combine(sets.engaged.Nanatsu,{ear1="Wyvern earring"})
	sets.engaged.Acc.Nanatsu.DRG              = set_combine(sets.engaged.Acc.Nanatsu,{ear1="Wyvern earring"})
	sets.engaged.Tank.Nanatsu.DRG             = set_combine(sets.engaged.Tank.Nanatsu,{ear1="Wyvern earring"})
	
	-- ranged / yoichi
	sets.precast.RA                           = {head="Zha'Go's barbut" ,neck="Peacock amulet"   ,ear1="Drone earring" ,ear2="Drone earring"
												,body="Kyudogi +1"      ,hands="Seiryu's kote"   ,ring1="Cerberus ring",ring2="Merman's ring"
												,back="Amemet mantle +1",waist="Buccaneer's belt",legs="Dusk trousers" ,feet="Hachiryu sune-ate"}
	                                          
	sets.midcast.RA                           = set_combine(sets.precast.RA,{})
	sets.midcast.RA.Acc                       = set_combine(sets.midcast.RA.Acc,{ring1="Merman's ring"})
	
	-- GK ws (184tp)
	sets.precast.WS                           = {head="Gnadbhod's helm"   ,neck="Fotia gorget"          ,ear1="Bushinomimi"     ,ear2="Brutal earring"
												,body="Byrnie +1"         ,hands="Alkyoneus's bracelets",ring1="Rajas ring"     ,ring2="Flame ring"
												,back="Cerberus mantle +1",waist="Warwolf belt"         ,legs="Hachiryu haidate",feet="Hachiman sune-ate"}
	sets.precast.WS.Acc                       = set_combine(sets.precast.WS,{body="Hachiman domaru +1"})
	
	-- sets.precast.WS['Tachi: Yukikaze']        = {}
	-- sets.precast.WS['Tachi: Yukikaze'].Acc    = {}
	
	-- sets.precast.WS['Tachi: Gekko']           = {}
	-- sets.precast.WS['Tachi: Gekko'].Acc       = {}
	                                          
	-- sets.precast.WS['Tachi: Kasha']           = {}
	-- sets.precast.WS['Tachi: Kasha'].Acc       = {}
	                                          
	-- sets.precast.WS['Tachi: Shoha']           = {}
	-- sets.precast.WS['Tachi: Shoha'].Acc       = {}
	                                          
	-- sets.precast.WS['Tachi: Kaiten']          = {}
	-- sets.precast.WS['Tachi: Kaiten'].Acc      = {}
	
	-- Bow ws
	sets.precast.WS['Sidewinder'] 	          = {head="Maat's cap"      ,neck="Fotia gorget"     ,ear1="Drone earring"   ,ear2="Drone earring"
												,body="Kirin's osode"   ,hands="Seiryu's kote"   ,ring1="Rajas ring"     ,ring2="Blobnag ring"
												,back="Amemet mantle +1",waist="Buccaneer's belt",legs="Hachiryu haidate",feet="Hachiryu sune-ate"}
	sets.precast.WS['Sidewinder'].Acc         = set_combine(sets.precast.WS['Sidewinder'],{legs="Oily trousers"})
	
	sets.precast.WS['Jishnu\'s Radiance'] 	  = set_combine(sets.precast.WS['Sidewinder'],{})
	sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS['Sidewinder'].Acc,{})
	
	sets.precast.WS['Namas Arrow'] 		      = set_combine(sets.precast.WS['Sidewinder'],{})
	sets.precast.WS['Namas Arrow'].Acc        = set_combine(sets.precast.WS['Sidewinder'],{})
	
end

function job_post_precast(spell,action,spellMap,eventArgs)
	if spell.name == 'Namas Arrow' then
		currentAM = 'Bow'
	elseif spell.name == 'Tachi: Kaiten' then
		currentAM = 'GK'
	end
	if spell.name:startswith('Tachi') and state.CombatWeapon.value == 'Nanatsu' then
		equip({hands="Hachiman kote +1"})
	end
	if spell.type == 'JobAbility' and state.OffenseMode.value == 'Tank' then
		equip(set_combine(sets.enmity,sets.precast.JA[spell.name]))
	end
	add_to_chat(spell.type)
end

function job_buff_change(name,gain)

	sleep_swap(name,gain)
	if name:startswith('Aftermath') and currentAM == 'GK' then
		state.Buff['Aftermath'] = gain
		adjust_melee_groups()
		handle_equipping_gear(player.status)
	elseif name == 'Seigan' then
		state.Buff[name] = gain
		handle_equipping_gear(player.status)
	end

end

function adjust_melee_groups()

	if player.sub_job == 'DRG' then
		classes.CustomMeleeGroups:append('DRG')
	end
	if state.Buff['Aftermath'] then
		classes.CustomMeleeGroups:append('AM')
	end

end

function customize_melee_set(meleeSet)

	if state.Buff['Seigan'] then
        meleeSet = set_combine(meleeSet,{legs="Saotome haidate"})
    end
    return meleeSet

end

function job_status_change(new,old)

	if new == "Engaged" then
	
		if player.equipment.main == 'Nanatsusaya' then
            state.CombatWeapon:set('Nanatsu')
        elseif player.equipment.main == 'Amanomurakumo' then
            state.CombatWeapon:set('Amano')
		else
            state.CombatWeapon:reset()
        end
		adjust_melee_groups()
	end
	
end