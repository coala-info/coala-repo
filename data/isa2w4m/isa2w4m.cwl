cwlVersion: v1.2
class: CommandLineTool
baseCommand: isa2w4m
label: isa2w4m
doc: "ISA-Tab to Workflow4Metabolomics (W4M) conversion tool\n\nTool homepage: https://github.com/workflow4metabolomics/isa2w4m"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isa2w4m:phenomenal-v1.1.0_cv1.4.11
stdout: isa2w4m.out
