# bigscape CWL Generation Report

## bigscape_cluster

### Tool Description
Clustering mode - BiG-SCAPE performs clustering of BGCs into GCFs. For a more comprehensive help menu and tutorials see GitHub Wiki.

### Metadata
- **Docker Image**: quay.io/biocontainers/bigscape:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/medema-group/BiG-SCAPE
- **Package**: https://anaconda.org/channels/bioconda/packages/bigscape/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bigscape/overview
- **Total Downloads**: 12.0K
- **Last updated**: 2026-02-04
- **GitHub**: https://github.com/medema-group/BiG-SCAPE
- **Stars**: N/A
### Original Help Text
```text
Usage: bigscape cluster [OPTIONS]

  BiG-SCAPE - CLUSTER

  Clustering mode - BiG-SCAPE performs clustering of BGCs into GCFs. For a
  more comprehensive help menu and tutorials see GitHub Wiki.

Options:
  -v, --verbose                   Prints more detailed information of each
                                  step in the analysis, output all kinds of
                                  logs, including debugging log info, and
                                  writes to logfile. Toggle to activate.
                                  Disclaimer: developed in linux, might not
                                  work as well in macOS.
  --quiet                         Don't print any log info to output, only
                                  write to logfile.
  -l, --label TEXT                A run label to be added to the output
                                  results folder name, as well as dropdown
                                  menu in the visualization page. By default,
                                  BiG-SCAPE runs will have a name such as
                                  [label]_YYYY-MM-DD_HH-MM-SS.
  -o, --output-dir DIRECTORY      Output directory for all BiG-SCAPE results
                                  files.  [required]
  --log-path FILE                 Path to output log file. (default:
                                  output_dir/timestamp.log).
  -i, --input-dir, --gbk-dir DIRECTORY
                                  Input directory containing .gbk files to be
                                  used by BiG-SCAPE. Duplicated filenames can
                                  be handled, but are not recommended. See the
                                  wiki for more details.  [required]
  --config-file-path FILE         Path to BiG-SCAPE config.yml file, which
                                  stores values for a series of advanced use
                                  parameters. (default: bundled
                                  big_scape/config.yml).
  -c, --cores INTEGER             Set the max number of cores available
                                  (default: use all available cores).
  --input-mode [recursive|flat]   Tells BiG-SCAPE where to look for input GBK
                                  files. recursive: search for .gbk files
                                  recursively in input directory. Duplicated
                                  filenames are not recommended. flat: search
                                  for .gbk files in input directory only.
                                  (default: recursive).
  --include-gbk TEXT              A comma separated list of strings. Only .gbk
                                  files that have the string(s) in their
                                  filename will be used for the analysis. Use
                                  an asterisk to accept every file ('*'
                                  overrides '--exclude_gbk_str'). (default:
                                  cluster,region).
  --exclude-gbk TEXT              A comma separated list of strings. If any
                                  string in this list occurs in the .gbk
                                  filename, this file will not be used for the
                                  analysis (default: final).
  --profiling                     Run profiler and output profile report.
                                  Note: currently only available for Linux
                                  systems.
  -m, --mibig-version TEXT        MIBiG release number (from 3.1 onwards,
                                  antiSMASH processed files of recent MIBiG
                                  releases might not be immediately
                                  available). If not provided, MIBiG will not
                                  be required, BiG-SCAPE will download the
                                  MIBiG database to ./big_scape/MIBiG/mibig_an
                                  tismash_<version>_gbk. For advanced users:
                                  any custom (antiSMASH-processed) MIBiG
                                  collection can be used as long as the
                                  expected folder is present, e.g. provide -m
                                  mymibig with ./big_scape/MIBiG/mibig_antisma
                                  sh_mymibig_gbk. If you wish to use a recent
                                  release, see the wiki on how to proceed.
  -r, --reference-dir DIRECTORY   Path to directory containing user defined,
                                  non-MIBiG, antiSMASH processed reference
                                  BGCs. Duplicated filenames are not
                                  recommended. For more information, see the
                                  wiki.
  -p, --pfam-path FILE            Path to Pfam database `.hmm` file (e.g
                                  `Pfam-A.hmm`). If the `.hmm` file has
                                  already been pressed and the pressed files
                                  are included in the same folder as the Pfam
                                  `.hmm` file, BiG-SCAPE will also use these
                                  pressed files. If this is not the case, BiG-
                                  SCAPE will run `hmmpress`. Note: the latter
                                  requires the user to have write permissions
                                  to the given Pfam folder.
  --domain-includelist-all-path FILE
                                  Path to .txt file with phmm domain
                                  accessions (commonly, Pfam accessions (e.g.
                                  PF00501)). Only regions containing all the
                                  listed accessions will be analyzed. In this
                                  file, each line contains a single phmm
                                  domain accession (with an optional comment,
                                  separated by a tab). Lines starting with '#'
                                  are ignored. Domain accessions are case-
                                  sensitive. Cannot be provided in conjuction
                                  with --domain-includelist-any-path.
  --domain-includelist-any-path FILE
                                  Path to .txt file with phmm domain
                                  accessions (commonly, Pfam accessions (e.g.
                                  PF00501)). Only BGCs containing any of the
                                  listed accessions will be analyzed. In this
                                  file, each line contains a single phmm
                                  domain accession (with an optional comment,
                                  separated by a tab). Lines starting with '#'
                                  are ignored.  Domain accessions are case-
                                  sensitive. Cannot be provided in conjuction
                                  with --domain-includelist-all-path.
  --legacy-weights                Use BiG-SCAPE v1 class-based weights in
                                  distance calculations. If not selected, the
                                  distance metric will be based on the 'mix'
                                  weights distribution. Warning: these weights
                                  have not been validated for record types
                                  other than region (see option --record-type,
                                  and wiki).
  --alignment-mode [global|glocal|local|auto]
                                  Alignment mode for each pair of gene
                                  clusters. global: the whole list of domains
                                  of each BGC record is compared; local: Seeds
                                  the subset of the domains used to calculate
                                  distance by trying to find the longest slice
                                  of common domain content (Longest Common
                                  Subcluster, LCS) between both records, then
                                  extends each side (see --extend-strategy).
                                  glocal: Starts with performing local, but
                                  domain selection is then extended to the
                                  shortest upstream/downstream arms in a
                                  compared record pair. auto: use glocal when
                                  at least one of the BGCs in each pair has
                                  the contig_edge annotation from antiSMASH
                                  v4+, otherwise use global mode on that pair.
                                  For an in depth description, see the wiki.
                                  (default: glocal).
  --extend-strategy [legacy|greedy|simple_match]
                                  Strategy to extend the BGCs record pair
                                  comparable region. legacy will use the
                                  original BiG-SCAPE extend strategy, while
                                  greedy and simple match are newly introduced
                                  in BiG-SCAPE 2. Legacy and simple match both
                                  examine the domain architecture of the
                                  record pair in order to find the most
                                  relevant extended borders. Greedy is a very
                                  simple method that takes the coordinates of
                                  the outermost matching domains as the
                                  extended borders. For more detail see the
                                  wiki. (default: legacy).
  --gcf-cutoffs TEXT              A comma separated list of distance cutoff(s)
                                  applied before family generation. One or
                                  multiple can be provided in each run. If
                                  multiple cutoffs are provided, BiG-SCAPE
                                  will generate one network for each distance
                                  cutoff value. Values should be in the range
                                  `[0.0, 1.0]`. Example (providing multiple
                                  cutoffs): `--gcf-cutoffs 0.1,0.25,0.5,1.0`
                                  For more detail see the wiki. (default:
                                  0.3).
  --profile-path FILE             Path to output profile file. (default:
                                  output_dir/).
  -db, --db-path FILE             Path to sqlite db output file. (default:
                                  output_dir/output_dir.db).
  --record-type [region|cand_cluster|protocluster|proto_core]
                                  Use a specific type of antiSMASH record for
                                  comparison. For every .gbk, BiG-SCAPE will
                                  try to extract the requested record type, if
                                  this is not present, BiG-SCAPE will try to
                                  extract the next higher level record type,
                                  i.e. if a proto_core feature is not present,
                                  BiG-SCAPE will look for a protocluster
                                  feature, and so on and so forth. The record
                                  type hierarchy is: region>cand_cluster>proto
                                  cluster>proto_core.. For more detail, see
                                  the wiki. (default: region).
  --no-db-dump                    Do not dump the sqlite database to disk.
                                  This will speed up your run, but in case of
                                  a crashed run no info will be stored and
                                  you'll have to re-start the run from scratch
  --db-only-output                Do not generate any output besides the data
                                  stored in the database. Suitable for
                                  advanced users that wish to only make use of
                                  the results stored in the SQLite database.
  --no-trees                      Do not generate any GCF newick trees.
                                  Suitable for users that do not utilize our
                                  output visualization, but only make use of
                                  the output stored in the .tsv files (which
                                  include the network files) and/or SQLite
                                  database.
  --force-gbk                     Recommended for advanced users only. Allows
                                  BiG-SCAPE to use non-antiSMASH processed
                                  .gbk files. If GBK files are found without
                                  antiSMASH annotations (specifically, BiG-
                                  SCAPE checks for the absence of a antiSMASH
                                  version feature), BiG-SCAPE will still read
                                  and parse these files, and will create
                                  internal gbk record objects, each of which
                                  will have a region feature covering the full
                                  sequence length and a product feature
                                  `other`. Warning: BiG-SCAPE still needs CDS
                                  features and a sequence feature to work with
                                  non-antiSMASH .gbks. Furthermore, --include-
                                  gbk and --exclude-gbk parameters might need
                                  to be adjusted if .gbk file names also do
                                  not follow antiSMASH format. Disclaimer:
                                  this feature is still under development, use
                                  at own risk.
  --classify [none|class|category|legacy]
                                  Define which method BiG-SCAPE should use to
                                  separate BGC records into analysis bins. '--
                                  classify class' and '--classify category'
                                  use antiSMASH/BGC classes (e.g. T2PKS) or
                                  categories (e.g. PKS) to run analyses on
                                  class/category-based bins, respectively.
                                  
                                  '--classify legacy' is based on BiG-SCAPE v1
                                  predefined groups: PKS1, PKSOther, NRPS,
                                  NRPS-PKS-hybrid, RiPP, Saccharide, Terpene,
                                  Others, and will automatically use
                                  complementary '--legacy-weights'. '--
                                  classify legacy' is available for backwards
                                  compatibility with input .gbks generated
                                  with antiSMASH versions up to version 7. For
                                  higher antiSMASH versions, use at your own
                                  risk, as BGC classes may have changed. All
                                  antiSMASH classes that this legacy mode does
                                  not recognise will be grouped in 'others'.
                                  To update the antiSMASH classes list
                                  yourself, see the config.yml file.
                                  
                                  '--classify class' and '--classify category'
                                  can be used in combination with --legacy-
                                  weights if input .gbks have been generated
                                  by antiSMASH version 6 or higher. For older
                                  antiSMASH versions, either use --classify
                                  'legacy' or do not select --legacy_weights,
                                  which will perform the weighted distance
                                  calculations based on the generic 'mix'
                                  weights. For more detail, see wiki.
                                  (default: category)
  --mix                           Calculate distances using a 'mix' bin,
                                  wherein no classification is applied. This
                                  will do an all-vs-all comparison of all
                                  input BGC records. This bin will use weights
                                  from the 'mix' weights distribution: {JC:
                                  0.2, AI: 0.05, DSS: 0.75, Anchor boost:
                                  2.0}. For more detail, see wiki.
  --hybrids-off                   Toggle to add BGC records with hybrid
                                  predicted classes/categories to each
                                  subclass instead of a hybrid class/network
                                  (e.g. a 'terpene-nrps' BGC would be added to
                                  both the terpene and NRPS classes/networks
                                  instead of the terpene.nrps network). Only
                                  works if any --classify mode is selected.
  --exclude-categories TEXT       A comma separated list of categories. BGCs
                                  that have at least one of the product
                                  categories in this list will be excluded
                                  from the comparison (e.g. 'NRPS,PKS' will
                                  exclude all NRPS or PKS BGCs, even hybrids
                                  like NRPS-terpene). Only available for .gbks
                                  produced by antiSMASH version 6 or higher.
  --include-categories TEXT       A comma separated list of categories. Only
                                  BGCs that have at least one of the product
                                  categories in this list will be included in
                                  the comparison (e.g. 'NRPS' will include
                                  only NRPS BGCs, including hybrids like NRPS-
                                  PKS). Only available for .gbks produced by
                                  antiSMASH version 6 or higher.
  --exclude-classes TEXT          A comma separated list of classes. BGCs that
                                  have at least one of the product classes in
                                  this list will be excluded from the
                                  comparison (e.g. 'T1PKS,T2PKS' will exclude
                                  all T1PKS and T2PKS BGCs, even hybrids like
                                  NRPS-T1PKS).
  --include-classes TEXT          A comma separated list of classes. Only BGCs
                                  that have at least one of the product
                                  classes in this list will be included in the
                                  comparison (e.g. 'T1PKS' will include only
                                  T1PKS BGCs, including hybrids like
                                  NRPS-T1PKS).
  --include-singletons            Include singletons in the network and all
                                  respective output. Reference singletons will
                                  not be included even if this is toggled.
  -h, --help                      Show this message and exit.
```


