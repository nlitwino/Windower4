function get_sets()

	mote_include_version = 2
	include('Mote-Include.lua')

end

function job_setup()

	state.Buff['Footwork'] = buffactive['Footwork'] or false
	state.Buff['Hundred Fists'] = buffactive['Hundred Fists'] or false
	state.Buff['Focus'] = buffactive['Focus'] or false
	
	include('Kay-Include.lua')
	
	initialize_job()

end

function user_setup()

	state.OffenseMode:options('Normal','HybridAcc','Acc','OffTank','Tank')
	state.WeaponskillMode:options('Normal','HNM')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	
end

function init_gear_sets()

	-- misc.
	sets.VIT                             = {ammo="Bibiki seashell"
			                               ,head="Genbu's kabuto"                      ,ear1="Cassie earring",ear2=""
			                               ,body="Kirin's osode"                                             ,ring2="Corneus ring"
			                               ,back="Melee cape"     ,waist="Warwolf belt",legs="Kensei sitabaki"}
	sets.MND                             = {head="Maat's cap"   ,neck="Gnole torque",ear1="Mamool Ja earring"
			                               ,body="Kirin's osode"                                          ,ring2="Star ring"
			                               ,back="Melee cape"   ,waist="Ocean stone"                      ,feet="Suzaku's sune-ate"}
	
	-- precast ja
	sets.precast.JA                      = {}
	
	sets.precast.JA['Chi Blast']         = set_combine(sets.MND,{})
	sets.precast.JA['Boost']             = {hands="Temple gloves"}
	sets.precast.JA['Chakra']            = set_combine(sets.VIT,{body="Temple cyclas",hands="Melee gloves"})
	sets.precast.JA['Focus']             = {head="Temple crown"}
	sets.precast.JA['Dodge']             = {feet="Temple gaiters"}
	sets.precast.JA['Footwork']			 = {feet="Kyoshu kyahan"}
	
	-- precast magic
	sets.precast.FC 					 = {ear1="Loquacious earring"}
	
	-- midcast magic
	sets.midcast.FastRecast              = set_combine(sets.precast.FC,{ammo="Bibiki seashell"
							                                           ,head="Walahra turban"     ,neck="Fortified chain"
							                                           ,body="Scorpion harness +1"                       ,ring1="Defending ring"
							                                           ,back="Prism cape"         ,waist="Black belt"    ,legs="Byakko's haidate",feet="Sarutobi kyahan"})
	
	sets.midcast['Utsusemi: Ni']         = set_combine(sets.midcast.FastRecast,{ring2="Antica ring"})
	sets.midcast['Utsusemi: Ichi']       = set_combine(sets.midcast.FastRecast,{waist="Resolute belt"})    
	
	-- idle
	sets.idle                            = {ammo="Bibiki seashell"
				                           ,head="Arhat's jinpachi +1",neck="Chocobo whistle" ,ear1="Merman's earring"     ,ear2="Merman's earring"
				                           ,body="Melee cyclas"       ,hands="Seiryu's kote"  ,ring1="Defending ring"      ,ring2="Shadow ring"
				                           ,back="Shadow mantle"      ,waist="Lycopodium sash",legs="Darksteel subligar +1",feet="Hermes' sandals"}
	sets.idle.Town                       = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
	
	-- defense
	
	
	sets.defense.PDT 	                 = {ammo="Bibiki seashell",head="Arhat's jinpachi +1",body="Arhat's gi +1",ring1="Defending ring",ring2="Jelly ring",back="Shadow mantle",waist="Black belt",legs="Darksteel subligar +1"}
	sets.defense.Evasion                 = set_combine(sets.defense.PDT,{head="Gnole crown",neck="Fortified chain",ear1="Drone earring",ear2="Drone earring",hands="Seiryu's kote",ring1="Defending ring",back="Boxer's mantle",legs="Raven hose",feet="Hachiryu sune-ate"})
	sets.defense.MDT                     = {ammo="Bibiki seashell"
	                                       ,head="Genbu's kabuto"                          ,ear1="Merman's ring"   ,ear2="Merman's ring"
					                       ,body="Avalon breastplate",hands="Seiryu's kote",ring1="Defending ring" ,ring2="Shadow ring"
					                                                 ,waist="Resolute belt",legs="Byakko's haidate",feet="Suzaku's sune-ate"}
	
	-- engaged
	sets.engaged                         = {ammo="Black tathlum"
				                           ,head="Walahra turban"    ,neck="Faith torque"    ,ear1="Bushinomimi"     ,ear2="Brutal earring"
				                           ,body="Hachiryu haramaki" ,hands="Bandomusha kote",ring1=gear.TRing2      ,ring2=gear.TRing1
				                           ,back="Cerberus mantle +1",waist="Black belt"     ,legs="Byakko's haidate",feet="Sarutobi kyahan"}
	sets.engaged.HybridAcc               = set_combine(sets.engaged,{back="Cuchulain's mantle"})
	sets.engaged.Acc                     = set_combine(sets.engaged.HybridAcc,{head="Enkidu's cap",ear1="Hollow earring",neck="Ancient torque",hands="Hachiryu kote",feet="Enkidu's leggings"})
	sets.engaged.OffTank                 = set_combine(sets.engaged,{ammo="Bibiki seashell",ear1="Cassie earring",hands="Melee gloves",ring1="Defending ring",back="Boxer's mantle"})
	sets.engaged.Tank                    = set_combine(sets.engaged.OffTank,{head="Gnole crown",neck="Fortified chain",legs="Temple hose"})
	
	-- engaged FOCUS
	sets.engaged.Focus                   = set_combine(sets.engaged,{})
	sets.engaged.HybridAcc.Focus         = set_combine(sets.engaged,{})
	sets.engaged.Acc.Focus               = set_combine(sets.engaged.HybridAcc,{})
	sets.engaged.OffTank.Focus           = set_combine(sets.engaged.OffTank,{})
	sets.engaged.Tank.Focus              = set_combine(sets.engaged.Tank,{})
	
	-- ws
	sets.precast.WS                      = {ammo="Black tathlum"
					                       ,head="Maat's cap"        ,neck="Fotia gorget"    ,ear1="Bushinomimi"     ,ear2="Brutal earring"
					                       ,body="Kirin's osode"     ,hands="Bandomusha kote",ring1="Rajas ring"     ,ring2=gear.TRing1
					                       ,back="Cerberus mantle +1",waist="Warwolf belt"   ,legs="Hachiryu haidate",feet="Rutter sabatons"}
	sets.precast.WS.HNM                  = set_combine(sets.precast.WS,{head="Gnadbhod's helm"})
	
	sets.precast.WS['Dragon Kick']       = set_combine(sets.precast.WS,{})
	sets.precast.WS['Dragon Kick'].HNM   = set_combine(sets.precast.WS['Dragon Kick'],{})
	
	sets.precast.WS['Asuran Fists']      = set_combine(sets.precast.WS,{head="Hissho hachimaki",ear1="Hollow earring",ear2="Merman's earring",body="Hachiryu haramaki"})
	sets.precast.WS['Asuran Fists'].HNM  = set_combine(sets.precast.WS['Asuran Fists'],{})
	
	sets.precast.WS['Victory Smite']     = set_combine(sets.precast.WS['Asuran Fists'],{})
	sets.precast.WS['Victory Smite'].HNM = set_combine(sets.precast.WS['Asuran Fists'].HNM,{})
	
