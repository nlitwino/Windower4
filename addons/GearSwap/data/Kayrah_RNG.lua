function get_sets()
	
	-- Import Mote-Include
	mote_include_version = 2
	include('Mote-Include.lua')
	
end

function job_setup()
	
	include('Kay-Include.lua')
	
	-- Establish flags for buffs
	state.Buff['Camouflage'] = buffactive['Camouflage'] or false
	state.Buff['Sharpshot'] = buffactive['Sharpshot'] or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
	
	initialize_job()
	
	--get main and sub weapons for regear function
	gear.ammo = player.equipment.ammo
	
end

function user_setup()
	
	-- Setup appropriate modes
	state.OffenseMode:options('Normal','DW')
	state.RangedMode:options('Normal','HNM','PureAcc')
	state.WeaponskillMode:options('Normal','HNM')

end

function init_gear_sets()

	-- misc.
	
	-- buff
	sets.buff['Camouflage']                   = {body="Hunter's jerkin"}
	sets.buff['Sharpshot']                    = {legs="Hunter's braccae"}
	
	-- precast ja
	sets.precast.JA['Camoflage']              = {body="Hunter's jerkin"}
	sets.precast.JA['Scavenge']               = {feet="Hunter's socks"}
	sets.precast.JA['Shadowbind']             = {hands="Hunter's bracers"}
	sets.precast.JA['Sharpshot']              = {legs="Hunter's braccae"}
	sets.precast.JA['Eagle Eye Shot']		  = {head="Zha'Go's barbut",neck="Ranger's necklace",ear1="Drone earring",ear2="Drone earring"
												,body="Kyudogi +1",hands="Blood finger gauntlets",ring1="Rajas ring",ring2="Flame ring"
												,back="Amemet mantle +1",waist="Scout's belt",legs="Hachiryu haidate",feet="Scout's socks"}
	
	-- precast magic
	sets.precast.FC                           = {ear2="Loquacious earring"}
	
	-- midcast magic
	sets.midcast.FastRecast                   = {head="Walahra turban",hands="Dusk gloves +1",waist="Velocious belt",legs="Byakko's haidate",feet="Dusk ledelsens +1"}
	sets.midcast['Ninjutsu']                  = set_combine(sets.midcast.FastRecast,{ring1="Antica ring"})
	
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
	
	-- precast ranged
	sets.precast.RA                           = {head="Zha'Go's barbut" ,neck="Peacock amulet"   ,ear1="Hollow earring",ear2="Drone earring"
												,body="Scout's jerkin"  ,hands="Seiryu's kote"   ,ring1="Rajas ring"   ,ring2="Merman's ring"
												,back="Amemet mantle +1",waist="Buccaneer's belt",legs="Oily trousers" ,feet="Hachiryu sune-ate"}
	sets.precast.RA.Anni 					  = set_combine(sets.precast.RA,{})
	sets.precast.RA.Yoichi					  = set_combine(sets.precast.RA,{legs="Hachiryu haidate"})
	
	-- midcast ranged
	sets.midcast.RA                           = set_combine(sets.precast.RA,{neck="Ranger's necklace",body="Kyudogi +1",hands="Blood finger gauntlets",waist="Scout's belt",feet="Scout's socks"})
	sets.midcast.RA.HNM                       = set_combine(sets.midcast.RA,{neck="Peacock amulet",ring2="Merman's ring",back="Mamool Ja mantle",waist="Buccaneer's belt",legs="Oily trousers",feet="Hachiryu sune-ate"})
	sets.midcast.RA.PureAcc                   = set_combine(sets.midcast.RA.HNM,{hands="Seiryu's kote",waist="Scout's belt"})
	
	-- midcast anni
	sets.midcast.RA.Anni                      = set_combine(sets.midcast.RA,{})
	sets.midcast.RA.Anni.HNM                  = set_combine(sets.midcast.RA.HNM,{})
	sets.midcast.RA.Anni.PureAcc              = set_combine(sets.midcast.RA.PureAcc,{})
	                                          
	-- midcast yoichi                         
	sets.midcast.RA.Yoichi                    = set_combine(sets.midcast.RA,{legs="Hachiryu haidate",feet="Hachiryu sune-ate"})
	sets.midcast.RA.Yoichi.HNM                = set_combine(sets.midcast.RA.HNM,{legs="Hachiryu haidate"})
	sets.midcast.RA.Yoichi.PureAcc            = set_combine(sets.midcast.RA.PureAcc,{legs="Hachiryu haidate"})
	
	-- weaponskill
	sets.precast.WS                           = {head="Maat's cap"      ,neck="Ranger's necklace",ear1="Drone earring",ear2="Drone earring"
												,body="Kirin's osode"   ,hands="Seiryu's kote"   ,ring1="Rajas ring"  ,ring2="Blobnag ring"
												,back="Amemet mantle +1",waist="Scout's belt"    ,legs="Oily trousers",feet="Hachiryu sune-ate"}
	sets.precast.WS.HNM                       = set_combine(sets.precast.WS,{ring1="Merman's ring",back="Mamool Ja mantle",waist="Buccaneer's belt",legs="Hachiryu haidate"})
	
	-- bow specific ws
	sets.precast.WS['Sidewinder']             = {head="Maat's cap"      ,neck="Breeze gorget" ,ear1="Drone earring",ear2="Drone earring"
												,body="Kirin's osode"   ,hands="Seiryu's kote",ring1="Rajas ring"  ,ring2="Blobnag ring"
												,back="Amemet mantle +1",waist="Scout's belt" ,legs="Oily trousers",feet="Hachiryu sune-ate"}
	sets.precast.WS['Sidewinder'].HNM         = set_combine(sets.precast.WS['Sidewinder'],{ring1="Merman's ring",back="Mamool Ja mantle",legs="Hachiryu haidate"})
	
	sets.precast.WS['Jishnu\'s Radiance']     = set_combine(sets.precast.WS['Sidewinder'],{neck="Flame gorget"})
	sets.precast.WS['Jishnu\'s Radiance'].HNM = set_combine(sets.precast.WS['Sidewinder'].HNM,{neck="Flame gorget"})
	
	sets.precast.WS['Namas Arrow']            = {head="Maat's cap"      ,neck="Light gorget"  ,ear1="Drone earring"    ,ear2="Drone earring"   
												,body="Kirin's osode"   ,hands="Seiryu's kote",ring1="Rajas ring"      ,ring2="Blobnag ring"
												,back="Amemet mantle +1",waist="Scout's belt" ,legs="Hachiryu haidate",feet="Hachiryu sune-ate"}
	sets.precast.WS['Namas Arrow'].HNM        = set_combine(sets.precast.WS['Namas Arrow'],{waist="Buccaneer's belt"})
	
	-- gun specific ws
	sets.precast.WS['Slug Shot']              = {head="Maat's cap"      ,neck="Aqua gorget"   ,ear1="Drone earring"
												,body="Kirin's osode"   ,hands="Seiryu's kote",ring1="Rajas ring"  ,ring2="Blobnag ring"
												,back="Amemet mantle +1",waist="Scout's belt" ,legs="Oily trousers",feet="Hachiryu sune-ate"}
	sets.precast.WS['Slug Shot'].HNM          = set_combine(sets.precast.WS['Slug Shot'],{waist="Buccaneer's belt",legs="Hachiryu haidate"})
	
	sets.precast.WS['Last Stand']             = set_combine(sets.precast.WS['Slug Shot'],{neck="Flame gorget"})
	sets.precast.WS['Last Stand'].HNM         = set_combine(sets.precast.WS['Slug Shot'].HNM,{neck="Flame gorget"})
	
	sets.precast.WS['Coronach']               = {head="Maat's cap"      ,neck="Thunder gorget" ,ear1="Drone earring"   ,ear2="Drone earring"
												,body="Kirin's osode"   ,hands="Seiryu's kote" ,ring1="Rajas ring"     ,ring2="Blobnag ring"
												,back="Commander's cape",waist="Scout's belt"  ,legs="Byakko's haidate",feet="Hachiryu sune-ate"}
	sets.precast.WS['Coronach'].HNM           = set_combine(sets.precast.WS['Coronach'],{back="Amemet mantle +1",waist="Buccaneer's belt",legs="Hachiryu haidate"})
	
