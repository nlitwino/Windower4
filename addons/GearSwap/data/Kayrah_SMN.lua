-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
    Custom commands:
    
    gs c siphon
        Automatically run the process to: dismiss the current avatar; cast appropriate
        weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
        and re-summon the avatar.
        
        Will not cast weather you do not have access to.
        Will not re-summon the avatar if one was not out in the first place.
        Will not release the spirit if it was out before the command was issued.
        
    gs c pact [PactType]
        Attempts to use the indicated pact type for the current avatar.
        PactType can be one of:
            cure
            curaga
            buffOffense
            buffDefense
            buffSpecial
            debuff1
            debuff2
            sleep
            nuke2
            nuke4
            bp70
            bp75 (merits and lvl 75-80 pacts)
            astralflow
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

	include('Kay-Include.lua')
	
	initialize_job()

    spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith"}

    magicalRagePacts = S{
        'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen',
        'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
        'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV',
        'Thunderspark','Burning Strike','Meteorite','Nether Blast','Flaming Crush',
        'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm',
        'Holy Mist','Lunar Bay','Night Terror','Level ? Holy'}


    pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby'}
    pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
    pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega', ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl'}
    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II'}
    pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',
        ['Carbuncle']='Soothing Ruby', ['Fenrir']='Heavenward Howl', ['Cait Sith']='Raise II'}
    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye'}
    pacts.debuff2 = {['Shiva']='Sleepga', ['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence'}
    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}
    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV'}
    pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
        ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
        ['Diabolos']='Nether Blast',['Cait Sith']='Regal Scratch'}
    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy'}
    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor"}

    -- Wards table for creating custom timers   
    wards = {}
    -- Base duration for ward pacts.
    wards.durations = {
        ['Crimson Howl'] = 60, ['Earthen Armor'] = 60, ['Inferno Howl'] = 60, ['Heavenward Howl'] = 60,
        ['Rolling Thunder'] = 120, ['Fleet Wind'] = 120,
        ['Shining Ruby'] = 180, ['Frost Armor'] = 180, ['Lightning Armor'] = 180, ['Ecliptic Growl'] = 180,
        ['Glittering Ruby'] = 180, ['Hastega'] = 180, ['Noctoshield'] = 180, ['Ecliptic Howl'] = 180,
        ['Dream Shroud'] = 180,
        ['Reraise II'] = 3600
    }
    -- Icons to use when creating the custom timer.
    wards.icons = {
        ['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
        ['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
        ['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
        ['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
        ['Inferno Howl']    = 'spells/00298.png', -- 00298 for Ifrit
        ['Hastega']         = 'spells/00358.png', -- 00358 for Hastega
        ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
        ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
        ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
        ['Reraise II']      = 'spells/00135.png', -- 00135 for Reraise
        ['Fleet Wind']      = 'abilities/00074.png', -- 
    }
    -- Flags for code to get around the issue of slow skill updates.
    wards.flag = false
    wards.spell = ''
	
	set_macro_page(1,15)
    
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()

    gear.perp_staff = {main="Claustrum"}
	
	set_macro_page(1,15)
	
end


-- Define sets and vars used by this job file.
function init_gear_sets()

	-- misc
	sets.MND                                                = {head="Maat's cap"        ,neck="Gnole torque"   ,ear1="Mamool Ja earring"
															  ,body="Errant houppelande",hands="Bricta's cuffs",ring1="Tamas ring"
															  ,back="Prism cape"                               ,legs="Mahatma slops",feet="Rostrum pumps"}
															  
	sets.INT                                                = {ammo="Phantom tathlum"
															  ,head="Maat's cap"        ,neck="Lemegeton medallion +1",ear1="Abyssal earring",ear2="Morion earring +1"
															  ,body="Errant houppelande",hands="Errant cuffs"         ,ring1="Tamas ring"    ,ring2="Snow ring"
															  ,back="Prism cape"        ,waist="Ocean stone"          ,legs="Mahatma slops"  ,feet="Rostrum pumps"}
	
    -- precast JA
    sets.precast.JA 										= {body="Errant houppelande",hands="Errant cuffs",waist="Buccaneer's belt",legs="Jet seraweels",feet="Avocat pigaches"}
	
	sets.precast.JA['Elemental Siphon']						= set_combine(sets.precast.JA,{head="Evoker's horn",hands="Summoner's bracers",ring2="Evoker's ring",back="Astute cape",legs="Oracle's braconi",feet="Nashira crackows"})
   
   -- bp precast
    sets.precast.BloodPactWard 								= set_combine(sets.precast.JA['Elemental Siphon'],{head="Summoner's horn",body="Yinyang robe",hands="Summoner's bracers",legs="Summoner's spats",feet="Summoner's pigaches"})
    sets.precast.BloodPactRage 								= sets.precast.BloodPactWard

    -- Fast cast sets for spells
    sets.precast.FC 										= {ear2="Loquacious earring",feet="Rostrum pumps"}
	sets.precast.FastRecast 								= {head="Walahra turban"}
       
	-- midcast magic
	sets.midcast['Healing Magic'] 							= set_combine(sets.MND,{ammo="Sturm's report",neck="Fylgja torque +1",ear1="Roundel earring"})
	sets.midcast['Divine Magic'] 							= set_combine(sets.MND,{ammo="Sturm's report",back="Prism cape"})
	
	sets.midcast['Enfeebling Magic']      					= {ammo="Sturm's report",head="Elite beret",neck="Spider torque",hands="Oracle's gloves",feet="Avocat pigaches"}
	sets.midcast['Enfeebling Magic']['BlackMagic']          = set_combine(sets.INT,sets.midcast['Enfeebling Magic'],{back="Prism cape"})
	sets.midcast['Enfeebling Magic']['WhiteMagic']          = set_combine(sets.MND,sets.midcast['Enfeebling Magic'],{back="Prism cape"})
	
	sets.midcast['Elemental Magic']            				= set_combine(sets.INT,{head="Oracle's cap",body="Oracle's robe",hands="Zenith mitts",back="Prism cape",feet="Numerist pumps"})
	
	sets.midcast['Dark Magic'] 								=  set_combine(sets.INT,{ammo="Sturm's report",neck="Dark torque",back="Prism cape"})
	
	-- avatar pacts
    sets.midcast.BloodPactWard 						    	= set_combine(sets.precast.JA['Elemental Siphon'],{head="Evoker's horn",hands="Summoner's bracers",legs="Oracle's braconi"})
    sets.midcast.DebuffBloodPactWard 				    	= set_combine(sets.midcast.Pet.BloodPactWard,{})
    sets.midcast.PhysicalBloodPactRage 				    	= set_combine(sets.midcast.Pet.BloodPactWard,{body="Summoner's doublet",legs="Evoker's spats"})
    sets.midcast.MagicalBloodPactRage 				    	= set_combine(sets.midcast.Pet.BloodPactWard,{})


    -- Spirits cast magic spells, which can be identified in standard ways.
    sets.midcast.Pet.WhiteMagic 							= {legs="Summoner's Spats"}
    sets.midcast.Pet['Elemental Magic'] 					= set_combine(sets.midcast.Pet.MagicalBloodPactRage, {legs="Summoner's Spats"})
	
    -- Resting sets
    sets.resting 											= {main="Claustrum",ammo="Bibiki seashell",head="Oracle's cap",neck="Gnole torque",body="Oracle's robe",hands="Oracle's gloves",legs="Oracle's braconi",feet="Avocat pigaches"}
    
    -- Idle sets
    sets.idle		 										= {ammo="Bibiki seashell"
															  ,head="Elite beret"    ,neck="Chocobo whistle"  ,ear1="Ethereal earring",ear2="Merman's earring"
															  ,body="Dalmatica"      ,hands="Evoker's bracers",ring1="Defending ring" ,ring2="Shadow ring"
															  ,back="Shadow mantle"  ,waist="Lycopodium sash" ,legs="Evoker's spats"  ,feet="Herald's gaiters"}
    sets.idle.Avatar 										= set_combine(sets.idle,{body="Yinyang robe",ring2="Evoker's ring",feet="Evoker's pigaches +1"})
    sets.idle.Spirit 										= set_combine(sets.idle,{body="Yinyang robe",ring2="Evoker's ring",feet="Evoker's pigaches +1"})
    sets.idle.Town 	 										= set_combine(sets.idle,{back="Nexus cape",ring2="Warp ring"})

    -- Favor uses Caller's Horn instead of Convoker's Horn for refresh
    sets.idle.Avatar.Melee                                  = set_combine(sets.idle.Avatar,{})
                                                            
    sets.perp 				                                = {body="Yinyang robe",hands="Nashira gages",ring2="Evoker's ring",feet="Evoker's pigaches +1"}
    sets.perp.Day 			                                = {body="Summoner's doublet"}
    sets.perp.Weather 		                                = {head="Summoner's horn"}
    sets.perp.Carbuncle 	                                = {hands="Carbuncle mitts"}
    sets.perp.Garuda     	                                = {head="Karura hachigane"}
    sets.perp.Alexander 	                                = sets.midcast.Pet.BloodPactWard

    sets.perp.staff_and_grip                                = {main=gear.perp_staff}
    
    -- engaged
    sets.engaged 											= {head="Walahra turban",neck="Peacock amulet",ear2="Brutal earring",ring1="Toreador's ring",ring2="Toreador's ring"}
	
	-- ws
	sets.precast.WS 										= set_combine(sets.INT,{neck="Snow gorget",ear2="Brutal earring"})
end

function job_midcast(spell, action, spellMap, eventArgs)

    	-- handle different equipsets for White and Black magic
	if spell.skill == 'Enfeebling Magic' then
		equip(sets.midcast[spell.skill][spell.type])
	else 
		equip(sets.midcast[spell.skill])
    end
	
end

function job_post_midcast(spell,action,spellMap,eventArgs)

	if spell.skill == 'Elemental Magic' then
		if spell.element == world.day_element or spell.element == world.weather_element then
			equip({waist="Hachirin-no-obi"})
		end
	end
	
	if spellMap == 'Cure' then
		if not (world.weather_element == 'Dark' or world.day_element == 'Dark') then
			equip({waist="Hachirin-no-obi"})
		end
	end

end

-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

    if not spell.interrupted and spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
        wards.flag = true
        wards.spell = spell.english
        send_command('wait 4; gs c reset_ward_flag')
    end
	
end



function job_buff_change(buff, gain)

	sleep_swap(name,gain)

    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
	
end


-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
	
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)

    classes.CustomIdleGroups:clear()
	
    if gain then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
	
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
    if spell.type == 'BloodPactRage' then
        if magicalRagePacts:contains(spell.english) then
            return 'MagicalBloodPactRage'
        else
            return 'PhysicalBloodPactRage'
        end
    elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
        return 'DebuffBloodPactWard'
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        if pet.element == world.day_element then
            idleSet = set_combine(idleSet, sets.perp.Day)
        end
        if pet.element == world.weather_element then
            idleSet = set_combine(idleSet, sets.perp.Weather)
        end
        if sets.perp[pet.name] then
            idleSet = set_combine(idleSet, sets.perp[pet.name])
        end
		
        gear.perp_staff.name = elements.perpetuance_staff_of[pet.element]
		
        if gear.perp_staff.name and (player.inventory[gear.perp_staff.name] or player.wardrobe[gear.perp_staff.name]) then
            idleSet = set_combine(idleSet, sets.perp.staff_and_grip)
        end
        if pet.status == 'Engaged' then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
        end
		
    end
    
    return idleSet
	
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)

    classes.CustomIdleGroups:clear()
	
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
	
end

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

    if cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'pact' then
        handle_pacts(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    end
	
end


-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end

    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
    
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
    end
    
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() > 0 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
    
    local command = ''
    local releaseWait = 0
    
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
    
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
    
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
        
        command = command..'input /pet "Release" <me>;'
    end
    
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
    
    send_command(command)
end


-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use pacts in town.')
        return
    end

    if not pet.isvalid then
        add_to_chat(122,'No avatar currently available. Returning to default macro set.')
        select_default_macro_book('reset')
        return
    end

    if spirits:contains(pet.name) then
        add_to_chat(122,'Cannot use pacts with spirits.')
        return
    end

    if not cmdParams[2] then
        add_to_chat(123,'No pact type given.')
        return
    end
    
    local pact = cmdParams[2]:lower()
    
    if not pacts[pact] then
        add_to_chat(123,'Unknown pact type: '..tostring(pact))
        return
    end
    
    if pacts[pact][pet.name] then
        if pact == 'astralflow' and not buffactive['astral flow'] then
            add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
            return
        end
        
        -- Leave out target; let Shortcuts auto-determine it.
        send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
        add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
end