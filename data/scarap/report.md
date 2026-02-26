# scarap CWL Generation Report

## scarap

### Tool Description
scarap: error: unrecognized arguments: -elp

### Metadata
- **Docker Image**: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/scarap
- **Package**: https://anaconda.org/channels/bioconda/packages/scarap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scarap/overview
- **Total Downloads**: 712
- **Last updated**: 2026-02-23
- **GitHub**: https://github.com/swittouck/scarap
- **Stars**: N/A
### Original Help Text
```text
/usr/local/lib/python3.12/site-packages/ete3/coretype/tree.py:387: SyntaxWarning: invalid escape sequence '\-'
  \--- H |
/usr/local/lib/python3.12/site-packages/ete3/coretype/tree.py:458: SyntaxWarning: invalid escape sequence '\-'
  #       /F|      \-B
/usr/local/lib/python3.12/site-packages/ete3/coretype/tree.py:1527: SyntaxWarning: invalid escape sequence '\-'
  #     |    |     \---|     \-b
/usr/local/lib/python3.12/site-packages/ete3/parser/newick.py:51: SyntaxWarning: invalid escape sequence '\['
  _ILEGAL_NEWICK_CHARS = ":;(),\[\]\t\n\r="
/usr/local/lib/python3.12/site-packages/ete3/parser/newick.py:54: SyntaxWarning: invalid escape sequence '\['
  _NHX_RE = "\[&&NHX:[^\]]*\]"
/usr/local/lib/python3.12/site-packages/ete3/parser/newick.py:55: SyntaxWarning: invalid escape sequence '\s'
  _FLOAT_RE = "\s*[+-]?\d+\.?\d*(?:[eE][-+]?\d+)?\s*"
/usr/local/lib/python3.12/site-packages/ete3/parser/newick.py:402: SyntaxWarning: invalid escape sequence '\s'
  matcher_str= '^\s*%s\s*%s\s*(%s)?\s*$' % (FIRST_MATCH, SECOND_MATCH, _NHX_RE)
/usr/local/lib/python3.12/site-packages/ete3/utils.py:82: SyntaxWarning: invalid escape sequence '\['
  return re.sub("\\033\[[^m]+m", "", string)
/usr/local/lib/python3.12/site-packages/ete3/treeview/main.py:64: SyntaxWarning: invalid escape sequence '\d'
  _COLOR_MATCH = re.compile("^#[A-Fa-f\d]{6}$")
/usr/local/lib/python3.12/site-packages/ete3/treeview/main.py:712: SyntaxWarning: invalid escape sequence '\d'
  compatible_code = re.sub('font-size="(\d+)"', 'font-size="\\1pt"', compatible_code)
/usr/local/lib/python3.12/site-packages/ete3/treeview/main.py:714: SyntaxWarning: invalid escape sequence '\s'
  compatible_code = re.sub('<g [^>]+>\s*</g>', '', compatible_code)
/usr/local/lib/python3.12/site-packages/ete3/treeview/faces.py:178: SyntaxWarning: invalid escape sequence '\_'
  :param 0 (inner\_)border.type: 0=solid, 1=dashed, 2=dotted
/usr/local/lib/python3.12/site-packages/ete3/parser/phylip.py:76: SyntaxWarning: invalid escape sequence '\s'
  m = re.match("^\s*(\d+)\s+(\d+)",line)
/usr/local/lib/python3.12/site-packages/ete3/parser/phylip.py:108: SyntaxWarning: invalid escape sequence '\s'
  SG.id2seq[id_counter] += re.sub("\s","", line)
/usr/local/lib/python3.12/site-packages/ete3/parser/phylip.py:123: SyntaxWarning: invalid escape sequence '\s'
  seq = re.sub("\s","",m.groups()[1])
/usr/local/lib/python3.12/site-packages/ete3/parser/phylip.py:138: SyntaxWarning: invalid escape sequence '\s'
  seq = re.sub("\s", "", line)
/usr/local/lib/python3.12/site-packages/ete3/phylo/phylotree.py:132: SyntaxWarning: invalid escape sequence '\d'
  id_match = re.compile("([^0-9])?(\d+)([^0-9])?")
/usr/local/lib/python3.12/site-packages/ete3/phylo/phylotree.py:188: SyntaxWarning: invalid escape sequence '\d'
  id_match = re.compile("([^0-9])(\d+)([^0-9])")
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:74: SyntaxWarning: invalid escape sequence '\('
  k = int(re.sub ('.* \(K=([0-9]+)\)\n', '\\1', line))
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:78: SyntaxWarning: invalid escape sequence '\d'
  re.match ('^[a-z]+.*(\d+\.\d{5} *){'+ str(k) +'}', line):
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:82: SyntaxWarning: invalid escape sequence '\d'
  classes[var] = [float(v) for v in re.findall('\d+\.\d{5}', line)]
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:86: SyntaxWarning: invalid escape sequence '\d'
  k = int(re.sub('.*for (\d+) classes.*\n', '\\1', line))
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:92: SyntaxWarning: invalid escape sequence '\d'
  k = int(re.sub('.*for (\d+) classes.*\n', '\\1', line))
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:217: SyntaxWarning: invalid escape sequence '\('
  model._tree = EvolTree (re.findall ('\(.*\);', ''.join(all_lines))[2])
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:227: SyntaxWarning: invalid escape sequence '\d'
  line = list(map (float, re.findall ('\d\.\d+', all_lines [i+j+1])))
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:240: SyntaxWarning: invalid escape sequence '\d'
  line = re.sub ('.* np: *(\d+)\): +(-\d+\.\d+).*',
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:245: SyntaxWarning: invalid escape sequence '\d'
  line = re.sub ('.* np: *(\d+)\): +(nan).*',
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:252: SyntaxWarning: invalid escape sequence '\d'
  labels = re.findall ('\d+\.\.\d+', line + ' ')
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:258: SyntaxWarning: invalid escape sequence '\d'
  model.stats ['kappa'] = float (re.sub ('.*(\d+\.\d+).*',
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:264: SyntaxWarning: invalid escape sequence '\d'
  if not re.match (' +\d+\.\.\d+ +\d+\.\d+ ', line):
/usr/local/lib/python3.12/site-packages/ete3/evol/parser/codemlparser.py:265: SyntaxWarning: invalid escape sequence '\d'
  if re.match (' +( +\d+\.\d+){8}', all_lines [i+1]):
/usr/local/lib/python3.12/site-packages/ete3/evol/evoltree.py:468: SyntaxWarning: invalid escape sequence '\['
  nwk += sub('\[&&NHX:mark=([ #0-9.]*)\]', r'\1',
/usr/local/lib/python3.12/site-packages/ete3/evol/evoltree.py:471: SyntaxWarning: invalid escape sequence '\['
  nwk = sub('\[&&NHX:mark=([ #0-9.]*)\]', r'\1',
/usr/local/lib/python3.12/site-packages/ete3/tools/utils.py:28: SyntaxWarning: invalid escape sequence '\['
  return re.sub("\\033\[[^m]+m", "", string)
/usr/local/lib/python3.12/site-packages/ete3/evol/model.py:367: SyntaxWarning: invalid escape sequence '\.'
  if sub('\..*', '', model) in AVAIL:
/usr/local/lib/python3.12/site-packages/ete3/evol/model.py:368: SyntaxWarning: invalid escape sequence '\.'
  return model, AVAIL [sub('\..*', '', model)]
/usr/local/lib/python3.12/site-packages/ete3/phylomedb/phylomeDB3.py:75: SyntaxWarning: invalid escape sequence '\w'
  ID_PATTERN = re.compile("^[Pp][Hh][Yy]\w{7}(_\w{2,7})?$")
/usr/local/lib/python3.12/site-packages/ete3/phylomedb/phylomeDB3.py:153: SyntaxWarning: invalid escape sequence '\w'
  m = re.search("Phy(\w{7})_[\w\d]+", name)
/usr/local/lib/python3.12/site-packages/ete3/phylomedb/phylomeDB3.py:500: SyntaxWarning: invalid escape sequence '\w'
  QUERY_OLD_REGEXP_FILTER = "^\w{3}\d{1,}$"
/usr/local/lib/python3.12/site-packages/ete3/phylomedb/phylomeDB3.py:756: SyntaxWarning: invalid escape sequence '\w'
  QUERY_GEN_REGEXP_FILTER = "^[\w\d\-_,;:.|#@\/\\\()'<>!]+$"
/usr/local/lib/python3.12/site-packages/ete3/phylomedb/phylomeDB3.py:757: SyntaxWarning: invalid escape sequence '\w'
  QUERY_OLD_REGEXP_FILTER = "^\w{3}\d{1,}$"
/usr/local/lib/python3.12/site-packages/ete3/phylomedb/phylomeDB3.py:758: SyntaxWarning: invalid escape sequence '\w'
  QUERY_INT_REGEXP_FILTER = "^[Pp][Hh][Yy]\w{7}(_\w{2,7})?$"
usage: scarap [-h]
              {pan,core,build,search,concat,sample,checkgenomes,checkgroups,filter,fetch}
              ...
scarap: error: unrecognized arguments: -elp
```

