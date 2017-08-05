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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'PDT')
    
    state.MagicBurst = M(false, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}
    
	-- gear.NukeLegs = {name="Jet Seraweels"}
    -- gear.DayLegs = "Sorcerer's Tonban"
    -- gear.NormLegs = "Jet Seraweels"
	
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')

    --select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs

    sets.precast.JA.Manafont = {}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {}
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {}

    sets.midcast['Enfeebling Magic'] = {head="Wizard's Petasos", body="Wizard's coat", hands="Bricta's Cuffs"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {head="Wizard's Petasos", hands="Sorcerer's Gloves", legs="Wizard's tonban"}

    sets.midcast.Drain = {}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {}

    sets.midcast.BardSong = {}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {head="Wizard's Petasos", hands="Wizard's Gloves", body="Igqira Weskit", legs="Jet Seraweels", neck="Lemegeton medallion +1" }

    sets.midcast['Elemental Magic'].Resistant = {head="Sorcerer's Petasos", hands="Wizard's Gloves", body="Igqira Weskit", legs="Jet Seraweels", neck="Lemegeton medallion +1" }

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {})


    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {head="Wizard's Petasos", hands="Wizard's Gloves", body="Igqira Weskit"}


    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {body="Errant houppelande"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {head="Dream Hat +1", body="Sorcerer's Coat", ear1="Moldavite Earring", ear2="abyssal Earring", hands="Wizard's Gloves"
				, ring1="Tamas Ring", ring2="Defending Ring", back="Hecate's Cape", waist="Sorcerer's belt", legs="Jet Seraweels", feet="Sorcerer's Sabots", neck="Chocobo Whistle"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {head="Dream Hat +1", body="Sorcerer's Coat", ear1="Moldavite Earring", ear2="abyssal Earring", hands="Wizard's Gloves"
				, ring1="Tamas Ring", ring2="Defending Ring", back="Hecate's Cape", waist="Sorcerer's belt", legs="Jet Seraweels", feet="Sorcerer's Sabots", neck="Chocobo Whistle"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {head="Dream Hat +1", body="Sorcerer's Coat", ear1="Moldavite Earring", ear2="abyssal Earring", hands="Wizard's Gloves"
				, ring1="Tamas Ring", ring2="Defending Ring", back="Hecate's Cape", waist="Sorcerer's belt", legs="Jet Seraweels", feet="Sorcerer's Sabots", neck="Chocobo Whistle"}
    
    -- Town gear.
    sets.idle.Town = {head="Dream Hat +1", body="Sorcerer's Coat", neck="Chocobo Whistle", ear1="Moldavite Earring", ear2="abyssal Earring", hands="Wizard's Gloves"
				, ring1="Tamas Ring", ring2="Defending Ring", back="Hecate's Cape", waist="Sorcerer's belt", legs="Jet Seraweels", feet="Sorcerer's Sabots", neck="Chocobo Whistle"}
        
    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.

    sets.magic_burst = {hands="Sorcerer's gloves"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Sekhmet Corset"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
	-- if spell.element == world.day_element then
		-- gear.NukeLegs.name = gear.DayLegs
	-- else
		-- gear.NukeLegs.name = gear.NormLegs
	-- end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
-- function select_default_macro_book()
    -- set_macro_page(1, 15)
-- end

