const fs = require("fs");
const readline = require("readline");
const { program } = require('commander');

async function readFileLineByLine(input, output){
	// TODO: replace file path with arg input
	const fileReadStream = fs.createReadStream(input);
	const fileWriteStream = fs.createWriteStream(output, {flags: "w"});

	let rl = readline.createInterface({
		input: fileReadStream,
		crlfDelay: Infinity
	});

	fileWriteStream.write("@{%\nconst moo = require(\"moo\")\nconst lexer = moo.compile({")
	let regular_lines = [];
	for await (const line of rl){
		if(line.trim()[0] == "%"){
			parts = line.split("->");
			let chunk = `\t${parts[0].slice(1)}: ${parts[1]},\n`;
			fileWriteStream.write(chunk)
		}else{
			regular_lines.push(line);
		}
	}
	fileWriteStream.write("});\n%}\n\n@lexer lexer\n\n");

	regular_lines.forEach((l) => {
		fileWriteStream.write(`${l}\n`);
	});

	fileWriteStream.close();
	fileReadStream.close();
	console.log("done!");
}

program
	.option('-i, --input <value>')
	.option('-o, --output <value>');

program.parse();

const options = program.opts();

readFileLineByLine(options.input, options.output);