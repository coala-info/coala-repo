cwlVersion: v1.2
class: CommandLineTool
baseCommand: ganon build-custom
label: ganon_build-custom
doc: "Build a custom Ganon database.\n\nTool homepage: https://github.com/pirovc/ganon"
inputs:
  - id: db_prefix
    type: string
    doc: Database output prefix
    inputBinding:
      position: 101
      prefix: --db-prefix
  - id: filter_size
    type:
      - 'null'
      - int
    doc: Fixed size for filter in Megabytes (MB). Mutually exclusive --max-fp. 
      Only valid for --filter-type ibf.
    inputBinding:
      position: 101
      prefix: --filter-size
  - id: filter_type
    type:
      - 'null'
      - string
    doc: Variant of bloom filter to use [hibf, ibf]. hibf requires raptor >= 
      v3.0.1 installed or binary path set with --raptor-path. --mode, 
      --filter-size and --min-length will be ignored with hibf. hibf will set 
      --max-fp 0.001 as default.
    inputBinding:
      position: 101
      prefix: --filter-type
  - id: genome_size_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Specific files for genome size estimation - otherwise files will be 
      downloaded
    inputBinding:
      position: 101
      prefix: --genome-size-files
  - id: hash_functions
    type:
      - 'null'
      - int
    doc: The number of hash functions for the interleaved bloom filter [1-5]. 
      With --filter-type ibf, 0 will try to set optimal value.
    inputBinding:
      position: 101
      prefix: --hash-functions
  - id: input_extension
    type:
      - 'null'
      - string
    doc: Required if --input contains folder(s). Wildcards/Shell Expansions not 
      supported (e.g. *).
    inputBinding:
      position: 101
      prefix: --input-extension
  - id: input_file
    type:
      - 'null'
      - File
    doc: 'Tab-separated file with all necessary file/sequence information. Fields:
      file [<tab> target <tab> node <tab> specialization <tab> specialization name].
      For details: https://pirovc.github.io/ganon/custom_databases/. Mutually exclusive
      --input'
    inputBinding:
      position: 101
      prefix: --input-file
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s) and/or folder(s). Mutually exclusive --input-file.
    inputBinding:
      position: 101
      prefix: --input
  - id: input_recursive
    type:
      - 'null'
      - boolean
    doc: Look for files recursively in folder(s) provided with --input
    inputBinding:
      position: 101
      prefix: --input-recursive
  - id: input_target
    type:
      - 'null'
      - string
    doc: Target to use [file, sequence]. Parse input by file or by sequence. 
      Using 'file' is recommended and will speed-up the building process
    inputBinding:
      position: 101
      prefix: --input-target
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: The k-mer size to split sequences.
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: level
    type:
      - 'null'
      - string
    doc: "Max. level to build the database. By default, --level is the --input-target.
      Options: any available taxonomic rank [species, genus, ...] or 'leaves' (requires
      --taxonomy). Further specialization options [assembly, custom]. assembly will
      retrieve and use the assembly accession and name. custom requires and uses the
      specialization field in the --input-file."
    inputBinding:
      position: 101
      prefix: --level
  - id: max_fp
    type:
      - 'null'
      - float
    doc: Max. false positive for bloom filters. Mutually exclusive 
      --filter-size. Defaults to 0.001 with --filter-type hibf or 0.05 with 
      --filter-type ibf.
    inputBinding:
      position: 101
      prefix: --max-fp
  - id: min_length
    type:
      - 'null'
      - int
    doc: Skip sequences smaller then value defined. 0 to not skip any sequence. 
      Only valid for --filter-type ibf.
    inputBinding:
      position: 101
      prefix: --min-length
  - id: mode
    type:
      - 'null'
      - string
    doc: Create smaller or faster filters at the cost of classification speed or
      database size, respectively [avg, smaller, smallest, faster, fastest]. If 
      --filter-size is used, smaller/smallest refers to the false positive rate.
      By default, an average value is calculated to balance classification speed
      and database size. Only valid for --filter-type ibf.
    inputBinding:
      position: 101
      prefix: --mode
  - id: ncbi_file_info
    type:
      - 'null'
      - type: array
        items: string
    doc: Downloads assembly_summary files to extract target information. 
      [refseq, genbank, refseq_historical, genbank_historical or one or more 
      assembly_summary files from https://ftp.ncbi.nlm.nih.gov/genomes/]
    inputBinding:
      position: 101
      prefix: --ncbi-file-info
  - id: ncbi_sequence_info
    type:
      - 'null'
      - type: array
        items: string
    doc: Uses NCBI e-utils webservices or downloads accession2taxid files to 
      extract target information. [eutils, nucl_gb, nucl_wgs, nucl_est, 
      nucl_gss, pdb, prot, dead_nucl, dead_wgs, dead_prot or one or more 
      accession2taxid files from 
      https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/]. By default 
      uses e-utils up-to 50000 sequences or downloads nucl_gb nucl_wgs 
      otherwise.
    inputBinding:
      position: 101
      prefix: --ncbi-sequence-info
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet output mode
    inputBinding:
      position: 101
      prefix: --quiet
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Restart build/update from scratch, do not try to resume from the latest
      possible step. {db_prefix}_files/ will be deleted if present.
    inputBinding:
      position: 101
      prefix: --restart
  - id: skip_genome_size
    type:
      - 'null'
      - boolean
    doc: Do not attempt to get genome sizes. Activate this option when using 
      sequences not representing full genomes.
    inputBinding:
      position: 101
      prefix: --skip-genome-size
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: Set taxonomy to enable taxonomic classification, lca and reports [ncbi,
      gtdb, skip]
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: taxonomy_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Specific files for taxonomy - otherwise files will be downloaded
    inputBinding:
      position: 101
      prefix: --taxonomy-files
  - id: threads
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output mode
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: The window-size to build filter with minimizers.
    inputBinding:
      position: 101
      prefix: --window-size
  - id: write_info_file
    type:
      - 'null'
      - boolean
    doc: Save copy of target info generated to {db_prefix}.info.tsv. Can be 
      re-used as --input-file for further attempts.
    inputBinding:
      position: 101
      prefix: --write-info-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ganon:2.2.0--py312hfc6b275_0
stdout: ganon_build-custom.out
