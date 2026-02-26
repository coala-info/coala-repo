cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsdfinder
label: hsdfinder
doc: "A tool to find HSDs (Highly Similar Domains) using BLAST and InterProScan output
  files.\n\nTool homepage: https://github.com/zx0223winner/HSDFinder"
inputs:
  - id: input_file
    type: File
    doc: the BLAST output file
    inputBinding:
      position: 101
      prefix: --input_file
  - id: length
    type: int
    doc: length e.g. 10
    inputBinding:
      position: 101
      prefix: --length
  - id: percentage_identity
    type: float
    doc: identity percent e.g. For 90%, input 90.0
    inputBinding:
      position: 101
      prefix: --percentage_identity
  - id: pfam_file
    type: File
    doc: the InterProScan output file
    inputBinding:
      position: 101
      prefix: --file
  - id: type
    type: string
    doc: type e.g. Pfam
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: output_file
    type: File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdfinder:1.1.1--hdfd78af_0
