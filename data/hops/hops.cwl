cwlVersion: v1.2
class: CommandLineTool
baseCommand: HOPS
label: hops
doc: "HOPS (Heuristic Operations for Pathogen Screening) is a tool for screening and
  analyzing ancient DNA data.\n\nTool homepage: https://github.com/rhuebler/HOPS/"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to Config File
    inputBinding:
      position: 101
      prefix: --configFile
  - id: input
    type:
      - 'null'
      - string
    doc: Specify input directory or files valid option depend on mode
    inputBinding:
      position: 101
      prefix: --input
  - id: mode
    type:
      - 'null'
      - string
    doc: HOPS Mode to run accpeted full, malt, maltex, post
    inputBinding:
      position: 101
      prefix: --mode
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Specify out directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hops:0.35--hdfd78af_2
