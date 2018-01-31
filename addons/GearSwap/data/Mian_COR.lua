function get_sets()

	--mote library settings
	mote_include_version = 2
	
	include('Mote-Include.lua')
	
end

function job_setup()

	--kay library settings
	include('Kay-Include.lua')
	
	-- custom state buffs
	state.Buff['Bust'] = buffactive['Bust'] or false
	
	current_dice = 'Chaos Roll' -- default
	
	initialize_job()
	
end

function user_setup()
	
end

function init_gear_sets()
	
end

function job_post_precast(spell,action,spellMap,eventArgs)

	if spell.type == 'CorsairRoll' or spell.english == 'Double-Up' then
		
		if spell.type == 'CorsairRoll' then
			current_dice = spell.english
		end
		handle_cor_rolls(current_dice)
		
	end
	
end

function job_buff_change(name,gain)

	sleep_swap(name,gain)
	
	if name == 'Bust' then
		send_command('cancel Bust')
	end

end