grammar = 'gramatica.txt'
with open(grammar, 'r') as file:
    grammar = file.read()

tokens = {
	'\'*\'' : 'STAR',
	'\'++\'' : 'PLUS2',
	'\'+\'' : 'PLUS',
	'\'--\'' : 'MINUS2',
	'\'-\'' : 'MINUS',
	'\'&\'' : 'AMPERSEND',
	'\'&&\'' : 'AND',
	'\'pipe\'' : 'PIPE',
	'\'|\'' : 'PIPE',
	'\'or\'' : 'OR',
	'\'||\'' : 'OR',
	'\'/\'' : 'DIV',
	'\'%\'' : 'MOD',
	'\'+=\'' : 'ATTRADD',
	'\'-=\'' : 'ATTRSUB',
	'\'*=\'' : 'ATTRMUL',
	'\'/=\'' : 'ATTRDIV',
	'\'%=\'' : 'ATTRMOD',
	'\'>>=\'' : 'ATTRSHIFTL',
	'\'<<=\'' : 'ATTRSHIFTR',
	'\'|=\'' : 'ATTRBITOR',
	'\'pipe=\'' : 'ATTRBITOR',
	'\'||=\'' : 'ATTROR',
	'\'or=\'' : 'ATTROR',
	'\'&=\'' : 'ATTRBITAND',
	'\'&&=\'' : 'ATTRAND',
	'\'==\'' : 'EQQ',
	'\'!=\'' : 'NEQ',
	'\'<=\'' : 'LEQ',
	'\'>=\'' : 'GEQ',
	'\'=\'' : 'ATTR',
	'\'!\'' : 'NEG',
	'\'<\'' : 'LT',
	'\'>\'' : 'GT',
	'\'<<\'' : 'SHIFTL',
	'\'>>\'' : 'SHIFTR',
	'\';\'' : 'SEMI',
	'\':\'' : 'COLON',
	'\'.\'' : 'DOT',
	'\',\'' : 'COMMA',
	'\'(\'' : 'LPAREN',
	'\')\'' : 'RPAREN',
	'\'[\'' : 'LBRACKET',
	'\']\'' : 'RBRACKET',
	'\'{\'' : 'LBRACE',
	'\'}\'' : 'RBRACE',
	'\'?\'' : 'QUESTION',
	'\'int\'' : 'TIPO_PRIMITIVO',
	'\'real\'' : 'TIPO_PRIMITIVO',
	'\'duplo\'' : 'TIPO_PRIMITIVO',
	'\'string\'' : 'TIPO_PRIMITIVO',
	'\'reald\'' : 'TIPO_PRIMITIVO',
	'\'caractere\'' : 'TIPO_PRIMITIVO',
	'\'vazio\'' : 'TIPO_PRIMITIVO',
	'\'importar\'' : 'IMPORTAR',
	'\'const\'' : 'CONSTANTE',
	'\'parar\'' : 'PARAR',
	'\'continuar\'' : 'CONTINUAR',
	'\'retornar\'' : 'RETORNAR',
	'\'irpara\'' : 'IRPARA',
	'\'se\'' : 'SE',
	'\'cc\'' : 'CC',
	'\'senao\'' : 'SENAO',
	'\'escolha\'' : 'ESCOLHA',
	'\'caso\'' : 'CASO',
	'\'para\'' : 'PARA',
	'\'de\'' : 'DE',
	'\'asc\'' : 'ASC',
	'\'desc\'' : 'DESC',
	'\'fazer\'' : 'FAZER',
	'\'faz\'' : 'FAZER',
	'\'enquanto\'' : 'ENQUANTO',
	'\'estrutura\'' : 'ESTRUTURA',
	'\'enum\'' : 'ENUM',
	'\'label\'' : 'LABEL',
	'\'id\'' : 'ID',
	'\'ID\'' : 'ID'
}

def transform_grammar():
	grammar_lines = grammar.split('\n')
	lines = []
	for line in grammar_lines:
		parts = line.split('->')
		print parts
		if len(parts) == 2:	
			p0 = parts[0].replace('<', '').replace('>', '')
			p1 = parts[1].replace('<', '').replace('>', '')
			rules = p1.replace('`', '\'').split('|')
			for rule in rules:
				r = rule.replace('LAMBDA', '\'\'')
				lines.append(p0.strip() + " -> " + r.strip())
	rs = ''
	for line in lines:
		rs += line
		rs += '\n'
	return rs[:-1]

def tokenize():
	lines = grammar.split('\n')
	for i in range(len(lines)):
		parts = lines[i].split('->')
		lines[i] = parts[0].upper().replace('-', '_').strip() + ' -> '
		for word in parts[1].split():
			w = word
			if word in tokens.keys():
				w = tokens[w]
			lines[i] += w.upper().replace('-', '_').strip() + ' '
	rs = ''
	for line in lines:
		rs += line
		rs += '\n'
	return rs[:-1]

grammar = transform_grammar()
grammar = tokenize()
with open('gramatica_token.txt', 'w') as file:
    file.write(grammar)