## bigscape_query

### Tool Description
Query BGC mode - BiG-SCAPE queries a set of BGCs based on a single BGC query in a one-vs-all comparison. For a more comprehensive help menu and tutorials see GitHub Wiki.

### Metadata
- **Docker Image**: quay.io/biocontainers/bigscape:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/medema-group/BiG-SCAPE
- **Package**: https://anaconda.org/channels/bioconda/packages/bigscape/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bigscape query [OPTIONS]

  BiG-SCAPE - QUERY

  Query BGC mode - BiG-SCAPE queries a set of BGCs based on a single BGC query
  in a one-vs-all comparison. For a more comprehensive help menu and tutorials
  see GitHub Wiki.

Options:
  -v, --verbose                   Prints more detailed information of each
                                  step in the analysis, output all kinds of
                                  logs, including debugging log info, and
                                  writes to logfile. Toggle to activate.
                                  Disclaimer: developed in linux, might not
                                  work as well in macOS.
  --quiet                         Don't print any log info to output, only
                                  write to logfile.
  -l, --label TEXT                A run label to be added to the output
                                  results folder name, as well as dropdown
                                  menu in the visualization page. By default,
                                  BiG-SCAPE runs will have a name such as
                                  [label]_YYYY-MM-DD_HH-MM-SS.
  -o, --output-dir DIRECTORY      Output directory for all BiG-SCAPE results
                                  files.  [required]
  --log-path FILE                 Path to output log file. (default:
                                  output_dir/timestamp.log).
  -i, --input-dir, --gbk-dir DIRECTORY
                                  Input directory containing .gbk files to be
                                  used by BiG-SCAPE. Duplicated filenames can
                                  be handled, but are not recommended. See the
                                  wiki for more details.  [required]
  --config-file-path FILE         Path to BiG-SCAPE config.yml file, which
                                  stores values for a series of advanced use
                                  parameters. (default: bundled
                                  big_scape/config.yml).
  -c, --cores INTEGER             Set the max number of cores available
                                  (default: use all available cores).
  --input-mode [recursive|flat]   Tells BiG-SCAPE where to look for input GBK
                                  files. recursive: search for .gbk files
                                  recursively in input directory. Duplicated
                                  filenames are not recommended. flat: search
                                  for .gbk files in input directory only.
                                  (default: recursive).
  --include-gbk TEXT              A comma separated list of strings. Only .gbk
                                  files that have the string(s) in their
                                  filename will be used for the analysis. Use
                                  an asterisk to accept every file ('*'
                                  overrides '--exclude_gbk_str'). (default:
                                  cluster,region).
  --exclude-gbk TEXT              A comma separated list of strings. If any
                                  string in this list occurs in the .gbk
                                  filename, this file will not be used for the
                                  analysis (default: final).
  --profiling                     Run profiler and output profile report.
                                  Note: currently only available for Linux
                                  systems.
  -m, --mibig-version TEXT        MIBiG release number (from 3.1 onwards,
                                  antiSMASH processed files of recent MIBiG
                                  releases might not be immediately
                                  available). If not provided, MIBiG will not
                                  be required, BiG-SCAPE will download the
                                  MIBiG database to ./big_scape/MIBiG/mibig_an
                                  tismash_<version>_gbk. For advanced users:
                                  any custom (antiSMASH-processed) MIBiG
                                  collection can be used as long as the
                                  expected folder is present, e.g. provide -m
                                  mymibig with ./big_scape/MIBiG/mibig_antisma
                                  sh_mymibig_gbk. If you wish to use a recent
                                  release, see the wiki on how to proceed.
  -r, --reference-dir DIRECTORY   Path to directory containing user defined,
                                  non-MIBiG, antiSMASH processed reference
                                  BGCs. Duplicated filenames are not
                                  recommended. For more information, see the
                                  wiki.
  -p, --pfam-path FILE            Path to Pfam database `.hmm` file (e.g
                                  `Pfam-A.hmm`). If the `.hmm` file has
                                  already been pressed and the pressed files
                                  are included in the same folder as the Pfam
                                  `.hmm` file, BiG-SCAPE will also use these
                                  pressed files. If this is not the case, BiG-
                                  SCAPE will run `hmmpress`. Note: the latter
                                  requires the user to have write permissions
                                  to the given Pfam folder.
  --domain-includelist-all-path FILE
                                  Path to .txt file with phmm domain
                                  accessions (commonly, Pfam accessions (e.g.
                                  PF00501)). Only regions containing all the
                                  listed accessions will be analyzed. In this
                                  file, each line contains a single phmm
                                  domain accession (with an optional comment,
                                  separated by a tab). Lines starting with '#'
                                  are ignored. Domain accessions are case-
                                  sensitive. Cannot be provided in conjuction
                                  with --domain-includelist-any-path.
  --domain-includelist-any-path FILE
                                  Path to .txt file with phmm domain
                                  accessions (commonly, Pfam accessions (e.g.
                                  PF00501)). Only BGCs containing any of the
                                  listed accessions will be analyzed. In this
                                  file, each line contains a single phmm
                                  domain accession (with an optional comment,
                                  separated by a tab). Lines starting with '#'
                                  are ignored.  Domain accessions are case-
                                  sensitive. Cannot be provided in conjuction
                                  with --domain-includelist-all-path.
  --legacy-weights                Use BiG-SCAPE v1 class-based weights in
                                  distance calculations. If not selected, the
                                  distance metric will be based on the 'mix'
                                  weights distribution. Warning: these weights
                                  have not been validated for record types
                                  other than region (see option --record-type,
                                  and wiki).
  --alignment-mode [global|glocal|local|auto]
                                  Alignment mode for each pair of gene
                                  clusters. global: the whole list of domains
                                  of each BGC record is compared; local: Seeds
                                  the subset of the domains used to calculate
                                  distance by trying to find the longest slice
                                  of common domain content (Longest Common
                                  Subcluster, LCS) between both records, then
                                  extends each side (see --extend-strategy).
                                  glocal: Starts with performing local, but
                                  domain selection is then extended to the
                                  shortest upstream/downstream arms in a
                                  compared record pair. auto: use glocal when
                                  at least one of the BGCs in each pair has
                                  the contig_edge annotation from antiSMASH
                                  v4+, otherwise use global mode on that pair.
                                  For an in depth description, see the wiki.
                                  (default: glocal).
  --extend-strategy [legacy|greedy|simple_match]
                                  Strategy to extend the BGCs record pair
                                  comparable region. legacy will use the
                                  original BiG-SCAPE extend strategy, while
                                  greedy and simple match are newly introduced
                                  in BiG-SCAPE 2. Legacy and simple match both
                                  examine the domain architecture of the
                                  record pair in order to find the most
                                  relevant extended borders. Greedy is a very
                                  simple method that takes the coordinates of
                                  the outermost matching domains as the
                                  extended borders. For more detail see the
                                  wiki. (default: legacy).
  --gcf-cutoffs TEXT              A comma separated list of distance cutoff(s)
                                  applied before family generation. One or
                                  multiple can be provided in each run. If
                                  multiple cutoffs are provided, BiG-SCAPE
                                  will generate one network for each distance
                                  cutoff value. Values should be in the range
                                  `[0.0, 1.0]`. Example (providing multiple
                                  cutoffs): `--gcf-cutoffs 0.1,0.25,0.5,1.0`
                                  For more detail see the wiki. (default:
                                  0.3).
  --profile-path FILE             Path to output profile file. (default:
                                  output_dir/).
  -db, --db-path FILE             Path to sqlite db output file. (default:
                                  output_dir/output_dir.db).
  --record-type [region|cand_cluster|protocluster|proto_core]
                                  Use a specific type of antiSMASH record for
                                  comparison. For every .gbk, BiG-SCAPE will
                                  try to extract the requested record type, if
                                  this is not present, BiG-SCAPE will try to
                                  extract the next higher level record type,
                                  i.e. if a proto_core feature is not present,
                                  BiG-SCAPE will look for a protocluster
                                  feature, and so on and so forth. The record
                                  type hierarchy is: region>cand_cluster>proto
                                  cluster>proto_core.. For more detail, see
                                  the wiki. (default: region).
  --no-db-dump                    Do not dump the sqlite database to disk.
                                  This will speed up your run, but in case of
                                  a crashed run no info will be stored and
                                  you'll have to re-start the run from scratch
  --db-only-output                Do not generate any output besides the data
                                  stored in the database. Suitable for
                                  advanced users that wish to only make use of
                                  the results stored in the SQLite database.
  --no-trees                      Do not generate any GCF newick trees.
                                  Suitable for users that do not utilize our
                                  output visualization, but only make use of
                                  the output stored in the .tsv files (which
                                  include the network files) and/or SQLite
                                  database.
  --force-gbk                     Recommended for advanced users only. Allows
                                  BiG-SCAPE to use non-antiSMASH processed
                                  .gbk files. If GBK files are found without
                                  antiSMASH annotations (specifically, BiG-
                                  SCAPE checks for the absence of a antiSMASH
                                  version feature), BiG-SCAPE will still read
                                  and parse these files, and will create
                                  internal gbk record objects, each of which
                                  will have a region feature covering the full
                                  sequence length and a product feature
                                  `other`. Warning: BiG-SCAPE still needs CDS
                                  features and a sequence feature to work with
                                  non-antiSMASH .gbks. Furthermore, --include-
                                  gbk and --exclude-gbk parameters might need
                                  to be adjusted if .gbk file names also do
                                  not follow antiSMASH format. Disclaimer:
                                  this feature is still under development, use
                                  at own risk.
  -q, --query-bgc-path FILE       Path to query BGC .gbk file. BiG-SCAPE will
                                  compare all BGCs records in the input and
                                  reference folders to the query in a one-vs-
                                  all mode.  [required]
  -n, --query-record-number INTEGER
                                  Query BGC record number. Used to select the
                                  specific record from the query BGC .gbk, and
                                  is only relevant when running --record-type
                                  cand_cluster, protocluster or proto_core.
                                  Warning: if interleaved or chemical hybrid
                                  proto cluster/cores are merged (see
                                  config.yml), the relevant number is that of
                                  the first record of the merged cluster (the
                                  one with the lowest number). e.g. if records
                                  1 and 2 get merged, the relevant number is
                                  1.
  --propagate                     By default, BiG-SCAPE will only generate
                                  edges between the query and reference BGC
                                  records. With the propagate flag, BiG-SCAPE
                                  will go through multiple cycles of edge
                                  generation until no new reference BGCs are
                                  connected to the query connected component.
                                  For more details, see the Wiki.
  --classify [none|class|category]
                                  By default BiG-SCAPE will compare the query
                                  BGC record against any other supplied
                                  reference BGC records regardless of
                                  antiSMASH  product class/category. Instead,
                                  select 'class' or 'category' to run analyses
                                  on one class-specific bin, in which case
                                  only reference BGC records with the same
                                  class/category as the query record will be
                                  compared. Can be used in combination with
                                  --legacy-weights for .gbks produced by
                                  antiSMASH version 6 or higher. For older
                                  antiSMASH versions or if --legacy-weights is
                                  not selected, BiG-SCAPE will use the generic
                                  'mix' weights: {JC: 0.2, AI: 0.05, DSS:
                                  0.75, Anchor boost: 2.0}. (default: none)
  -h, --help                      Show this message and exit.
