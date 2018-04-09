grammar = 'gramatica_table_parser.txt'
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
	'\'ID\'' : 'ID',
	'\'\'' : 'LAMBDA'
}


def tokenize():
	grammar_lines = grammar.split('\n')
	grammar_words = [line.split(' ') for line in grammar_lines]
	for i in range(len(grammar_words)):
		for j in range(len(grammar_words[i])):
			if grammar_words[i][j] in tokens.keys():
				grammar_words[i][j] = tokens[grammar_words[i][j]]

	rs = ''
	for words in grammar_words:
		for word in words:
			rs += word + ' '
		rs += '\n'
	return rs

def to_array():
	grammar_lines = tokenize().split('\n')
	for i in range(len(grammar_lines) - 1):
		parts = grammar_lines[i].split('->')
		rule = parts[1].replace('LAMBDA', '').split()
		grammar_lines[i] = '{'
		for symbol in reversed(rule):
			symbol = symbol.strip()
			if symbol != '':
				grammar_lines[i] += symbol.upper().replace('-', '_') + ', '
		grammar_lines[i] += '-1}'

	rs = '{'
	for line in grammar_lines:
		rs += line
		rs += ',\n'
	rs = rs[:-4] + '}'
	return rs

#rs = tokenize()
rs = to_array()
print(rs)