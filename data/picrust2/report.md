# picrust2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| picrust2_add_descriptions.py | PASS |  |
| picrust2_convert_table.py | PASS |  |
| picrust2_hsp.py | PASS |  |
| picrust2_metagenome_pipeline.py | PASS |  |
| picrust2_pathway_pipeline.py | PASS | ran on the EC table from the picrust2 pipeline run; repo test table uses a newer id format than the image |
| picrust2_picrust2_pipeline.py | PASS | ran on picrust2 test sequences with the bundled references; takes about 23 minutes |
| picrust2_place_seqs.py | PASS |  |
| picrust2_shuffle_predictions.py | PASS |  |

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


## picrust2_metagenome_pipeline.py

### Tool Description
Per-sample metagenome functional profiles from predicted functions for each study sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
- **Homepage**: https://github.com/picrust/picrust2
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metagenome_pipeline.py [-h] -i PATH -f PATH [-m PATH]
                              [--max_nsti FLOAT] [--min_reads INT]
                              [--min_samples INT] [--strat_out] [--wide_table]
                              [--skip_norm] [-o PATH] [-v]

Per-sample metagenome functional profiles are generated based on the predicted functions for each study sequence. Note that typically these sequences correspond to OTUs or ASVs. The specified sequence abundance table will be normalized by the predicted number of marker gene copies before outputting the final files by default. The sample metagenome table stratified by contributing ASVs can optionally also be output.

options:
  -h, --help            show this help message and exit
  -i PATH, --input PATH
                        Input table of sequence abundances (BIOM, TSV, or
                        mothur shared file format).
  -f PATH, --function PATH
                        Table of predicted gene family copy numbers (output of
                        hsp.py).
  -m PATH, --marker PATH
                        Table of predicted marker gene copy numbers (output of
                        hsp.py - typically for 16S).
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
  --strat_out           Output table stratified by sequences as well. By
                        default this will be in "contributional" format (i.e.
                        long-format) unless the "--wide_table" option is set.
                        The startified outfile is named
                        "metagenome_contrib.tsv.gz" when in long-format.
  --wide_table          Output wide-format stratified table of metagenome
                        predictions when "--strat_out" is set. This is the
                        deprecated method of generating stratified tables
                        since it is extremely memory intensive. The startified
                        outfile is named "pred_metagenome_strat.tsv.gz" when
                        this option is set.
  --skip_norm           Skip normalizing sequence abundances by predicted
                        marker gene copy numbers (typically 16S rRNA genes).
                        This step will be performed automatically unless this
                        option is specified.
  -o PATH, --out_dir PATH
                        Output directory for metagenome predictions. (default:
                        metagenome_out).
  -v, --version         show program's version number and exit

Usage example:
metagenome_pipeline.py -i seqabun.biom -f predicted_EC.tsv.gz -m predicted_16S.tsv.gz --max_nsti 2.0 -o metagenome_out
  matcher_str= '^\s*%s\s*%s\s*(%s)?\s*$' % (FIRST_MATCH, SECOND_MATCH, _NHX_RE)
