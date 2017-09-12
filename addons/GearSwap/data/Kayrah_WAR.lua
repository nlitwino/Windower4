function get_sets()

	mote_include_version = 2
	include('Mote-Include.lua')
	
end

function job_setup()

	state.Buff['Mighty Strikes']    = buffactive['Mighty Strikes'] or false
	state.Buff['Warrior\'s Charge'] = buffactive['Warrior\'s Charge'] or false
	
	include('Kay-Include.lua')
	
	initialize_job()
	
end

function user_setup()

	state.OffenseMode:options('Normal','Acc')
	state.WeaponskillMode:options('Normal','HNM')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	
end

function init_gear_sets()

	--Misc.
	sets.resting                            = {}
	sets.enmity                             = {head="Warrior's mask",body="Warrior's lorica",hands="Warrior's mufflers",ring2="Hercules' ring",back="Cerberus mantle +1",waist="Trance belt",legs="Warrior's cuisses",feet="Warrior's calligae"}
	
	--Buff Sets
	
	--Precast JAs
	sets.precast.JA['Provoke']              = sets.enmity
	sets.precast.JA['Warcry']               = {head="Warrior's mask"}
	                                        
	sets.precast.JA['Tomahawk']             = {ammo="Thr. Tomahawk"}
	
	--Precast Magic
	sets.precast.FC                         = {ear2="Loquacious earring"}
	
	--Midcast Magic
	sets.midcast.FastRecast                 = set_combine(sets.precast.FC,{head="Walahra turban",ear2="Magnetic earring",hands="Dusk gloves +1",waist="Velocious belt",legs="Byakko's haidate",feet="Dusk ledelsens +1"})
	
	sets.midcast['Ninjutsu']                = set_combine(sets.midcast.FastRecast,{neck="Fortified chain",ring2="Antica ring",back="Shadow mantle"})
	
	--Idle Sets
	sets.idle                               = {ammo="Bibiki seashell"
	                                            ,head="Genbu's kabuto" ,neck="Chocobo whistle" ,ear1="Merman's earring" ,ear2="Merman's earring"
												,body="Barone corazza" ,hands="Heavy gauntlets",ring1="Defending ring"  ,ring2="Shadow ring"
												,back="Shadow mantle"  ,waist="Lycopodium sash",legs="Koenig diechlings",feet="Hermes' sandals"}
	sets.idle.Town                          = set_combine(sets.idle,{ring2="Warp ring",back="Nexus cape"})
	
	--Defense Sets
	sets.defense.PDT                        = {body="Valhalla breastplate",hands="Heavy gauntlets",ring1="Defending ring",ring2="Jelly ring"}
	sets.defense.MDT                        = {ammo="Bibiki seashell",body="Valhalla breastplate",ear1="Merman's earring",ear2="Merman's earring",ring1="Defending ring",ring2="Shadow ring",feet="Merman's leggings"}
	
	
	-- default engaged
	sets.engaged                            = {ammo="Bomb core"
								          	  ,head="Walahra turban"    ,neck="Chivalrous chain",ear1="Bushinomimi"     ,ear2="Brutal earring"
								          	  ,body="Armada hauberk"    ,hands="Dusk gloves +1" ,ring1=gear.TRing2      ,ring2=gear.TRing1
								           	  ,back="Cerberus mantle +1",waist="Velocious belt" ,legs="Byakko's haidate",feet="Dusk ledelsens +1"}
	sets.engaged.Acc                        = set_combine(sets.engaged,{ammo="Fire bomblet",neck="Ancient torque",ear1="Fowling earring",back="Cuchulain's mantle",feet="Aurum sabatons"})
	
	-- bravura engaged (normal) [[Rose strap]]  
	sets.engaged.Bravura                    = set_combine(sets.engaged,{body="Aurum cuirass",ring1="Rajas ring"})
	sets.engaged.Bravura.Acc                = set_combine(sets.engaged.Bravura,{ammo="Fire bomblet",neck="Ancient torque",ear1="Fowling earring",back="Cuchulain's mantle",feet="Aurum sabatons"})
								  
	-- bravura engaged (SAM) [[Pole grip]]     
	sets.engaged.Bravura.SAM                = set_combine(sets.engaged,{})
	sets.engaged.Bravura.SAM.Acc            = set_combine(sets.engaged.Bravura.SAM,{ammo="Fire bomblet",ear1="Fowling earring",back="Cuchulain's mantle",feet="Aurum sabatons"})
	                              
	-- ragnarok engaged (normal)  
	sets.engaged.Ragnarok                   = {ammo="Bomb core"
									          ,head="Walahra turban"   ,neck="Chivalrous chain",ear1="Fowling earring" ,ear2="Brutal earring"
									          ,body="Hachiryu haramaki",hands="Dusk gloves +1" ,ring1="Rajas ring"     ,ring2=gear.TRing1
									          ,back="Bushido cape"     ,waist="Velocious belt" ,legs="Byakko's haidate",feet="Dusk ledelsens +1"}
	sets.engaged.Ragnarok.Acc               = set_combine(sets.engaged.Ragnarok,{ammo="Fire bomblet",neck="Ancient torque",hands="Hachiryu kote",back="Cuchulain's mantle"})
	
	-- ragnarok engaged (SAM)
	sets.engaged.Ragnarok.SAM               = {ammo="White tathlum"
								              ,head="walahra turban"    ,neck="Chivalrous chain",ear1="Fowling earring" ,ear2="Brutal earring"
								              ,body="Aurum cuirass"     ,hands="Dusk gloves +1" ,ring1="Rajas ring"     ,ring2=gear.TRing1
								              ,back="Cerberus mantle +1",waist="Velocious belt" ,legs="Byakko's haidate",feet="Dusk ledelsens +1"}
	sets.engaged.Ragnarok.SAM.Acc 			= set_combine(sets.engaged.Ragnarok.SAM,{back="Cuchulain's mantle"})
				
	-- dual wield engaged			
	sets.engaged.DW               			= set_combine(sets.engaged,{ear1="Suppanomimi",ring1=gear.TRing2})
	sets.engaged.DW.Acc           			= set_combine(sets.engaged.DW,{ammo="Fire bomblet",back="Cuchulain's mantle",feet="Aurum sabatons"})
	
	--Weaponskill Sets
	sets.precast.WS                         = {ammo="Bomb core"
					                          ,head="Hecatomb cap +1"      ,neck="Fotia gorget"                                  ,ear2="Brutal earring"
					                          ,body="Armada hauberk"    ,hands="Alkyoneus's bracelets",ring1="Rajas ring"     ,ring2="Flame ring"
					                          ,back="Cerberus mantle +1",waist="Warwolf belt"         ,legs="Hachiryu haidate",feet="Hecatomb leggings +1"}
	sets.precast.WS.Acc                     = set_combine(sets.precast.WS,{ammo="Fire bomblet",ear1="Fowling earring",back="Cuchulain's mantle",waist="Warrior's stone"})
	
	----Sword
	sets.precast.WS['Vorpal Blade']         = set_combine(sets.precast.WS,{body="Zahak's mail",hands="Hecatomb mittens +1",back="Cuchulain's mantle"})
	sets.precast.WS['Vorpal Blade'].Acc     = set_combine(sets.precast.WS['Vorpal Blade'],{ammo="Fire bomblet",waist="Warrior's stone"})
	                                        
	sets.precast.WS['Requiescat']           = set_combine(sets.precast.WS['Vorpal Blade'],{})
	sets.precast.WS['Requiescat'].Acc       = set_combine(sets.precast.WS['Vorpal Blade'].Acc,{})
	                                        
	----Sword MS                            
	sets.precast.WS['Vorpal Blade'].MS      = set_combine(sets.precast.WS['Vorpal Blade'],{body="Armada hauberk",hands="Alkyoneus's bracelets"})
	sets.precast.WS['Vorpal Blade'].Acc.MS  = set_combine(sets.precast.WS['Vorpal Blade'].MS,{ammo="Fire bomblet",waist="Warrior's stone"})
	                                        
	sets.precast.WS['Requiescat'].MS        = set_combine(sets.precast.WS['Vorpal Blade'].MS,{})
	sets.precast.WS['Requiescat'].Acc.MS    = set_combine(sets.precast.WS['Vorpal Blade'].Acc.MS,{})
	                                        
	----Great Axe                           
	sets.precast.WS['Raging Rush']          = set_combine(sets.precast.WS,{body="Zahak's mail",hands="Hecatomb mittens +1",back="Cuchulain's mantle"})
	sets.precast.WS['Raging Rush'].Acc      = set_combine(sets.precast.WS['Raging Rush'],{ammo="Fire bomblet",ear1="Fowling earring",waist="Warrior's stone"})
	                                        
	sets.precast.WS['Upheaval']             = set_combine(sets.precast.WS['Raging Rush'],{})
	sets.precast.WS['Upheaval'].Acc         = set_combine(sets.precast.WS['Raging Rush'].Acc,{})
	
	sets.precast.WS['Metatron Torment']     = set_combine(sets.precast.WS,{neck="Light gorget"})
	sets.precast.WS['Metatron Torment'].Acc = set_combine(sets.precast.WS['Metatron Torment'],{ammo="Fire bomblet",ear1="Fowling earring",waist="Warrior's stone"}) 
	
	sets.precast.WS['Steel Cyclone']        = set_combine(sets.precast.WS,{head="Maat's cap",body="Kirin's osode",waist="Warwolf belt"})
	sets.precast.WS['Steel Cyclone'].Acc    = set_combine(sets.precast.WS['Steel Cyclone'],{ammo="Fire bomblet",ear2="Fowling earring",ring2="Corneus ring",back="Cuchulain's mantle"})
	                    
	----Great Axe MS                        
	sets.precast.WS['Raging Rush'].MS       = set_combine(sets.precast.WS['Raging Rush'],{body="Armada hauberk",hands="Alkyoneus's bracelets"})
	sets.precast.WS['Raging Rush'].Acc.MS   = set_combine(sets.precast.WS['Raging Rush'].MS,{ammo="Fire bomblet",ear1="Fowling earring",waist="Warrior's stone"})
	                                        
	sets.precast.WS['Upheaval'].MS          = set_combine(sets.precast.WS['Raging Rush'].MS,{})
	sets.precast.WS['Upheaval'].Acc.MS      = set_combine(sets.precast.WS['Raging Rush'].Acc.MS,{})
	
	----Greatsword
	sets.precast.WS['Scourge']              = set_combine(sets.precast.WS,{})
	sets.precast.WS['Scourge'].Acc          = set_combine(sets.precast.WS['Scourge'],{})
	
	sets.precast.WS['Resolution']           = set_combine(sets.precast.WS,{hands="Hecatomb mittens +1",back="Cerberus mantle +1",waist="Warrior's stone"})
	sets.precast.WS['Resolution'].Acc       = set_combine(sets.precast.WS['Resolution'],{})

