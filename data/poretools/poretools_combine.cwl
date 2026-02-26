cwlVersion: v1.2
class: CommandLineTool
baseCommand: poretools_combine
label: poretools_combine
doc: "Combine FAST5 files into a TAR archive.\n\nTool homepage: https://github.com/arq5x/poretools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: The input FAST5 files.
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: output_tar
    type: File
    doc: The name of the output TAR archive for the set of FAST5 files.
    outputBinding:
      glob: $(inputs.output_tar)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
