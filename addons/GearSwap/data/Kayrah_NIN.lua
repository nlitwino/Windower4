function get_sets()

	mote_include_version = 2
	include('Mote-Include.lua')

	
end

function job_setup()

	state.Buff['Yonin'] = buffactive['Yonin'] or false
	state.Buff['Innin'] = buffactive['Innin'] or false
	state.Buff['Sange'] = buffactive['Sange'] or false
	
	include('Kay-Include.lua')
	
	initialize_job()
	
	send_command('bind !x gs c trade_earring1')
	send_command('bind !c gs c trade_earring2')
	send_command('bind !v gs c trade_ring')
	send_command('bind ^g gs c regear')
	
end

function user_setup()

	state.OffenseMode:options('Normal','HybridAcc','Acc')
	state.WeaponskillMode:options('Normal','HNM')
	state.CastingMode:options('Normal','Enmity')
	state.RangedMode:options('Normal','HNM')
	state.PhysicalDefenseMode:options('Evasion', 'PDT')
	state.MagicalDefenseMode:options('MDT')

end

function init_gear_sets()

	-- misc.
	sets.INT                                   = {head="Maat's cap"   ,neck="Lemegeton medallion +1",ear1="Morion earring +1"
											     ,body="Kirin's osode"                              ,ring1="Flame ring",ring2="Snow ring"
											                          ,waist="Ocean stone"}
	                                           
	sets.obi                                   = {Fire      = {waist="Karin Obi"}
									             ,Earth     = {waist="Dorin Obi"}
									             ,Water     = {waist="Suirin Obi"}
									             ,Wind 	    = {waist="Furin Obi"}
									             ,Ice 	    = {waist="Hyorin Obi"}
									             ,Lightning = {waist="Rairin Obi"}
									             ,Light     = {waist="Korin Obi"}
									             ,Dark 	    = {waist="Anrin Obi"}}
	
	sets.enmityDown                            = {head="Zha'Go's barbut",waist="Buccaneer's belt"}
	sets.enmityUp                              = {neck="Ritter gorget",back="Cerberus mantle",waist="Trance belt"}
	                                           
	-- precast ja                              
	sets.precast.JA                            = {}
	                                           
	sets.precast.JA['Mijin Gakure']            = set_combine(sets.precast.JA, {ammo="Reacton arm"})
	                                           
	-- precast magic                           
	sets.precast.FC                            = {ear2="Loquacious earring"}
	                                           
	-- midcast magic                           
	sets.midcast.FastRecast                    = {head="Walahra turban",neck="Fortified chain",ear1="Drone earring"   ,ear2="Magnetic earring"
												 ,body="Yasha samue"   ,hands="Dusk gloves +1",ring1="Defending ring" ,ring2="Antica ring"
												 ,back="Prism cape"    ,waist="Resolute belt" ,legs="Byakko's haidate",feet="Dusk ledelsens +1"}
	                                           
	sets.midcast['Utsusemi: Ni']               = set_combine(sets.midcast.FastRecast,{})
	sets.midcast['Utsusemi: Ichi']             = set_combine(sets.midcast['Utsusemi: Ni'],{head="Ninja hatsuburi +1",hands="Yasha tekko",legs="Yasha hakama",feet="Koga kyahan +1"})
	sets.midcast.NinjutsuDebuff                = set_combine(sets.midcast.FastRecast,{head="Ninja hatsuburi +1",feet="Koga kyahan +1",back="Astute cape"})
	sets.midcast.ElementalNinjutsu             = set_combine(sets.midcast.FastRecast,sets.INT,{back="Astute cape"})
	                                           
	sets.midcast.NinjutsuDebuff.Enmity         = set_combine(sets.midcast.NinjutsuDebuff,sets.enmityUp,{})
	sets.midcast.ElementalNinjutsu.Enmity      = set_combine(sets.midcast.ElementalNinjutsu,sets.enmityUp,{})
	                                           
	-- idle                                    
	sets.idle                                  = {ammo="Bibiki seashell"
												 ,head="Gnole crown",neck="Chocobo whistle",ear1="Merman's earring",ear2="Merman's earring"
	                                             ,body="Ninja chainmail +1",hands="Seiryu's kote",ring1="Defending ring",ring2="Shadow ring"
												 ,back="Shadow mantle",waist="Lycopodium sash",legs="Koga hakama",feet="Ninja kyahan +1"}
	                                           
	sets.idle.Town                             = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
	                                           
	-- defense                                 
	sets.defense.Evasion                       = {head="Gnole crown"        ,neck="Fortified chain",ear1="Suppanomimi",ear2="Drone earring"
												 ,body="Scorpion harness +1",hands="Seiryu's kote"
												                            ,waist="Koga sarashi"  ,legs="Koga hakama",feet="Hachiryu sune-ate"}
	sets.defense.PDT                           = {ammo="Bibiki seashell"
	                                             ,head="Arhat's jinpachi +1"
												 ,body="Arhat's gi +1"      ,ring1="Defending ring"      ,ring2="Jelly ring"
												 ,back="Shadow mantle"      ,legs="Darksteel subligar +1"}
	sets.defense.MDT                           = {ear1="Merman's earring",ear2="Merman's earring",ring1="Defending ring",ring2="Shadow ring",waist="Resolute belt",feet="Suzaku's sune-ate"}
	                                           
	-- engaged                                 
	sets.engaged                               = {ammo="Bomb core"
												 ,head="Walahra turban"    ,neck="Hope torque"    ,ear1="Suppanomimi"     ,ear2="Brutal earring"
												 ,body="Ninja chainmail +1",hands="Dusk gloves +1",ring1=gear.TRing2      ,ring2=gear.TRing1
												 ,back="Cerberus mantle +1",waist="Velocious belt",legs="Byakko's haidate",feet="Dusk ledelsens +1"}
	sets.engaged.HybridAcc                     = set_combine(sets.engaged,{neck="Ancient torque",back="Cuchulain's mantle"})											
	sets.engaged.Acc                           = set_combine(sets.engaged,{ammo="Fire bomblet",body="Hachiryu haramaki",back="Cuchulain's mantle"})
	sets.engaged.Tank                          = set_combine(sets.engaged.Acc,{back="Boxer's mantle",})
	                                           
	sets.engaged.Night                         = set_combine(sets.engaged,{hands="Koga tekko"})
	sets.engaged.HybridAcc.Night               = set_combine(sets.engaged.HybridAcc,{hands="Koga tekko"})
	sets.engaged.Acc.Night                     = set_combine(sets.engaged.Acc,{hands="Koga tekko"})
	sets.engaged.Tank.Night                    = set_combine(sets.engaged.Tank,{hands="Koga tekko",legs="Koga hakama"})
	                                           
	-- yonin engaged                           
	sets.engaged.Yonin                         = set_combine(sets.engaged,{ammo="Fire bomblet",neck="Peacock amulet",back="Cuchulain's mantle"})
	sets.engaged.HybridAcc.Yonin               = set_combine(sets.engaged.HybridAcc,{})
	sets.engaged.Acc.Yonin                     = set_combine(sets.engaged.Acc,{})
	sets.engaged.Tank.Yonin                    = set_combine(sets.engaged.Tank,{})
	                                           
	sets.engaged.Yonin.Night                   = set_combine(sets.engaged.Night,{ammo="Fire bomblet",neck="Peacock amulet",back="Cuchulain's mantle"})
	sets.engaged.HybridAcc.Yonin.Night         = set_combine(sets.engaged.HybridAcc.Night,{})
	sets.engaged.Acc.Yonin.Night               = set_combine(sets.engaged.Acc.Night,{})
	sets.engaged.Tank.Yonin.Night              = set_combine(sets.engaged.Tank.Night,{})
	                                           
	-- innin engaged                           
	sets.engaged.Innin                         = set_combine(sets.engaged,{})
	sets.engaged.HybridAcc.Innin               = set_combine(sets.engaged.HybridAcc,{})
	sets.engaged.Acc.Innin                     = set_combine(sets.engaged.Acc,{})
	sets.engaged.Tank.Innin                    = set_combine(sets.engaged.Tank,{})
	                                           
	sets.engaged.Innin.Night                   = set_combine(sets.engaged.Night,{})
	sets.engaged.HybridAcc.Innin.Night		   = set_combine(sets.engaged.HybridAcc.Night,{})
	sets.engaged.Acc.Innin.Night               = set_combine(sets.engaged.Acc.Night,{})
	sets.engaged.Tank.Innin.Night              = set_combine(sets.engaged.Tank.Night,{})
	                                           
	-- ranged                                  
	sets.precast.RA                            = {head="Zha'Go's barbut",neck="Peacock amulet",ear1="Drone earring",ear2="Drone earring"
	                                             ,body="Koga chainmail",hands="Ninja tekko +1",ring1="Merman's ring",ring2="Merman's ring"
												 ,back="Amemet mantle +1",waist="Buccaneer's belt",legs="Ninja hakama +1",feet="Enkidu's leggings"}
	                                           
	sets.midcast.RA                            = set_combine(sets.precast.RA,{})
	sets.midcast.RA.HNM                        = set_combine(sets.midcast.HNM,{back="Mamool Ja mantle",hands="Seiryu's kote",feet="Hachiryu sune-ate"})
	                                           
	--ws                                       
	sets.precast.WS                            = {head="Maat's cap"        ,neck="Fotia gorget"   ,ear1="Fenrir's earring",ear2="Brutal earring"
	                                             ,body="Kirin's osode"     ,hands="Ninja tekko +1",ring1="Rajas ring"     ,ring2="Flame ring"
												 ,back="Cerberus mantle +1",waist="Warwolf belt"  ,legs="Byakko's haidate",feet="Enkidu's leggings"}
	sets.precast.WS.HNM                        = set_combine(sets.precast.WS,{})
	                                           
	sets.precast.WS['Blade: Jin']              = set_combine(sets.precast.WS,{legs="Byakko's haidate"})
	sets.precast.WS['Blade: Jin'].HNM          = set_combine(sets.precast.WS['Blade: Jin'],{back="Cuchulain's mantle"})
	                                           
	sets.precast.WS['Blade: Shun']             = set_combine(sets.precast.WS['Blade: Jin'],{})
	sets.precast.WS['Blade: Shun'].HNM         = set_combine(sets.precast.WS['Blade: Jin'].HNM,{})
	                                           
	sets.precast.WS['Blade: Ku']               = set_combine(sets.precast.WS,{head="Gnadbhod's helm",body="Hachiryu haramaki",hands="Bandomusha kote"})
	sets.precast.WS['Blade: Ku'].HNM           = set_combine(sets.precast.WS['Blade: Ku'],{})
	                                           
	sets.precast.WS['Blade: Metsu']            = set_combine(sets.precast.WS,{body="Haubergeon +1"})
	sets.precast.WS['Blade: Metsu'].HNM        = set_combine(sets.precast.WS['Blade: Metsu'],{})
	
	-- night ws                                
	sets.precast.WS.Night                      = set_combine(sets.precast.WS,{hands="Koga tekko",feet="Koga kyahan +1"})
	sets.precast.WS.HNM.Night                  = set_combine(sets.precast.WS.HNM,{hands="Koga tekko",feet="Koga kyahan +1"})
	                                           
	sets.precast.WS['Blade: Jin'].Night        = set_combine(sets.precast.WS,{hands="Koga tekko",feet="Koga kyahan +1"})
	sets.precast.WS['Blade: Jin'].HNM.Night    = set_combine(sets.precast.WS.HNM,{ear1="Pixie earring",hands="Koga tekko",feet="Koga kyahan +1"})
	                                           
	sets.precast.WS['Blade: Shun'].Night       = set_combine(sets.precast.WS,{hands="Koga tekko",feet="Koga kyahan +1"})
	sets.precast.WS['Blade: Shun'].HNM.Night   = set_combine(sets.precast.WS.HNM,{hands="Koga tekko",feet="Koga kyahan +1"})
	                                           
	sets.precast.WS['Blade: Ku'].Night         = set_combine(sets.precast.WS['Blade: Ku'],{})
	sets.precast.WS['Blade: Ku'].HNM.Night     = set_combine(sets.precast.WS['Blade: Ku'].HNM,{})
	                                           
	sets.precast.WS['Blade: Metsu'].Night      = set_combine(sets.precast.WS['Blade: Metsu'],{ear1="Pixie earring",feet="Koga kyahan +1"})
	sets.precast.WS['Blade: Metsu'].HNM.Night  = set_combine(sets.precast.WS['Blade: Metsu'].HNM,{ear1="Pixie earring",feet="Koga kyahan +1"})
	
