cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mimsi
  - analyze
label: mimsi_analyze
doc: "Metabolomics Ion Mobility Spectral Investigator analyze tool\n\nTool homepage:
  https://github.com/mskcc/mimsi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
stdout: mimsi_analyze.out
