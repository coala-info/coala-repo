cwlVersion: v1.2
class: CommandLineTool
baseCommand: msisensor-rna
label: msisensor-rna
doc: "A tool for detecting microsatellite instability (MSI) from RNA-seq data. (Note:
  The provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments.)\n\nTool homepage: https://github.com/xjtu-omics/msisensor-rna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor-rna:0.1.6--pyhdfd78af_0
stdout: msisensor-rna.out
