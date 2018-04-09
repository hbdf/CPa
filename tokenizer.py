grammar = 'start -> inc dec1\n\
inc -> IMPORTAR STRING \';\' inc\n\
inc -> \'\'\n\
dec1 -> dec dec0\n\
dec0 -> dec1\n\
dec0 -> \'\'\n\
dec -> const-dec\n\
dec -> id-dec \n\
dec -> struct-dec\n\
dec -> enum-dec\n\
const-dec -> \'const\' type ID expr \';\'\n\
id-dec -> type ID id-suffix\n\
id-suffix -> func-dec\n\
id-suffix -> var-dec\n\
func-dec -> \'(\' params \')\' func-end\n\
func-end -> \';\'\n\
func-end -> block\n\
var-dec -> id-init var-dec1\n\
var-dec1 -> \';\'\n\
var-dec1 -> \',\' ID var-dec\n\
id-init -> \'=\' expr\n\
id-init -> \'\'\n\
struct-dec -> \'estrutura\' ID \'{\' var-decs \'}\'\n\
var-decs -> id-dec var-decs\n\
var-decs -> \'\'\n\
enum-dec -> \'enum\' ID \'{\' ids1 \'}\'\n\
ids1 -> ID ids0\n\
ids0 -> \',\' ids1\n\
ids0 -> \'\'\n\
params -> param1\n\
params -> \'\'\n\
param1 -> type ID param0\n\
param0 -> \',\' param1\n\
param0 -> \'\'\n\
type -> basic-type array-type\n\
type -> \'(\' type \')\'\n\
basic-type -> ID\n\
basic-type -> \'int\' \n\
basic-type -> \'caractere\'\n\
basic-type -> \'string\'\n\
basic-type -> \'real\'\n\
basic-type -> \'reald\'\n\
basic-type -> \'vazio\'\n\
basic-type -> \'*\' type\n\
array-type -> \'[\' expr \']\' array-type\n\
array-type -> \'\'\n\
block -> \'{\' stmts \'}\'\n\
stmts -> stmt stmts\n\
stmts -> \'\'\n\
stmt -> dec\n\
stmt -> if\n\
stmt -> switch-case\n\
stmt -> for\n\
stmt -> while\n\
stmt -> do-while\n\
stmt -> block\n\
stmt -> expr \';\'\n\
stmt -> return\n\
stmt -> \'parar\' \';\'\n\
stmt -> \'continuar\' \';\'\n\
stmt -> \'irpara\' ID \';\'\n\
stmt ->  LABEL\n\
return -> \'retornar\' return-expr \';\'\n\
return-expr -> expr\n\
return-expr -> \'\'\n\
if -> \'se\' \'(\' expr \')\' stmt else\n\
else -> \'senao\' stmt\n\
else -> \'\'\n\
while -> \'enquanto\' \'(\' expr \')\' stmt\n\
do-while -> \'faz\' stmt \'enquanto\' \'(\' expr \')\' \';\'\n\
for -> \'para\' ID \'de\' \'(\' expr \')\' for-expr\n\
for-expr -> for-asc\n\
for-expr -> for-desc\n\
for-asc -> \'asc\' \'(\' expr \')\' stmt\n\
for-desc -> \'desc\' \'(\' expr \')\' stmt\n\
switch-case -> \'escolha\' \'(\' expr \')\' \'{\' case1 \'}\' \n\
case1 -> case case0\n\
case0 -> case1\n\
case0 -> \'\'\n\
case -> \'caso\' expr \':\' stmts \n\
case -> \'cc\' \':\' stmts\n\
expr -> attr ternary\n\
ternary -> \'?\' expr \':\' expr\n\
ternary -> \'\'\n\
attr -> logor-chain attr-tail\n\
attr-tail -> attr-op logor-chain\n\
attr-tail -> \'\'\n\
logor-chain -> logand-chain logor-tail\n\
logor-tail -> logor-op logor-chain\n\
logor-tail -> \'\'\n\
logand-chain -> bitor-chain logand-tail\n\
logand-tail -> logand-op logand-chain\n\
logand-tail -> \'\'\n\
bitor-chain -> bitand-chain bitor-tail\n\
bitor-tail -> bitor-op bitor-chain\n\
bitor-tail -> \'\'\n\
bitand-chain -> rel bitand-tail\n\
bitand-tail -> bitand-op bitand-chain\n\
bitand-tail -> \'\'\n\
rel -> shift-chain rel-tail\n\
rel-tail -> rel-op shift-chain \n\
rel-tail -> \'\'\n\
shift-chain -> add-chain shift-tail\n\
shift-tail -> shift-op shift-chain \n\
shift-tail -> \'\'\n\
add-chain -> mul-chain add-tail\n\
add-tail -> add-op add-chain\n\
add-tail -> \'\'\n\
mul-chain -> un-chain mul-tail\n\
mul-tail -> mul-op mul-chain\n\
mul-tail -> \'\'\n\
un-chain -> un-op un-chain\n\
un-chain -> expr-leaf\n\
expr-leaf -> pre-op expr-leaf\n\
expr-leaf -> var-call\n\
expr-leaf -> expr-lit\n\
expr-leaf -> \'(\' expr \')\'\n\
var-call -> var call \n\
call -> \'(\' args \')\'\n\
call -> pos-op \n\
call -> \'\'\n\
args1 -> expr args0\n\
args0 -> \',\' args\n\
args0 -> \'\'\n\
args -> args1\n\
args -> \'\'\n\
expr-lit -> INTEIRO\n\
expr-lit -> REAL\n\
expr-lit -> STRING\n\
expr-lit -> CARACTERE\n\
expr-lit -> array-lit\n\
array-lit -> \'{\' args1 \'}\'\n\
var -> ID var-mods\n\
var-mods -> \'.\' ID var-mods\n\
var-mods -> \'[\' expr \']\' var-mods \n\
var-mods -> \'\'\n\
attr-op -> \'=\' \n\
attr-op -> \'+=\'\n\
attr-op -> \'-=\'\n\
attr-op -> \'*=\'\n\
attr-op -> \'*=\'\n\
attr-op -> \'/=\' \n\
attr-op -> \'pipe=\'\n\
attr-op -> \'or=\'\n\
attr-op -> \'&=\'\n\
attr-op -> \'&&=\'\n\
attr-op -> \'>>=\'\n\
attr-op -> \'<<=\'\n\
pre-op -> \'*\'\n\
pre-op -> \'&\'\n\
pre-op -> \'++\'\n\
pre-op -> \'--\'\n\
pos-op -> \'++\'\n\
pos-op -> \'--\'\n\
mul-op -> \'*\'\n\
mul-op -> \'/\'\n\
mul-op -> \'%\'\n\
un-op -> \'!\'\n\
un-op -> \'-\'\n\
un-op -> \'+\'\n\
add-op -> \'+\' \n\
add-op -> \'-\'\n\
shift-op -> \'<<\' \n\
shift-op -> \'>>\'\n\
rel-op -> \'==\'\n\
rel-op -> \'!=\'\n\
rel-op -> \'>\'\n\
rel-op -> \'<\'\n\
rel-op -> \'>=\'\n\
rel-op -> \'<=\'\n\
bitand-op -> \'&\'\n\
bitor-op -> \'pipe\'\n\
logand-op -> \'&&\'\n\
logor-op -> \'or\'\n'


