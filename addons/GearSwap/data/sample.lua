function get_sets()

	mote_include_version = 2
	include('Mote-Include.lua')
	
end

function job_setup()

end

function user_setup()

end

function init_gear_sets()

	sets.idle = {main="",sub=""  ,ranged="",ammo=""
				,head="",neck="" ,ear1=""  ,ear2=""
				,body="",hands="",ring1="" ,ring2={ name="Toreador's Ring", augments={'Crit. hit damage +2%','Crit.hit rate+2',}}
				,back="",waist="",legs=""  ,feet=""}

	sets.resting = set_combine(sets.idle,{})
	
	sets.precast.JA['Flee'] = {}
	
	sets.engaged = {}
	
	sets.precast.WS = {}
				
end