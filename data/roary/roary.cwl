cwlVersion: v1.2
class: CommandLineTool
baseCommand: roary
label: roary
doc: "Roary: Rapid large-scale prokaryote pan genome analysis\n\nTool homepage: https://github.com/sanger-pathogens/Roary"
inputs:
  - id: gff_files
    type:
      type: array
      items: File
    doc: Input GFF files
    inputBinding:
      position: 1
  - id: add_gene_inference_info
    type:
      - 'null'
      - boolean
    doc: add gene inference information to spreadsheet, doesnt work with -e
    inputBinding:
      position: 102
      prefix: -y
  - id: allow_paralogs_in_core_alignment
    type:
      - 'null'
      - boolean
    doc: allow paralogs in core alignment
    inputBinding:
      position: 102
      prefix: -ap
  - id: blastp_executable
    type:
      - 'null'
      - string
    doc: blastp executable
    inputBinding:
      position: 102
      prefix: -b
  - id: check_dependencies
    type:
      - 'null'
      - boolean
    doc: check dependancies and print versions
    inputBinding:
      position: 102
      prefix: -a
  - id: clusters_output_filename
    type:
      - 'null'
      - string
    doc: clusters output filename
    inputBinding:
      position: 102
      prefix: -o
  - id: core_gene_percentage_threshold
    type:
      - 'null'
      - float
    doc: percentage of isolates a gene must be in to be core
    inputBinding:
      position: 102
      prefix: -cd
  - id: create_core_gene_alignment
    type:
      - 'null'
      - boolean
    doc: create a multiFASTA alignment of core genes using PRANK
    inputBinding:
      position: 102
      prefix: -e
  - id: create_r_plots
    type:
      - 'null'
      - boolean
    doc: create R plots, requires R and ggplot2
    inputBinding:
      position: 102
      prefix: -r
  - id: dont_delete_intermediate_files
    type:
      - 'null'
      - boolean
    doc: dont delete intermediate files
    inputBinding:
      position: 102
      prefix: -z
  - id: dont_split_paralogs
    type:
      - 'null'
      - boolean
    doc: dont split paralogs
    inputBinding:
      position: 102
      prefix: -s
  - id: fast_core_gene_alignment_mafft
    type:
      - 'null'
      - boolean
    doc: fast core gene alignment with MAFFT, use with -e
    inputBinding:
      position: 102
      prefix: -n
  - id: generate_qc_report
    type:
      - 'null'
      - boolean
    doc: generate QC report with Kraken
    inputBinding:
      position: 102
      prefix: -qc
  - id: kraken_database_path
    type:
      - 'null'
      - string
    doc: path to Kraken database for QC, use with -qc
    inputBinding:
      position: 102
      prefix: -k
  - id: makeblastdb_executable
    type:
      - 'null'
      - string
    doc: makeblastdb executable
    inputBinding:
      position: 102
      prefix: -m
  - id: max_clusters
    type:
      - 'null'
      - int
    doc: maximum number of clusters
    inputBinding:
      position: 102
      prefix: -g
  - id: mcl_executable
    type:
      - 'null'
      - string
    doc: mcl executable
    inputBinding:
      position: 102
      prefix: -c
  - id: mcl_inflation_value
    type:
      - 'null'
      - string
    doc: Change the MCL inflation value
    inputBinding:
      position: 102
      prefix: -iv
  - id: mcxdeblast_executable
    type:
      - 'null'
      - string
    doc: mcxdeblast executable
    inputBinding:
      position: 102
      prefix: -d
  - id: min_percentage_identity_blastp
    type:
      - 'null'
      - int
    doc: minimum percentage identity for blastp
    inputBinding:
      position: 102
      prefix: -i
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 102
      prefix: -f
  - id: print_version_and_exit
    type:
      - 'null'
      - boolean
    doc: print version and exit
    inputBinding:
      position: 102
      prefix: -w
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: -p
  - id: translation_table
    type:
      - 'null'
      - int
    doc: translation table
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose_output
    type:
      - 'null'
      - boolean
    doc: verbose output to STDOUT
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/roary:3.13.0--pl526h516909a_0
stdout: roary.out
