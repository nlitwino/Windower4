-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	include('organizer-lib.lua')
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Breath')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    sets.enmity= {head="Aegishjalmer", hands="Valor gauntlets", body="Valor Surcoat", hands="Valor Gauntlets", ring1="Hercules' Ring", back="Valor Cape"
										, waist="Trance Belt", legs="Valor Breeches"}
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {}
    sets.precast.JA['Holy Circle'] = set_combine(sets.enmity, {feet="Gallant leggings"})
    sets.precast.JA['Shield Bash'] = set_combine(sets.enmity, {hands="Valor gauntlets"})
    sets.precast.JA['Sentinel'] = set_combine(sets.enmity, {feet="Valor Leggings"})
    sets.precast.JA['Rampart'] = set_combine(sets.enmity, {head="Valor Coronet"})
    sets.precast.JA['Fealty'] = {}
    sets.precast.JA['Divine Emblem'] = {}
    sets.precast.JA['Cover'] = set_combine(sets.enmity, {body="Valor Surcoat", head="Gallant Coronet"})

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = set_combine(sets.enmity, {})
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {}
    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {head="Walkure Mask", neck="Spike Necklace", ear1="Coral Earring", ear2="Spike Earring", 
						body="Haubergeon +1", hands="Alkyoneus's bracelets", ring1="Sun Ring", ring2="Flame Ring", back="Cerberus mantle", 
						waist="Swordbelt", legs="Royal Kinght's breeches", feet="Dusk Ledelsens"}

    sets.precast.WS.Acc = {head="Walkure Mask", neck="Peacock Amulet", ear1="Coral Earring", ear2="Spike Earring", 
						body="Haubergeon +1", hands="Alkyoneus's bracelets", ring1="Sun Ring", ring2="Flame Ring", back="Cerberus mantle", 
						waist="Swordbelt", legs="Royal Kinght's breeches", feet="Dusk Ledelsens"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Sanguine Blade'] = {}
    
    sets.precast.WS['Atonement'] = {}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}
        
    sets.midcast.Enmity = sets.enmity

    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {})
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = set_combine(sets.enmity, {head="Valor Coronet", feet="Valor leggings", body="Crimson scale mail", waist="Trance Belt", neck="Justice Badge",
													back="Valor Cape"})

    sets.midcast['Enhancing Magic'] = {legs="Gallant breeches"}
    
    sets.midcast.Protect = {legs="Gallant breeches"}
    sets.midcast.Shell = {legs="Gallant breeches"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {}
    
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {head=empty, neck="Chocobo Whistle", ear1="Fowling Earring", ear2="Bloodbead Earring", 
						body="Vermillion Cloak", hands="Valor Gauntlets", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Valor Cape", 
						waist="Marid belt", legs="Valor breeches", feet="Valor leggings"}

    sets.idle.Town = {head=empty, neck="Chocobo Whistle", ear1="Fowling Earring", ear2="Bloodbead Earring", 
						body="Vermillion Cloak", hands="Valor Gauntlets", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Valor Cape", 
						waist="Marid belt", legs="Valor breeches", feet="Valor leggings"}
    
    sets.idle.Weak = {head=empty, neck="Chocobo Whistle", ear1="Fowling Earring", ear2="Bloodbead Earring", 
						body="Vermillion Cloak", hands="Valor Gauntlets", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Valor Cape", 
						waist="Marid belt", legs="Valor breeches", feet="Valor leggings"}
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {}

    sets.latent_refresh = {}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {}
    sets.MP = {}
    sets.MP_Knockback = {}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {} -- Ochain
    sets.MagicalShield = {} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {}
    sets.defense.HP = {}
    sets.defense.Reraise = {}
    sets.defense.Charm = {}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {head="Gallant coronet", neck="Peacock Amulet", ear1="Fowling Earring", ear2="Bloodbead Earring", 
						body="Adaman Cuirass", hands="Valor Gauntlets", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Valor Cape", 
						waist="Marid belt", legs="Gallant breeches", feet="Valor leggings"}

    sets.engaged.Acc = {head="Walahra Turban", neck="Peacock Amulet", ear1="Fowling Earring", ear2="Bloodbead Earring", 
						body="Adaman Cuirass", hands="Dusk Gloves", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Valor Cape", 
						waist="Velocious Belt", legs="Gallant breeches", feet="Dusk Ledelsens"}
						
	sets.engaged.Breath = {head="Gallant coronet", neck="Peacock Amulet", ear1="Fowling Earring", ear2="Bloodbead Earring", 
						body="Crimson scale mail", hands="Valor Gauntlets", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Valor Cape", 
						waist="Marid belt", legs="Gallant breeches", feet="Valor leggings"}

    sets.engaged.DW = {head="Gallant coronet", neck="Peacock Amulet", ear1="Fowling Earring", ear2="Bloodbead Earring", 
						body="Adaman Cuirass", hands="Valor Gauntlets", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Valor Cape", 
						waist="Marid belt", legs="Gallant breeches", feet="Valor leggings"}

    sets.engaged.DW.Acc = {head="Walahra Turban", neck="Peacock Amulet", ear1="Fowling Earring", ear2="Bloodbead Earring", 
						body="Adaman Cuirass", hands="Dusk Gloves", ring1="Phalanx Ring", ring2="Phalanx Ring", back="Valor Cape", 
						waist="Velocious Belt", legs="Gallant breeches", feet="Dusk Ledelsens"}

    sets.engaged.PDT = set_combine(sets.engaged, {})
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {})
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {})
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {}
    sets.buff.Cover = {body="Valor Surcoat"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


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
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
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

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    -- if player.sub_job == 'DNC' then
        -- set_macro_page(5, 2)
    -- elseif player.sub_job == 'NIN' then
        -- set_macro_page(4, 2)
    -- elseif player.sub_job == 'RDM' then
        -- set_macro_page(3, 2)
    -- else
        -- set_macro_page(2, 2)
    -- end
end

