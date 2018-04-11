import pprint

table = 'table.html'
with open(table, 'r') as file:
    table = file.read()

prod = []
prod_dic = {}

def print_array(arr):
	rs = '{'
	for w in arr:
		rs += str(w)
		rs += ','
	rs = rs[:-1] + '}\n'
	return rs

def to_array(rule):
	rule = rule.replace("\n", '').strip()
	parts = rule.split('->')
	if len(parts) < 2:
		return -2
	rule = parts[1].replace('\'\'', '').split()
	if len(rule) == 0:
		return -1

	rs = '{'
	for symbol in reversed(rule):
		symbol = symbol.strip()
		if symbol != '':
			rs += symbol + ', '
	rs += '-1}'
	if rs in prod_dic.keys():
		return prod_dic[rs]
	prod.append(rs)
	i = len(prod) - 1
	prod_dic[rs] = i
	return i

def to_table():
	table_parts = table.split('</thead>')
	table_head = table_parts[0].replace("<tr id=\"llTableHead\">", '').replace("<thead>", '').replace("<th>", "").replace("</tr>", "").split('</th>')
	table_lines = table_parts[1].replace("<tbody id=\"llTableRows\">", '').replace("<tr></tr>", '').replace("<tr>", '').replace("</tbody>", '').split('</tr>')

	lines = []
	for tline in table_lines:
		line = tline.replace("<td nowrap=\"nowrap\">", "").split("</td>")
		line = [to_array(w.replace("\n", '').strip().replace("-&gt;", "->")) for w in line[3:]]
		linestr = print_array(line)
		lines.append(linestr)

	return print_array(lines)

#pp = pprint.PrettyPrinter()
#pp.pprint(table_matrix)

with open('lltable.c', 'w') as file:
    file.write(to_table())

with open('prod.c', 'w') as file:
	file.write(print_array(prod))