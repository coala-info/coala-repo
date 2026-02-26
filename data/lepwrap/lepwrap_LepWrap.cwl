cwlVersion: v1.2
class: CommandLineTool
baseCommand: LepWrap
label: lepwrap_LepWrap
doc: "Perform the modules of Lep-Map3 and/or Lep-Anchor\n\nTool homepage: https://github.com/pdimens/LepWrap/"
inputs:
  - id: threads
    type: int
    doc: Number of threads to use
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file for Lep-Map3 and/or Lep-Anchor. Defaults to 
      config.yml if not provided.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lepwrap:5.0--hdfd78af_0
stdout: lepwrap_LepWrap.out
