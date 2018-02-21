function get_sets()
   
    mote_include_version = 2
    include('Mote-Include.lua')
  include('organizer-lib')
    
end

function job_setup()
   
    include('Kay-Include.lua')
    
    initialize_job()
    
end

function user_setup()
   
    state.OffenseMode:options('Normal','HybridAcc','Acc')
    state.WeaponskillMode:options('Normal','HNM')
    state.PhysicalDefenseMode:options('PDT','Breath')
    state.MagicalDefenseMode:options('MDT')
    
   state.Geirskogul = M(false, 'Geirskogul')
    
end

function init_gear_sets()
   
    --misc.
    sets.enmityUp                       = {}
    sets.enmityDown                     = {}
    
    sets.HB                             = {head="Wyrm Armet",legs="Drachen Brais",feet="Homam Gambieras"}
    sets.midcast.Breath                 = set_combine(sets.HB,{head="Saurian Helm",legs="Falconer's Hose"})
    
    --precast ja
    sets.precast.JA                     = {}
    
    sets.precast.JA['Call Wyvern']      = {body="Wyrm mail +1"}
    
    sets.precast.JA['Jump']             = {ammo="Black tathlum"
                                          ,head="Gnadbhod's helm"   ,neck="Love torque"       ,ear1="Fowling earring" ,ear2="Brutal earring"
                                          ,body="Barone corazza"    ,hands="Tarasque mitts +1",ring1="Rajas ring"     ,ring2="Strigoi ring"
                                          ,back="Cerberus mantle +1",waist="Warwolf belt"     ,legs="Barone cosciales",feet="Drachen greaves"}
    sets.precast.JA['High Jump']        = {body="Barone corazza",legs="Barone cosciales"}
    sets.precast.JA['Super Jump']       = {}
    sets.precast.JA['Ancient Circle']   = {legs="Drachen brais"}
    
    sets.precast.JA['Spirit Link']      = {head="Drachen armet +1"}
    
    sets.precast.JA['Angon']            = {ammo="Angon"}
    
    --precast magic
    sets.precast.FC                     = {ear2="Loquacious earring",legs="Homam cosciales"}
    
    --midcast magic
    sets.midcast.FastRecast             = set_combine(sets.precast.FC,{head="Walahra turban",body="Wyrm mail +1",hands="Dusk gloves +1",waist="Velocious belt",feet="Homam gambieras"})
    
    sets.midcast['Utsusemi: Ni']        = set_combine(sets.midcast.FastRecast,{neck="Fortified chain",ear1="Magnetic earring",ring1="Defending ring",ring2="Antica ring",back="Boxer's mantle"})
    sets.midcast['Utsusemi: Ichi']      = set_combine(sets.midcast['Utsusemi: Ni'],{waist="Resolute belt"})
    
    --idle
    sets.idle                           = {ammo="Bibiki seashell"
                                          ,head="Crimson mask"  ,neck="Chocobo whistle"        ,ear1="Merman's earring",ear2="Merman's earring"
                                          ,body="Barone corazza",hands="Blood finger gauntlets",ring1="Defending ring" ,ring2="Shadow ring"
                                          ,back="Shadow mantle" ,waist="Resolute belt"         ,legs="Blood cuisses"   ,feet="Homam gambieras"}
    sets.idle.Town                      = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
    
    sets.idle.Resting                   = {}
    
    --defense
    sets.defense.PDT                    = {ammo="Bibiki seashell",head="Darksteel cap +1",neck="Wivre gorget +1",body="Darksteel harness +1",ring1="Defending ring",ring2="Jelly ring",back="Shadow mantle",legs="Darksteel subligar +1"}
    sets.defense.MDT                    = {ring1="Defending ring",ring2="Shadow ring"}
    ----------------------------
    --sets.defense.Breath = {}--
    ----------------------------
    
    --default engaged
    sets.engaged                        = {ammo="Black tathlum"
                                          ,head="Walahra turban"    ,neck="Love torque"    ,ear1="Merman's earring"   ,ear2="Brutal earring"
                                          ,body="Wyrm mail +1"      ,hands="Dusk gloves +1",ring1="Rajas ring"        ,ring2=gear.TRing1
                                          ,back="Cerberus mantle +1",waist="Velocious belt",legs="Barbarossa's zerehs",feet="Dusk ledelsens +1"}
    sets.engaged.HybridAcc              = set_combine(sets.engaged,{ear1="Fowling earring",back="Cuchulain's mantle",legs="Homam cosciales",feet="Homam gambieras"})
    sets.engaged.Acc                    = set_combine(sets.engaged.HybridAcc,{hands="Homam manopolas"})
    
    --engaged (sam)
    sets.engaged.SAM                    = {ammo="White tathlum"
                                          ,head="Walahra turban",neck="Love torque",ear1="Merman's earring",ear2="Brutal earring"
                                          ,body="Aurum cuirass",hands="Dusk gloves +1",ring1="Rajas ring",ring2=gear.TRing1
                                          ,back="Cerberus mantle +1",waist="Velocious belt",legs="Barbarossa's zerehs",feet="Dusk ledelsens +1"}
    sets.engaged.HybridAcc.SAM          = set_combine(sets.engaged.SAM,{ear1="Fowling earring",back="Cuchulain's mantle",legs="Homam cosciales",feet="Homam gambieras"})
    sets.engaged.Acc.SAM                = set_combine(sets.engaged.HybridAcc.SAM,{hands="Homam manopolas"})
    
    --ws
    sets.precast.WS                     = {ammo="Black tathlum"
                                          ,head="Gnadbhod's helm"   ,neck="Fotia gorget"          ,ear1="Merman's earring"    ,ear2="Brutal earring"
                                          ,body="Aurum cuirass"     ,hands="Alkyoneus's bracelets",ring1="Rajas ring"         ,ring2="Strigoi ring"
                                          ,back="Cerberus mantle +1",waist="Warwolf belt"         ,legs="Hecatomb subligar +1",feet="Conte gambieras"}
    sets.precast.WS.HNM                 = set_combine(sets.precast.WS,{ear1="Fowling earring",hands="Tarasque mitts +1"})
    
    sets.precast.WS['Penta Thrust']     = set_combine(sets.precast.WS,{hands="Tarasque mitts +1",waist="Potent belt"})
    sets.precast.WS['Penta Thrust'].HNM = set_combine(sets.precast.WS.HNM,{ring2=gear.TRing1,back="Cuchulain's mantle",waist="Potent belt"})
    
    sets.precast.WS['Stardiver']        = set_combine(sets.precast.WS['Penta Thrust'],{})
    sets.precast.WS['Stardiver'].HNM    = set_combine(sets.precast.WS['Penta Thrust'].HNM,{})
    
    sets.precast.WS['Geirskogul']       = set_combine(sets.precast.WS,{hands="Tarasque mitts +1",waist="Swordbelt +1"})
    sets.precast.WS['Geirskogul'].HNM   = set_combine(sets.precast.WS.HNM,{waist="Swordbelt +1"})
    
    sets.precast.WS['Drakesbane']       = set_combine(sets.precast.WS,{head="Hecatomb cap +1",body="Zahak's mail",hands="Hecatomb mittens +1",ring2=gear.CritRing,feet="Hecatomb leggings +1"})
    sets.precast.WS['Drakesbane'].HNM   = set_combine(sets.precast.WS.HNM,{hands="Hecatomb mittens +1",ring2=gear.CritRing,feet="Hecatomb leggings +1"})
    
