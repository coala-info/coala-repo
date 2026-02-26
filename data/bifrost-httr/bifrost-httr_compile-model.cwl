cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bifrost-httr
  - compile-model
label: bifrost-httr_compile-model
doc: "Compile a Stan model file (uses built-in model if no file specified).\n\nTool
  homepage: https://github.com/seqera-services/bifrost-httr"
inputs:
  - id: stan_file
    type:
      - 'null'
      - File
    doc: Stan model file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bifrost-httr:0.5.0--pyhdfd78af_0
stdout: bifrost-httr_compile-model.out
