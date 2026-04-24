cwlVersion: v1.2
class: CommandLineTool
baseCommand: haptools index
label: haptools_index
doc: "Takes in an unsorted .hap file and outputs it as a .gz and a .tbi file\n\nTool
  homepage: https://github.com/cast-genomics/haptools"
inputs:
  - id: haplotypes
    type: File
    doc: Input .hap file
    inputBinding:
      position: 1
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: Do not sort the file
    inputBinding:
      position: 102
      prefix: --no-sort
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Sort the file
    inputBinding:
      position: 102
      prefix: --sort
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The level of verbosity desired
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: A .hap file containing sorted and indexed haplotypes and variants
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