```


## bigscape_dereplicate

### Tool Description
Dereplicate mode - BiG-SCAPE performs a pairwise comparison of BGCs based on the protein sequence comparison tool sourmash, clusters them based on a similarity threshold, and selects a representative BGC per cluster.

### Metadata
- **Docker Image**: quay.io/biocontainers/bigscape:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/medema-group/BiG-SCAPE
- **Package**: https://anaconda.org/channels/bioconda/packages/bigscape/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bigscape dereplicate [OPTIONS]

  BiG-SCAPE - DEREPLICATE

  Dereplicate mode - BiG-SCAPE performs a pairwise comparison of BGCs based on
  the protein sequence comparison tool sourmash, clusters them based on a
  similarity threshold, and selects a representative BGC per cluster.

Options:
  -v, --verbose                   Prints more detailed information of each
                                  step in the analysis, output all kinds of
                                  logs, including debugging log info, and
                                  writes to logfile. Toggle to activate.
                                  Disclaimer: developed in linux, might not
                                  work as well in macOS.
  --quiet                         Don't print any log info to output, only
                                  write to logfile.
  -l, --label TEXT                A run label to be added to the output
                                  results folder name, as well as dropdown
                                  menu in the visualization page. By default,
                                  BiG-SCAPE runs will have a name such as
                                  [label]_YYYY-MM-DD_HH-MM-SS.
  -o, --output-dir DIRECTORY      Output directory for all BiG-SCAPE results
                                  files.  [required]
  --log-path FILE                 Path to output log file. (default:
                                  output_dir/timestamp.log).
  -i, --input-dir, --gbk-dir DIRECTORY
                                  Input directory containing .gbk files to be
                                  used by BiG-SCAPE. Duplicated filenames can
                                  be handled, but are not recommended. See the
                                  wiki for more details.  [required]
  --config-file-path FILE         Path to BiG-SCAPE config.yml file, which
                                  stores values for a series of advanced use
                                  parameters. (default: bundled
                                  big_scape/config.yml).
  -c, --cores INTEGER             Set the max number of cores available
                                  (default: use all available cores).
  --input-mode [recursive|flat]   Tells BiG-SCAPE where to look for input GBK
                                  files. recursive: search for .gbk files
                                  recursively in input directory. Duplicated
                                  filenames are not recommended. flat: search
                                  for .gbk files in input directory only.
                                  (default: recursive).
  --include-gbk TEXT              A comma separated list of strings. Only .gbk
                                  files that have the string(s) in their
                                  filename will be used for the analysis. Use
                                  an asterisk to accept every file ('*'
                                  overrides '--exclude_gbk_str'). (default:
                                  cluster,region).
  --exclude-gbk TEXT              A comma separated list of strings. If any
                                  string in this list occurs in the .gbk
                                  filename, this file will not be used for the
                                  analysis (default: final).
  --cutoff FLOAT RANGE            Similarity threshold for sourmash distances.
                                  Only pairs with a similarity equal or above
                                  this value will be considered for
                                  clustering.  [0.0<=x<=1.0]
  -h, --help                      Show this message and exit.
```