```

## picrust2_pathway_pipeline.py

### Tool Description
Infer the presence and abundances of pathways from gene family abundances.

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
- **Homepage**: https://github.com/picrust/picrust2
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pathway_pipeline.py [-h] -i IN_TABLE -o DIRECTORY [-db DATABASE]
                           [-m MAP] [--skip_minpath] [--no_gap_fill]
                           [--intermediate DIR] [-p PROCESSES] [--no_regroup]
                           [--coverage] [-r ID_MAP] [--per_sequence_contrib]
                           [--per_sequence_abun PATH]
                           [--per_sequence_function PATH] [--wide_table]
                           [--verbose] [-v]

Script to infer the presence and abundances of pathways based on gene family abundances in a sample. By default, this script expects a table of EC number abundances (as output by PICRUSt2). However, alternative reaction to pathways mapping files can also be specified. By default, EC numbers are first regrouped to MetaCyc reactions, which are then linked to MetaCyc pathways through the default database.

Stratified output will only be output if a stratified metagenome is input (or if --per_sequence_contrib is set). Please note that by default stratified abundances are based on how much predicted genomes (e.g. sequences) contribute to the community-wide abundance, not the abundance of the pathway based on the predicted genes in that genome alone. In other words, a predicted genome might be contributing greatly to the community-wide pathway abundance simply because one required gene for that pathway is at extremely high abundance in that genome even though no other required genes for that pathway are present. In contrast, the --per_sequence_contrib option should be used to get the predicted abundance and coverage of each pathway based on the predicted gene families within each genome. Note that using the --per_sequence_contrib option can greatly increase runtime.

options:
  -h, --help            show this help message and exit
  -i IN_TABLE, --input IN_TABLE
                        Input TSV table of gene family abundances (either the
                        unstratified or stratified output of
                        metagenome_pipeline.py).
  -o DIRECTORY, --out_dir DIRECTORY
                        Output folder for pathway abundance output.
  -db DATABASE, --database DATABASE
                        Database that is being used for the pathway
                        calculations. Set this to oldIMG if you want to run
                        this script with the old IMG database.
  -m MAP, --map MAP     Mapping of pathways to reactions. The default mapfile
                        maps MetaCyc reactions to prokaryotic MetaCyc pathways
                        (default: /usr/local/lib/python3.12/site-packages/picr
                        ust2/default_files/pathway_mapfiles/metacyc_pathways_s
                        tructured_filtered_v24.txt).
  --skip_minpath        Do not run MinPath to identify which pathways are
                        present as a first pass (on by default).
  --no_gap_fill         Do not perform gap filling before predicting pathway
                        abundances (Gap filling is on otherwise by default.
  --intermediate DIR    Output folder for intermediate files (will be deleted
                        otherwise).
  -p PROCESSES, --processes PROCESSES
                        Number of processes to run in parallel (default: 1).
  --no_regroup          Do not regroup input gene families to reactions as
                        specified in the regrouping mapfile.
  --coverage            Calculate pathway coverages as well as abundances,
                        which are experimental and only useful for advanced
                        users.
  -r ID_MAP, --regroup_map ID_MAP
                        Mapfile of ids to regroup gene families to before
                        running MinPath. The default mapfile is for regrouping
                        EC numbers to MetaCyc reactions (default:
                        /usr/local/lib/python3.12/site-packages/picrust2/defau
                        lt_files/pathway_mapfiles/ec_level4_to_metacyc_rxn_new
                        .tsv).
  --per_sequence_contrib
                        Flag to specify that MinPath is run on the genes
                        contributed by each sequence (i.e. a predicted genome)
                        individually. Note this will greatly increase the
                        runtime. The output will be the predicted pathway
                        abundance contributed by each individual sequence.
                        This is in contrast to the default stratified output,
                        which is the contribution to the community-wide
                        pathway abundances. Experimental pathway coverage
                        stratified by contributing sequence will also be
                        output when --coverage is set. Options
                        --per_sequence_contrib and --per_sequence_function
                        need to be set when this option is used (default:
                        False).
  --per_sequence_abun PATH
                        Path to table of sequence abundances across samples
                        normalized by marker copy number (typically the
                        normalized sequence abundance table output at the
                        metagenome pipeline step). This input is required when
                        the --per_sequence_contrib option is set. (default:
                        None).
  --per_sequence_function PATH
                        Path to table of function abundances per sequence,
                        which was outputted at the hidden-state prediction
                        step. This input is required when the
                        --per_sequence_contrib option is set. Note that this
                        file should be the same input table as used for the
                        metagenome pipeline step (default: None).
  --wide_table          Flag to specify that wide-format stratified table
                        should be output rather than metagenome contribution
                        table. This is the deprecated method of generating
                        stratified tables since it is extremely memory
                        intensive (default: False).
  --verbose             If specified, print out wrapped commands and other
                        details to screen.
  -v, --version         show program's version number and exit

Usage examples:

Default mapping of predicted EC number abundances to MetaCyc pathways:
pathway_pipeline.py -i EC_metagenome_out/pred_metagenome_unstrat.tsv.gz -o pathways_out --processes 1

Mapping predicted KO abundances to legacy KEGG pathways (with stratified output that represents contributions to community-wide abundances):
pathway_pipeline.py -i KO_metagenome_out/pred_metagenome_strat.tsv.gz -o KEGG_pathways_out --no_regroup --map picrust2/picrust2/default_files/pathway_mapfiles/KEGG_pathways_to_KO.tsv

Map EC numbers to MetaCyc pathways and get stratified output corresponding to contribution of predicted gene family abundances within each predicted genome:
pathway_pipeline.py -i EC_metagenome_out/pred_metagenome_unstrat.tsv.gz -o pathways_out_per_seq --per_sequence_contrib --per_sequence_abun EC_metagenome_out/seqtab_norm.tsv.gz --per_sequence_function EC_predicted.tsv.gz
  matcher_str= '^\s*%s\s*%s\s*(%s)?\s*$' % (FIRST_MATCH, SECOND_MATCH, _NHX_RE)
```

