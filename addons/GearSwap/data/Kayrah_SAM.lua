function get_sets()

	mote_include_version = 2
	include('Mote-Include.lua')
	
end

function user_setup()

	state.OffenseMode:options('Normal', 'Hybrid', 'Acc')
	state.WeaponskillMode:options('Normal', 'Hybrid', 'Acc')
	state.RangedMode:options('Normal', 'Hybrid', 'Acc')
	state.DefenseMode:options('Normal','PDT','MDT')

end

function init_gear_sets()

	--{ammo="",head="",neck="",ear1="",ear2="",body="",hands="",ring1="",ring2="",back="",waist="",legs="",feet=""}

	-- Idle sets
	sets.idle = {ammo="Bibiki seashell",head="Dream hat +1",neck="Chocobo whistle",ear1="Merman's earring",ear2="Merman's earring",body="Jujitsu gi",hands="Ochimusha kote",ring1="Defending ring",ring2="Merman's ring",back="Nexus cape",waist="Velocious belt",legs="Republic subligar",feet="Saotome sune-ate"}
	
	-- JA sets
	sets.precast.JA['Meditate'] = {head="Myochin Kabuto",hands="Saotome Kote"}
	sets.precast.JA['Warding Circle'] = {head="Myochin Kabuto"}
	
	sets.precast.JA['Jump'] = {}
	sets.precast.JA['High Jump'] = {}
	
	-- TP sets
	sets.engaged = {head="Walahra turban",neck="Peacock amulet",ear1="Bushinomimi",ear2="Fowling earring",body="Hachiman domaru",hands="Dusk gloves +1",ring1="Rajas ring",ring2="Sniper's ring +1",back="Cerberus mantle",waist="Velocious belt",legs="Byakko's haidate",feet="Dusk ledelsens +1"}
	sets.engaged.Hybrid = set_combine(sets.engaged, {body="Haubergeon +1",back="Cuchulain's mantle"})
	sets.engaged.Acc = set_combine(sets.engaged.Hybrid, {ring1="Sniper's ring +1"})

	-- Melee WS sets
	sets.precast.WS = {head="Gnadbhod's helm",neck="Spike necklace",ear1="Bushinomimi",ear2="Merman's earring",body="Haubergeon +1",hands="Ochimusha kote",ring1="Rajas ring",ring2="Flame ring",back="Cerberus mantle",waist="Warwolf belt",legs="Enkidu's subligar",feet="Saotome sune-ate"}
	sets.precast.WS.Hybrid = set_combine(sets.precast.WS, {body="Hachiman domaru", hands="Enkidu's mittens"})
	sets.precast.WS.Acc = set_combine(sets.precast.WS.Hybrid, {back="Cuchulain's mantle", ring2="Sniper's ring +1"})
	
	sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Snow gorget"})
	sets.precast.WS['Tachi: Yukikaze'].Hybrid = set_combine(sets.precast.WS.Hybrid, {neck="Snow gorget"})
	sets.precast.WS['Tachi: Yukikaze'].Acc = set_combine(sets.precast.WS.Acc, {neck="Snow gorget"})
	
	sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Snow gorget"})
	sets.precast.WS['Tachi: Gekko'].Hybrid = set_combine(sets.precast.WS.Hybrid, {neck="Snow gorget"})
	sets.precast.WS['Tachi: Gekko'].Acc = set_combine(sets.precast.WS.Acc, {neck="Snow gorget"})
	
	sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {neck="Flame gorget"})
	sets.precast.WS['Tachi: Kasha'].Hybrid = set_combine(sets.precast.WS.Hybrid, {neck="Flame gorget"})
	sets.precast.WS['Tachi: Kasha'].Acc = set_combine(sets.precast.WS.Acc, {neck="Flame gorget"})
	
	sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS['Tachi: Gekko'], {neck="Thunder gorget"})
	sets.precast.WS['Tachi: Shoha'].Hybrid = set_combine(sets.precast.WS['Tachi: Gekko'].Hybrid, {neck="Thunder gorget"})
	sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS['Tachi: Gekko'].Acc, {neck="Thunder gorget"})
	
	-- Ranged sets
	sets.precast.RA = {head="Enkidu's cap",body="Kirin's osode",hands="Enkidu's mittens",ring1="Rajas ring",ring2="Flame ring",back="Amemet mantle +1",waist="Buccaneer's belt",legs="Enkidu's subligar",feet="Enkidu's leggings"}
	
	sets.midcast.RA = set_combine(sets.precast.RA, {})
	sets.midcast.RA.Hybrid = set_combine(sets.precast.RA, {hands="Seiryu's kote",ring1="Sniper's ring +1", ring2="Sniper's ring +1"})
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA.Hybrid, {ring1="Merman's ring",ring2="Merman's ring"})
	
	-- Ranged WS sets
	
	-- Defense sets
	
	-- Magic sets
	sets.precast['Ninjutsu'] = {}
	
	sets.midcast['Ninjutsu'] = {}
	
	-- Misc. sets

end