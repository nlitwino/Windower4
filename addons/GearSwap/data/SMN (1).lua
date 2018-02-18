send_command('wait 4; input /lockstyleset 20; wait 1; input //ae load Houziouzi')

function get_sets()

	mote_include_version = 2
	include('Mote-Include.lua')

end

function job_setup()

	include('Kay-Include.lua')
	
	state.Buff['Copy Image (3)'] = buffactive['Copy Image (3)'] or false
    	state.Buff['Copy Image (2)'] = buffactive['Copy Image (2)'] or false
    	state.Buff['Copy Image (1)'] = buffactive['Copy Image'] or false
    	state.Buff['Sneak Attack'] = buffactive['Sneak Attack'] or false
	
	initialize_job()

end

function user_setup()

	state.IdleMode:options('Normal','SuperMDT','SuperPDT')
	state.OffenseMode:options('Normal','Acc','Heavy','Wyrm','Back','BackWyrm')
	state.WeaponskillMode:options('Normal','Acc')
	state.PhysicalDefenseMode:options('PDT','Breath')
	state.MagicalDefenseMode:options('MDT', 'Fire')
	
	send_command('bind f9 gs c cycle IdleMode')
	
	gear.main = player.equipment.main
	gear.sub = player.equipment.sub

end

function init_gear_sets()
	
	sets.idle={main="Earth Staff",
		   head="Summoner's Horn", neck="Chcobo Whistle", 
		   body="Yinyang robe",    hands="Wonder Mitts",  ring1="Warp Ring",      ring2="Evoker's Ring",
		   back="Prism Cape",      waist="Headlong belt", legs="Summoner's Spats", feet="Wonder Clomps"} 
		   
	sets.resting={main="Iridal Staff",
		      head="Summoner's Horn", neck="Chcobo Whistle", 
		      body="Yinyang robe",    hands="Wonder Mitts",  ring1="Warp Ring",      ring2="Evoker's Ring",
		      back="Prism Cape",      waist="Headlong belt", legs="Summoner's Spats", feet="Wonder Clomps"} 
		      
end

function customize_idle_set(idleSet)
	if pet.isvalid then
		if pet.name:contains('Shiva') then
			equip({main="Aquilo's Staff"})
		else 
			equip({main="Iridal Staff"})
		end
	else 
		equip(sets.idle)
	end
end