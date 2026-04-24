cwlVersion: v1.2
class: CommandLineTool
baseCommand: sonicparanoid
label: sonicparanoid
doc: "SonicParanoid 2.0.9\n\nTool homepage: http://iwasakilab.bs.s.u-tokyo.ac.jp/sonicparanoid/"
inputs:
  - id: blast
    type:
      - 'null'
      - boolean
    doc: Use Blastp for all-vs-all alignments. This will bypass the -m (--mode) 
      option.
    inputBinding:
      position: 101
      prefix: --blast
  - id: complete_aln
    type:
      - 'null'
      - boolean
    doc: Perform complete alignments (slower), rathen than essential ones.
    inputBinding:
      position: 101
      prefix: --complete-aln
  - id: compression_lev
    type:
      - 'null'
      - int
    doc: Gzip compression level. Integer values between 1 and 9, with 9 and 1 
      being the highest lowest compression levels, respectively.
    inputBinding:
      position: 101
      prefix: --compression-lev
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Show debug lines. WARNING: extremely verbose'
    inputBinding:
      position: 101
      prefix: --debug
  - id: diamond
    type:
      - 'null'
      - string
    doc: Use Diamond with a custom sensitivity. This will bypass the -m (--mode)
      option.
    inputBinding:
      position: 101
      prefix: --diamond
  - id: force_all_threads
    type:
      - 'null'
      - boolean
    doc: Force using all the requested threads.
    inputBinding:
      position: 101
      prefix: --force-all-threads
  - id: graph_only
    type:
      - 'null'
      - boolean
    doc: Perform only graph-based orthology (skip architectures analysis).
    inputBinding:
      position: 101
      prefix: --graph-only
  - id: index_db
    type:
      - 'null'
      - boolean
    doc: 'Index the MMSeqs2/Diamond databases. IMPORTANT: This will use more storage
      but will be slighly faster (5~10%) when processing many big proteomes with MMseqs2.
      The results might also be sligthy different.'
    inputBinding:
      position: 101
      prefix: --index-db
  - id: inflation
    type:
      - 'null'
      - float
    doc: Affects the granularity of ortholog groups. This value should be 
      between 1.2 (very coarse) and 5 (fine grained clustering).
    inputBinding:
      position: 101
      prefix: --inflation
  - id: input_directory
    type: Directory
    doc: Directory containing the proteomes (in FASTA format) of the species to 
      be analyzed.
    inputBinding:
      position: 101
      prefix: --input-directory
  - id: keep_raw_alignments
    type:
      - 'null'
      - boolean
    doc: 'Do not delete raw MMseqs2 alignment files. NOTE: this will triple the space
      required for storing the results.'
    inputBinding:
      position: 101
      prefix: --keep-raw-alignments
  - id: max_len_diff
    type:
      - 'null'
      - float
    doc: 'Maximum allowed length-difference-ratio between main orthologs and canditate
      inparalogs. Example: 0.5 means one of the two sequences could be two times longer
      than the other 0 means no length difference allowed; 1 means any length difference
      allowed.'
    inputBinding:
      position: 101
      prefix: --max-len-diff
  - id: min_arch_merging_cov
    type:
      - 'null'
      - float
    doc: When merging graph- and arch-based orhtologs consider only 
      new-orthologs with a protein coverage greater or equal than this value.
    inputBinding:
      position: 101
      prefix: --min-arch-merging-cov
  - id: min_bitscore
    type:
      - 'null'
      - int
    doc: 'Consider only alignments with bitscores above min- bitscore.Increasing this
      value can be a good idea when comparing very closely related species.Increasing
      this value will reduce the number of paralogs (and orthologs) generate.WARNING:
      use only if you are sure of what you are doing. INFO: higher min-bitscore values
      reduce the execution time for all-vs-all.'
    inputBinding:
      position: 101
      prefix: --min-bitscore
  - id: mmseqs
    type:
      - 'null'
      - string
    doc: Use MMseqs2 with a custom sensitivity (between 1.0 and 7.5). This will 
      bypass the -m (--mode) option.
    inputBinding:
      position: 101
      prefix: --mmseqs
  - id: mode
    type:
      - 'null'
      - string
    doc: SonicParanoid execution mode. The default mode is suitable for most 
      studies. Use sensitive if the input proteomes are not closely related.
    inputBinding:
      position: 101
      prefix: --mode
  - id: no_compress
    type:
      - 'null'
      - boolean
    doc: Skip the compression of processed alignment files.
    inputBinding:
      position: 101
      prefix: --no-compress
  - id: output_pairs
    type:
      - 'null'
      - boolean
    doc: Output a text file with all the pairwise orthologous relationships.
    inputBinding:
      position: 101
      prefix: --output-pairs
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite previous runs and execute it again. This can be useful to 
      update a subset of the computed tables.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: overwrite_tables
    type:
      - 'null'
      - boolean
    doc: This will force the re-computation of the ortholog tables. Only missing
      alignment files will be re-computed.
    inputBinding:
      position: 101
      prefix: --overwrite-tables
  - id: project_id
    type:
      - 'null'
      - string
    doc: Name for the project reflecting the name of run. If not specified it 
      will be automatically generated using the current date and time.
    inputBinding:
      position: 101
      prefix: --project-id
  - id: remove_old_species
    type:
      - 'null'
      - boolean
    doc: (EXPERIMENTAL) Remove alignments and pairwise ortholog tables related 
      to species used in a previous run. This option should be used when 
      updating a run in which some input proteomes were modified or removed.
    inputBinding:
      position: 101
      prefix: --remove-old-species
  - id: seqs_dbs
    type:
      - 'null'
      - Directory
    doc: 'The directory in which the database files created by the selectedlocal alignment
      tool will be stored. DEFAULT: automatically created inside the main output directory.'
    inputBinding:
      position: 101
      prefix: --seqs-dbs
  - id: shared_directory
    type:
      - 'null'
      - Directory
    doc: Directory in which the alignment files are stored. If not specified it 
      is created inside the main output directory.
    inputBinding:
      position: 101
      prefix: --shared-directory
  - id: skip_multi_species
    type:
      - 'null'
      - boolean
    doc: Skip the creation of multi-species ortholog groups.
    inputBinding:
      position: 101
      prefix: --skip-multi-species
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of CPUs to be used.
    inputBinding:
      position: 101
      prefix: --threads
  - id: update_input_names
    type:
      - 'null'
      - boolean
    doc: (EXPERIMENTAL) Remove alignments and pairwise ortholog tables for an 
      input proteome used in a previous which file name conflicts with a newly 
      added species. This option should be used when updating a run in which 
      some input proteomes or their file names were modified.
    inputBinding:
      position: 101
      prefix: --update-input-names
outputs:
  - id: output_directory
    type: Directory
    doc: The directory in which the results will be stored.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sonicparanoid:2.0.9--py312hc9302aa_0
