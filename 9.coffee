{_log,test,expect,main} = require './util'

input = '''
{{{},{{{{<e""a!!io<"!!!!"!'!!"u!>},<"o!!}i>,<!>!i<!!!!oi!>},<>},{},{{<!>,<{!u!!!>,<!!'<!>!,,!!"!e'o}>}}},{},{<!!!!"a"<!!eo,!>}!!!>,io!>'!o>}},{{{<!!!'ou!!!>!oe!>!<!!i>,{<!>},<uoue>}},{},{{<}}>,<"'',!!}{!!i{>}}},{{{{<'o!>>,<!>!{u}<e!>a<au!!o!>,<a!!""a!!!>">},{{<i{!>,<"!>e!!'!!!!!>},<'o!!!,!e<o<>},{{}}}},{{<e'!!!!!!i"a!>,<,>},{<'!!!><!}!!{!>},<,"u>}}},{{{{<a{o!!!!!>!><<!!!>},<>}},{<!!"!>e>,{<!>},<"}a"''!!!!!!!>o<}!!,>}}},{{{<!,}!"}!!!>,<'!!!!e!>},<!>},<{!>},<,,!!}}!!u>},{{}}},{{{<i!>,<!><>}},{{}}},{{}}},{{{<>},<!>},<eu'!>},<u!''!!!>!!!>!!<>},{<>}},{{},{<!<<!!e!!!>,<>,{}},{{},{{<>},{{<!>!>!!!!a!>,<!!e}e!>{>}}}}}},{{{},{}}}}},{{{<a}a>}},{<!>,<!!!!'!>,<!!!!'o"a!!eea"!>"e!u>,{{{<!!!!{ua>}}}},{{<}!!<,e>},<<!>,<'{!{ei!!!>>}}}},{{{{{<'!a>,<!!i<o!,!!"<i!>,<!>},<o!!e}!!e<!!!>a>},{{<!!}!>,<!i}o!!i!>"!>},<!>},<e'!!<!>!>,<{!>,<>,{}},{{},{{}}},{<!!u'!>,<}!!!!!>!!!>!>},<!>"!!!>!!ui'>}}},{{<u!{<!!u{{!>},<!>},<a!!!!!!,!!!>},<"{>}},{{},{{{<ei!!!{"!>{!a<!><}<!>},<!!e>,{<!!!>'!!a<!!!>},<u}o<aa'!>,<>}},{<",>}},{<!!!>{!!}!e!>,<<{!>},<<!>,<!<!>},<>,{<'!e!>},<!>,<i!!!!!>!>!>!'>}}},{{<<!>!!{>},{{<!oa{>},{<!>i!{>}}},{{{{{{{<!}ou<,!>,<!!a!>},<">,<,}i!!!>!}!>!!!!!>},<e"i!>io,!>},<!!!>}!!i>}}},{{},{<!!!!!!>,{{},{}}}},{<!>,<>}}},{{{<,!>i!!!>},<!>!{ue!!i>},{{{<,!>!>},<}!!{u'!}!>!!!>!>},<>}},{<u!u!!<<{!!<,}e{ua'>}}},{<!>!!!>!!!!!>!io>}},{{{{<e,iu"!>,<!!!>!>e!{'>,{<'e!!'!,u!>},<u>}},{{<o'!!!>,<!>,<!!!>o!>a<u!>},<ao!!a!o},>}}}},{{{{}},{{<!!'!>},<!!!>},<!!aei<,!>>},{<!!!>!!!>"}!oae>},{{<"!!!<!!!>!>,<'!!!>a,<"!>},<o!>>}}},{{{<!>,<'uo{!{>}},<}!!}<!!!!<e}u!!!>'a!>},<>}},{{{<!!i!!!!{<!!!!oo!!a}'!!!>!!'!!>},<!!!>,{oi{!!,!e!!!<>},{{},{}},{{<e<<!>,<!>,<!!!>},<}"{e<!euue"!"o>},{<e!!!!!>oa>}}}},{{{<!>,<'<!!!>eo!>,<!aa},>,<'"!!!!!>!!e"!!!>'}!!>},{{{<"!>},<{a!!'!!!>!!"!'a!!!!!>!!u>},{<'>}}},{{<a!>i!>},<!'e!>!>!!!><e!>!>},<">},{<<>}}},{{<<u!i}!>,<!!!>>},{}},{{<ao'u!>},<'u{',uo>,<!!a'{ue,>},{}}},{{<!>!!e!>,<e>,{{<!>},<{'!>,<!!!>'a,!!!>!'!>,<<!>!!!<!>,<<{">}}},{<!>},<!}oii!o"!>,<>}}},{{<<!>,<}!"!>!>},<!!!>u>}}},{{<ei!!>}},{{{<!>>,{<>}},{{<!,oa}!!!>o{>},{}},{}},{{<">}},{<o!!!>"uaou!>,"'>,{<!>},<<o",!!!>!>u!e!>,<ui!>},<<>,<,!}}}"!!{e!>,<aeaia'!<>}}}}}},{{{}},{{<!>},<!!!>!!!>,o,o!!o!!!><>}},{{<}'!!!>!>!!a}>,{}},{}}}}},{{{{{{<>},{<eui'a!!<!>,<ie!!<}!u!>},<!>},<{!>,<!!>}},{{}},{<!!!>">,<aou!!,!>,<}"{ee>}},{{}}},{{{{<!!!!"uou>}},<<'"!o,e{a!>},<!>,<">},{{<<!>},<!>},<!>},<i!uu<u!!!!ooie!>},<!>{o>},<a>},{{{},<>},{{<o!!!>ao!!{}{u!>},<,i"!!>}}}},{{<">},{{<!!!><!>},<'!!!>"!>},<"!>,<,""!}ua!>"a>}}},{{{},<<!!!>!>,<a!!!>!>},<'oe!!!>,<!>,<!!!!!>!!!!!!i'!uieo>},{{<!!!>!>},<!!o'i}o!!!!ae!!{"!>>,<!>,<!>},<<e,,!!>},{{<!!!!!>u!!!>{!!oi!>>},{}},{{<a"!eii!!!aa,,',!>,<io>},{<!!o!>},<,>}}}}},{{},{{{<i!!!!!>,<!>},<'"}!!!>}u"o!>,<"!}<<!!>},{{<io!>,<!!!!a!!!>e!!!>!,!!!>ae!a!!"<!!}!>,<e>}}},{<<"!>},<!!>,{<u}>}},{{},{<!oo'!>i!>},<!>,,!!'<!!!>e>}}},{{{<!!!>'{>},<!>,<!>},<}!o>},{<}e!!!>!>,'!>,<!!>,{}},{{},<>}},{}},{{{{<'!!!!!>o!!!,!>,<"'>}}},{{{<!>},<>}},{},{{<e!u"'>,{}}}}}},{{{{{{<!<'u}u<!!">},{{<""ie!"{>}}}},{<}!!!!e<'ioa!>},<"!>},<!eo!>},<!>,<!!u>}},{},{{<<<>,{<!{!>},<!!{!!,!>!a!>"{!!!>!{!!!!iei<>,{{<!!a!u'!!i!aeu!!'!>},<'u!!u">},{{<!!!>},<,"oe!<{!,u!!!>!"!!!>>}}}}},{{<iiia>},<<!!!>!!!!,>},{{<!><!!u>},{<!!!>,<'!>"!>,<>}}}},{{{{},{{{<aeu!>,<{e!!!>!!!!!">},<<!!!>},<"!>u!'{',>},<!!!!!>a!"o",!a!'!u}!>},<"a!>},<>}},{<>,<u!>},<{!!!>,o!!aa"!!'!!!!"!!!>ie>}},{{{<!!a!>,<!!u>}},{{{{<!{'!!!!!><{!>ii>}}},<o!!!>!!!>e!!{!>,u!!o!!!!o>},{{<>}}},{{{{<{!!!!i"i<o!!"!!ui}}>,<!<!>"ui"!!<!>o!>},<!!}!>'",>},{<!!e!>>}},{{{{{<!!ouee}o!"!!e!<a!>},<e,}!!'>},<{o<,o"<a!!!>i!!!>},<,!!!'!!o!>,<u!>>},<<"!>,<{o{!}i!!<>}}},{{{{<!!{!!!>'a'"!ei>},{<!!!!!>,<,!!!>'"e!{<!>,<>}}}}}},{{<"!!!>ai'>},{{{<!>,<"ou"u!>}!!'ue!>},<'o}!>},<a!a>}},<i!>},<"i,u!!!>!!!!!>i"{!!!>>}}},{{{{<!a!!!>!o}!!!>},eo!!!>!>},<!>!>},<!>",!!!!u,>,<!>!!ie,o<',<}!>"oe!>,<!!>},{{<!!!>!i{u>},<u!!i!>},<'o!}eu{}!e>},{{<"<u!>!>,<<!!o'!!!!!!!!!!e!,!!!!'!!!>,'!!!>>},<e'!!o>}},{},{{{{{<"!!!>!!!>}o!>},<u}u}!!e!!!>!!e!!e!!!>>}}}},<!>,<o!!eo!!"!!!>>}},{{{{<{'!iu!>,<}!>},<}>},{<'i>}},{<}ea!!{,o!!!>,<'}oi<,!}a">,<!!!>,<!!!!u,"<i>}},{{<!!!>aei{!>,<!>,<'e<>},{}},{{{},<!>,<>}}},{{<>,<o!>,<i!>},<>}}},{{{{<,"oo!>},<!!!>i<'!!{!>a!!i"!"!!>,<!!i!>i!!a!!!!!>{>}},{{<a>}}},{{{<e{!!!!'>,{<!!o"{,!!!!>}},{{<iia{e<<a!!!!!!'>},<!!!>},<!!o!!!>,<!>},<"!!!!!!!>!!!>!!!!uau<>},{<i"a!!!>a!>{oo,!>},<a!!!>!!ii<}>,{<"!ia!><o!!!ao!!oe,,i'>}}},{{{<"o,!>,!a!!e>},{},{{{<>},<!>},<auii!!!><{>},{<!ia<iu'!u!>!!!>},<!>},<o"!!,>}}},{<!!!>},<!!!!!>'!>},<<!!,"!!{}<>,<o!!!>!>!>}!!!>!>!!!>!>,<!>,<i!!uu<ou">},{{<!>u!>!{,a!}!>,<},i!>,<!!!!""a!!!>,<>}}},{},{{},{<}!>e!!>,<!o!>!!!>},<!"!!u!!!>!!'u!>,<!>>}}},{{{{{<!!{"<u}!!!!!>!!o!i"!!!>!>i!!<}o!>},<!!'>}},<<{<>},{{{<!>},<o!>},<i!!!>!>,<'!>},<>}},{},{{<!>{}!>,<!!,,!!,!!">},{}}},{{{{{<"!!,}{a!!>},<,!{eau>},{<!o!oo!i}!>,<!o>}},{{{},{}}}},{<ao>},{<,!!!>a!>,<'>,{}}}},{{<!a'!!!!!,!{!>!>,<}!>},<!!"!!!>}<,>},{{<>},{}},{<""a!!!>>}}},{},{{{{<!>a!>},<<!!ii!!!>!!!,!!>},{<!!oe!{!>},<a'!>,<!!a!,!>>}},{{<!!>},{{<<ouuu,o",a<!!!}!>},<{{!>o!>,<>},<!!!>,<}o>}},{{<!>},<u!!!!o>,{}}}},{{{{{<a,>},{<!a!!<ii"<!"!!!>!!!>!>,<!!!>,aaa!!!>!>,<!!<>}}},{{<!!!>!!'e{!,",!!!>ii!>">},{{},<}u{!!!>!!!>!!"!!!>}!!">}}},{{<!!u<<e!>iu!!!>!>},<!>,<!>,<>},{},{{<i'!>"!!!!!>u!!!!!>!>,i>},<i{u!<,}!!}a!>,!>!>!!{"!!a>}},{{},{}},{{{<!!o!!!!!<u!>,<}!e>},{<a,!>},<!!!!!>!>,<!{!!!>!>!ao"!a>}},{{{{{<>}},{{},<>},{}},{},{<}e>,{}}}},{}}},{{{<}"!!!>e!!!><>}},{{<'!!!!"u'}aou,a>,{<<e!!,'e""!>!>,<{!>},<!!o!>oa>,{{},<u,!!'!!!><">}}},{{<'!!!>e{!>},<!eo!i!><",>},{{<!!!>a,u!>!>,<}u!!}!>},<>},<",!>},<"!a!!"!>!>},<>}},{<o!!"a!>!!}eiii{>,<!!!>!>!>}!>!!!>,<!>!!!!!!i>}},{{{<e}!>,<{!!a!>!>,<!!aoo!>,<ai!>},<>},{<"o}'"!uo<!{'!!!>{'o'"{>,{}}},{<!!"'"!!}!>}>}}},{{{{{<!>},<e!>},<>},{}},{<{'>},{<o!!e!>,<>,{{}}}},{{},{<u,o!!!!i!!!>},<"!>,<{>},{}},{{{<!>">,<'!!,{!>!!!>,>}},{{{<{<!>},<!"!>},<'>,<!>o!!!!!!"<oe{"<!>!>,<!!aa!>},<>},{<e}"<!>},<!>ie!e!!"{auu<oie>}}}},{{{<}>},<uo!!<{"!!}e'o!>,<a!>},<!>,<!!!>!!!>,<>}}},{{{<<!!!!!!!>!>!>}}{{!!o"e>}},{{}},{<!>},<!!!a!!'!!!>!>e>}},{{},{},{{<>}}},{{{<!!!>u!!!>eo!o}u!}!{!>},<}'i!>},<>,<,!!!>},<'!!!!!!!>'uu!!a<!>,<!!!>,<!!!>e>},{<u!!!>"<!!i{aio>}},{{{<!,>},<i>},{<!!!>e!!!>!!!!u}o!!<!!!>">}},{{<>},{<e!>,<!>},<'!>},<<!!!!!>{}!<}"!>,<!>},<!>!>e>},{<{'{!>!!ae!!>}}}}}}},{{{{{{<">},<}oea!>,<}o>},{<!>,<<!oa!!!!}<u,!>!e!!!o>,{}},{{<!!!>!>,<'a{'>}}}},{{{{},{{<>}}},{<!>,<!!!>}eae'!uuo!!}!!<>,{{<"'i>}}},{<o!>},<}ae!!!>e'{!!!><>}},{{{{<}!>},<!!u!!!>e<'a!!!>,<}ee}!>,!>},<"<">,{<e!,!>"!>!!i!!>}},{{{{<>}},{}},{{<uoi!!<!!!>,<{u}>}},{}},{<>,{<!!!!!!{!!!>,<!>o!!!>},<!!"!!{o>}}},{{{<!>u!!!>!eoeo{!!<!{!!!>,<}i!>},<>,<,!}a!>,<oa<'>},{<o{>},{<"e>,{}}},{<!!u!!!{{>,<e!>,<i!!u!!!!!>{!!!>i!!>}},{{{},<!,!!!>,<u!!!>,<'!!!>},<!>},<!>},<!>},<"!>>}},{{<o!!u!!}!!,!u!!"a>},{<<oua<au'!!!!!!,!>i!!,!>},<',>}}}},{{{<'ei!!!>{!>,<i!!""<"!!!>!!!>>},<oauae!!!>},<!!!>ieu!>,<!!u<!!o{!!e!>>},{{{<!ea!!!!!>!<>}}},{<a!!!!a>,{}}},{{{{{<u{>,{{{{<!a!a!>},<!!{!!!>!!"!>,<i<o"!{!!!>!!!>},<a,!!!!,>}}},{}}},{{<!!}!!!!!>!>"{a!!{!>,<!!"u!!{o>},{<>}},{}}},{}}}},{{{{{<!>,<!>},<u!>o!>e!!,>}}},{},{<!>,<'!!aoa!!!>!!!!!!!>!!!>,<',!!a!>i>}},{{<!","!>!!!>},<oeia,!>}{}">,{<!!,,e!!!>,<!>,i"!<oe!><'{!o>}}}},{{{{{<"e!!i!>>,{<!>!>},<iu!>},<<e'!>!!e<o!>,<!>,<<>}}},{<,"o!e<<!!!!!eu!!!>o!io!>,<!!'oe!!'>,{}}},{{},{}},{{},{{{<!>},<!!oa!!i!>,<!!ea!!>},<o!>},<!!!>!!<>},{{}},{{{<!>'!!e!>},<!>,<a}!>},<!!!>!!!>"}}!!i,'>},<{>},{<!>},<<!!!>!>},<!!}>}}},{{{<'i{i'!>!!e!!!>!{ie!!!!!>,<{!>{!!!!a">},{<!}e!{!>},<ui}{o"!>},<e!!}!""e''!>>}},{<<o!!!>{i,!{>,{{{<!>!!,>}},{<!!!>!>!!!!}iu,!>},<{o!>},<ai!o}<"!!!>>}}}}}}},{{{{<!>,<!!{!!!>},<!!<>},{{{{{<!!!>o{>,{}}},{<!!}'e!!!!!ea!>,<{>}}},{{<}!>,<!>,<e!,'">,{{},<>}},{}},{{{<!>!<{,!>iu{'"o>,{<!!>}},{{<!!!>u>},{}},{}},{{<i"!!!>,ee!!''i!><!!'>},<{!>,<!>,,o,o,i!>},<!!!>,<!>}!>},<"!!!>},<{!!!o>},{{{<!e!u!!!'}!!!!!>!!>,{<o!!!>>,{{{},{{<{!!!>'!>,<!>!>!!o!!!>}!!!>>}}},<!>},<e!>},<!>},<!!!>!>u"e"}!a!'a!u{>}}},{{{{<e!!,<!!!!!>,<'{a!>,<}"!>,<i"<!>},<a<>,{}},<}u!>u,a!>!!!>u!!!!!>u!<!!',>},{{<,u<'!>!>},<>}},{{{{},<}!>},<{ee"}"!>!!<>}},{{<!!a,ae!!!>!!e<'>},<!!!>io!'!>"!!i!!}!>,<!!o,i>},{<!!!,u'"!>,<!!!>!>,<!!!>ei!>!!u!>o,!>},<>}}}}},{{<a!!!>{!>,<o!!ea!!},e}!!{>},{{{<e<}>}}}}}}},{{<!!au!uu!!'<"!}!>u<!!,!!a!>"<o'>},<}!>},<>}},{{<!!{ao!!!>},<!>,<!!!!'{a!!!>aa!'!!!>>},{}}},{{{<'}<!!!>!!>,<!>!>},<!>,<}!!!>!!a'!!!>}!>},<!!!>!',"!>}!>},<!>},<>},{{{<!>,<ae{,!a!e!!a!!!>"{}'!!!>!!!>!!!>{>},{<o,!!"}!!!>!>'!>ea!!!>u!!i>,{{<"a<,}!!",'a!!u}a{}<u!>},<'!!>},<!!}i'!><'!,u<!a}!!i!>>}}},{{<ooo!>},<!>!!!!u'au!!u>},{<>,<!!}}!!!!!>!>u{aeai!>,<!!!!!>!!"}!!'e!!'}>}}},{{{<!!u>},{<!>,<}o}>,{<ei!>,<!>},<ue'a}!!!>!!'!>},<!>},<i>}}}}}},{{{{{{<!>},<ie!>ao!!"}o!>},<>}},{}},{<!>,<{!!!!!>}"!>},<}>}},{{<e"o!>,<,!>,<!>!!!>,<<o!>,<!!',e>}}}},{{{{{},{}},{{{<!!!>!!!>,<iuu!o'i{,"o!'ao!!u>}},{{<}<e<!>},<!>,<a<i!>,<!!!>,<a{a>},{<!!!>},<e<o<i!!!>ia>}}},{<e!!}!>,<'<{!>uu!!i<e{i!!!>a>,<!!e'!!!>,<!!!>,<,,<>}},{{{{},{<"!>},<!!!>},<"!>,<!>}ai!!!!a!'u>},{{},{<!!!>o"!>,<!!}o,!ao}!!!>!>!!!!"{!>o}>}}},{<{!!">}},{{{<,oooe>,{<!!!>eo<{!>,<!>},<!u<!!!>'!!>}},{},{}},{{<{,<}!>,<u!<!o>},{{}}}},{{<!>,<!>},<!!!>,<}!!'}<o>},{{<!!!'!!!>!uu''!!{,oeu!>,<!>{>,<,"'>},{{<e!{,o!>},<!!{!oe!>,<!>}"a""!!!>>},{{},{}}}}}},{{<e!"{{!},,o">}}},{{{{},{<'!!"<!!!>,<<!>},<!>,<!!'"">}},<!!!>},<!>}!,,!!ia{>},{{{{{<e>,{<<oe}ii{!e!!!>},<!!<!!!>!!!>>}},{{}}}},<>},{{<e!!!>!!'>,<}!!<<!!!>,<!!!>!!!>,<},i!>!<>},{}},{{<!!!!!>!>,<!!!>'!>,<o!>},<i,!!!>u,}!>}>},{<!>>}}},{{<u,},o!>!!{!>{>},<!o,i!!!e!i!e!>,<aia",!"o'!e>}},{{{<!!!!a,e!>"a!>},<<iu!!!>a!!!>'!>},<}!ii>},{<!,>,{<!>},<!!}<!>!!>}},{{{{<o!>},<>}},<}e!>},<}!!a>}}}}},{{{{{},{<>}},{<>}},{{<!!!!!>"!!!!!>!i!>!>,<ii!>!>,<!>,<}!!!>,<>},<!>},<!!}a!!!>!!i'!>,<>},{{<u!!o!>},<!>},<<,!!!!a!!<i'u"a>,<a<{,!>},<'!u!>,<>},{<<!!a!!!>!>!>},<!>e"i!>>,{<o>}},{<!>,<>}}},{{}},{{<a!!!!o!>!!!u"!>,<i{i}>,{}},{}}}}},{{{{},{<{<!!!>!>,<u',}!>},<>}},{{},<>}},{},{{<i!!!!<oo,o>},{{{{{<!oa}<o>}},{{{{}}}}},{{<e!!!!!!!!!>,<>}}},{{<{ie!!'!o'!!!>,<!>,<,!>!!{!u!>},<>,<!!!>!!!>!>'<!!!>"eu>},{{{<,!eu!io<!!"ui>,{{},<o{eouo<"!>},<!>,<}<!!eu!!,'!!{{{>}}},{{{},{<!>,<!ea<<,!>!>e>}},{<i!!ii{e!>},<!>},<!!ui!>},<'!>,<"e!!!>"">,{<!!!>>}}}},{{}}},{{<>},<<}>}},{{{},<!!!>>},{{},<!!,a}!>}!!oe'>}}}}},{{{{{<!>,<!!!!!>!!">}}},{{{},{}},{{<!'!!a!>},<e!>!}ie!!{!!>}}},{{{<!>o<<!!!!<!!{u!>'!e!<!!!>e!>,<>}},{{{},<!!e<!o!!!>!u!!{u<!><!!>},<e!!i!oi'!>,<a}!>,<u!>,<>},{<aeo,!!,!!!>{!>a<!<{'}{!!!>!>!!,>,{}}}},{{{{{{{<i}!!'!>!>,<<!>,<>},<!>},<uaea!!uo!!!>,<'{!!}!!!>,uo>}},{<!>u!!!!!>>,<e{'i!!<!>},<e!>},<a!!!>!!!>,<!!!!!!!>,<!'ei,>}}},{{{{<!a'!!!!!>,!!!>""<!e<!!!>>}},{<!!!><i,"<!o'<!>,<e!!!!!>o>,{{{{{<'!>},<!!!e!!!>!!<!>o"oe!>},<,e!!'a>,<!>,<,a!!!u}!!!!!!"!!i!!'i!!"u!>},<>},{<<eu>}}},<!!{!>,<!!!>,<i!!!!ee!!!>!!!>>}}}},{{{{{{<}e!>!>o!>!>'i!!"'<,!>},<{e!!i>},<oiu>},{<,!>},<!u<o!>},<}!>,<!!o>,{<<u"u!{,!>!!'!>,<<<>}}},{<e!>!!!!o!!}i,<!!!>!!!!!!!>!}'!>!!}i>,{<<!>,<a'!>},<e!!!>,u!>},<e!!{!>>}},{{<!>!!!>e,!a,a!!!>o}!>},<<!>},<a'!!{!!a>},<!!!!<!!!>{<!>,<u'"!!!>},<<a>}},{{<!>,<{"!aeoa!!>,<!a!>,<>},{<>}}},{{{<!!!>,<!>,<}e"!>,<>},{<{!>,<!>,<e!!e!>,<u",}!!!>>,{}}}},{{<<>}}}}}},{{{{<ie!>,<>},<}u!>},<'ei>},{{},{{<!!i!'o{!{}!>,<!!!>}}!>,<!!!><">,{<oeo<!!!!!>}{{!!!>{>,<">}},{{{<"a!!a!!!}{<>},{{},<}u>}},{{<!>!>'}!!!>!!!>,<!!!><!!{'!!!>!!!>e>},{{{<!>!>,<!>iu>}}}}},{{<a>,{<!!"!>,<"'!>,<!!!>},<u!>},<!!<!'i!"{!!!!!>a!!>}},<<!>,<!>,<}!!!>!>,<!!o!!{!!'i!!!!!>!!!!!>}!u>}},{{<!!'!o{<<!!!>!>,<"!}}}<}ou>},{<!!!!!>},<>}}},{{<,!!o>}}},{{{{<<!!"u!>!!!>},<!>,<!!!>o!>},<}!'!!!>{>},{<>}}}},{{{<!>},<>},{<!!!>},<uae'!!!>}i>}},{{<!u''o<>}},{{{}},{{<!!!!eiua>},<u!!i!>!>},<i!>!!{!!!><'!<!>{!>!!'>}}},{{}}},{{{},{<{,'!>,!!!>{!!!>,<!!!!i{e!!!!!>!!!>'!!!>>,{<<!i!>,<{{!i!!oe'a!>i"!!a<!}}e">}},{<!!!>i!>},<}!!!>,<'!!!>,<a!>,<,!!!!au!>,<o""e>,{<<!>,<!>,<{'>}}},{{<!!ou!!'!>},!!!>ao!!!>>,{<e<<a!{,a{!!!>!>,<!!}!>},<!!!>!>!>!>>}},{<!!{!!!a<!eu!!'!>!!!>!>}>,<,,,{>},{<!!!!!>,!!>}}},{{{{{<euu!!i"{>},{{},<o{!>!}"ea!!!>>}},{{},{<!>,<!!oe}!>},<'{}!!!i!!!>"!>},<!>},<ie!>,<!!>}},{<o>}},{{{<!>},<e!!oe!>,<e!!!>'a!>u!!<,!!!>>},{<!>},<i>}},{{<!>},<}i!!!!!>e!!!!!>o>},{<>}},{}}},{{{{{<!>i}e'!!!>},<o{!"!!!!<!!!<{!o>},<{!>,<<a,{i!,!!!>!>,<>}},{{{<!'!!!>!<{,"o!>,<!!!>!!o>},{<!>i{'!!!!!i'!>,<!!!>}a!!!>},<>}}}}}}}}
'''

