cwlVersion: v1.2
class: CommandLineTool
baseCommand: SHAPEIT5_ligate
label: shapeit5_ligate
doc: "Ligate multiple phased chunks (VCF/BCF) into a single chromosome-length file.\n
  \nTool homepage: https://odelaneau.github.io/shapeit5/"
inputs:
  - id: index
    type:
      - 'null'
      - boolean
    doc: Index the output file.
    inputBinding:
      position: 101
      prefix: --index
  - id: input
    type: File
    doc: Text file containing the list of VCF/BCF files to ligate (one per line).
    inputBinding:
      position: 101
      prefix: --input
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: output
    type: File
    doc: Output ligated VCF/BCF file.
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type:
      - 'null'
      - File
    doc: Log file.
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
