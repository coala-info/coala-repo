cwlVersion: v1.2
class: CommandLineTool
baseCommand: cluster_vcf_records
label: cluster_vcf_records
doc: "A tool for clustering VCF records. Note: The provided help text contains system
  error messages regarding a container build failure ('no space left on device') and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/iqbal-lab-org/cluster_vcf_records"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cluster_vcf_records:0.13.3--pyhdfd78af_0
stdout: cluster_vcf_records.out
