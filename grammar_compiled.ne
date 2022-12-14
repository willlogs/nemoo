@{%
const moo = require("moo")
const lexer = moo.compile({	ws :  /[ \t]+/,
	number :  /[0-9]+/,
	word :  { match: /[a-z]+/, type: moo.keywords({ times: "x" }) },
	times :  /\*/,
});
%}

@lexer lexer

expr -> multiplication {% id %} | trig {% id %}
multiplication -> %number %ws %times %ws %number {% ([first, , , , second]) => first * second %}
trig -> "sin" %ws %number {% ([, , x]) => Math.sin(x) %}

