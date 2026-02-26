# picrust2 CWL Generation Report

## picrust2_picrust2_pipeline.py

### Tool Description
Wrapper for full PICRUSt2 pipeline to be run with two different domains. This is intended for use with the new separate bacteria and archaea trees and reference trait tables. Run sequence placement with EPA-NG and GAPPA to place study sequences (i.e. OTUs and ASVs) into a reference tree. Then runs hidden-state prediction with the castor R package to predict NSTI and marker gene copy number for each study sequence. The domain that best fits each study sequence will then be chosen and hidden-state prediction with the castor R package will be used to predict traits for each genome. Predicted traits for all genomes are combined for both domains Metagenome profiles are then generated, which can be optionally stratified by the contributing sequence. Finally, pathway abundances are predicted based on metagenome profiles. By default, output files include predictions for Enzyme Commission (EC) numbers, KEGG Orthologs (KOs), and MetaCyc pathway abundances. However, this script enables users to use custom reference and trait tables to customize analyses. If you wish to run the previous version of PICRUSt2 (i.e. a single reference for all prokaryotes, please use the picrust2_pipeline.py script. This version was designed for running the separate bacterial and archaeal trees, but could be used for any two domains. If you know that your study sequences only contain bacteria, or only contain archaea, you may wish to run the picrust2_pipeline.py script but specifying bacteria/archaea as the reference database to use.

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
- **Homepage**: https://github.com/picrust/picrust2
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/picrust2/overview
- **Total Downloads**: 61.9K
- **Last updated**: 2026-02-20
- **GitHub**: https://github.com/picrust/picrust2
- **Stars**: N/A
### Original Help Text
```text
usage: picrust2_pipeline.py [-h] -s PATH -i PATH -o PATH [-p PROCESSES]
                            [-t epa-ng|sepp] [-r1 PATH] [-r2 PATH]
                            [--in_traits IN_TRAITS]
                            [--custom_trait_tables_ref1 PATH]
                            [--custom_trait_tables_ref2 PATH]
                            [--marker_gene_table_ref1 PATH]
                            [--marker_gene_table_ref2 PATH]
                            [--pathway_map MAP] [--reaction_func MAP]
                            [--no_pathways] [--regroup_map ID_MAP]
                            [--no_regroup] [--stratified] [--max_nsti FLOAT]
                            [--min_reads INT] [--min_samples INT]
                            [-m {mp,emp_prob,pic,scp,subtree_average}]
                            [-e EDGE_EXPONENT] [--min_align MIN_ALIGN]
                            [--skip_minpath] [--no_gap_fill] [--coverage]
                            [--per_sequence_contrib] [--wide_table]
                            [--skip_norm] [--remove_intermediate] [--verbose]
                            [-v]

Wrapper for full PICRUSt2 pipeline to be run with two different domains. This is intended for use with the new separate bacteria and archaea trees and reference trait tables. Run sequence placement with EPA-NG and GAPPA to place study sequences (i.e. OTUs and ASVs) into a reference tree. Then runs hidden-state prediction with the castor R package to predict NSTI and marker gene copy number for each study sequence. The domain that best fits each study sequence will then be chosen and hidden-state prediction with the castor R package will be used to predict traits for each genome. Predicted traits for all genomes are combined for both domains Metagenome profiles are then generated, which can be optionally stratified by the contributing sequence. Finally, pathway abundances are predicted based on metagenome profiles. By default, output files include predictions for Enzyme Commission (EC) numbers, KEGG Orthologs (KOs), and MetaCyc pathway abundances. However, this script enables users to use custom reference and trait tables to customize analyses. If you wish to run the previous version of PICRUSt2 (i.e. a single reference for all prokaryotes, please use the picrust2_pipeline.py script. This version was designed for running the separate bacterial and archaeal trees, but could be used for any two domains. If you know that your study sequences only contain bacteria, or only contain archaea, you may wish to run the picrust2_pipeline.py script but specifying bacteria/archaea as the reference database to use.

options:
  -h, --help            show this help message and exit
  -s PATH, --study_fasta PATH
                        FASTA of unaligned study sequences (e.g. ASVs). The
                        headerline should be only one field (i.e. no
                        additional whitespace-delimited fields).
  -i PATH, --input PATH
                        Input table of sequence abundances (BIOM, TSV or
                        mothur shared file format).
  -o PATH, --output PATH
                        Output folder for final files.
  -p PROCESSES, --processes PROCESSES
                        Number of processes to run in parallel (default: 1).
  -t epa-ng|sepp, --placement_tool epa-ng|sepp
                        Placement tool to use when placing sequences into
                        reference tree. One of "epa-ng" or "sepp" must be
                        input (default: epa-ng)
  -r1 PATH, --ref_dir1 PATH
                        Directory containing reference sequence files
                        (default: /usr/local/lib/python3.12/site-
                        packages/picrust2/default_files/bacteria/bac_ref).
                        Please see the online documentation for how to name
                        the files in this directory.
  -r2 PATH, --ref_dir2 PATH
                        Directory containing reference sequence files
                        (default: /usr/local/lib/python3.12/site-
                        packages/picrust2/default_files/archaea/arc_ref).
                        Please see the online documentation for how to name
                        the files in this directory.
  --in_traits IN_TRAITS
                        Comma-delimited list (with no spaces) of which gene
                        families to predict from this set: EC, KO, GO, PFAM,
                        BIGG, CAZY, GENE_NAMES. Note that EC numbers will
                        always be predicted unless --no_pathways is set
                        (default: EC,KO).
  --custom_trait_tables_ref1 PATH
                        Optional path to custom trait tables for domain 1 with
                        gene families as columns and genomes as rows
                        (overrides --in_traits setting) to be used for hidden-
                        state prediction. Multiple tables can be specified by
                        delimiting filenames by commas. Importantly, the first
                        custom table specified will be used for inferring
                        pathway abundances. Typically this command would be
                        used with a custom marker gene table
                        (--marker_gene_table) as well.
  --custom_trait_tables_ref2 PATH
                        Optional path to custom trait tables for domain 2 with
                        gene families as columns and genomes as rows
                        (overrides --in_traits setting) to be used for hidden-
                        state prediction. Multiple tables can be specified by
                        delimiting filenames by commas. Importantly, the first
                        custom table specified will be used for inferring
                        pathway abundances. Typically this command would be
                        used with a custom marker gene table
                        (--marker_gene_table) as well.
  --marker_gene_table_ref1 PATH
                        Path to marker gene copy number table for domain 2
                        (16S copy numbers for bacteria by default).
  --marker_gene_table_ref2 PATH
                        Path to marker gene copy number table for domain 2
                        (16S copy numbers for archaea by default).
  --pathway_map MAP     MinPath mapfile. The default mapfile maps MetaCyc
                        reactions to prokaryotic pathways (default:
                        /usr/local/lib/python3.12/site-packages/picrust2/defau
                        lt_files/pathway_mapfiles/metacyc_pathways_structured_
                        filtered_v24.txt).
  --reaction_func MAP   Functional database to use as reactions for inferring
                        pathway abundances (default: EC). This should be
                        either the short-form of the database as specified in
                        --in_traits, or the path to the file as would be
                        specified for --custom_trait_tables. Note that when
                        functions besides the default EC numbers are used
                        typically the --no_regroup option would also be set.
  --no_pathways         Flag to indicate that pathways should NOT be inferred
                        (otherwise they will be inferred by default).
                        Predicted EC number abundances are used to infer
                        pathways when the default reference files are used.
  --regroup_map ID_MAP  Mapfile of ids to regroup gene families to before
                        running MinPath. The default mapfile is for regrouping
                        EC numbers to MetaCyc reactions (default:
                        /usr/local/lib/python3.12/site-packages/picrust2/defau
                        lt_files/pathway_mapfiles/ec_level4_to_metacyc_rxn_new
                        .tsv).
  --no_regroup          Do not regroup input gene families to reactions as
                        specified in the regrouping mapfile. This option
                        should only be used if you are using custom reference
                        and/or mapping files.
  --stratified          Flag to indicate that stratified tables should be
                        generated at all steps (will increase run-time).
  --max_nsti FLOAT      Sequences with NSTI values above this value will be
                        excluded (default: 2).
  --min_reads INT       Minimum number of reads across all samples for each
                        input ASV. ASVs below this cut-off will be counted as
                        part of the "RARE" category in the stratified output
                        (default: 1).
  --min_samples INT     Minimum number of samples that an ASV needs to be
                        identfied within. ASVs below this cut-off will be
                        counted as part of the "RARE" category in the
                        stratified output (default: 1).
  -m {mp,emp_prob,pic,scp,subtree_average}, --hsp_method {mp,emp_prob,pic,scp,subtree_average}
                        HSP method to use."mp": predict discrete traits using
                        max parsimony. "emp_prob": predict discrete traits
                        based on empirical state probabilities across tips.
                        "subtree_average": predict continuous traits using
                        subtree averaging. "pic": predict continuous traits
                        with phylogentic independent contrast. "scp":
                        reconstruct continuous traits using squared-change
                        parsimony (default: mp).
  -e EDGE_EXPONENT, --edge_exponent EDGE_EXPONENT
                        Setting for maximum parisomony hidden-state
                        prediction. Specifies weighting transition costs by
                        the inverse length of edge lengths. If 0, then edge
                        lengths do not influence predictions. Must be a non-
                        negative real-valued number (default: 0.500000).
  --min_align MIN_ALIGN
                        Proportion of the total length of an input query
                        sequence that must align with reference sequences. Any
                        sequences with lengths below this value after making
                        an alignment with reference sequences will be excluded
                        from the placement and all subsequent steps. (default:
                        0).
  --skip_minpath        Do not run MinPath to identify which pathways are
                        present as a first pass (on by default).
  --no_gap_fill         Do not perform gap filling before predicting pathway
                        abundances (Gap filling is on otherwise by default.
  --coverage            Calculate pathway coverages as well as abundances,
                        which are experimental and only useful for advanced
                        users.
  --per_sequence_contrib
                        Flag to specify that MinPath is run on the genes
                        contributed by each sequence (i.e. a predicted genome)
                        individually. Note this will greatly increase the
                        runtime. The output will be the predicted pathway
                        abundance contributed by each individual sequence.
                        This is in contrast to the default stratified output,
                        which is the contribution to the community-wide
                        pathway abundances. Pathway coverage stratified by
                        contributing sequence will also be output when
                        --coverage is set (default: False).
  --wide_table          Output wide-format stratified table of metagenome and
                        pathway predictions when "--stratified" is set. This
                        is the deprecated method of generating stratified
                        tables since it is extremely memory intensive. The
                        stratified filenames contain "strat" rather than
                        "contrib" when this option is used.
  --skip_norm           Skip normalizing sequence abundances by predicted
                        marker gene copy numbers (typically 16S rRNA genes).
                        This step will be performed automatically unless this
                        option is specified.
  --remove_intermediate
                        Remove the intermediate outfiles of the sequence
                        placement and pathway inference steps.
  --verbose             Print out details as commands are run.
  -v, --version         show program's version number and exit

Run full default pipeline with 10 cores (only unstratified output):
picrust2_pipeline.py -s study_seqs.fna -i seqabun.biom -o picrust2_out --processes 10

Run full default pipeline with 10 cores with stratified output (including pathway stratified output based on per-sequence contributions):
picrust2_pipeline.py -s study_seqs.fna -i seqabun.biom -o picrust2_out --processes 10 --stratified --per_sequence_contrib
```


## picrust2_add_descriptions.py

### Tool Description
Add descriptions to PICRUSt2 output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
- **Homepage**: https://github.com/picrust/picrust2
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust2/overview
- **Validation**: PASS

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
usage: add_descriptions.py [-h] -i PATH -o PATH [-m {METACYC,EC,KO,PFAM,GO}]
                           [--custom_map_table PATH] [-v]
add_descriptions.py: error: the following arguments are required: -i/--input, -o/--output
```


## picrust2_place_seqs.py

### Tool Description
Place query sequences onto a reference tree and generate a new tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
- **Homepage**: https://github.com/picrust/picrust2
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust2/overview
- **Validation**: PASS

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
usage: place_seqs.py [-h] -s PATH [-t epa-ng|sepp] [-r PATH] -o PATH
                     [-p PROCESSES] [--intermediate PATH]
                     [--min_align MIN_ALIGN] [--chunk_size CHUNK_SIZE]
                     [--verbose] [-v]
place_seqs.py: error: the following arguments are required: -s/--study_fasta, -o/--out_tree
```


## picrust2_hsp.py

### Tool Description
Calculates the functional profile of a microbial community based on a phylogenetic tree and marker gene information.

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
- **Homepage**: https://github.com/picrust/picrust2
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust2/overview
- **Validation**: PASS

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
usage: hsp.py [-h] -t PATH -o PATH
              [-i {16S,BIGG,CAZY,EC,GENE_NAMES,GO,KO,PFAM,COG,TIGRFAM,PHENO}]
              [-db DATABASE] [-r REFERENCE] [--observed_trait_table PATH]
              [-e EDGE_EXPONENT] [--chunk_size CHUNK_SIZE]
              [-m {mp,emp_prob,pic,scp,subtree_average}] [-n] [--check]
              [-p PROCESSES] [--seed SEED] [--verbose] [-v]
hsp.py: error: the following arguments are required: -t/--tree, -o/--output
```

