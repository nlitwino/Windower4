-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

	state.Buff['Barrage'] = buffactive.Barrage or false
	state.Buff['Camouflage'] = buffactive.Camouflage or false
	state.Buff['Sharpshot'] = buffactive['Sharpshot'] or false
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')

	send_command('bind f9 gs c cycle RangedMode')
	send_command('bind ^f9 gs c cycle OffenseMode')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
end


-- Set up all gear sets.
function init_gear_sets()
	
	-- Buff sets
	sets.buff['Barrage'] = 					sets.midcast.RA.Acc
	sets.buff['Camouflage'] = 				{}
	sets.buff['Sharpshot'] = 				{legs="Hunter's braccae"}

	-- Precast sets to enhance JAs
	sets.precast.JA['Camouflage'] = 		{body="Hunter's jerkin"}
	sets.precast.JA['Scavenge'] = 			{feet="Hunter's socks"}
	sets.precast.JA['Shadowbind'] = 		{hands="Hunter's bracers"}
	sets.precast.JA['Sharpshot'] = 			{legs="Hunter's braccae"}
	
	-- Fast cast sets for spells
	sets.precast.FC = 						{}

	-- Ranged sets (snapshot)
	sets.precast.RA = 						{head="Hunter's beret"}

	-- Default set for any weaponskill that t any more specifically defined
	sets.precast.WS = 						{head="Hunter's beret",neck="Spike necklace",body="Hunter's Jerkin",hands="Custom F gloves",ring1="Rajas ring",ring2="",feet="Bounding boots"}
	sets.precast.WS.Acc = 					set_combine(sets.precast.WS, {neck="Peacock amulet"})
	
	-- Fast recast for spells
	sets.midcast.FastRecast = 				{}
	sets.midcast.Utsusemi = 				{}

	-- Ranged sets
	sets.midcast.RA = 						set_combine(sets.precast.RA, {neck="Ranger's necklace",hands="Noct gloves +1",ring1="Sniper's ring +1",ring2="Sniper's ring +1",legs="Noct brais +1",feet="Bounding boots"})
	sets.midcast.RA['Sharpshot'] = 			set_combine(sets.midcast.RA, sets.buff['Sharpshot'])
	sets.midcast.RA.Acc = 					set_combine(sets.midcast.RA,{neck="Peacock amulet"})
	sets.midcast.RA.Acc['Sharpshot'] = 		set_combine(sets.midcast.RA.Acc, sets.buff['Sharpshot'])
	--sets.midcast.RA.Annihilator = 		set_combine(sets.midcast.RA)
	--sets.midcast.RA.Annihilator.Acc = 	set_combine(sets.midcast.RA.Acc)
	--sets.midcast.RA.Yoichinoyumi = 		set_combine(sets.midcast.RA, {})
	--sets.midcast.RA.Yoichinoyumi.Acc = 	set_combine(sets.midcast.RA.Acc, {})
	
	-- Resting sets
	sets.resting = 							{}

	-- Idle sets
	sets.idle = 							{head="Hunter's beret",neck="Chocobo whistle",ear1="Mythril earring +1",ear2="Bloodbead earring",body="Hunter's Jerkin",hands="Hunter's bracers",ring1="Sniper's ring +1",ring2="Sniper's ring +1",back="Kinesis mantle +1",waist="Velocious belt",legs="Hunter's braccae",feet="Trotter boots"}
	
	-- Defense sets
	sets.defense.PDT = 						{}
	sets.defense.MDT = 						{}
	sets.Kiting = 							{}

	-- Engaged sets
	sets.engaged = 							{head="Noct beret +1",neck="Peacock amulet",ear1="Mythril earring +1",ear2="Bloodbead earring",body="Hunter's Jerkin",hands="Custom F gloves",ring1="Sniper's ring +1",ring2="Sniper's ring +1",back="Kinesis mantle +1",waist="Velocious belt",legs="Noct brais +1",feet="Bounding boots"}
	sets.engaged.Acc = 						set_combine(sets.engaged, {})
	
	--head="",neck="",ear1="",ear2="",body="",hands="",ring1="",ring2="",back="",waist="",legs="",feet=""
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		state.CombatWeapon:set(player.equipment.range)
	end

	if spell.action_type == 'Ranged Attack' or
	  (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
	end
	
	if state.DefenseMode.value ~= 'None' and spell.type == 'WeaponSkill' then
		-- Don't gearswap for weaponskills when Defense is active.
		eventArgs.handled = true
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff['Barrage'] then
		equip(sets.buff.Barrage)
		eventArgs.handled = true
	end
	if spell.action_type == 'Ranged Attack' and state.Buff['Sharpshot'] then
		if state.RangedMode.value == 'Acc' then
			equip(sets.midcast.RA['Sharpshot'])
		else
			equip(sets.midcast.RA.Acc['Sharpshot'])
		end
		eventArgs.handled = true
	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Camouflage" then
		if gain then
			equip(sets.buff.Camouflage)
			disable('body')
		else
			enable('body')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	-- if state.Buff['Unlimited Shot'] then
		-- if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			-- if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
				-- add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				-- equip({ammo=U_Shot_Ammo[player.equipment.range]})
			-- elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
				-- add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				-- equip({ammo=DefaultAmmo[player.equipment.range]})
			-- else
				-- add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			-- end
		-- end
	-- else
		-- if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			-- if DefaultAmmo[player.equipment.range] then
				-- if player.inventory[DefaultAmmo[player.equipment.range]] then
					-- add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					-- equip({ammo=DefaultAmmo[player.equipment.range]})
				-- else
					-- add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					-- equip({ammo=empty})
				-- end
			-- else
				-- add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				-- equip({ammo=empty})
			-- end
		-- elseif player.equipment.ammo == 'empty' then
			-- if DefaultAmmo[player.equipment.range] then
				-- if player.inventory[DefaultAmmo[player.equipment.range]] then
					-- add_to_chat(122,"Using Default Ammo")
					-- equip({ammo=DefaultAmmo[player.equipment.range]})
				-- else
					-- add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				-- end
			-- else
				-- add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			-- end
		-- elseif player.inventory[player.equipment.ammo].count < 15 then
			-- add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		-- end
	-- end
end