## picrust2_convert_table.py

### Tool Description
Convert to and from PICRUSt2 function abundance tables (legacy contributional format, HUMAnN2).

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
- **Homepage**: https://github.com/picrust/picrust2
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: convert_table.py [-h] -o OUTPUT -c CONVERSION [--raw_abun] [-v]
                        INPUT [INPUT ...]

Converts to and from PICRUSt2 function abundance table. Currently supports converting to legacy contributional format and to and from HUMAnN2 function tables. Both stratified and unstratified tables are supported. Note that the categories like "UNMAPPED" in the HUMAnN2 tables will be removed if they have values of 0. The PICRUSt2 "strat" format refers to the deprecated wide-table stratified table format only.

positional arguments:
  INPUT                 Input table to convert. If there are multiple input
                        files (e.g. if multiple HUMAnN2 gene tables for
                        different samples should be converted to a single
                        PICRUSt2 table) then specify them all: file1 file2
                        file3...

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Path to output. Corresponds to folder name if multiple
                        files are output, otherwise it will be a filename.
  -c CONVERSION, --conversion CONVERSION
                        Type of conversion to perform ('contrib_to_legacy',
                        'humann2_unstrat_to_picrust2',
                        'humann2_strat_to_picrust2',
                        'picrust2_unstrat_to_humann2_split',
                        'picrust2_strat_to_humann2_split', or
                        'picrust2_to_humann2_merged').
  --raw_abun            When converting to legacy contributional table output
                        abundance (i.e. OTUAbundanceInSample column) as raw
                        abundance rather than relative abundances (relative
                        abundances are the default).
  -v, --version         show program's version number and exit

Usage example:
convert_table.py -o output.tsv -c humann2_strat_to_picrust2 humann2_out/*.tsv
  matcher_str= '^\s*%s\s*%s\s*(%s)?\s*$' % (FIRST_MATCH, SECOND_MATCH, _NHX_RE)
```

## picrust2_shuffle_predictions.py

### Tool Description
Shuffle sequence ids of a prediction table for a number of replicates.

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
- **Homepage**: https://github.com/picrust/picrust2
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: shuffle_predictions.py [-h] -i OUTPUT -o OUTPUT [-r INT] [-s INT] [-v]

Shuffles sequence ids of prediction table for a specified number of replicates. Note that this means that the prediction table is not totally scrambled across all colunmns: each predicted genome is still the same, but the sequence ids (e.g. the ASV id) linked with each predicted genome is randomized.

options:
  -h, --help            show this help message and exit
  -i OUTPUT, --input OUTPUT
                        Path to input directory.
  -o OUTPUT, --outdir OUTPUT
                        Path to output directory.
  -r INT, --rep INT     Number of shuffled replicates to create (default: 1).
  -s INT, --seed INT    Random seed: set this if you want reproducible
                        shufflings (default: None).
  -v, --version         show program's version number and exit

Usage example:

shuffle_predictions.py -i EC_predicted.tsv.gz -o EC_predicted_shuffled --rep 5
  matcher_str= '^\s*%s\s*%s\s*(%s)?\s*$' % (FIRST_MATCH, SECOND_MATCH, _NHX_RE)
```

## Metadata
- **Skill**: generated
