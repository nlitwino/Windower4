--[[
Copyright (c) 2013, Ricky Gall
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
    * Neither the name of <addon name> nor the
    names of its contributors may be used to endorse or promote products
    derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <your name> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

--Declaring default settings
defaults = T{}
--Addon settings
defaults.staggeronly = false  
defaults.showrolls = true
defaults.selfrolls = false
defaults.duration = 7

--Textbox settings
defaults.bg = {}
defaults.bg.alpha = 100
defaults.bg.red = 0
defaults.bg.blue = 0
defaults.bg.green = 0
defaults.pos = {}
defaults.pos.x = 400
defaults.pos.y = 300
defaults.text = {}
defaults.text.red = 255
defaults.text.green = 255
defaults.text.blue = 255
defaults.text.font = 'Consolas'
defaults.text.size = 15

--Moblist defaults
defaults.moblist = T{}
defaults.moblist['voidwatch'] = S{"Qilin", "Celaeno", "Morta", "Bismarck", "Ig-Alima", "Kalasutrax", "Ocythoe", "Gaunab", "Hahava", "Cherufe", "Botulus Rex", "Taweret", "Agathos", "Goji", "Gugalanna", "Gasha", "Giltine", "Mellonia", "Kaggen", "Akvan", "Pil", "Belphoebe", "Kholomodumo", "Aello", "Uptala", "Sarbaz", "Shah", "Wazir", "Asb", "Rukh", "Provenance Watcher"}
defaults.moblist['abyssea'] = S{"Alfard", "Orthrus", "Carabosse", "Glavoid", "Isgebind"}
defaults.moblist['legion'] = S{"Veiled", "Lofty", "Soaring", "Mired", "Paramount"}
defaults.moblist['meebles'] = S{"Goldwing", "Silagilith", "Surtr", "Dreyruk", "Samursk", "Umagrhk", "Izyx", "Grannus", "Svaha", "Melisseus"}
defaults.moblist['other'] = S{"Tiamat", "Khimaira", "Khrysokhimaira", "Cerberus", "Dvergr", "Bloodthirsty", "Hydra", "Enraged", "Odin"}
defaults.moblist['dangerous'] = S{"Provenance Watcher", "Apademak"}
defaults.dangerwords = T{}
defaults.dangerwords['ult'] = S{"Spirit Surge","Call Wyvern","Manafont","Blood Weapon","Perfect Dodge","Astral Flow","Soul Voice","Chainspell","Eagle Eye Shot","Meikyo Shisui","Invincible","Mighty Strikes","Hundred Fists","Mijin Gakure","Benediction","Familiar"}
defaults.dangerwords['bigdmg'] = S{"Comet","Head Snatch","Quake","Quake II","Tornado","Tornado II","Flare","Flare II","Freeze","Freeze II","Flood","Flood II","Burst","Burst II","Aero V","Fire V","Blizzard V","Thunder V","Stone V","Water V","Aero IV","Fire IV","Blizzard IV","Thunder IV","Stone IV","Water IV"}
defaults.dangerwords['bigdmgaoe'] = S{"Meteor","Discoid","Dragon Breath","Fiery Breath","Glacial Breath","Geotic Breath","Lightning Spear","Stonega III","Stoneja","Aeroga III","Aeroja","Firaga III","Firaja","Blizzaga III","Blizzaja","Waterga III","Thundaga III","Thundaja","Explosive Impulse"}
defaults.dangerwords['status'] = S{"Death","Kaustra"}
defaults.dangerwords['charm'] = S{"Absolute Terror","Stasis","Maiden's Virelai","Brainjack","Danse Macabre","Frog Song"}
defaults.dangerwords['buff'] = S{"Heavy Armature","Raksha Stance","Extreme Purgation"}
defaults.dangerwords['aidsaoe'] = S{"Fulmination","Gates of Hades","Tebbad Wing","Gregale Wing","Thundris Shriek","Ballistic Kick","Optic Induration","Geirrothr"}
defaults.dangerwords['statusaoe'] = S{"Eternal Damnation","Zantetsuken","Breakga","Pleiades Ray","Nerve Gas","Impact Stream"}
defaults.dangerwords['charmaoe'] = S{"Luminous Drape","Frog Chorus","Gala Macabre"}
defaults.dangerwords['buffaoe'] = S{"Arcane Stomp"}
defaults.dangerwords['dmgaoe'] = S{"Homing Missile","Gorge","Arm Cannon"}
-- REMOVED "Aeroga IV", DUE TO AV TESTS

--Fill settings from either defaults table or settings.xml
settings = config.load(defaults)
ohShi_tb = texts.new(settings)

--create tables to be used throughout the addon
tracking = T{}
prims = S{}
--[[ keeping in case the function below doesn't work.
trusts = S{'Kupipi','Excenmille','Naji','Ayame','Zeid','Curilla',
            'NanaaMihgo','Trion','Shantotto','Volker','Ajido-Marujido',
            'MihliAliapoh','Valaineral','Joachim','Lion','Prishe','Ulmia',
            'Ironeater','Gadalar','NajaSalaheem','Cherukiki','Nashmeira',
            'Zazarg','Ingrid','LhekoHabhoka','Ovjang','Mnejing','Sakura',
            'Luzaf','Najelith', 'Maat','Gessho','Aldo','Moogle','Fablinix',
            'D.Shantotto','Elvira','Noillurie','LhuMhakaracca','FerreousCoffin',
            'StarSibyl','Mumor'}]]
 trusts = S(res.spells:type('Trust'):map(string.gsub-{' ', ''} .. table.get-{'name'}))
