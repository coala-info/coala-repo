cwlVersion: v1.2
class: CommandLineTool
baseCommand: knock-knock
label: knock-knock
doc: "A tool for analyzing and validating CRISPR-Cas9 HDR (Homology-Directed Repair)
  results.\n\nTool homepage: https://github.com/jeffhussmann/knock-knock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knock-knock:0.4.2--pyhdfd78af_0
stdout: knock-knock.out
