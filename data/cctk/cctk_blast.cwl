cwlVersion: v1.2
class: CommandLineTool
baseCommand: cctk blast
label: cctk_blast
doc: "BLASTn settings:\n\nTool homepage: https://github.com/Alan-Collins/CRISPR_comparison_toolkit"
inputs:
  - id: append
    type:
      - 'null'
      - boolean
    doc: add new CRISPR data to a previous run
    inputBinding:
      position: 101
      prefix: --append
  - id: assemblies
    type:
      - 'null'
      - File
    doc: file containing a list of your assembly names
    inputBinding:
      position: 101
      prefix: --assemblies
  - id: batch_size
    type:
      - 'null'
      - int
    doc: 'batch size for blastdbcmd. Default: 1000'
    default: 1000
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: blast_options
    type:
      - 'null'
      - string
    doc: 'input additional blastn options. Forbidden options: blastn -query -db -task
      -outfmt -num_threads -max_target_seqs -evalue'
    inputBinding:
      position: 101
      prefix: --blast-options
  - id: blastdb
    type: string
    doc: path to blast db (excluding file extension)
    inputBinding:
      position: 101
      prefix: --blastdb
  - id: evalue
    type:
      - 'null'
      - float
    doc: 'blastn evalue. Default: 10'
    default: 10
    inputBinding:
      position: 101
      prefix: --evalue
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: 'max_target_seqs option for blastn. Default: 10000'
    default: 10000
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: min_array_len
    type:
      - 'null'
      - int
    doc: minimum array length (number of spacers). Default 2
    default: 2
    inputBinding:
      position: 101
      prefix: --min-array-len
  - id: min_shared
    type:
      - 'null'
      - int
    doc: minimum spacers shared to draw an edge in network
    inputBinding:
      position: 101
      prefix: --min-shared
  - id: min_sp_len
    type:
      - 'null'
      - int
    doc: 'minimum spacer length when identifying arrays. Default: 25'
    default: 25
    inputBinding:
      position: 101
      prefix: --min-sp-len
  - id: percent_id
    type:
      - 'null'
      - float
    doc: 'minumum percent ID of repeat BLAST hits. Default: 80'
    default: 80
    inputBinding:
      position: 101
      prefix: --percent-id
  - id: regex_pattern
    type:
      - 'null'
      - string
    doc: pattern describing your assembly names
    inputBinding:
      position: 101
      prefix: --regex-pattern
  - id: regex_type
    type:
      - 'null'
      - string
    doc: '{E, P} regex type describing assembly names. Default: P'
    default: P
    inputBinding:
      position: 101
      prefix: --regex-type
  - id: repeat_interval
    type:
      - 'null'
      - int
    doc: 'maximum interval between repeats. Default: 100'
    default: 100
    inputBinding:
      position: 101
      prefix: --repeat-interval
  - id: repeats
    type: File
    doc: CRISPR repeats in FASTA format
    inputBinding:
      position: 101
      prefix: --repeats
  - id: snp_thresh
    type:
      - 'null'
      - int
    doc: 'number of SNPs to consider spacers the same. Default: 0'
    default: 0
    inputBinding:
      position: 101
      prefix: --snp-thresh
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads to use. Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type: Directory
    doc: directory to store output files
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
