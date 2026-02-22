cwlVersion: v1.2
class: CommandLineTool
baseCommand: pacu_snp
label: pacu_snp
doc: "The provided text does not contain help information or usage instructions for
  pacu_snp; it contains system error messages regarding container image acquisition
  and disk space issues.\n\nTool homepage: https://github.com/BioinformaticsPlatformWIV-ISP/PACU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacu_snp:1.0.0--pyhdfd78af_0
stdout: pacu_snp.out
