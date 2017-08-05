-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime

--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    include('organizer-lib.lua')
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
     state.OffenseMode:options('Normal', 'Acc', 'Mod')
     state.HybridMode:options('Normal', 'Evasion', 'PDT')
     state.RangedMode:options('Normal', 'Acc')
     state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
     state.PhysicalDefenseMode:options('Evasion', 'PDT')


    gear.default.weaponskill_neck = "Spike Necklace"
     gear.default.weaponskill_waist = "Swordbelt"
     gear.AugQuiahuiz = {name="Quiahuiz Trousers", augments={'Haste+2','"Snapshot"+2','STR+8'}}

     -- Additional local binds
     send_command('bind ^` input /ja "Flee" <me>')
     send_command('bind ^= gs c cycle treasuremode')
     send_command('bind !- gs c cycle targetmode')
	 --send_command('bind !` input @mk %target_id')

    --select_default_macro_book()
 end

--  Called when this job file is unloaded (eg: job change)
 function user_unload()
     send_command('unbind ^`')
     send_command('unbind !-')
end

--Define sets and vars used by this job file.
function init_gear_sets()
    -- --------------------------------------
    -- -- Special sets (required by rules)
    -- --------------------------------------

    sets.TreasureHunter = {hands="Assassin's armlets"}
    sets.ExtraRegen = {}
    sets.Kiting = {feet="Trotter Boots"}

    sets.buff['Sneak Attack'] = {}

    sets.buff['Trick Attack'] = {}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    -- --------------------------------------
    -- -- Precast sets
    -- --------------------------------------

    -- -- Precast sets to enhance JAs
    -- sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
    -- sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Flee'] = {feet="Rogue's poulaines"}
    sets.precast.JA['Hide'] = {body="Rogue's Vest"}
    -- sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
    sets.precast.JA['Steal'] = {hands="Rogue's Armlets",head="Rogue's Bonnet",legs="Rogue's Culottes",feet="Rogue's Poulaines"}
    -- sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
    -- sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    -- sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    -- sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    -- sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {feet="Assassin's Poulaines"}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- -- Fast cast sets for spells
    sets.precast.FC = {}

    --sets.precast.FC.Utsusemi = sets.precast.FC


    -- Ranged snapshot gear
    sets.precast.RA = {}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {head="Hecatomb Cap", neck="Spike Necklace", ear1="Coral Earring", ear2="Spike Earring", body="Scorpion Harness +1",
		hands="Custom F Gloves", ring1="Assailant's Ring", ring2="Flame Ring", back="Cerberus Mantle", waist="Swordbelt", legs="Noct Brais +1",
		feet="Bounding Boots"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {body="Scorpion Harness +1", neck="Peacock Amulet"})
    sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {}) --waist=gear.ElementalBelt
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {back="Assassin's Mantle"})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {body="Scorpion Harness +1", neck="Peacock Amulet"})
    sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {}) --waist=gear.ElementalBelt
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {body="Scorpion Harness +1", neck="Peacock Amulet"})
    sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {})--waist=gear.ElementalBelt
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {back="Assassin's Mantle"})

    -- sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +1",ear1="Brutal Earring",ear2="Moonshade Earring"})
    -- sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Honed Tathlum", back="Letalis Mantle"})
    -- sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {back="Kayapa Cape",waist=gear.ElementalBelt})
    -- sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
        -- body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    -- sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
        -- body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    -- sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
        -- body="Pillager's Vest +1",legs="Pillager's Culottes +1"})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {body="Scorpion Harness +1", neck="Peacock Amulet"})
    sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {}) --waist=gear.ElementalBelt
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {back="Assassin's Mantle"})

    -- sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +1",ear1="Brutal Earring",ear2="Moonshade Earring"})
    -- sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    -- sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {back="Kayapa Cape",waist=gear.ElementalBelt})
    -- sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
        -- body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    -- sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
        -- body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    -- sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
        -- body="Pillager's Vest +1",legs="Pillager's Culottes +1"})

    sets.precast.WS['Cyclone'] = set_combine(sets.precast.WS, {ear1="Moldavite Earring"})

    sets.precast.WS['Cyclone'].TH = set_combine(sets.precast.WS['Cyclone'], sets.TreasureHunter)


    -- --------------------------------------
    -- -- Midcast sets
    -- --------------------------------------

    sets.midcast.FastRecast = {}

    -- -- Specific spells
    sets.midcast.Utsusemi = {head="Walahra Turban", body="Rapparee Harness", legs="Bravo's Subligar", waist="Velocious Belt", hands="Dusk Gloves", 
								feet="Dusk ledelsens"}

    -- -- Ranged gear
    sets.midcast.RA = {hands="Assassin's armlets"}

    sets.midcast.RA.Acc = {hands="Assassin's armlets"}


    -- --------------------------------------
    -- -- Idle/resting/defense sets
    -- --------------------------------------

    -- -- Resting sets
    sets.resting = {head="Dream Hat +1", neck="Chocobo Whistle", ear1="Mythril Earring +1", ear2="Mythril Earring", body="Scorpion Harness +1", 
		hands="Assassin's Armlets", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Kinesis mantle +1", waist="Velocious belt", legs="Bravo's Subligar",
		feet="Trotter Boots"}


    -- -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {head="Dream Hat +1", neck="Chocobo Whistle", ear1="Mythril Earring +1", ear2="Mythril Earring", body="Rapparee harness", 
		hands="Assassin's Armlets", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Kinesis mantle +1", waist="Velocious belt", legs="Bravo's Subligar",
		feet="Trotter Boots"}

    sets.idle.Town = {head="Dream Hat +1", neck="Chocobo Whistle", ear1="Mythril Earring +1", ear2="Mythril Earring", body="Rapparee harness", 
		hands="Assassin's Armlets", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Kinesis mantle +1", waist="Velocious belt", legs="Bravo's Subligar",
		feet="Trotter Boots"}

    sets.idle.Weak = {head="Dream Hat +1", neck="Chocobo Whistle", ear1="Mythril Earring +1", ear2="Mythril Earring", body="Rapparee harness", 
		hands="Assassin's Armlets", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Kinesis mantle +1", waist="Velocious belt", legs="Bravo's Subligar",
		feet="Trotter Boots"}


    -- -- Defense sets

    sets.defense.Evasion = {head="Empress Hairpin", neck="Peacock Amulet", ear1="Mythril Earring +1", ear2="Mythril Earring", body="Scorpion Harness +1", 
		hands="Custom F Gloves", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Kinesis mantle +1", waist="Velocious belt", legs="Bravo's Subligar",
		feet="Trotter Boots"}

    sets.defense.PDT = {head="Dream Hat +1", neck="Peacock Amulet", ear1="Mythril Earring +1", ear2="Mythril Earring", body="Scorpion Harness +1", 
		hands="Custom F Gloves", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Kinesis mantle +1", waist="Velocious belt", legs="Bravo's Subligar",
		feet="Trotter Boots"}

    sets.defense.MDT = {head="Dream Hat +1", neck="Peacock Amulet", ear1="Mythril Earring +1", ear2="Mythril Earring", body="Scorpion Harness +1", 
		hands="Custom F Gloves", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Kinesis mantle +1", waist="Velocious belt", legs="Bravo's Subligar",
		feet="Trotter Boots"}


    -- --------------------------------------
    -- -- Melee sets
    -- --------------------------------------

    -- -- Normal melee group
    sets.engaged = {head="Walahra Turban", neck="Peacock Amulet", ear1="Mythril Earring +1", ear2="Suppanomimi", body="Rapparee harness",
		hands="Dusk Gloves", ring1="Assailant's Ring", ring2="Ecphoria Ring", back="Kinesis Mantle +1", waist="Velocious Belt", legs="Bravo's Subligar",
		feet="Dusk ledelsens"}
    sets.engaged.Acc = {head="Walahra Turban", neck="Peacock Amulet", ear1="Mythril Earring +1", ear2="Suppanomimi", body="Scorpion Harness +1",
		hands="Dusk Gloves", ring1="Assailant's Ring", ring2="Ecphoria Ring", back="Kinesis Mantle +1", waist="Velocious Belt", legs="Bravo's Subligar",
		feet="Dusk ledelsens"}
        
    -- -- Mod set for trivial mobs (Skadi+1)
    sets.engaged.Mod = {head="Walahra Turban", neck="Peacock Amulet", ear1="Mythril Earring +1", ear2="Suppanomimi", body="Rapparee harness",
		hands="Dusk Gloves", ring1="Assailant's Ring", ring2="Ecphoria Ring", back="Kinesis Mantle +1", waist="Velocious Belt", legs="Bravo's Subligar",
		feet="Dusk ledelsens"}

    -- -- Mod set for trivial mobs (Thaumas)
    sets.engaged.Mod2 = {head="Walahra Turban", neck="Peacock Amulet", ear1="Mythril Earring +1", ear2="Suppanomimi", body="Rapparee harness",
		hands="Dusk Gloves", ring1="Assailant's Ring", ring2="Ecphoria Ring", back="Kinesis Mantle +1", waist="Velocious Belt", legs="Bravo's Subligar",
		feet="Dusk ledelsens"}

    sets.engaged.Evasion = {head="Walahra Turban", neck="Peacock Amulet", ear1="Mythril Earring +1", ear2="Suppanomimi", body="Scorpion Harness +1",
		hands="Dusk Gloves", ring1="Assailant's Ring", ring2="Ecphoria Ring", back="Kinesis Mantle +1", waist="Velocious Belt", legs="Bravo's Subligar",
		feet="Dusk ledelsens"}
    sets.engaged.Acc.Evasion = {head="Walahra Turban", neck="Peacock Amulet", ear1="Mythril Earring +1", ear2="Suppanomimi", body="Scorpion Harness +1",
		hands="Dusk Gloves", ring1="Assailant's Ring", ring2="Ecphoria Ring", back="Kinesis Mantle +1", waist="Velocious Belt", legs="Bravo's Subligar",
		feet="Dusk ledelsens"}
    sets.engaged.PDT = {head="Walahra Turban", neck="Peacock Amulet", ear1="Mythril Earring +1", ear2="Suppanomimi", body="Scorpion Harness +1",
		hands="Dusk Gloves", ring1="Assailant's Ring", ring2="Ecphoria Ring", back="Kinesis Mantle +1", waist="Velocious Belt", legs="Bravo's Subligar",
		feet="Dusk ledelsens"}
    sets.engaged.Acc.PDT = {head="Walahra Turban", neck="Peacock Amulet", ear1="Mythril Earring +1", ear2="Suppanomimi", body="Scorpion Harness +1",
		hands="Dusk Gloves", ring1="Assailant's Ring", ring2="Ecphoria Ring", back="Kinesis Mantle +1", waist="Velocious Belt", legs="Bravo's Subligar",
		feet="Dusk ledelsens"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Cyclone' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
-- function select_default_macro_book()
    -- -- Default macro set/book
    -- if player.sub_job == 'DNC' then
        -- set_macro_page(2, 5)
    -- elseif player.sub_job == 'WAR' then
        -- set_macro_page(3, 5)
    -- elseif player.sub_job == 'NIN' then
        -- set_macro_page(4, 5)
    -- else
        -- set_macro_page(2, 5)
    -- end
-- end


