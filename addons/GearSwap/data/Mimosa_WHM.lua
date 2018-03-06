function get_sets()
	
	mote_include_version = 2
	include('organizer-lib.lua')
	include('Mote-Include.lua')
	
end

function job_setup()

end

function user_setup()

	state.OffenseMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT', 'MDT')

end

function init_gear_sets()

	-- misc
	sets.MND 													= {sub="Bugard leather strap +1", head="Healer's cap", neck="Holy phial", ear1="Mamool Ja earring", ear2="Star earring", body="Errant houppelande", hands="Blessed mitts", ring1="Tamas ring", ring2="Star ring", back="Prism cape", waist="Cleric's belt", legs="Blessed trousers", feet="Cleric's duckbills"}
	sets.INT 													= {sub="Bugard leather strap +1", body="Errant houppelande", ring1="Tamas ring", ring2="Snow ring", back="Prism cape", legs="Jet seraweels"}
	sets.resting 												= {main="Chatoyant staff", sub="Bugard leather strap +1 +1", body="Errant houppelande", hands="Oracle's gloves", back="Invigorating cape",feet="Oracle's Pigaches"}
	
	--Precast Magic
	sets.precast.FC 											= {main="Chatoyant staff", sub="Magic strap", waist="Cleric's belt",feet="Rostrum pumps"}
	sets.precast.FC.Cure										= set_combine(sets.precast.FC, {feet="Cure clogs"})
	
	--Midcast Magic
	sets.midcast['Enhancing Magic'] 							= {feet="Cleric's duckbills"}
	sets.midcast['Enfeebling Magic'] 							= {neck="Spider torque", body="Healer's briault", hands="Bricta's cuffs",feet="Avocat pigaches"}
	
	sets.midcast['Healing Magic'] 								= set_combine(sets.MND, {neck="Fylgja torque +1",body="Aristocrat's coat", hands="Healer's mitts"})
	sets.midcast['Divine Magic']								= set_combine(sets.MND, {legs="Healer's pantaloons"})
	sets.midcast['Enfeebling Magic']['WhiteMagic']				= set_combine(sets.MND, {body="Healer's briault"})
	sets.midcast['Enfeebling Magic']['WhiteMagic'].Resistant	= set_combine(sets.MND, sets.midcast['Enfeebling Magic']['WhiteMagic'], {hands="Bricta's cuffs"})
	
	sets.midcast.Regen  										= set_combine(sets.midcast['Healing Magic'], {body="Cleric's briault"})
	
	sets.midcast['Dark Magic']									= set_combine(sets.INT, {})
	sets.midcast['Elemental Magic']								= set_combine(sets.INT, {})
	sets.midcast['Enfeebling Magic']['BlackMagic']				= set_combine(sets.INT, {body="Healer's briault"})
	sets.midcast['Enfeebling Magic']['BlackMagic'].Resistant	= set_combine(sets.INT, sets.midcast['Enfeebling Magic']['BlackMagic'], {hands="Bricta's cuffs"})
	
	sets.midcast.CureSelf 										= set_combine(sets.midcast['Healing Magic'], {})
	sets.midcast.FastRecast										= set_combine(sets.precast.FC, {})
	
	--Idle Sets
	sets.idle 													= {main="Kerykeion", sub="Genbu's shield", head="Cait Sith cap", neck="Chocobo whistle", ear1="Mamool Ja earring", ear2="Star earring", body="Dalmatica", hands="Healer's mitts", ring1="Merman's ring", ring2="Merman's ring", back="Hexerei cape", waist="Lycopodium sash", legs="Healer's pantaloons", feet="Healer's duckbills"}
	sets.idle.Town												= set_combine(sets.idle, {})
	sets.Kiting													= {feet="Herald's gaiters"}
	
	sets.idle.PDT												= set_combine(sets.idle, {})
	sets.idle.MDT												= set_combine(sets.idle, {ring1="Merman's ring",ring2="Merman's ring"})
	
	--Engaged Sets
	sets.engaged												= {head="Walahra turban", hands="Blessed mitts", waist="Headlong belt", legs="Blessed trousers", feet="Blessed pumps"}
	sets.engaged.Acc											= set_combine(sets.engaged, {})
	
	sets.engaged.DW												= {}
	sets.engaged.DW.Acc											= set_combine(sets.engaged.DW, {})
	
	--Weaponskill Sets
	sets.precast.WS												= {}
	sets.precast.WS.Acc											= set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Hexa Strike']								= set_combine(sets.precast.WS, {})
	sets.precast.WS['Hexa Strike'].Acc							= set_combine(sets.precast.WS['Hexa Strike'], {})

end

function job_post_midcast(spell, action, spellMap, eventArgs)

	if spellMap == 'Cure' and spell.target.type == 'SELF' then
		equip(sets.midcast.CureSelf)
	end
	
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
send_command('gs c update')
end

function job_midcast(spell, action, spellMap, eventArgs)
	
	if spell.skill == 'Enfeebling Magic' then
		equip(sets.midcast[spell.skill][spell.type])
	else 
		equip(sets.midcast[spell.skill])
    end
	
end

function job_state_change(stateField, newValue, oldValue)

	if stateField == 'Offense Mode' then
		if newValue == 'None' then
			enable('main', 'sub', 'range')
		else
			disable('main', 'sub', 'range')
		end
	end
	
end

function display_current_job_state(eventArgs)

	display_current_caster_state()
	eventArgs.handled = true
	
end