cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac
  - preproc
label: deepac_preproc
doc: "Preprocessing config file.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: config
    type: File
    doc: Preprocessing config file.
    inputBinding:
      position: 1
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Automatically trim the sequences to the read length specified in the 
      config file.
    inputBinding:
      position: 102
      prefix: --trim
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
stdout: deepac_preproc.out
