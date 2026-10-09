cwlVersion: v1.2
class: CommandLineTool
baseCommand: hops
label: hops
doc: "HOPS (Heuristic Operations for Pathogen Screening) is a tool for screening and
  analyzing ancient DNA data.\n\nTool homepage: https://github.com/rhuebler/HOPS/"
inputs:
  - id: config_file
    type: File
    doc: Path to Config File
    inputBinding:
      position: 101
      prefix: --configFile
  - id: input
    type: string
    doc: Specify input directory or files valid option depend on mode
    inputBinding:
      position: 101
      prefix: --input
  - id: mode
    type: string
    doc: HOPS Mode to run accpeted full, malt, maltex, post
    inputBinding:
      position: 101
      prefix: --mode
  - id: output_path
    type: string
    doc: Specify out directory
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Specify out directory
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hops:0.35--hdfd78af_2
