function job_self_command(commandArgs,eventArgs)

  if commandArgs[1] == 'trade_ring' then
    trade_ring()
  elseif commandArgs[1] == 'trade_earring1' then
    trade_earring1()
	elseif commandArgs[1] == 'trade_earring2' then
		trade_earring2()
  elseif commandArgs[1] == 'trade_whistle' then
    trade_whistle()
	elseif commandArgs[1] == 'regear' then
		regear()
	elseif commandArgs[1] == 'custom_treasure_cycle' then
		custom_treasure_cycle()
  elseif commandArgs[1]:lower() == 'siphon' then
    handle_siphoning()
    eventArgs.handled = true
  elseif commandArgs[1]:lower() == 'pact' then
    handle_pacts(commandArgs)
    eventArgs.handled = true
  elseif commandArgs[1] == 'reset_ward_flag' then
    wards.flag = false
    wards.spell = ''
    eventArgs.handled = true
	elseif commandArgs[1] == 'lock_ranged' then
    lock_ranged()
    eventArgs.handled = true
  elseif commandArgs[1] == 'handle_shot' then
    handle_shot()
    eventArgs.handled = true
  elseif commandArgs[1] == 'setskin' then
    setskin(player.main_job)
    eventArgs.handled = true
  elseif commandArgs[1] == 'warp_out' then
    warp_out()
    eventArgs.handled = true
  end
    
end

function initialize_job()
	
	daytime = world.time <= (18*60) and world.time >= (6*60)
	duskdawn = (world.time >= (17*60) and world.time <= (18*60)) and (world.time >= (6*60) and world.time <= (7*60))
	
	initialize_custom_augments(player.name)
	initialize_skins(player.name)
	
	state.Tank = M(false, 'Tank')
  state.Ranged = M(false, 'Ranged')
	
	gear.main = player.equipment.main
	gear.sub = player.equipment.sub
	
	select_default_macro_book()
	set_custom_universal_keybinds()
	
	windower.register_event('zone change', 
	function(new, old)
		send_command('gs c update')
	end)

	windower.register_event('time change', 
	function(new, old)
		if new == (17*60) or new == (18*60) or new == (6*60) or new == (7*60) then
			if new == (17*60) then
				duskdawn = true
			elseif new == (18*60) then
				daytime = false
			elseif new == (6*60) then
				daytime = true
			elseif new == (7*60) then
				duskdawn = false
			end
			if not midaction() then
				send_command('gs c update')
			else
				add_to_chat('Time change midaction.')
			end
		end
	end)
	
end

function initialize_custom_augments(name)

	if name == "Kayrah" then
    toreador_ring
	   = {["Triple Attack (1)"] = { name="Toreador's Ring", augments={'Accuracy+5','"Triple Atk."+2',}}
	     ,["Triple Attack (2)"] = { name="Toreador's Ring", augments={'"Triple Atk."+2','Accuracy+4',}}
       ,["Triple Attack (3)"] = { name="Toreador's Ring", augments={'"Triple Atk."+2','"Triple Atk."+1',}}
	     ,["Ranged Attack"]     = { name="Toreador's Ring", augments={'Rng.Atk.+5','Rng.Atk.+7',}}}
	     
    scorpion_harness
     = {["Haste"]      = { name="Scorpion Harness +1", augments={'Haste+11',}}
       ,["Rapid Shot"] = { name="Scorpion Harness +1", augments={'"Rapid Shot"+11',}}}
       
		prism_cape
		 = {["Fast Cast"]       = { name="Prism Cape", augments={'"Fast Cast"+3',}}
			 ,["Spell Interrupt"] = { name="Prism Cape", augments={'Spell interruption rate down -20%',}}
			 ,["Magic Accuracy"]  = { name="Prism Cape", augments={'Mag. Acc.+4',}}
			 ,["Cure Potency"]    = { name="Prism Cape", augments={'"Cure" potency +4%',}}}
			 
	elseif name == "Mimosa" then
	  toreador_ring
	  = {["Triple Attack (4"] = { name="Toreador's Ring", augments={'"Triple Atk."+2','"Triple Atk."+2',}}}
	  
    scorpion_harness
     = {["Haste"]      = { name="Scorpion Harness +1", augments={'Haste+11',}}}
     
		prism_cape 
		 = {["Fast Cast"]       = { name="Prism Cape", augments={'"Fast Cast"+3',}}
			 ,["Spell Interrupt"] = { name="Prism Cape", augments={'Spell interruption rate down -20%',}}
			 ,["Magic Accuracy"]  = { name="Prism Cape", augments={'Mag. Acc.+4',}}
			 ,["Cure Potency"]    = { name="Prism Cape", augments={'"Cure" potency +4%',}}}
		
	elseif name == "Mian" then
    scorpion_harness
     = {["Rapid Shot"] = { name="Scorpion Harness +1", augments={'"Rapid Shot"+11',}}}
     
		prism_cape 
     = {["Fast Cast"]       = { name="Prism Cape", augments={'"Fast Cast"+3',}}
       ,["Spell Interrupt"] = { name="Prism Cape", augments={'Spell interruption rate down -20%',}}
       ,["Magic Accuracy"]  = { name="Prism Cape", augments={'Mag. Acc.+4',}}
       ,["Cure Potency"]    = { name="Prism Cape", augments={'"Cure" potency +4%',}}}
       
	end
	
