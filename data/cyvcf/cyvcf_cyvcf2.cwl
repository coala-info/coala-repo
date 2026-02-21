cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyvcf
label: cyvcf_cyvcf2
doc: "A fast VCF parser based on htslib.\n\nTool homepage: https://github.com/brentp/cyvcf2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyvcf:0.8.0--py36_0
stdout: cyvcf_cyvcf2.out
