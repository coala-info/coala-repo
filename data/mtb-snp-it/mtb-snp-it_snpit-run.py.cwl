cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtb-snp-it_snpit-run.py
label: mtb-snp-it_snpit-run.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages regarding container execution and disk space.\n
  \nTool homepage: https://github.com/samlipworth/snpit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtb-snp-it:1.1--py_0
stdout: mtb-snp-it_snpit-run.py.out
