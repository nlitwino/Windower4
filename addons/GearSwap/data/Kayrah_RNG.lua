function get_sets()
	
	-- Import Mote-Include
	mote_include_version = 2
	include('Mote-Include.lua')
	
end

function job_setup()
	
	include('Kay-Include.lua')
	
	-- Establish flags for buffs
	state.Buff['Camouflage'] = buffactive['Camouflage'] or false
	state.Buff['Barrage'] = buffactive['Barrage'] or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
	
	initialize_job()
	
	--get main and sub weapons for regear function
	gear.ammo = player.equipment.ammo
	
end

function user_setup()
	
	-- Setup appropriate modes
	state.OffenseMode:options('Normal','DW','HNM')
	state.RangedMode:options('Normal','HybridAcc','Acc','Trash')
	state.WeaponskillMode:options('Normal','Power','Acc','Test')

end

function init_gear_sets()

	-- misc.
	
	-- buff
	sets.buff['Camouflage']                   = {body="Hunter's jerkin"}
	sets.buff['Barrage']					  = {hands="Hunter's bracers +1"}
	
	-- precast ja
	sets.precast.JA['Camoflage']              = {body="Hunter's jerkin"}
	sets.precast.JA['Scavenge']               = {feet="Hunter's socks +1"}
	sets.precast.JA['Shadowbind']             = {hands="Hunter's bracers +1"}
	sets.precast.JA['Eagle Eye Shot']		  = {head="Zha'Go's barbut" ,neck="Ranger's necklace"      ,ear1="Drone earring"   ,ear2="Bushinomimi"
												,body="Kyudogi +1"      ,hands="Blood finger gauntlets",ring1="Rajas ring"     ,ring2="Cerberus ring +1"
												,back="Amemet mantle +1",waist="Scout's belt"          ,legs="Hachiryu haidate",feet="Scout's socks +1"}
	
	-- precast magic
	sets.precast.FC                           = {ear2="Loquacious earring"}
	
	-- midcast magic
	sets.midcast.FastRecast                   = {head="Walahra turban",hands="Dusk gloves +1",waist="Velocious belt",legs="Byakko's haidate",feet="Dusk ledelsens +1"}
	sets.midcast['Ninjutsu']                  = set_combine(sets.midcast.FastRecast,{ring1="Antica ring",back="Prism cape"})
	
	-- idle
	sets.idle                                 = {head="Crimson mask" ,neck="Chocobo whistle" ,ear1="Merman's earring",ear2="Merman's earring"
												,body="Kyudogi +1"   ,hands="Seiryu's kote"  ,ring1="Defending ring" ,ring2="Shadow ring"
												,back="Shadow mantle",waist="Lycopodium sash",legs="Blood cuisses" ,feet="Trotter boots"}
	sets.idle.Town                            = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
	
	sets.resting                              = set_combine(sets.idle,{neck="Orochi nodowa",feet="Suzaku's sune-ate"})
	
	-- engaged
	sets.engaged                              = {head="Walahra turban"    ,neck="Peacock amulet" ,ear1="Hollow earring"  ,ear2="Brutal earring"
												,body="Hachiryu haramaki" ,hands="Dusk gloves +1",ring1="Rajas ring"     ,ring2=gear.TRing1
												,back="Cuchulain's mantle",waist="Velocious belt",legs="Byakko's haidate",feet="Dusk ledelsens +1"}
	sets.engaged.DW                           = set_combine(sets.engaged,{ear1="Suppanomimi"})
	sets.engaged.HNM                          = set_combine(sets.engaged,{head="Genbu's help"      ,neck="Orochi nodowa" ,ear1="Merman's earring",ear2="Merman's earring"
																		 ,body="Avalon breastplate",hands="Seiryu's kote",ring1="Defending ring" ,ring2="Shadow ring"
																		 ,back="Shadow mantle"     ,waist="Resolute belt",legs="Blood cuisses"   ,feet="Suzaku's sune-ate"})
	
	-- precast ranged
	sets.precast.RA                           = {head="Hunter's beret +1",neck="Peacock amulet",ear1="Drone earring",ear2="Hollow earring"
												,body="Scout's jerkin",hands="Seiryu's kote",ring1="Rajas ring",ring2="Behemoth ring +1"
												,back="Mamool Ja mantle",waist="Scout's belt",legs="Dusk trousers +1",feet="Hachiryu sune-ate"}
	sets.precast.RA.Anni 					  = set_combine(sets.precast.RA,{})
	sets.precast.RA.Yoichi					  = set_combine(sets.precast.RA,{legs="Hachiryu haidate"})
	
	-- midcast ranged
	-- Vulcan
	sets.midcast.RA                           = {head="Zha'Go's barbut" ,neck="Faith torque"           ,ear1="Drone earring"   ,ear2="Bushinomimi"
												,body="Kyudogi +1"      ,hands="Blood finger gauntlets",ring1="Rajas ring"     ,ring2="Cerberus ring +1"
												,back="Amemet mantle +1",waist="Scout's belt"          ,legs="Hachiryu haidate",feet="Scout's socks +1"}
	sets.midcast.RA.Trash                     = set_combine(sets.midcast.RA,{head="Scout's beret"})
	
	-- Mekki Shakki
	sets.midcast.RA.HybridAcc                 = set_combine(sets.midcast.RA,{ear2="Hollow earring",ring2="Behemoth ring +1",feet="Hachiryu sune-ate"})
	sets.midcast.RA.Acc                       = set_combine(sets.midcast.RA.HybridAcc,{hands="Seiryu's kote",back="Mamool Ja mantle",legs="Dusk trousers +1"})
	
	-- midcast anni
	sets.midcast.RA.Anni                      = set_combine(sets.midcast.RA,{})
	sets.midcast.RA.Anni.HybridAcc            = set_combine(sets.midcast.RA.HybridAcc,{})
	sets.midcast.RA.Anni.Acc                  = set_combine(sets.midcast.RA.Acc,{})
	sets.midcast.RA.Anni.Trash                = set_combine(sets.midcast.RA.Trash,{})
	
	-- midcast yoichi                         
	sets.midcast.RA.Yoichi                    = set_combine(sets.midcast.RA,{neck="Hope torque",feet="Hachiryu sune-ate"})
	sets.midcast.RA.Yoichi.HybridAcc          = set_combine(sets.midcast.RA.HybridAcc,{})
	sets.midcast.RA.Yoichi.Acc                = set_combine(sets.midcast.RA.Acc,{})
	sets.midcast.RA.Yoichi.Trash              = set_combine(sets.midcast.RA.Trash,{feet="Hachiryu sune-ate"})
	
	-- weaponskill
	sets.precast.WS                           = {head="Maat's cap"      ,neck="Fotia gorget"   ,ear1="Drone earring"   ,ear2="Drone earring"
												,body="Kirin's osode"   ,hands="Seiryu's kote" ,ring1="Rajas ring"     ,ring2="Blobnag ring"
												,back="Amemet mantle +1",waist="Scout's belt",legs="Hachiryu haidate",feet="Hachiryu sune-ate"}
	sets.precast.WS.HNM                       = set_combine(sets.precast.WS,{})
	
	-- bow specific ws
	sets.precast.WS['Sidewinder']             = set_combine(sets.precast.WS,{})
	sets.precast.WS['Sidewinder'].HNM         = set_combine(sets.precast.WS['Sidewinder'],{ear2="Hollow earring"})
	
	sets.precast.WS['Jishnu\'s Radiance']     = set_combine(sets.precast.WS['Sidewinder'],{})
	sets.precast.WS['Jishnu\'s Radiance'].HNM = set_combine(sets.precast.WS['Sidewinder'],{})
	
	sets.precast.WS['Namas Arrow']            = set_combine(sets.precast.WS,{ear1="Bushinomimi",ear2="Triumph earring"})
	sets.precast.WS['Namas Arrow'].Power      = set_combine(sets.precast.WS['Namas Arrow'],{hands="Blood finger gauntlets",ring2="Cerberus ring +1"})
	sets.precast.WS['Namas Arrow'].Acc        = set_combine(sets.precast.WS['Namas Arrow'],{ear1="Drone earring",ear2="Drone earring",waist="Blobnag ring"})
	
	-- gun specific ws
	sets.precast.WS['Slug Shot']              = set_combine(sets.precast.WS,{ear2="Triumph earring"})
	sets.precast.WS['Slug Shot'].Power        = set_combine(sets.precast.WS['Slug Shot'],{hands="Blood finger gauntlets",ring2="Cerberus ring +1",feet="Scout's socks +1"})
	sets.precast.WS['Slug Shot'].Acc          = set_combine(sets.precast.WS['Slug Shot'],{ear2="Drone earring",legs="Oily trousers"})
	
	sets.precast.WS['Last Stand']             = set_combine(sets.precast.WS['Slug Shot'],{})
	sets.precast.WS['Last Stand'].Power       = set_combine(sets.precast.WS['Slug Shot'].Power,{})
	sets.precast.WS['Last Stand'].Acc         = set_combine(sets.precast.WS['Slug Shot'].Acc,{})
												
	sets.precast.WS['Coronach']               = set_combine(sets.precast.WS,{ear2="Hollow earring",ring2="Cerberus ring +1",feet="Hunter's socks +1"})
	sets.precast.WS['Coronach'].Power         = set_combine(sets.precast.WS['Coronach'],{hands="Blood finger gauntlets",ring2="Cerberus ring +1",feet="Scout's socks +1"})
	sets.precast.WS['Coronach'].Acc           = set_combine(sets.precast.WS['Coronach'],{ear2="Hollow earring",feet="Hachiryu sune-ate"})
	sets.precast.WS['Coronach'].Test		  = set_combine(sets.precast.WS['Coronach'].Power,{ring2="Strigoi ring"})
	