end

function initialize_skins(name)

  if name == "Kayrah" then
    skins
     = {['WAR'] = {head=179,body=328,hands=282,legs=282,feet=3}
       ,['BLM'] = {set=285}
       ,['MNK'] = {head=140,body=216,hands=336,legs=238,feet=415}
       ,['RDM'] = {head=286,body=208,hands=286,legs=185,feet=343}
       ,['THF'] = {set=367}
       ,['PLD'] = {head=140,body=113,hands=77,legs=62,feet=77}
       ,['DRK'] = {head=140,body=113,hands=78,legs=62,feet=78}
       ,['RNG'] = {head=140,body=180,hands=84,legs=62,feet=11}
       ,['SAM'] = {head=140,body=37,hands=9,legs=14,feet=98}
       ,['NIN'] = {head=140,body=196,hands=89,legs=294,feet=294}
       ,['SMN'] = {head=116,body=578,hands=215,legs=577,feet=577}
       ,['DNC'] = {set=305}
       ,['SCH'] = {head=140,body=306,hands=306,legs=215,feet=21}}
       
  elseif name == "Mimosa" then
    skins
     = {['WHM'] = {}
       ,['BLM'] = {}
       ,['RDM'] = {head=286,body=208,hands=286,legs=185,feet=343}
       ,['THF'] = {set=367}
       ,['BRD'] = {head=379,body=578,hands=215,legs=215,feet=215}}
       
  elseif name == "Mian" then
    skins
     = {['RDM'] = {head=286,body=208,hands=286,legs=185,feet=343}
       ,['COR'] = {head=168,body=225,hands=225,legs=168,feet=168}}
       
  end

end

function set_custom_universal_keybinds()

	-- Defensive cycles
	send_command('bind f9 gs c cycle PhysicalDefenseMode')
	send_command('bind f10 gs c set DefenseMode Physical')
	send_command('bind f11 gs c set DefenseMode Magical')
	send_command('bind f12 gs c reset DefenseMode')
	
	-- Offensive cycles
	send_command('bind ^f9 gs c cycle OffenseMode')
	send_command('bind ^f10 gs c cycle WeaponskillMode')
	send_command('bind ^f11 gs c cycle RangedMode')
	send_command('bind ^f12 gs c cycle CastingMode')
	
	-- Misc. cycles
	-- F9 left out for customs
	send_command('bind !f10 gs c toggle Tank')
	send_command('bind !f11 gs c regear')
	send_command('bind !f12 gs reload')
	
	-- Trade functions
	send_command('bind !z input /pcmd leader '..player.name)
	send_command('bind !x gs c trade_earring1')
	send_command('bind !c gs c trade_earring2')
	send_command('bind !v gs c trade_ring')
  send_command('bind !q gs c trade_whistle')
  
  -- other misc
  send_command('bind !b gs c setskin')
  send_command('bind !n ffo me')
  send_command('bind !m ffo stopall')
  send_command('bind !, gs c warp_out')

end

function trade_ring()
	
	local currentRing
	
	if player.inventory['Rajas Ring'] then
		currentRing = 'Rajas Ring'
	elseif player.inventory['Tamas Ring'] then
		currentRing = 'Tamas Ring'
	elseif player.inventory['Sattva Ring'] then
		currentRing = 'Sattva Ring'
	end
	
	if player.target.name == "Runga-Kopunga" then
		send_command('input /item "'..currentRing..'" <t> ')
	else
		add_to_chat("Please target Runga-Kopunga!")
		return
	end
	
end

function trade_earring1()
	
	local currentEarring	
	
	if player.inventory['Abyssal Earring'] then
		currentEarring = 'Abyssal Earring'
	elseif player.inventory['Beastly Earring'] then
		currentEarring = 'Beastly Earring'
	elseif player.inventory['Bushinomimi'] then
		currentEarring = 'Bushinomimi'
	elseif player.inventory["Knight\'s Earring"] then
		currentEarring = 'Knight\'s Earring'
	elseif player.inventory['Suppanomimi'] then
		currentEarring = 'Suppanomimi'
	end
	
	if player.target.name == "Runga-Kopunga" then
		send_command('input /item "'..currentEarring..'" <t> ')
	else
		add_to_chat("Please target Runga-Kopunga!")
		return
	end
	
