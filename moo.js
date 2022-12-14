const moo = require("moo");
let lexer = moo.compile({
	WS: /[ \t]+/,
	comment: /\/\/.*?$/,
	number: /0|[1-9][0-9]*/,
	string: /"(?:\\["\\]|[^\n"\\])*"/,
	lparen: '(',
    rparen:  ')',
    keyword: ['while', 'if', 'else', 'moo', 'cows'],
    NL:      { match: /\n/, lineBreaks: true },
});

lexer.reset("while (10) cows\nmoo");
console.log(lexer.next());
console.log(lexer.next());
console.log(lexer.next());
console.log(lexer.next());
console.log(lexer.next());
console.log(lexer.next());
console.log(lexer.next());
console.log(lexer.next());
console.log(lexer.next());
console.log(lexer.next());