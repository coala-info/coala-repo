cwlVersion: v1.2
class: CommandLineTool
baseCommand: piranha
label: piranha-polio_piranha
doc: "Poliovirus Investigation Resource\nAutomating Nanopore Haplotype Analysis\n\n\
  Tool homepage: https://github.com/polio-nanopore/piranha"
inputs:
  - id: all_metadata_to_header
    type:
      - 'null'
      - boolean
    doc: "Parse all fields from input barcode.csv file and\n                     \
      \   include in the output fasta headers. Be aware spaces\n                 \
      \       in metadata will disrupt the record id, so avoid\n                 \
      \       these."
    inputBinding:
      position: 101
      prefix: --all-metadata-to-header
  - id: analysis_mode
    type:
      - 'null'
      - string
    doc: "Specify analysis mode to run, for preconfigured\n                      \
      \  defaults. Options: `vp1`, `wg`. Default: `vp1`"
    default: '`vp1`'
    inputBinding:
      position: 101
      prefix: --analysis-mode
  - id: archive_fastq
    type:
      - 'null'
      - boolean
    doc: "Write the supplied fastq_pass directory to the output\n                \
      \        directory."
    inputBinding:
      position: 101
      prefix: --archive-fastq
  - id: archivedir
    type:
      - 'null'
      - Directory
    doc: "Configure where to put the fastq_pass files, default\n                 \
      \       in the output directory."
    default: in the output directory
    inputBinding:
      position: 101
      prefix: --archivedir
  - id: barcodes_csv
    type: File
    doc: "CSV file describing which barcodes were used on which\n                \
      \        sample"
    inputBinding:
      position: 101
      prefix: --barcodes-csv
  - id: config
    type: File
    doc: "Input config file in yaml format, all command line\n                   \
      \     arguments can be passed via the config file."
    inputBinding:
      position: 101
      prefix: --config
  - id: datestamp
    type:
      - 'null'
      - string
    doc: "Append datestamp to directory name when using\n                        <-o/--outdir>.
      Default: <-o/--outdir> without a\n                        datestamp"
    default: <-o/--outdir> without a datestamp
    inputBinding:
      position: 101
      prefix: --datestamp
  - id: epi_csv
    type:
      - 'null'
      - File
    doc: "CSV file providing EPI-info for the samples. Sample\n                  \
      \      names must correspond to the names in barcodes_csv"
    inputBinding:
      position: 101
      prefix: --epi-csv
  - id: haplotype_sample_size
    type:
      - 'null'
      - int
    doc: "Number of reads to downsample to for haplotype\n                       \
      \ calling. Default: 3000"
    default: 3000
    inputBinding:
      position: 101
      prefix: --haplotype-sample-size
  - id: institute
    type:
      - 'null'
      - string
    doc: "Institute name to appear in report. Default: no\n                      \
      \  institute name"
    default: no institute name
    inputBinding:
      position: 101
      prefix: --institute
  - id: language
    type:
      - 'null'
      - string
    doc: 'Output report language. Options: English, French. Default: English'
    default: English
    inputBinding:
      position: 101
      prefix: --language
  - id: local_database_threshold
    type:
      - 'null'
      - float
    doc: "The threshold beyond which Sabin-related sequences are\n               \
      \         added to the supplementary data directory if update\n            \
      \            local database flag used. Default: 6"
    default: '6'
    inputBinding:
      position: 101
      prefix: --local-database-threshold
  - id: max_haplotypes
    type:
      - 'null'
      - int
    doc: "Maximum number of haplotypes callable within reference\n               \
      \         group. Default: 4"
    default: 4
    inputBinding:
      position: 101
      prefix: --max-haplotypes
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: 'Maximum read length. Default: 1300'
    default: 1300
    inputBinding:
      position: 101
      prefix: --max-read-length
  - id: medaka_list_models
    type:
      - 'null'
      - boolean
    doc: List available medaka models and exit.
    inputBinding:
      position: 101
      prefix: --medaka-list-models
  - id: medaka_model
    type:
      - 'null'
      - string
    doc: "Medaka model to run analysis using. Default:\n                        r941_min_hac_variant_g507"
    default: r941_min_hac_variant_g507
    inputBinding:
      position: 101
      prefix: --medaka-model
  - id: min_allele_frequency
    type:
      - 'null'
      - float
    doc: "Minimum allele frequency to call. Note: setting this\n                 \
      \       below 0.07 may significantly increase run time. Default: 0.07"
    default: 0.07
    inputBinding:
      position: 101
      prefix: --min-allele-frequency
  - id: min_aln_block
    type:
      - 'null'
      - string
    doc: "Minimum alignment block length. Default:\n                        0.6*MIN_READ_LENGTH"
    default: 0.6*MIN_READ_LENGTH
    inputBinding:
      position: 101
      prefix: --min-aln-block
  - id: min_haplotype_depth
    type:
      - 'null'
      - int
    doc: 'Minimum number of reads in a given haplotype. Default: 20'
    default: 20
    inputBinding:
      position: 101
      prefix: --min-haplotype-depth
  - id: min_haplotype_distance
    type:
      - 'null'
      - int
    doc: 'Minimum number of SNPs between haplotypes. Default: 2'
    default: 2
    inputBinding:
      position: 101
      prefix: --min-haplotype-distance
  - id: min_map_quality
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality. Range 0 to 60, however 0 can\n                \
      \        imply a multimapper. Default: 0"
    default: 0
    inputBinding:
      position: 101
      prefix: --min-map-quality
  - id: min_read_depth
    type:
      - 'null'
      - int
    doc: 'Minimum read depth required for consensus generation. Default: 50'
    default: 50
    inputBinding:
      position: 101
      prefix: --min-read-depth
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: 'Minimum read length. Default: 1000'
    default: 1000
    inputBinding:
      position: 101
      prefix: --min-read-length
  - id: min_read_pcent
    type:
      - 'null'
      - float
    doc: "Minimum percentage of sample required for consensus\n                  \
      \      generation. Default: 0"
    default: 0
    inputBinding:
      position: 101
      prefix: --min-read-pcent
  - id: minimap2_options
    type:
      - 'null'
      - type: array
        items: string
    doc: "Specify any number of minimap2 options to overwrite\n                  \
      \      the default mapping settings. The options take the\n                \
      \        form `flag=value` and can be any number of space-\n               \
      \         delimited options. Default: -x asm20. Example: For\n             \
      \           short reads of a sample diverged from the reference,\n         \
      \               we suggest using `-mo k=5 w=4`, which overwrites the\n     \
      \                   minimap2 option `-x asm20`."
    default: -x asm20
    inputBinding:
      position: 101
      prefix: --minimap2-options
  - id: negative_control
    type:
      - 'null'
      - string
    doc: "Sample name of negative control. If multiple samples,\n                \
      \        supply as comma-separated string of sample names. E.g.\n          \
      \              `sample01,sample02` Default: `negative`"
    default: '`negative`'
    inputBinding:
      position: 101
      prefix: --negative-control
  - id: no_temp
    type:
      - 'null'
      - boolean
    doc: "Output all intermediate files. For development/\n                      \
      \  debugging purposes"
    inputBinding:
      position: 101
      prefix: --no-temp
  - id: notes
    type:
      - 'null'
      - string
    doc: 'Miscellaneous notes to appear at top of report. Default: no notes'
    default: no notes
    inputBinding:
      position: 101
      prefix: --notes
  - id: orientation
    type:
      - 'null'
      - string
    doc: "Orientation of barcodes in wells on a 96-well plate.\n                 \
      \       If `well` is supplied as a column in the barcode.csv,\n            \
      \            this default orientation will be overwritten. Default:\n      \
      \                  `vertical`. Options: `vertical` or `horizontal`."
    default: '`vertical`'
    inputBinding:
      position: 101
      prefix: --orientation
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'Output directory. Default: `analysis-2022-XX-YY`'
    default: '`analysis-2022-XX-YY`'
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "Prefix of output directory & report name: Default:\n                   \
      \     `analysis`"
    default: '`analysis`'
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite output directory. Default: append an\n                       \
      \ incrementing number if <-o/--outdir> already exists"
    default: "append an\n                        incrementing number if <-o/--outdir>
      already exists"
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: phylo_metadata_columns
    type:
      - 'null'
      - string
    doc: "Columns in the barcodes.csv file to annotate the\n                     \
      \   phylogeny with. Default: ['call', 'sample_date',\n                     \
      \   'EPID']"
    default: "['call', 'sample_date', 'EPID']"
    inputBinding:
      position: 101
      prefix: --phylo-metadata-columns
  - id: positive_control
    type:
      - 'null'
      - string
    doc: "Sample name of positive control. If multiple samples,\n                \
      \        supply as comma-separated string of sample names. E.g.\n          \
      \              `sample01,sample02`. Default: `positive`"
    default: '`positive`'
    inputBinding:
      position: 101
      prefix: --positive-control
  - id: positive_references
    type:
      - 'null'
      - string
    doc: "Comma separated string of sequences in the reference\n                 \
      \       file to class as positive control sequences."
    inputBinding:
      position: 101
      prefix: --positive-references
  - id: primer_length
    type:
      - 'null'
      - int
    doc: "Length of primer sequences to trim off start and end\n                 \
      \       of reads. Default: 30"
    default: 30
    inputBinding:
      position: 101
      prefix: --primer-length
  - id: publishdir
    type:
      - 'null'
      - Directory
    doc: "Output publish directory. Default: `analysis-2022-XX-\n                \
      \        YY`"
    default: '`analysis-2022-XX-YY`'
    inputBinding:
      position: 101
      prefix: --publishdir
  - id: readdir
    type: Directory
    doc: Path to the directory containing fastq read files
    inputBinding:
      position: 101
      prefix: --readdir
  - id: reference_group_field
    type:
      - 'null'
      - string
    doc: "Specify reference description field to group\n                        references
      by. Default: `ddns_group`"
    default: '`ddns_group`'
    inputBinding:
      position: 101
      prefix: --reference-group-field
  - id: reference_sequences
    type:
      - 'null'
      - File
    doc: Custom reference sequences file.
    inputBinding:
      position: 101
      prefix: --reference-sequences
  - id: run_haplotyping
    type:
      - 'null'
      - boolean
    doc: "Trigger the optional haplotyping module. Additional\n                  \
      \      dependencies may need to be installed."
    inputBinding:
      position: 101
      prefix: --run-haplotyping
  - id: run_phylo
    type:
      - 'null'
      - boolean
    doc: "Trigger the optional phylogenetics module. Additional\n                \
      \        dependencies may need to be installed."
    inputBinding:
      position: 101
      prefix: --run-phylo
  - id: runname
    type:
      - 'null'
      - string
    doc: 'Run name to appear in report. Default: polioDDNS'
    default: polioDDNS
    inputBinding:
      position: 101
      prefix: --runname
  - id: sample_type
    type:
      - 'null'
      - string
    doc: "Specify sample type. Options: `stool`,\n                        `environmental`,
      `isolate`. Default: `stool`"
    default: '`stool`'
    inputBinding:
      position: 101
      prefix: --sample-type
  - id: save_config
    type:
      - 'null'
      - boolean
    doc: Output the config file with all parameters used
    inputBinding:
      position: 101
      prefix: --save-config
  - id: supplementary_datadir
    type:
      - 'null'
      - Directory
    doc: "Path to directory containing supplementary sequence\n                  \
      \      FASTA file and optional metadata to be incorporated\n               \
      \         into phylogenetic analysis."
    inputBinding:
      position: 101
      prefix: --supplementary-datadir
  - id: supplementary_metadata_columns
    type:
      - 'null'
      - string
    doc: "Columns in the supplementary metadata to annotate the\n                \
      \        phylogeny with. Default: ['location', 'lineage']"
    default: "['location', 'lineage']"
    inputBinding:
      position: 101
      prefix: --supplementary-metadata-columns
  - id: supplementary_metadata_id_column
    type:
      - 'null'
      - string
    doc: "Column in the supplementary metadata files to match\n                  \
      \      with the supplementary sequences. Default:\n                        sequence_name"
    default: sequence_name
    inputBinding:
      position: 101
      prefix: --supplementary-metadata-id-column
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: "Specify where you want the temp stuff to go. Default:\n                \
      \        `$TMPDIR`"
    default: '`$TMPDIR`'
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads. Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: update_local_database
    type:
      - 'null'
      - boolean
    doc: "Add newly generated consensus sequences (with a\n                      \
      \  distance greater than a threshold (--local-database-\n                  \
      \      threshold) away from Sabin, if Sabin-related) and\n                 \
      \       associated metadata to the supplementary data\n                    \
      \    directory."
    inputBinding:
      position: 101
      prefix: --update-local-database
  - id: username
    type:
      - 'null'
      - string
    doc: 'Username to appear in report. Default: no user name'
    default: no user name
    inputBinding:
      position: 101
      prefix: --username
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print lots of stuff to screen
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piranha-polio:1.5.3--pyhdfd78af_0
stdout: piranha-polio_piranha.out
