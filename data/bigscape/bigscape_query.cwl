cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bigscape
  - query
label: bigscape_query
doc: "Query BGC mode - BiG-SCAPE queries a set of BGCs based on a single BGC query
  in a one-vs-all comparison. For a more comprehensive help menu and tutorials see
  GitHub Wiki.\n\nTool homepage: https://github.com/medema-group/BiG-SCAPE"
inputs:
  - id: alignment_mode
    type:
      - 'null'
      - string
    doc: 'Alignment mode for each pair of gene clusters. global: the whole list of
      domains of each BGC record is compared; local: Seeds the subset of the domains
      used to calculate distance by trying to find the longest slice of common domain
      content (Longest Common Subcluster, LCS) between both records, then extends
      each side (see --extend-strategy). glocal: Starts with performing local, but
      domain selection is then extended to the shortest upstream/downstream arms in
      a compared record pair. auto: use glocal when at least one of the BGCs in each
      pair has the contig_edge annotation from antiSMASH v4+, otherwise use global
      mode on that pair. For an in depth description, see the wiki.'
    default: glocal
    inputBinding:
      position: 101
      prefix: --alignment-mode
  - id: classify
    type:
      - 'null'
      - string
    doc: "By default BiG-SCAPE will compare the query BGC record against any other
      supplied reference BGC records regardless of antiSMASH product class/category.
      Instead, select 'class' or 'category' to run analyses on one class-specific
      bin, in which case only reference BGC records with the same class/category as
      the query record will be compared. Can be used in combination with --legacy-weights
      for .gbks produced by antiSMASH version 6 or higher. For older antiSMASH versions
      or if --legacy-weights is not selected, BiG-SCAPE will use the generic 'mix'
      weights: {JC: 0.2, AI: 0.05, DSS: 0.75, Anchor boost: 2.0}."
    default: none
    inputBinding:
      position: 101
      prefix: --classify
  - id: config_file_path
    type:
      - 'null'
      - File
    doc: Path to BiG-SCAPE config.yml file, which stores values for a series of 
      advanced use parameters.
    default: bundled big_scape/config.yml
    inputBinding:
      position: 101
      prefix: --config-file-path
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Set the max number of cores available (default: use all available cores).'
    inputBinding:
      position: 101
      prefix: --cores
  - id: db_only_output
    type:
      - 'null'
      - boolean
    doc: Do not generate any output besides the data stored in the database. 
      Suitable for advanced users that wish to only make use of the results 
      stored in the SQLite database.
    inputBinding:
      position: 101
      prefix: --db-only-output
  - id: db_path
    type:
      - 'null'
      - File
    doc: Path to sqlite db output file.
    default: output_dir/output_dir.db
    inputBinding:
      position: 101
      prefix: --db-path
  - id: domain_includelist_all_path
    type:
      - 'null'
      - File
    doc: Path to .txt file with phmm domain accessions (commonly, Pfam 
      accessions (e.g. PF00501)). Only regions containing all the listed 
      accessions will be analyzed. In this file, each line contains a single 
      phmm domain accession (with an optional comment, separated by a tab). 
      Lines starting with '#' are ignored. Domain accessions are case-sensitive.
      Cannot be provided in conjuction with --domain-includelist-any-path.
    inputBinding:
      position: 101
      prefix: --domain-includelist-all-path
  - id: domain_includelist_any_path
    type:
      - 'null'
      - File
    doc: Path to .txt file with phmm domain accessions (commonly, Pfam 
      accessions (e.g. PF00501)). Only BGCs containing any of the listed 
      accessions will be analyzed. In this file, each line contains a single 
      phmm domain accession (with an optional comment, separated by a tab). 
      Lines starting with '#' are ignored. Domain accessions are case-sensitive.
      Cannot be provided in conjuction with --domain-includelist-all-path.
    inputBinding:
      position: 101
      prefix: --domain-includelist-any-path
  - id: exclude_gbk
    type:
      - 'null'
      - string
    doc: A comma separated list of strings. If any string in this list occurs in
      the .gbk filename, this file will not be used for the analysis
    default: final
    inputBinding:
      position: 101
      prefix: --exclude-gbk
  - id: extend_strategy
    type:
      - 'null'
      - string
    doc: Strategy to extend the BGCs record pair comparable region. legacy will 
      use the original BiG-SCAPE extend strategy, while greedy and simple match 
      are newly introduced in BiG-SCAPE 2. Legacy and simple match both examine 
      the domain architecture of the record pair in order to find the most 
      relevant extended borders. Greedy is a very simple method that takes the 
      coordinates of the outermost matching domains as the extended borders. For
      more detail see the wiki.
    default: legacy
    inputBinding:
      position: 101
      prefix: --extend-strategy
  - id: force_gbk
    type:
      - 'null'
      - boolean
    doc: 'Recommended for advanced users only. Allows BiG-SCAPE to use non-antiSMASH
      processed .gbk files. If GBK files are found without antiSMASH annotations (specifically,
      BiG-SCAPE checks for the absence of a antiSMASH version feature), BiG-SCAPE
      will still read and parse these files, and will create internal gbk record objects,
      each of which will have a region feature covering the full sequence length and
      a product feature `other`. Warning: BiG-SCAPE still needs CDS features and a
      sequence feature to work with non-antiSMASH .gbks. Furthermore, --include-gbk
      and --exclude-gbk parameters might need to be adjusted if .gbk file names also
      do not follow antiSMASH format. Disclaimer: this feature is still under development,
      use at own risk.'
    inputBinding:
      position: 101
      prefix: --force-gbk
  - id: gbk_dir
    type: Directory
    doc: Input directory containing .gbk files to be used by BiG-SCAPE. 
      Duplicated filenames can be handled, but are not recommended. See the wiki
      for more details.
    inputBinding:
      position: 101
      prefix: --gbk-dir
  - id: gcf_cutoffs
    type:
      - 'null'
      - string
    doc: 'A comma separated list of distance cutoff(s) applied before family generation.
      One or multiple can be provided in each run. If multiple cutoffs are provided,
      BiG-SCAPE will generate one network for each distance cutoff value. Values should
      be in the range [0.0, 1.0]. Example (providing multiple cutoffs): --gcf-cutoffs
      0.1,0.25,0.5,1.0 For more detail see the wiki.'
    default: '0.3'
    inputBinding:
      position: 101
      prefix: --gcf-cutoffs
  - id: include_gbk
    type:
      - 'null'
      - string
    doc: A comma separated list of strings. Only .gbk files that have the 
      string(s) in their filename will be used for the analysis. Use an asterisk
      to accept every file ('*' overrides '--exclude_gbk_str').
    inputBinding:
      position: 101
      prefix: --include-gbk
  - id: input_dir
    type: Directory
    doc: Input directory containing .gbk files to be used by BiG-SCAPE. 
      Duplicated filenames can be handled, but are not recommended. See the wiki
      for more details.
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: input_mode
    type:
      - 'null'
      - string
    doc: 'Tells BiG-SCAPE where to look for input GBK files. recursive: search for
      .gbk files recursively in input directory. Duplicated filenames are not recommended.
      flat: search for .gbk files in input directory only.'
    default: recursive
    inputBinding:
      position: 101
      prefix: --input-mode
  - id: label
    type:
      - 'null'
      - string
    doc: A run label to be added to the output results folder name, as well as 
      dropdown menu in the visualization page. By default, BiG-SCAPE runs will 
      have a name such as [label]_YYYY-MM-DD_HH-MM-SS.
    inputBinding:
      position: 101
      prefix: --label
  - id: legacy_weights
    type:
      - 'null'
      - boolean
    doc: "Use BiG-SCAPE v1 class-based weights in distance calculations. If not selected,
      the distance metric will be based on the 'mix' weights distribution. Warning:
      these weights have not been validated for record types other than region (see
      option --record-type, and wiki)."
    inputBinding:
      position: 101
      prefix: --legacy-weights
  - id: log_path
    type:
      - 'null'
      - File
    doc: Path to output log file.
    default: output_dir/timestamp.log
    inputBinding:
      position: 101
      prefix: --log-path
  - id: mibig_version
    type:
      - 'null'
      - string
    doc: 'MIBiG release number (from 3.1 onwards, antiSMASH processed files of recent
      MIBiG releases might not be immediately available). If not provided, MIBiG will
      not be required, BiG-SCAPE will download the MIBiG database to ./big_scape/MIBiG/mibig_antismash_<version>_gbk.
      For advanced users: any custom (antiSMASH-processed) MIBiG collection can be
      used as long as the expected folder is present, e.g. provide -m mymibig with
      ./big_scape/MIBiG/mibig_antismash_mymibig_gbk. If you wish to use a recent release,
      see the wiki on how to proceed.'
    inputBinding:
      position: 101
      prefix: --mibig-version
  - id: no_db_dump
    type:
      - 'null'
      - boolean
    doc: Do not dump the sqlite database to disk. This will speed up your run, 
      but in case of a crashed run no info will be stored and you'll have to 
      re-start the run from scratch
    inputBinding:
      position: 101
      prefix: --no-db-dump
  - id: no_trees
    type:
      - 'null'
      - boolean
    doc: Do not generate any GCF newick trees. Suitable for users that do not 
      utilize our output visualization, but only make use of the output stored 
      in the .tsv files (which include the network files) and/or SQLite 
      database.
    inputBinding:
      position: 101
      prefix: --no-trees
  - id: output_dir
    type: Directory
    doc: Output directory for all BiG-SCAPE results files.
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: pfam_path
    type:
      - 'null'
      - File
    doc: 'Path to Pfam database `.hmm` file (e.g Pfam-A.hmm). If the `.hmm` file has
      already been pressed and the pressed files are included in the same folder as
      the Pfam `.hmm` file, BiG-SCAPE will also use these pressed files. If this is
      not the case, BiG-SCAPE will run `hmmpress`. Note: the latter requires the user
      to have write permissions to the given Pfam folder.'
    inputBinding:
      position: 101
      prefix: --pfam-path
  - id: profile_path
    type:
      - 'null'
      - File
    doc: Path to output profile file.
    default: output_dir/
    inputBinding:
      position: 101
      prefix: --profile-path
  - id: profiling
    type:
      - 'null'
      - boolean
    doc: 'Run profiler and output profile report. Note: currently only available for
      Linux systems.'
    inputBinding:
      position: 101
      prefix: --profiling
  - id: propagate
    type:
      - 'null'
      - boolean
    doc: By default, BiG-SCAPE will only generate edges between the query and 
      reference BGC records. With the propagate flag, BiG-SCAPE will go through 
      multiple cycles of edge generation until no new reference BGCs are 
      connected to the query connected component. For more details, see the 
      Wiki.
    inputBinding:
      position: 101
      prefix: --propagate
  - id: query_bgc_path
    type: File
    doc: Path to query BGC .gbk file. BiG-SCAPE will compare all BGCs records in
      the input and reference folders to the query in a one-vs-all mode.
    inputBinding:
      position: 101
      prefix: --query-bgc-path
  - id: query_record_number
    type:
      - 'null'
      - int
    doc: 'Query BGC record number. Used to select the specific record from the query
      BGC .gbk, and is only relevant when running --record-type cand_cluster, protocluster
      or proto_core. Warning: if interleaved or chemical hybrid proto cluster/cores
      are merged (see config.yml), the relevant number is that of the first record
      of the merged cluster (the one with the lowest number). e.g. if records 1 and
      2 get merged, the relevant number is 1.'
    inputBinding:
      position: 101
      prefix: --query-record-number
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print any log info to output, only write to logfile.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: record_type
    type:
      - 'null'
      - string
    doc: 'Use a specific type of antiSMASH record for comparison. For every .gbk,
      BiG-SCAPE will try to extract the requested record type, if this is not present,
      BiG-SCAPE will try to extract the next higher level record type, i.e. if a proto_core
      feature is not present, BiG-SCAPE will look for a protocluster feature, and
      so on and so forth. The record type hierarchy is: region>cand_cluster>proto
      cluster>proto_core.. For more detail, see the wiki.'
    default: region
    inputBinding:
      position: 101
      prefix: --record-type
  - id: reference_dir
    type:
      - 'null'
      - Directory
    doc: Path to directory containing user defined, non-MIBiG, antiSMASH 
      processed reference BGCs. Duplicated filenames are not recommended. For 
      more information, see the wiki.
    inputBinding:
      position: 101
      prefix: --reference-dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Prints more detailed information of each step in the analysis, output all
      kinds of logs, including debugging log info, and writes to logfile. Toggle to
      activate. Disclaimer: developed in linux, might not work as well in macOS.'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigscape:2.0.2--pyhdfd78af_0
stdout: bigscape_query.out