end

function job_buff_change(name,gain)
	
	sleep_swap(name,gain)
	
	if name == 'Hundred Fists' then
		state.Buff[name] = gain
		adjust_melee_groups()
		handle_equipping_gear(player.status)
	elseif name == 'Focus' then
		state.Buff[name] = gain
		adjust_melee_groups()
		handle_equipping_gear(player.status)
	end

end

function job_post_precast(spell,action,spellMap,eventArgs)

	if spell.type == 'WeaponSkilll' then
		if state.Buff['Footwork'] then
		--equip({feet="Kyoshu kyahan"})
		end
		if daytime then
			equip({ear1="Fenrir's earring"})
		end
	end

end

function customize_melee_set(meleeSet)

	if state.Buff['Hundred Fists'] then
        meleeSet = set_combine(meleeSet,sets.precast.WS,{head="Hissho hachimaki",neck="Peacock amulet",ear1="Hollow earring",ring1=gear.TRing2,waist="Black belt"})
	end
	if state.Buff['Footwork'] then
		--meleeSet = set_combine(meleeSet, {feet="Kyoshu kyahan"})
    end
	if daytime then
		meleeSet = set_combine(meleeSet, {ear1="Fenrir's earring"})
	end
    return meleeSet
	
end

function adjust_melee_groups()

	classes.CustomMeleeGroups:clear()
	
	if state.Buff['Focus'] then
		classes.CustomMeleeGroups:append('Focus')
	end
	
end