function get_sets()

	

	mote_include_version = 2

	include('Mote-Include.lua')

	

end



function job_setup()



	include('Kay-Include.lua')



	initialize_job()

	

end



function user_setup()



	state.IdleMode:options('Normal','SuperMDT','SuperPDT')

	state.OffenseMode:options('Normal','DW','Heavy','Wyrms')

	state.WeaponskillMode:options('Normal','Acc')

	state.PhysicalDefenseMode:options('PDT')

	state.MagicalDefenseMode:options('MDT')

	

	send_command('bind !f9 gs c cycle IdleMode')

	

	gear.main = player.equipment.main

	gear.sub = player.equipment.sub

	

end



function init_gear_sets()



	-- Misc.

	sets.enmity                             = {head="Aegishjalmer",neck="Ritter gorget",body="Hydra Haubert",hands="Valor gauntlets +1",ring2="Hercules' ring",back="Cerberus mantle +1",waist="Velocious Belt",legs="Hydra Brayettes",feet="Valor leggings +1"}

	sets.resting                            = set_combine(sets.enmity,{ammo="Bibiki seashell",neck="Gnole torque",feet="Numerist pumps"})

	                                        

	sets.MND                                = {head="Maat's cap",neck="Gnole torque",ear2="Mamool Ja earring",body="Crimson scale mail",legs="Jet seraweels",feet="Valor leggings"}

	                                        

	sets.obi 										   = {Fire 	    = {waist="Karin Obi"}

													     ,Earth 	= {waist="Dorin Obi"}

													     ,Water 	= {waist="Suirin Obi"}

													     ,Wind 	    = {waist="Furin Obi"}

													     ,Ice 		= {waist="Hyorin Obi"}

													     ,Lightning = {waist="Rairin Obi"}

													     ,Light     = {waist="Korin Obi"}

													     ,Dark 	    = {waist="Anrin Obi"}}                           

	                                        

	-- Precast JAs                          

	sets.precast.JA                         = set_combine(sets.enmity,{})

	                                       

	sets.precast.JA['Cover']                = set_combine(sets.precast.JA,{head="Gallant coronet",body="Valor surcoat +1"})

	sets.precast.JA['Rampart']              = set_combine(sets.precast.JA,{head="Valor coronet"})

	sets.precast.JA['Sentinel']             = set_combine(sets.precast.JA,{feet="Valor leggings +1"})

	sets.precast.JA['Shield Bash']          = set_combine(sets.precast.JA,{ear2="Knightly earring",hands="Valor gauntlets +1"})

	sets.precast.JA['Holy Circle']          = set_combine(sets.precast.JA,{feet="Gallant leggings +1"})

	                                       

	-- Precast magic                        

	sets.precast.FC                         = {ear1="Loquacious earring",legs="Homam cosciales"}

		

	sets.precast['Healing Magic']			= set_combine(sets.precast.FC,{head="Gnadbhod's helm",neck="Orochi nodowa",body="Haubergeon +1",hands="Heavy gauntlets",ring1="Astral ring",ring2="Serket ring",feet="Aurum sabatons"})

	

	-- Midcast magic                        

	sets.midcast['Enhancing Magic']         = set_combine(sets.enmity,sets.precast.FC,{ammo="Bibiki Seashehe;;",legs="Gallant breeches"})

	sets.midcast['Healing Magic']           = set_combine(sets.enmity,{head="Valor coronet"     ,neck="Ritter gorget"   ,ear1="Bloodbead earring",ear2="Cassie earring"

	                                                                  ,body="Crimson scale mail",hands="Homam manopolas"                         ,ring2="Bloodbead ring"

																	  ,back="Cerberus mantle +1"                           ,legs="Blood cuisses",feet="Valor leggings +1"})

	sets.midcast['Divine Magic']            = set_combine(sets.enmity,sets.precast.FC,{ammo="Sturm's report",head="Homam zucchetto",ear1="Knight's earring",body="Gallant surcoat"})

	sets.midcast['Ninjutsu']                = set_combine(sets.enmity,sets.precast.FC,{body="Avalon Breastplate",ring1="Antica ring"})

	                                        

	-- Idle sets                            

	sets.idle                               = {ammo="Bibiki seashell",head="",neck="Chocobo whistle",ear1="Ethereal earring",ear2="Toreador's Ring",body="Avalon Breastplate", head= "Walahra Turban",hands="Heavy gauntlets",ring1="Defending ring",ring2="Shadow ring",back="Shadow mantle",waist="Lycopodium sash",legs="Blood cuisses",feet="Valor Leggigns +1"}

	sets.idle.Town                          = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})

	

	sets.idle.SuperMDT                      = {ammo="White tathlum"

	                                          ,head="Koenig schaller +1",neck="Gnole torque",ear1="Ethereal earring",ear2="Merman's earring"

											  ,body="Valhalla Breastplate",hands="Koenig handschuhs",ring1="Defending ring",ring2="Shadow ring"

											  ,back="Cerberus Mantle +1",waist="Resolute belt",legs="Koenig diechlings",feet="Valor leggings +1"}

	sets.idle.SuperPDT                      = {ammo="Bibiki seashell"

											  ,head="Valhalla Helm",neck="Fortified chain",ear1="Knight's earring",ear2="Ethereal earring"

											  ,body="Valhalla breastplate",hands="Heavy gauntlets",ring1="Defending ring",ring2=""

											  ,back="Shadow mantle",waist="Warwolf belt",legs="Blood cuisses",feet="Gallant Leggigns +1"}

	

	-- Defense sets                         

	sets.defense.PDT                        = set_combine(sets.enmity,{hands="Heavy gauntlets",ring1="Defending ring",ring2="Jelly ring"})

	sets.defense.MDT                        = set_combine(sets.enmity,{ear2="Merman's earring",hands="Heavy gauntlets",ring1="Defending ring",ring2="Shadow Ring"})

	sets.defense.Breath                     = set_combine(sets.enmity,{body="Crimson scale mail",ring1="Defending ring"})

	                                        

	-- Engaged sets                         

	sets.engaged                            = {ammo="Bibiki seashell"

											  ,head="Walahra turban",neck="Peacock amulet",ear1="Knight's earring",ear2="Brutal earring"

											  ,body="Avalon Breastplate",hands="Dusk gloves +1",ring1="Sattva ring",ring2="Toreador's Ring"

											  ,back="Cerberus mantle +1",waist="Velocious belt",legs="Homam cosciales",feet="Homam gambieras"}

	sets.engaged.DW                         = set_combine(sets.engaged,{ear1="Suppanomimi",ring1="Rajas ring"})

	sets.engaged.Heavy                      = {ammo="Bibiki seashell"

	                                          ,head="Valhalla Helm",neck="Ritter gorget",ear1="Knight's earring",ear2="Ethereal earring"

											  ,body="Valhalla breastplate",hands="Koenig handschuhs",ring1="Defending ring",ring2="Sattva ring"

											  ,back="Shadow mantle",waist="Warwolf belt",legs="Blood cuisses",feet="Kaiser schuhs"}

	sets.engaged.Wyrms						= set_combine(sets.engaged.Heavy,{body="Crimson scale mail"})

	

	-- Weaponskill sets                     

	sets.precast.WS                         = {head="Hecatomb cap"      ,neck="Fotia gorget"      ,ear1="Fowling earring",ear2="Brutal earring"

	                                          ,body="Hecatomb Harness +1"     ,hands="Hecatomb Mitts +1"                       ,ring2="Flame ring"

											  ,back="Cerberus mantle +1",waist="Warwolf belt"         ,legs="Hecatomb Subligar +1" ,feet="Hecatomb leggings +1"}

	sets.precast.WS.Acc                     = set_combine(sets.precast.WS,{neck="Peacock amulet",hands="Hecatomb mittens +1"})

	                                        

	sets.precast.WS['Vorpal Blade']         = set_combine(sets.precast.WS,{body="Zahak's mail",hands="Hecatomb mittens +1",back="Cuchulain's mantle"})

	sets.precast.WS['Vorpal Blade'].Acc     = set_combine(sets.precast.WS['Vorpal Blade'],{ring2=gear.TRing1})

	                                        

	sets.precast.WS['Requiescat']           = set_combine(sets.precast.WS['Vorpal Blade'],{})

	sets.precast.WS['Requiescat'].Acc       = set_combine(sets.precast.WS['Vorpal Blade'].Acc,{})

	                                       

	sets.precast.WS['Knights of Round']     = set_combine(sets.precast.WS,{head="Hecatomb cap +1"})

	sets.precast.WS['Knights of Round'].Acc = set_combine(sets.precast.WS['Knights of Round'],{ring2=gear.TRing1})

	                                        

	sets.precast.WS['Swift Blade']          = set_combine(sets.precast.WS,{head="Hecatomb cap +1"})

	sets.precast.WS['Swift Blade'].Acc      = set_combine(sets.precast.WS['Swift Blade'],{ring2=gear.TRing1})

	                                        

	sets.precast.WS['Savage Blade']         = set_combine(sets.precast.WS,{head="Hecatomb cap +1"})

	sets.precast.WS['Savage Blade'].Acc     = set_combine(sets.precast.WS['Savage Blade'],{ring2=gear.TRing1})

	

end



function job_post_precast(spell,action,spellMap,eventArgs)



	if spellMap == 'Cure' then

		equip(sets.precast['Healing Magic'])

	end



end



function job_post_midcast(spell,action,spellMap,eventArgs)



	if spell.skill == 'Healing Magic' or spell.skill == 'Divine magic' then 

		if spell.element == world.weather_element or spell.element == world.day_element and world.weather_element ~= 'Dark' then

			equip({waist="Hachirin-no-obi"})

		end

	end



end



function job_status_change(new,old)



	if new == "Idle" then

		if (player.hp/player.max_hp) > 0.85 then

			equip({neck="Parade gorget"})

			disable("neck")

		elseif (player.hp/player.max_hp) < 0.50 then

			equip({ring2="Hercules' ring"})

			disable("neck")

		end

	else

		enable("neck")

	end

	

	gear.main = player.equipment.main

	gear.sub = player.equipment.sub

	

end