end

function trade_earring2()
	
	local currentEarring	
	
	if player.inventory['Ethereal Earring'] then
		currentEarring = 'Ethereal Earring'
	elseif player.inventory['Hollow Earring'] then
		currentEarring = 'Hollow Earring'
	elseif player.inventory['Magnetic Earring'] then
		currentEarring = 'Magnetic Earring'
	elseif player.inventory['Static Earring'] then
		currentEarring = 'Static Earring'
	end
	
	if player.target.name == "Runga-Kopunga" then
		send_command('input /item "'..currentEarring..'" <t> ')
	else
		add_to_chat("Please target Runga-Kopunga!")
		return
	end
	
end

function trade_whistle()

  if player.target.name == "Honorine" then
    equip({neck="Chocobo Whistle"})
    send_command('wait 0.25;input /item "Chocobo Whistle" <t>')
  else
    add_to_chat("Please target Honorine!")
    return
  end

end

function job_sub_job_change(new,old)

	select_default_macro_book()

end

function select_default_macro_book()
	
	local mainjobs = {'WAR','MNK','WHM','BLM','RDM','THF','PLD','DRK','BST','BRD','RNG','SAM','NIN','DRG','SMN','BLU','COR','PUP','DNC','SCH'}
	local commonsubs = {'NIN','DNC','WAR','SAM','THF','WHM','RDM','SCH','BLM','DRG'}
	
	local mainpage
	local subpage
	
	for mainjob = 1,20 do
		if player.main_job == mainjobs[mainjob] then
			mainpage = mainjob
			add_to_chat('Main job '..player.main_job..': Macro Book '..mainjob..'.')
		end
	end
	
	for subjob = 1,10 do
		if player.sub_job == commonsubs[subjob] then
			subpage = subjob
			add_to_chat('Sub job '..player.sub_job..': Macro Page '..subjob..'.')
		end
	end
		
		set_macro_page(subpage,mainpage)
	
end

function regear()
	
	equip({main=gear.main,sub=gear.sub})
	send_command('gs c update')
	add_to_chat('Regeared: ' .. gear.main .. ' and ' .. gear.sub)
	
end

function sleep_swap(name,gain)

    local neck = 'Opo-opo necklace'

    if name == 'sleep' then
        if gain then
            if player.main_job == 'WAR' or player.main_job == 'PLD' or player.main_job == 'DRK' or player.main_job == 'SAM' or player.main_job == 'DRG' then
              neck='Berserker\'s torque'
            elseif player.main_job == 'DNC' or player.main_job == 'THF' or player.main_job == 'MNK' or player.main_job == 'BST' then
              equip({head='Frenzy sallet'})
            end
            equip({neck=neck})
        else
            send_command('gs c update')
        end
    end

end

function ammo_recharge()

	if player.equipment.ammo == 'empty' then
		if player.inventory[gear.ammo] then
			add_to_chat("Replenishing "..gear.ammo.."s.")
			equip({ammo=gear.ammo})
		else
			add_to_chat("No more "..gear.ammo.."s.")
		end
	else
		gear.ammo = player.equipment.ammo
	end

end

function lock_ranged()
	
	if state.Range.value then
		disable("range","ammo")
	else
		enable("range","ammo")
	end
	
end

function handle_cor_rolls(roll)
	
	
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
	
	rollinfo = rolls[roll]
	if rollinfo then
        add_to_chat(roll..': '..rollinfo.bonus..'.')
        add_to_chat('Lucky: '..tostring(rollinfo.lucky)..', Unlucky: '..tostring(rollinfo.unlucky)..'.')
    end
end

function setskin(job)

  ids = skins[job]
  slots = {"head","body","hands","legs","feet","main","sub","ranged","ammo","set"}
  
  local command = ''
  for slot = 1,10 do
    if ids[slots[slot]] then
      command = command..'wait 2;input !setskin '..slots[slot]..' '..ids[slots[slot]]..';'
    end
  end 
  send_command('gs c update;'..command..'wait 1; input /lockstyle on')

end

function warp_out()

  local send = 'send @all '
  local equip_ring = 'input /equip ring2 \\"Warp ring\\"'
  local use_ring = 'input /item \\"Warp ring\\" <me>'
  send_command(send..equip_ring..';wait 10;'..send..use_ring)

end

-- function protect_shell_pt()

	-- local x = 0

	-- while x < (party.count - 1) then
	
		-- send_command('@input /ma "Protect IV')
	
	-- end

-- end