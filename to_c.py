grammar = 'gramatica_token.txt'
with open(grammar, 'r') as file:
    grammar = file.read()

def to_c():
	grammar_lines = grammar.split('\n')
	for i in range(len(grammar_lines)):
		parts = grammar_lines[i].split('->')
		rule = parts[1].replace('\'\'', '').split()
		grammar_lines[i] = '{'
		for symbol in reversed(rule):
			symbol = symbol.strip()
			if symbol != '':
				grammar_lines[i] += symbol + ', '
		grammar_lines[i] += '-1}'
	rs = '{'
	for line in grammar_lines:
		rs += line
		rs += ',\n'
	rs = rs[:-2] + '}'
	return rs

print to_c()