end

function job_post_precast(spell,action,spellMap,eventsArgs)

	if daytime and spell.skill == 'WeaponSkill' then
		if state.Buff['Warrior\'s Charge'] then
			equip({ear2="Fenrir's earring"})
		else
			if state.WeaponskillMode.value == 'Normal' then
				equip({ear1="Fenrir's earring"})
			end
		end
	elseif spell.skill == 'WeaponSkill' then
		if state.Buff['Warrior\'s Charge'] then
			if player.inventory['Bushinomimi'] then
				equip({ear2="Bushinomimi"})
			else
				equip({ear2="Merman's earring"})
			end
		end
	end

end

function job_buff_change(name,gain)

	sleep_swap(name,gain)

end

function job_status_change(new,old)
	
	if new == "Engaged" then
		if player.equipment.main == 'Bravura' or player.equipment.main == 'Ragnarok' then
			state.CombatWeapon:set(player.equipment.main)
		elseif player.equipment.main == 'Ridill' then
			state.CombatWeapon:set('DW')
		else
			state.CombatWeapon:reset()
		end
			adjust_melee_groups()
	end
	
end

function get_custom_wsmode(spell,spellMap,default_wsmode)

	local wsmode = ''
	if state.Buff['Mighty Strike'] then
		wsmode = wsmode .. 'MS'
	end
	if wsmode ~= '' then
		return wsmode
	end
	
end

function customize_idle_set(idleSet)

    if player.hpp < 51 then
        idleSet = set_combine(idleSet,{ring2="Hercules' ring"})
    end
    
    return idleSet
end

function customize_melee_set(meleeSet)

	if daytime and state.OffenseMode.value == 'Normal' then
        meleeSet = set_combine(meleeSet,{ear1="Fenrir's earring"})
    end

    return meleeSet
	
end

function adjust_melee_groups()

	classes.CustomMeleeGroups:clear()
	if player.sub_job == 'SAM' then
		classes.CustomMeleeGroups:append('SAM')
	end
	
end