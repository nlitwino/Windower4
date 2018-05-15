_addon.author   = 'Gobbo, Project Tako';
_addon.name     = 'ex';
_addon.version  = '1.0';

require('common');
require 'ffxi.targets';
require('buffs');
local default_config =
{
    font =
    {
        family      = 'Arial',
        size        = 10,
        color       = 0xFFFFFFFF,
        position    = { 200, 200 },
        bgcolor     = 0x80000000,
        bgvisible   = true,
    }
};
start_time = os.time()
local debuff_data = 
{
	[23]  = { name = 'Dia', duration = 60, overwrites = { } },
	[24]  = { name = 'Dia II', duration = 120, overwrites = { 23, 33, 230 } },
	[25]  = { name = 'Dia III', duration = 90, overwrites = { 23, 24, 230, 231, 33 } },
	[33]  = { name = 'Diaga', duration = 60, overwrites = { } },
	[56]  = { name = 'Slow', duration = 120, overwrites = { } },
	[58]  = { name = 'Paralyze', duration = 120, overwrites = { } },
	[59]  = { name = 'Silence', duration = 120, overwrites = { } },
	[79]  = { name = 'Slow II', duration = 120, overwrites = { 56 } },
	[80]  = { name = 'Paralyze II', duration = 120, overwrites = { 58 } },
	[98]  = { name = 'Repose', duration = 90, overwrites = { 253 } },
	[220] = { name = 'Poison', duration = 90, overwrites = { } },
	[221] = { name = 'Poison II', duration = 120, overwrites = { 220, 225 } },
	[225] = { name = 'Poisonga', duration = 90, overwrites = { } },
	[230] = { name = 'Bio', duration = 60, overwrites = { 23, 33 } },
	[231] = { name = 'Bio II', duration = 120, overwrites = { 23, 24, 33 ,230 } },
	[232] = { name = 'Bio III', duration = 30, overwrites = { 23, 24, 33, 230, 231 } },
	[235] = { name = 'Burn', duration = 60, overwrites = { 236 } },	 --
	[236] = { name = 'Frost', duration = 60, overwrites = { 237 } }, --
	[237] = { name = 'Choke', duration = 60, overwrites = { 238 } }, -- These 6 spells I'm unsure of duration.  
	[238] = { name = 'Rasp', duration = 60, overwrites = { 239 } },	 -- They will be 60s until I confirm.
	[239] = { name = 'Shock', duration = 60, overwrites = { 240 } }, --
	[240] = { name = 'Drown', duration = 60, overwrites = { 235 } }, --
	[253] = { name = 'Sleep', duration = 60, overwrites = { } },
	[254] = { name = 'Blind', duration = 180, overwrites = { } },
	[255] = { name = 'Break', duration = 30, overwrites = { } },
	[259] = { name = 'Sleep II', duration = 120, overwrites = { 253, 273, 363, 576, 584, 598, 678 } },
	[273] = { name = 'Sleepga', duration = 90, overwrites = { } },
	[274] = { name = 'Sleepga II', duration = 120, overwrites = { 253, 273, 363, 576, 584, 598, 678 } },
	[276] = { name = 'Blind II', duration = 180, overwrites = { 254 } },
	[278] = { name = 'Geohelix', duration = 274, overwrites = { } },	    --
	[279] = { name = 'Hydrohelix', duration = 274, overwrites = { } },	--
	[280] = { name = 'Anemohelix', duration = 274, overwrites = { } },	--
	[281] = { name = 'Pyrohelix', duration = 274, overwrites = { } },	    -- Helix duration varies based on Job Points, Dark Arts, and Cape used.
	[282] = { name = 'Cryohelix', duration = 274, overwrites = { } },	    -- This is my duration under Dark Arts, Cape, and no Tabula Rasa.
	[283] = { name = 'Ionohelix', duration = 274, overwrites = { } },	    --
	[284] = { name = 'Noctohelix', duration = 274, overwrites = { } },	--
	[285] = { name = 'Luminohelix', duration = 274, overwrites = { } },   --
	[286] = { name = 'Addle', duration = 120, overwrites = { } },
	[319] = { name = 'Aisha: Ichi', duration = 120, overwrites = { } }, -- Don't know debuff duration
	[341] = { name = 'Jubaku: Ichi', duration = 90, overwrites = { } },
	[344] = { name = 'Hojo: Ichi', duration = 90, overwrites = { } },
	[345] = { name = 'Hojo: Ni', duration = 90, overwrites = { 344 } },
	[347] = { name = 'Kurayami: Ichi', duration = 90, overwrites = { } },
	[348] = { name = 'Kurayami: Ni', duration = 90, overwrites = { 347 } },
	[363] = { name = 'Sleepga', duration = 90, overwrites = { } },
	[364] = { name = 'Sleepga II', duration = 120, overwrites = { 253, 273, 363, 576, 584, 598, 678 } },
--	[156] = { name = 'Feint', duration = 30, overwrites = {} },
	[372] = { name = 'Gambit', duration = 92, overwrites = {} },
	[375] = { name = 'Rayke', duration = 47, overwrites = {} },
	[365] = { name = 'Breakga', duration = 30, overwrites = { } },
	[508] = { name = 'Yurin: Ichi', duration = 90, overwrites = { } },
--  [561] = { name = 'Frightful Roar', duration = 180, overwrites = { } },
    [572] = { name = 'Sound Blast', duration = 180, overwrites = { } },
    [576] = { name = 'Yawn', duration = 90, overwrites = { } },
	[584] = { name = 'Sheep Song', duration = 60, overwrites = { } },
    [598] = { name = 'Soporific', duration = 90, overwrites = { } },
--  [659] = { name = 'Demoralizing Roar', duration = 30, overwrites = { } },
--  [660] = { name = 'Cimicine Discharge', duration = 90, overwrites = { } },
    [678] = { name = 'Dream Flower', duration = 90, overwrites = { } },
	[703] = { name = 'Embalming Earth', duration = 180, overwrites = { } },
	[705] = { name = 'Foul Waters', duration = 180, overwrites = { 235, 719 } },
    [716] = { name = 'Nectarous Deluge', duration = 30, overwrites = { } },
    [719] = { name = 'Searing Tempest', duration = 60, overwrites = { } },
    [722] = { name = 'Entomb', duration = 60, overwrites = { } },
    [723] = { name = 'Saurian Slide', duration = 60, overwrites = { } },
--  [724] = { name = 'Palling Salvo', duration = 90, overwrites = { 23, 33, 230 } },
    [726] = { name = 'Scouring Spate', duration = 180, overwrites = { } },
    [727] = { name = 'Silent Storm', duration = 300, overwrites = { } },
    [728] = { name = 'Tenebral Crush', duration = 90, overwrites = { } },
    [740] = { name = 'Tourbillion', duration = 60, overwrites = { } },
    [752] = { name = 'Cesspool', duration = 60, overwrites = { } },
    [753] = { name = 'Tearing Gust', duration = 60, overwrites = { } },
	[841] = { name = 'Distract', duration = 120, overwrites = { } },
	[842] = { name = 'Distract II', duration = 120, overwrites = { 841 } },
	[843] = { name = 'Frazzle', duration = 120, overwrites = { } },
	[844] = { name = 'Frazzle II', duration = 120, overwrites = { 843 } },
 	[882] = { name = 'Distract III', duration = 120, overwrites = { 841, 842 } },
 	[883] = { name = 'Frazzle III', duration = 120, overwrites = { 843, 844 } },
	[884] = { name = 'Addle II', duration = 120, overwrites = { 286 } },
	[885] = { name = 'Geohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } },		--
	[886] = { name = 'Hydrohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } },	--
	[887] = { name = 'Anemohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } },	--
	[888] = { name = 'Pyrohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } },	 	-- Helix duration varies based on Job Points, Dark Arts, and Cape used.
	[889] = { name = 'Cryohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } },		-- This is my duration under Dark Arts, Cape, and no Tabula Rasa.
	[890] = { name = 'Ionohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } },	 	--
	[891] = { name = 'Noctohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } }, 	--
	[892] = { name = 'Luminohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } } 	--
--  [502] = { name = 'Kaustra', duration = 0, overwrites = { } },
--  [000] = { name = 'Spooky Holder', duration = 0, overwrites = { } },
}, { 'name', 'duration', 'overwrites' };
local tracked_mobs= 
{
	
};

local spell_success = T{ 2, 230, 236, 237, 270, 277, 278, 279, 280, 266, 267, 268, 269, 271, 272, 320, 672 };
local spell_debuff = T{ 23, 24, 25, 33, 56, 58, 59, 79, 80, 98, 220, 221, 225, 230, 231, 232, 235, 236, 237, 238, 239, 240, 253, 254, 255, 259, 273, 274, 276, 286, 319, 341, 344, 345, 347, 348, 364, 365, 508, 572, 841, 842, 843, 844, 882, 883, 884 };
local spell_debuff_status = T{ 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 17, 16, 18, 19, 20, 21, 31, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 147, 								148, 149, 168, 404, 562, 564, 536, 571 };
local spell_damage_debuff = T{ 23, 24, 25, 33, 230, 231, 232, 278, 279, 280, 281, 282, 283, 284, 285, 885, 886, 887, 888, 889, 890, 891, 892,
								703, 705, 716, 719, 722, 723, 726, 727, 728, 740, 752, 753 };
local exConfig = default_config;
---------------------------------------------------------------------------------------------------
-- func: load
-- desc: First called when our addon is loaded.
---------------------------------------------------------------------------------------------------
ashita.register_event('load', function()
	-- load the config
	exConfig = ashita.settings.load_merged(_addon.path .. 'settings/settings.json', exConfig);

	-- create our test on screen objects

	local f = AshitaCore:GetFontManager():Create('test-object');
		f:SetPositionX(exConfig.font.position[1]);
		f:SetPositionY(exConfig.font.position[2]);
		f:SetColor(exConfig.font.color);
		f:SetFontFamily(exConfig.font.family);
		f:SetFontHeight(exConfig.font.size);
		f:SetBold(true);
		f:GetBackground():SetColor(exConfig.font.bgcolor);
		f:GetBackground():SetVisibility(exConfig.font.bgvisible);
		f:SetVisibility(true);	
		f:SetText('Testing Grounds')

	
end);

---------------------------------------------------------------------------------------------------
-- func: command
-- desc: Called when our addon receives a command.
---------------------------------------------------------------------------------------------------
ashita.register_event('command', function(cmd, nType) 
	return false;
end);

ashita.register_event('prerender', function()
	-- for getting the name that is associated with the target index
	local entity_manager = AshitaCore:GetDataManager():GetEntity();
	-- create a table to hold text
	-- this is the final text to be shown
	
	local f = AshitaCore:GetFontManager():Get('test-object');	
	
	local final_text = T{ }
	
	-- Go through the Tracked Mobs with the Key being the Target Index and Value Monster
	for index, monster in pairs(tracked_mobs) do 
		
			-- Create another table for text that will get added with mobs and their debuffs
			local text = T{ };
			-- adds the monster name to the table instead of the target index
			
			table.insert(text, string.format('-------------------------\n %s \n-------------------------', entity_manager:GetName(index))) -- will re-add to the table each time casted on with all debuffs on there + new ones
			for key, value in pairs(monster) do
				local d = debuff_data[key]
				-- needed to create another table within the text table  so it wouldn't re-add the same table with a new spell each time
				local spell_text = T{ }
				table.insert(spell_text, string.format('%s: ', d['name']))
				
				for y, z in pairs(value) do
					local spell_time = T{ }
					local seconds = os.time() - z;
					local timer_start = os.date('!%M%S',seconds);
					local timer_start2 = timer_start - d['duration'];
					local timer = timer_start2
					
				-- the value in this loop is the Spell ID that is being stored
				-- use this Spell ID to get the name associated with the ID in our debuff table
				-- go through and add the name of every Spell ID stored in the prev_debuff table
				 
				 --table.insert(spell_text, string.format('%s: '..-timer, d['name']))
				-- table.insert(spell_text, string.format('%s', d['name']))
					table.insert(spell_time, string.format('%d', -timer))
					table.insert(spell_text, spell_time:concat(' '))
				end
				table.insert(text, spell_text:concat(' '));
			end
			-- f:SetText(final_text:concat('\n')) -- this creates a new line for each iteration of tracked_mob
			
				table.insert(final_text, text:concat('\n'));
	end
	-- separate all monsters with a new line
	f:SetText(final_text:concat('\n'));
	-- Currently does not remove old mobs unless they respawn with same index.
	
	
end);
------------------

---------------------------------------------------------------------------------------------------
-- func: incoming_packet
-- desc: Called when our addon receives an incoming packet.
---------------------------------------------------------------------------------------------------
ashita.register_event('incoming_packet', function(id, size, packet)
	
		---	local target_t = ashita.ffxi.targets.get_target('t');
		--	local target_bt = ashita.ffxi.targets.get_target('bt');
		local self = GetPlayerEntity();
		local party = AshitaCore:GetDataManager():GetParty();
		local entity_manager = AshitaCore:GetDataManager():GetEntity();
	-- action packet
	if (id == 0x28) then
		-- defines everything in the action packet
		local actor_id = struct.unpack('I', packet, 0x05 + 1);
			
		local target_count = struct.unpack('b', packet, 0x09 + 1);
		
		-- holds the bitOffset for unpacking bits
		local bitOffset = 82;

		-- unpack the action type
		-- 82 bits in. 0x0A:0x02 = 82
		-- action type is 4 bits wide
		local action_type = ashita.bits.unpack_be(packet, bitOffset, 4);
		-- adjust the offset
		bitOffset = bitOffset + 4;

		-- adjust the bitOffset
		bitOffset = bitOffset + 64;
		
		-- get the spell id
		local spell_id = ashita.bits.unpack_be(packet, 86, 10);
		
		-- create our targets table, empty
		local targets = { };

		-- loop through how many targets there are
		for x = 1, target_count do
			-- empty target
			targets[x] = { };

			-- get the id of the target
			targets[x].id = ashita.bits.unpack_be(packet, bitOffset, 32);
			-- adjust the offset
			bitOffset = bitOffset + 32;


			-- get the action count
			targets[x].action_count = ashita.bits.unpack_be(packet, bitOffset, 4) + 1;
			-- adjust the offset
			bitOffset = bitOffset + 4;
			
			-- empty actions table
			targets[x].actions = { };
			
		--	for index = 1, 1024, 1 do
		--		local entity_manager = AshitaCore:GetDataManager():GetEntity();
		--		if entity_manager:GetServerId(index) == targets[x].id then
			--	print('we did it')
		--		end
		--	end

			-- loop through the action count
			for i = 1, targets[x].action_count do
				targets[x].actions[i] = { };
				-- get the targets reaction
				targets[x].actions[i].reaction = ashita.bits.unpack_be(packet, bitOffset, 5);
				-- adjust the offset
				bitOffset = bitOffset + 5;

				-- get the targets animation
				targets[x].actions[i].animation = ashita.bits.unpack_be(packet, bitOffset, 12);
				-- adjust the offset
				bitOffset = bitOffset + 12;

				-- get the targets special effect
				targets[x].actions[i].effect = ashita.bits.unpack_be(packet, bitOffset, 7);
				-- adjust the offset
				bitOffset = bitOffset + 7;

				-- get the targets knockback
				targets[x].actions[i].knockback = ashita.bits.unpack_be(packet, bitOffset, 3);
				-- adjust the offset
				bitOffset = bitOffset + 3;

				-- get the targets param
				-- use for damage debuffs (dia, bio, helix, blue magic)
				targets[x].actions[i].param = ashita.bits.unpack_be(packet, bitOffset, 17);
				-- adjust the offset
				bitOffset = bitOffset + 17;
				-- simplify name
				act_param = targets[x].actions[i].param
				-- get the targets message id
				-- use for all normal debuffs (paralyze, slow, silence)
				targets[x].actions[i].message_id = ashita.bits.unpack_be(packet, bitOffset, 10);
				-- adjust the offset
				bitOffset = bitOffset + 10;

				-- adjust the offset manually
				bitOffset = bitOffset + 31;

				-- get if there is a subeffect. 0 = false 1 = true
				targets[x].actions[i].subeffect = ashita.bits.unpack_be(packet, bitOffset, 1);
				-- adjust the offset
				bitOffset = bitOffset + 1;
				
				-- check if there's a sub effect
				if (targets[x].actions[i].subeffect == 1) then
					-- get the targets add_effect
					targets[x].actions[i].add_effect = ashita.bits.unpack_be(packet, bitOffset, 10);
					-- adjust the offset
					bitOffset = bitOffset + 10;

					-- get the targets add_effect_param
					targets[x].actions[i].add_effect_param = ashita.bits.unpack_be(packet, bitOffset, 17);
					-- adjust the offset
					bitOffset = bitOffset + 17;

					-- get the targets add_effect_message
					targets[x].actions[i].add_effect_message = ashita.bits.unpack_be(packet, bitOffset, 10);
					-- adjust the offset
					bitOffset = bitOffset + 10;
				end

				-- get if there is a spikes. 0 = false 1 = true
				targets[x].actions[i].spikes = ashita.bits.unpack_be(packet, bitOffset, 1);
				-- adjust the offset
				bitOffset = bitOffset + 1;

				-- check if there's spikes
				if (targets[x].actions[i].spikes == 1) then
					-- get the targets spikes_effect
					targets[x].actions[i].spikes_effect = ashita.bits.unpack_be(packet, bitOffset, 10);
					-- adjust the offset
					bitOffset = bitOffset + 10;

					-- get the targets spikes_param
					targets[x].actions[i].spikes_param = ashita.bits.unpack_be(packet, bitOffset, 14);
					-- adjust the offset
					bitOffset = bitOffset + 17;

					-- get the targets spikes_message
					targets[x].actions[i].spikes_message = ashita.bits.unpack_be(packet, bitOffset, 10);
					-- adjust the offset
					bitOffset = bitOffset + 10;
				end
			end
		end
		-- where we do things with the targets in the action packet
		for index,value in pairs(targets) do
			local success = 0
			local para = 0
			local target_id = value.id
		
			
			-- sees if any debuff that was cast landed
			for k,v in pairs(spell_success) do	
				if (v == value.actions[1].message_id) then
					success = 1
				end
			end
			
			-- sees if we have a debuff
			for k,v in pairs(spell_debuff) do
				if (v == spell_id) or (v == act_param) then
					para = 1
				end
			end
				
			-- Find out if the entity casting the spell is in our party or ourself
			if friend_check(party, actor_id) or (self.ServerId == actor_id) then
				-- sees if debuff search found something
				if para == 1 then
					-- sees if we have a valid message
					if success == 1 then
						local target_name, target_index = target_match(target_id);		
									-- creates a table for debuffs used in table tracked_mobs at 
									-- value target_index.
									-- doesn't actually get added to tracked_mobs[target_index] yet
									
									prev_debuffs = tracked_mobs[target_index];
									if (prev_debuffs == nil) then
										prev_debuffs = { };
									end -- nil check
									
									
						local d = debuff_data[spell_id]; -- d = the spell's ID
						if (d ~= nil) then						-- if a spell in the table is used we continue, all the results are at the end of this block
							local debuff_name = d['name'];		-- the name of the debuff
							local overwrites = d['overwrites'];	-- the spell IDs that it overwrites
							if (overwrites ~= nil and #overwrites > 0) then 	-- if there are any spells that could be overwritten, continue
								for o_index, o_value in pairs(overwrites) do	-- I'm assuming this looks over the placement of the values vs the values in those placements
									local overwritten_debuff = debuff_data[o_value];	-- simplifies the expression
									if (overwritten_debuff ~= nil) then				-- if that spell
										-- remove from previous debuffs
										 prev_debuffs = remove_from_table(prev_debuffs, o_value);
									end
								end	-- end of loop
							end -- end of overwriting check
								spell_time = prev_debuffs[spell_id]
								if spell_time == nil then
									spell_time = { }
								end
								spell_time[#spell_time + 1] = os.time()
							-- Adds the Spell ID to the next available Key in the prev_debuffs table
								prev_debuffs[spell_id] = spell_time
							
							--prev_debuffs[#prev_debuffs + 1] = spell_id;
							--start_time = os.time()
							-- Since it wasn't actually added to tracked_mobs[target_index] we do so now
								tracked_mobs[target_index] = prev_debuffs;
						end
					end
				end
			end	
		end	

	end
	if (id == 0x29) then
		local P_Sender_id = struct.unpack('I', packet, 0x04 + 1)
		local T_Sender_id = struct.unpack('I', packet, 0x08 + 1)
		local P_Sender_Targsid = struct.unpack('I', packet, 0x14 + 1 ) 
		local T_Sender_Targsid = struct.unpack('I', packet, 0x16 + 1 )
		local message_id = struct.unpack('H', packet, 0x18 + 1);
	end
	return false;
end);


function build_tables(target_index, target_name, spell_id, debuff_name)--abiility_id
		
end
function friend_check(party, actor_id)
	for index = 1, 1024, 1 do
		if (party:GetMemberServerId(index) ~= nil) then
			if (party:GetMemberServerId(index) == actor_id) then
				return true;
			end
		else 
			return false;
		end
	end
end

function target_match(target_id)
	local entity_manager = AshitaCore:GetDataManager():GetEntity();
	for index = 1, 1024, 1 do
		if (entity_manager:GetServerId(index) ~= nil) then
			if (entity_manager:GetServerId(index) == target_id) then
				return entity_manager:GetName(index), entity_manager:GetTargetIndex(index)
			end
		else 
			return 'N/A', -1;
		end
	end
end
function remove_from_table(t, value)
	for k,v in pairs(t) do
		if (v == value) then
			t[k] = nil;
		end
	end

	return t;
end

---------------------------------------------------------------------------------
-- func: outgoing_packet
-- desc: Called when our addon receives an outgoing packet.
---------------------------------------------------------------------------------------------------
ashita.register_event('outgoing_packet', function(id, size, packet)
	return false;
end);

---------------------------------------------------------------------------------------------------
-- func: unload
-- desc: Called when our addon is unloaded.
---------------------------------------------------------------------------------------------------
ashita.register_event('unload', function()
	-- Get the font object..

	AshitaCore:GetFontManager():Delete('test-object');
end);