end

function job_buff_change(name,gain)
	
	sleep_swap(name,gain)
	
	if name == 'Yonin' or name == 'Innin'then
		adjust_melee_groups()
		handle_equipping_gear(player.status)
	end

end

function job_post_precast(spell)
	
	if spell.type == 'JobAbility' then
		if state.OffenseMode.value == 'Tank' then
			equip(set_combine(sets.precast.JA,sets.enmityUp))
		else
			equip(set_combine(sets.precast.JA,sets.enmityDown))
		end
	end

end

function job_post_midcast(spell,default_spell_map)

    if spell.skill == 'Ninjutsu' then 
		if spell.element == world.weather_element or spell.element == world.day_element then
			equip({waist="Hachirin-no-obi"})
		end
	end
	
end

function job_get_spell_map(spell,default_spell_map)

    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
	
end

function adjust_melee_groups()

	classes.CustomMeleeGroups:clear()
	
	if state.Buff['Yonin'] then
		classes.CustomMeleeGroups:append('Yonin')
	elseif state.Buff['Innin'] then
		classes.CustomMeleeGroups:append('Innin')
	end
	
	if not daytime then
		classes.CustomMeleeGroups:append('Night')
	end

end

function customize_melee_set(meleeSet)

	if player.hpp < 75 then
        meleeSet = set_combine(meleeSet,{ring1="Shinobi ring",legs="Koga hakama"})
    end

    return meleeSet
	
end

function get_custom_wsmode(spell,spellMap,default_wsmode)

	local wsmode = ''
	if not daytime then
		wsmode = wsmode .. 'Night'
	end
	if wsmode ~= '' then
		return wsmode
	end
	
end