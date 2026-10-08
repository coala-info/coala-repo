cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gottcha2
  - profile
label: gottcha2_profile
doc: "Taxonomic profiling of metagenomic reads: maps reads to a GOTTCHA2 signature database with minimap2 and reports the taxa found.\n\nTool homepage: https://github.com/poeli/gottcha2"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: '$({"class": "Directory", "listing": []})'
      - $(inputs.database_files)
inputs:
  - id: acc_exclusion_list
    type:
      - 'null'
      - File
    doc: List of excluded accessions from the database (e.g. plasmid 
      accessions).
    inputBinding:
      position: 101
      prefix: --accExclusionList
  - id: database
    type: string
    doc: "The path and prefix of the GOTTCHA2 database (for example
      gottcha_db.species.fna; the database files with this prefix must be given
      in database_files)."
    inputBinding:
      position: 101
      prefix: --database
  - id: database_files
    type:
      type: array
      items: File
    doc: Files of the GOTTCHA2 database (.mmi, .stats, .tax.tsv, ...) staged in the
      working directory so that the database prefix resolves.
  - id: db_level
    type:
      - 'null'
      - string
    doc: Specify the taxonomic level of the input database. You can choose one 
      rank from "superkingdom", "phylum", "class", "order", "family", "genus", 
      "species" and "strain". The value will be auto-detected if the input 
      database ended with levels (e.g. GOTTCHA_db.species).
    inputBinding:
      position: 101
      prefix: --dbLevel
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode. Provide verbose running messages and keep all temporary 
      files.
    inputBinding:
      position: 101
      prefix: --debug
  - id: error_rate
    type:
      - 'null'
      - float
    doc: 'Estimated error rate for sequencing data. [default: 0.005]'
    inputBinding:
      position: 101
      prefix: --errorRate
  - id: format
    type:
      - 'null'
      - string
    doc: 'Format of the results; available options include tsv, csv or biom. [default:
      tsv]'
    inputBinding:
      position: 101
      prefix: --format
  - id: input_fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTQ/FASTA file(s). Use space to separate multiple input files.
    inputBinding:
      position: 101
      prefix: --input
  - id: input_sam
    type:
      - 'null'
      - File
    doc: Specify the input SAM file. Use '-' for standard input.
    inputBinding:
      position: 101
      prefix: --sam
  - id: match_fraction
    type:
      - 'null'
      - float
    doc: 'Minimum fraction (0.0-1.0) of the read or signature fragment required to
      be considered a valid match. [default: 0]'
    inputBinding:
      position: 101
      prefix: --matchFraction
  - id: match_identity
    type:
      - 'null'
      - float
    doc: 'Minimum identity (0.0-1.0) required for a valid match. [default: 0]'
    inputBinding:
      position: 101
      prefix: --matchIdentity
  - id: match_length
    type:
      - 'null'
      - int
    doc: 'Minimum length of the alignment required to be considered a valid match.
      [default: 0]'
    inputBinding:
      position: 101
      prefix: --matchLength
  - id: max_zscore
    type:
      - 'null'
      - float
    doc: 'Maximum estimated z-score for the depths of the mapped region. Set to 0
      to disable. [default: 0]'
    inputBinding:
      position: 101
      prefix: --maxZscore
  - id: min_cov
    type:
      - 'null'
      - float
    doc: 'Minimum signature coverage to be considered valid in abundance calculation.
      [default: 0]'
    inputBinding:
      position: 101
      prefix: --minCov
  - id: min_len
    type:
      - 'null'
      - int
    doc: 'Minimum signature length to be considered valid in abundance calculation.
      [default: 0]'
    inputBinding:
      position: 101
      prefix: --minLen
  - id: min_reads
    type:
      - 'null'
      - int
    doc: 'Minimum number of reads to be considered valid in abundance calculation.
      [default: 0]'
    inputBinding:
      position: 101
      prefix: --minReads
  - id: minimap2_options
    type:
      - 'null'
      - string
    doc: "The minimap2 mapping options for short reads. Do not use this option unless
      you know what you are doing. [default: 'auto']"
    inputBinding:
      position: 101
      prefix: --m2options
  - id: mpa
    type:
      - 'null'
      - boolean
    doc: Generate output in MetaPhlAn format.
    inputBinding:
      position: 101
      prefix: --mpa
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: Indicate that the input reads are from Oxford Nanopore sequencing 
      platform. This option enables read splitting and error rate set to 0.03 if
      not specified.
    inputBinding:
      position: 101
      prefix: --nanopore
  - id: no_cutoff
    type:
      - 'null'
      - boolean
    doc: Remove all cutoffs. This option is equivalent to use [-mc 0 -mr 0 -ml 0
      -mf 0 -mz 0 -ss 0,0,0]
    inputBinding:
      position: 101
      prefix: --noCutoff
  - id: outdir
    type: string
    doc: 'Output directory (created before the run) [default: .]'
    default: gottcha2_out
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Prefix of the output file [default: <INPUT_FILE_PREFIX>]'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: preset_minimap2
    type:
      - 'null'
      - string
    doc: "The preset option (-x) for minimap2. Default value 'sr' for short reads.
      [default: sr]"
    inputBinding:
      position: 101
      prefix: --presetx
  - id: rel_abu
    type:
      - 'null'
      - string
    doc: 'The field will be used to calculate relative abundance. You can specify
      one of the following fields: "DEPTH", "READ_COUNT", "GENOMIC_CONTENT_EST". [default:
      DEPTH]'
    inputBinding:
      position: 101
      prefix: --relAbu
  - id: remove_multiple_hits
    type:
      - 'null'
      - string
    doc: "The multiple hit removal step is automatically enabled for sequence input
      files and disabled for SAM files. Users can explicitly control this behavior
      by specifying 'yes' or 'no' to force the step to be enabled or disabled. [default:
      auto]"
    inputBinding:
      position: 101
      prefix: --removeMultipleHits
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Disable all messages.
    inputBinding:
      position: 101
      prefix: --silent
  - id: sni_score
    type:
      - 'null'
      - string
    doc: 'Signature nucleotide identity (SNI) score thresholds for taxonomic aggregation:
      other levels (first), species level (first value), and strain level (second
      value); if only one value is provided, all three levels use that value. [default:
      0.9,0.95,0.99]'
    inputBinding:
      position: 101
      prefix: --sniScore
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Write on standard output.
    inputBinding:
      position: 101
      prefix: --stdout
  - id: tax_info
    type:
      - 'null'
      - File
    doc: Specify the path to the taxonomy information directory or file. The 
      program will attempt to locate a matching .tax.tsv file for the specified 
      database. If it cannot find one, it will use the ‘taxonomy_db’ directory 
      located in the same directory as the executable by default.
    inputBinding:
      position: 101
      prefix: --taxInfo
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads [default: 1]'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Provide verbose messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir_dir
    type: Directory
    doc: 'Output directory with the profile tables, SAM file, log and extracted reads'
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gottcha2:2.2.0--pyhdfd78af_0
stdout: gottcha2_profile.out