clear_garbage = ( input, cb )->
	inside = no
	escape = no
	cleared = 0
	for c, i in input
		if escape
			escape = no
			continue
		if inside
			switch c
				when '!'
					escape = yes
				when '>'
					inside = no
				else
					++cleared
		else
			switch c
				when '<'
					inside = yes
				else
					cb c
	cleared

get_score = ( input )->
	res = ''
	level = 0
	score = 0
	cleared = clear_garbage input, (c)->
		res+=c
		switch c
			when '{'
				++level
			when '}'
				score += level--
		return
	[score,cleared]

test.score = ->
	expect.nth(0) 1, get_score '{}'
	expect.nth(0) 6, get_score '{{{}}}'
	expect.nth(0) 5, get_score '{{},{}}'
	expect.nth(0) 16, get_score '{{{},{},{{}}}}'
	expect.nth(0) 1, get_score '{<a>,<a>,<a>,<a>}'
	expect.nth(0) 9, get_score '{{<ab>},{<ab>},{<ab>},{<ab>}}'
	expect.nth(0) 9, get_score '{{<!!>},{<!!>},{<!!>},{<!!>}}'
	expect.nth(0) 3, get_score '{{<a!>},{<a!>},{<a!>},{<ab>}}'
	return

test.cleared = ->
	expect.nth(1) 0, get_score '<>'
	expect.nth(1) 17, get_score '<random characters>'
	expect.nth(1) 3, get_score '<<<<>'
	expect.nth(1) 2, get_score '<{!>}>'
	expect.nth(1) 0, get_score '<!!>'
	expect.nth(1) 0, get_score '<!!!>>'
	expect.nth(1) 10, get_score '<{o"i!a,<{i<a>'
	return

main ->
	_log.yellow get_score input
	return
