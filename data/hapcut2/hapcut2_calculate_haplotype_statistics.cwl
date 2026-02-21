cwlVersion: v1.2
class: CommandLineTool
baseCommand: calculate_haplotype_statistics
label: hapcut2_calculate_haplotype_statistics
doc: "Calculate haplotype statistics (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/vibansal/HapCUT2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2
stdout: hapcut2_calculate_haplotype_statistics.out