end

function job_post_precast(spell,action,spellMap,eventArgs)

	if spell.type == 'WeaponSkill' then
        if daytime and state.WeaponskillMode.value == 'Normal' then
            equip({ear1="Fenrir's earring"})
        end
        if spell.name == 'Geirskogul' then
            send_command('gs c toggle Geirskogul')
        else
            send_command('gs c reset Geirskogul')
        end
	end
	if spell.type == 'JobAbility' then
		if state.Tank.value then
			equip(set_combine(sets.enmityUp,sets.precast.JA[spell.english]) or sets.enmityUp)
		else
			equip(set_combine(sets.enmityDown,sets.precast.JA[spell.english]) or sets.enmityDown)
		end
	end
	
end
    
function job_pet_midcast(spell, action, spellMap, eventArgs)

    if spell.english:startswith('Healing Breath') then
		equip(sets.HB)
    else
        equip(sets.midcast.Breath)
	end
        
end
    
function job_midcast(spell, action, spellMap, eventArgs)

	if spell.action_type == 'Magic' then
	    equip(set_combine(sets.midcast.FastRecast,{head="Drachen Armet"}))
	end
        
end

function job_buff_change(name,gain)

	sleep_swap(name,gain)

end

function customize_idle_set(idleSet)
    
	if daytime then
		idleSet = set_combine(idleSet,{waist="Lycopodium sash"})
	end
    return idleSet
    
end

function adjust_melee_groups()

	classes.CustomMeleeGroups:clear()
	if player.sub_job == 'SAM' then
		classes.CustomMeleeGroups:append('SAM')
	end
	
end

function customize_melee_set(meleeSet)

    
	if state.OffenseMode.value == 'Normal' and daytime then
        meleeSet = set_combine(meleeSet, {ear1="Fenrir's earring"})
    end
    if state.Geirskogul.value and player.sub_job == 'SAM' then
       meleeSet = set_combine(meleeSet,{neck="Chivalrous chain"}) 
    end
    return meleeSet
	
end

function job_status_change(new,old)

	adjust_melee_groups()
	
end