end

function job_precast(spell,action,spellMap,eventArgs)
	
	if spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
		if state.WeaponskillMode.value == 'HNM' then
			if daytime then
				equip({ear1="Ladybug earring +1",ear2="Ladybug earring +1"})
			else
				if player.sub_job == 'SAM' then
					equip({ear2="Bushinomimi"})
				end
			end
		end
	end
	
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
	
	if state.Buff['Unlimited Shot'] and spell.type == 'WeaponSkill' then
		equip({ammo="Combat Caster's arrow"})
	end
	
	if spell.name == 'Eagle Eye Shot' then
		if daytime then
			equip({ear1="Ladybug earring +1",ear2="Ladybug earring +1"})
		else
			if player.sub_job == 'SAM' then
				equip({ear2="Bushinomimi"})
			end
		end
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
		if state.Buff['Sharpshot'] and state.RangedMode.value ~= 'Normal' then
			equip(sets.buff['Sharpshot'])
		end
		if daytime then
			equip({ear1="Ladybug earring +1",ear2="Ladybug earring +1"})
		else
			if player.sub_job == 'SAM' then
				equip({ear2="Bushinomimi"})
			end
		end
	end

end

function job_buff_change(buff,gain)
	
	sleep_swap(name,gain)
	
	if buff == "Camouflage" then
		if gain then
			equip(sets.buff.Camouflage)
			disable('body')
		else
			enable('body')
		end
	end
	
end