cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - alignment
label: hicberg_alignment
doc: "Perform alignment of Hi-C reads.\n\nTool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: genome
    type: string
    doc: Index of the genome (path). If not set, the index is built.
    inputBinding:
      position: 1
  - id: input1
    type: string
    doc: Input file 1
    inputBinding:
      position: 2
  - id: input2
    type: string
    doc: Input file 2
    inputBinding:
      position: 3
  - id: cpus
    type:
      - 'null'
      - int
    doc: Threads to use for analysis.
    default: 1
    inputBinding:
      position: 104
      prefix: --cpus
  - id: index
    type:
      - 'null'
      - string
    doc: Index of the genome (path). If not set, the index is built.
    inputBinding:
      position: 104
      prefix: --index
  - id: max_alignment
    type:
      - 'null'
      - int
    doc: Set the number of alignments to report in ambiguous reads case. If set 
      to -1, all alignments are reported.
    inputBinding:
      position: 104
      prefix: --max-alignment
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output folder to save results. If not set, the current directory is 
      used.
    inputBinding:
      position: 104
      prefix: --output
  - id: sensitivity
    type:
      - 'null'
      - string
    doc: Set sensitivity level for Bowtie2.
    default: very-sensitive
    inputBinding:
      position: 104
      prefix: --sensitivity
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbosity level.
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
stdout: hicberg_alignment.out
