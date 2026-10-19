cwlVersion: v1.2
class: CommandLineTool
baseCommand: refasplit
label: recentrifuge_refasplit
doc: 'Symmetrically split a FASTA file into several files


  Tool homepage: https://github.com/khyox/recentrifuge'
inputs:
  - id: compress
    type:
      - 'null'
      - boolean
    doc: the resulting FASTA files will be gzipped
    inputBinding:
      position: 101
      prefix: --compress
  - id: debug
    type:
      - 'null'
      - boolean
    doc: increase output verbosity and perform additional checks
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_file
    type: File
    doc: single FASTA file (no paired-ends), which may be gzipped
    inputBinding:
      position: 101
      prefix: --input
  - id: max_reads
    type:
      - 'null'
      - int
    doc: 'maximum number of FASTA reads to process; default: no maximum'
    inputBinding:
      position: 101
      prefix: --maxreads
  - id: num_output_files
    type: int
    doc: number of output FASTA files to generate
    inputBinding:
      position: 101
      prefix: --num
  - id: output_prefix
    type: string
    doc: path with prefix for the series of FASTA output files
    inputBinding:
      position: 101
      prefix: --outprefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: split_files
    type:
      type: array
      items: File
    doc: Series of FASTA files written with the output prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
stdout: recentrifuge_refasplit.out
