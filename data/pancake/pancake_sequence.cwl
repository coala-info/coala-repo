cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pancake
  - sequence
label: pancake_sequence
doc: "Extract sequences from PanCake Data Object Files\n\nTool homepage: https://github.com/pancakeswap/pancake-frontend"
inputs:
  - id: chromosome
    type:
      - 'null'
      - string
    doc: Chromosome from which sequence originates
    inputBinding:
      position: 101
      prefix: --chrom
  - id: genome
    type:
      - 'null'
      - type: array
        items: string
    doc: (multiple) .fasta output of GENOME (if set, start and stop will be ignored)
    inputBinding:
      position: 101
      prefix: --genome
  - id: linewidth
    type:
      - 'null'
      - int
    doc: line witdth in .fastafile (DEFAULT=100)
    default: 100
    inputBinding:
      position: 101
      prefix: --linewidth
  - id: pan_file
    type: File
    doc: Name of PanCake Data Object File (required)
    inputBinding:
      position: 101
      prefix: --panfile
  - id: start
    type:
      - 'null'
      - int
    doc: (1-based) start position on CHROMOSME (DEFAULT = 1)
    default: 1
    inputBinding:
      position: 101
      prefix: -start
  - id: stop
    type:
      - 'null'
      - int
    doc: (1-based) stop position on CHROMOSME (DEFAULT = length of CHROMOSME)
    inputBinding:
      position: 101
      prefix: -stop
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: file to which .fasta output will be written (DEFAULT = STDOUT)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pancake:1.1.2--py35_0