end

function job_precast(spell,action,spellMap,eventArgs)
	
	if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
		ammo_recharge()
	end
end

function job_post_precast(spell,action,spellMap,eventsArgs) 

	if player.equipment.range == 'Annihilator' then
		state.CombatWeapon:set('Anni')
	elseif player.equipment.range == 'Yoichinoyumi' then
		state.CombatWeapon:set('Yoichi')
	end
	
	if spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
		if state.WeaponskillMode.value == 'HNM' then
			if not daytime then
				equip({ear1="Fenrir's earring"})
			end
		end
	end
	if spell.name == 'Eagle Eye Shot' then
		if daytime then
			equip({ear1="Ladybug earring +1",ear2="Ladybug earring +1"})
		else
			equip({ear1="Fenrir's earring"})
		end
	end
	
	if state.Buff['Unlimited Shot'] and spell.type == 'WeaponSkill' and spell.skill == 'Archery' then
		equip({ammo="Combat Caster's arrow"})
	end
	
end

function job_post_aftercast(spell,action,spellMap,eventArgs)
	
	if player.equipment.ammo == 'Cmb.Cst. Arrow' then
		add_to_chat("Re-equipping "..gear.ammo.."s.")
		equip({ammo=gear.ammo})
	end
	
end

function job_post_midcast(spell,action,spellMap,eventsArgs)

	if spell.action_type == 'Ranged Attack' then
		if state.Buff['Barrage'] then
			equip(sets.buff['Barrage'])
		end
		if daytime then
			equip({ear1="Ladybug earring +1"})
			if state.RangedMode.value == 'Normal' or state.RangedMode.value == 'Trash' then
				equip({ear2="Ladybug earring +1"})
			end
		else
			equip({ear1="Fenrir's earring"})
		end
	end

end

function job_buff_change(buff,gain)
	
	sleep_swap(name,gain)
	
	if buff == "Camouflage" then
		if gain then
			equip(sets.buff['Camouflage'])
			disable('body')
		else
			enable('body')
		end
	end
	
end