## bigscape_benchmark

### Tool Description
Benchmarking mode - Compare a BiG-SCAPE or BiG-SLICE BGC clustering against a known/expected set of BGC <-> GCF assignments. For a more comprehensive help menu and tutorials see GitHub Wiki.

### Metadata
- **Docker Image**: quay.io/biocontainers/bigscape:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/medema-group/BiG-SCAPE
- **Package**: https://anaconda.org/channels/bioconda/packages/bigscape/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bigscape benchmark [OPTIONS]

  BiG-SCAPE - BENCHMARK

  Benchmarking mode - Compare a BiG-SCAPE or BiG-SLICE BGC clustering against
  a known/expected set of BGC <-> GCF assignments. For a more comprehensive
  help menu and tutorials see GitHub Wiki.

Options:
  -v, --verbose                   Prints more detailed information of each
                                  step in the analysis, output all kinds of
                                  logs, including debugging log info, and
                                  writes to logfile. Toggle to activate.
                                  Disclaimer: developed in linux, might not
                                  work as well in macOS.
  --quiet                         Don't print any log info to output, only
                                  write to logfile.
  -l, --label TEXT                A run label to be added to the output
                                  results folder name, as well as dropdown
                                  menu in the visualization page. By default,
                                  BiG-SCAPE runs will have a name such as
                                  [label]_YYYY-MM-DD_HH-MM-SS.
  -o, --output-dir DIRECTORY      Output directory for all BiG-SCAPE results
                                  files.  [required]
  --log-path FILE                 Path to output log file. (default:
                                  output_dir/timestamp.log).
  -g, --GCF-assignment-file FILE  Path to GCF assignments file. BiG-SCAPE will
                                  compare a run output to these assignments.
                                  [required]
  -b, --BiG-dir DIRECTORY         Path to BiG-SCAPE (v1 or v2) or BiG-SLICE
                                  output directory.  [required]
  -h, --help                      Show this message and exit.
```


## Metadata
- **Skill**: generated
