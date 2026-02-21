cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtb-snp-it
label: mtb-snp-it
doc: "A tool for identifying Mycobacterium tuberculosis lineages from SNP data. (Note:
  The provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: https://github.com/samlipworth/snpit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtb-snp-it:1.1--py_0
stdout: mtb-snp-it.out
