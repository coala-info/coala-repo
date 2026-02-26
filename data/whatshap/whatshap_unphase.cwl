cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - whatshap
  - unphase
label: whatshap_unphase
doc: "Remove phasing information from a VCF file\n\nTool homepage: https://whatshap.readthedocs.io"
inputs:
  - id: vcf
    type: File
    doc: VCF file. Use "-" to read from standard input
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
stdout: whatshap_unphase.out
