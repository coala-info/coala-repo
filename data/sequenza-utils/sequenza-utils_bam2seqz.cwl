cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - bam2seqz
label: sequenza-utils_bam2seqz
doc: "Convert BAM files to Sequenza's .seqz format.\n\nTool homepage: http://sequenza-utils.readthedocs.org"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: max_depth
    type:
      - 'null'
      - int
    doc: 'Maximum depth to consider a position. Default: 1000.'
    inputBinding:
      position: 102
      prefix: --max-depth
  - id: min_allele_depth
    type:
      - 'null'
      - int
    doc: 'Minimum depth for an allele (ref or alt) to be considered. Default: 3.'
    inputBinding:
      position: 102
      prefix: --min-allele-depth
  - id: min_depth
    type:
      - 'null'
      - int
    doc: 'Minimum depth to consider a position. Default: 10.'
    inputBinding:
      position: 102
      prefix: --min-depth
  - id: step
    type:
      - 'null'
      - int
    doc: 'Step size for sliding window. Default: 10000.'
    inputBinding:
      position: 102
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. Default: 1.'
    inputBinding:
      position: 102
      prefix: --threads
  - id: window
    type:
      - 'null'
      - int
    doc: 'Window size for calculating allele frequencies. Default: 50000.'
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: output_seqz
    type: File
    doc: Output .seqz file.
    outputBinding:
      glob: $(inputs.output_seqz)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