tokens = {
	'\'*\'' : 'STAR',
	'\'++\'' : 'PLUS2',
	'\'+\'' : 'PLUS',
	'\'--\'' : 'MINUS2',
	'\'-\'' : 'MINUS',
	'\'&\'' : 'AMPERSEND',
	'\'&&\'' : 'AND',
	'\'|\'' : 'PIPE',
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
	'\'int\'' : 'INTEIRO',
	'\'real\'' : 'REAL',
	'\'duplo\'' : 'REALD',
	'\'string\'' : 'STRING',
	'\'reald\'' : 'REALD',
	'\'caractere\'' : 'CARACTERE',
	'\'vazio\'' : 'VAZIO',
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
	'\'enquanto\'' : 'ENQUANTO',
	'\'estrutura\'' : 'ESTRUTURA',
	'\'enum\'' : 'ENUM',
	'\'label\'' : 'LABEL',
	'\'id\'' : 'ID',
	'\'ID\'' : 'ID',
	'\'\'' : 'LAMBDA'
}


def tokenize(gram, toks):
	grammar_lines = grammar.split('\n')
	grammar_words = [line.split(' ') for line in grammar_lines]
	grammar_size = len(grammar_words)
	for i in range(grammar_size):
		for j in range(len(grammar_words[i])):
			if grammar_words[i][j] in tokens.keys():
				grammar_words[i][j] = tokens[grammar_words[i][j]]

	tmp = []
	for words in grammar_words:
		tmp_2 = []
		for word in words:
			tmp_2.append(word)
			tmp_2.append(' ')
		tmp.append(tmp_2)


	rs = ''
	for words in tmp:
		rs += ''.join(words)
		rs += '\n'
	print rs


tokenize(grammar, tokens)