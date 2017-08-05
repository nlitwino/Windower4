-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()

    mote_include_version = 2
    include('Mote-Include.lua')
	
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

    state.Buff['Footwork'] = buffactive.Footwork or false
    state.Buff['Hundred Fists'] = buffactive.Footwork or false
	
	include('Kay-Include.lua')
	
	initialize_job()


end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()

    state.OffenseMode:options('Normal','Acc','HNM')
	state.WeaponskillMode:options('Normal','Acc','HNM')
	state.PhysicalDefenseMode:options('Counterstance','PDT')
	state.MagicalDefenseMode:options('MDT')
	
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind f10 gs c cycle WeaponskillMode')
	send_command('bind f11 gs c cycle PhysicalDefenseMode')
	send_command('bind f12 gs c cycle MagicalDefenseMode')

    select_default_macro_book()
	
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Misc. Sets
	sets.resting						 	= {neck="Orochi nodowa",body="Melee cyclas",back="Melee cape"}
		
	sets.enmity							 	= {back="Cerberus mantle +1",waist="Warwolf belt"}
		
	-- Buff Sets	
		
	-- Precast JAs (MNK)	
	sets.precast.JA = sets.enmity	
	sets.precast.JA['Focus']			 	= set_combine(sets.precast.JA,{head="Temple crown"})
	sets.precast.JA['Dodge']			 	= set_combine(sets.precast.JA,{feet="Temple gaiters"})
	sets.precast.JA['Chakra']			 	= set_combine(sets.precast.JA,{head="Genbu's kabuto",body="Temple cyclas",hands="Melee gloves",ring2="Bastokan ring",back="Melee cape",waist="Warwolf belt",legs="Kensei sitabaki"})
	sets.precast.JA['Boost']			 	= set_combine(sets.precast.JA,{hands="Temple gloves"})
	sets.precast.JA['Counterstance']	 	= set_combine(sets.precast.JA,{feet="Melee gaiters"})
	sets.precast.JA['Chi Blast']		 	= set_combine(sets.precast.JA,{head="Temple crown",neck="Gnole torque",ear1="Mamool Ja earring",body="Kirin's osode",back="Melee cape",feet="Suzaku's sune-ate"})
		
	-- Precast Magic	
	sets.precast.FC						 	= {}
		
	-- Midcast Magic	
	sets.midcast.FastRecast				 	= {}
	sets.midcast['Ninjutsu']			 	= {ring2="Antica ring"}
		
	-- Idle Sets	
	sets.idle							 	= {ammo="Bibiki seashell"
											  ,head="Genbu's kabuto"   ,neck="Chocobo whistle" ,ear1="Merman's earring",ear2="Merman's earring"
											  ,body="Melee cyclas"     ,hands="Melee gloves"   ,ring1="Defending ring" ,ring2="Merman's ring"
											  ,back="Kinesis mantle +1",waist="Lycopodium sash",legs="Byakko's haidate",feet="Hermes' sandals"}
		
	sets.idle.Town						 	= set_combine(sets.idle,{})
		
	sets.Kiting							 	= {feet="Hermes' sandals"}
		
	-- Defense Sets	
	sets.defense.Counterstance = {}
	sets.defense.PDT = {}
	
		
	-- TP Sets	
    sets.engaged						 	= {ammo="Black tathlum"
	                                          ,head="Walahra turban" ,neck="Peacock amulet",ear1="Bushinomimi"     ,ear2="Pixie earring"
											  ,body="Kirin's osode"  ,hands="Melee gloves" ,ring1="Rajas ring"     ,ring2="Flame ring"
											  ,back="Cerberus mantle +1",waist="Black belt"   ,legs="Byakko's haidate",feet="Sarutobi kyahan"}
	sets.engaged.Acc					 	= set_combine(sets.engaged,{body="Scorpion harness +1",ring2="Sniper's ring +1",back="Cuchulain's mantle"})
	sets.engaged.HNM					 	= set_combine(sets.engaged.Acc,{})
		
	--sets.engaged['HF'] = {}	
		
    -- Weaponskill Sets	
	sets.precast.WS						 	= {head="Maat's cap",neck="Spike necklace",ear1="Merman's earring",ear2="Merman's earring",body="Kirin's osode",hands="Ochimusha kote",ring1="Rajas ring",ring2="Flame ring",back="Cerberus mantle",waist="Warwolf belt",legs="Enkidu's subligar",feet="Enkidu's leggings"}
	sets.precast.WS.Acc					 	= set_combine(sets.precast.WS,{body="Scorpion's harness +1",ring1="Sniper's ring +1",ring2="Sniper's ring +1"})
	sets.precast.WS.HNM					 	= set_combine(sets.precast.WS.Acc,{})
		
	sets.precast.WS['Asuran Fists']		 	= {head="Maat's cap",neck="Flame gorget",ear1="Merman's earring",ear2="Merman's earring",body="Kirin's osode",hands="Ochimusha kote",ring1="Rajas ring",ring2="Flame ring",back="Cerberus mantle",waist="Warwolf belt",legs="Enkidu's subligar",feet="Enkidu's leggings"}
	sets.precast.WS['Asuran Fists'].Acc	 	= set_combine(sets.precast.WS['Asuran Fists'],{body="Scorpion's harness +1",ring1="Sniper's ring +1",ring2="Sniper's ring +1"})
	sets.precast.WS['Asuran Fists'].HNM	 	= set_combine(sets.precast.WS['Asuran Fists'].Acc,{})
		
	sets.precast.WS['Dragon Kick']		 	= set_combine(sets.precast.WS,{neck="Spike necklace",ear1="Bushinomimi"})
	sets.precast.WS['Dragon Kick'].Acc	 	= set_combine(sets.precast.WS['Dragon Kick'].Acc,{neck="Breeze gorget"})
	sets.precast.WS['Dragon Kick'].HNM	 	= set_combine(sets.precast.WS['Dragon Kick'].Acc,{})
		
	sets.precast.WS['Victory Smite']	 	= set_combine(sets.precast.WS['Asuran Fists'],{neck="Thunder gorget"})
	sets.precast.WS['Victory Smite'].Acc	 = set_combine(sets.precast.WS['Asuran Fists'],{neck="Thunder gorget"})
	sets.precast.WS['Victory Smite'].HNM	 = set_combine(sets.precast.WS['Asuran Fists'].HNM,{neck="Thunder gorget"})
	
end