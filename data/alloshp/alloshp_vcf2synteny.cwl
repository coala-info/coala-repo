cwlVersion: v1.2
class: CommandLineTool
baseCommand: alloshp_vcf2synteny
label: alloshp_vcf2synteny
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/execution due to insufficient
  disk space.\n\nTool homepage: https://github.com/eead-csic-compbio/AlloSHP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alloshp:2025.09.12--h7b50bb2_0
stdout: alloshp_vcf2synteny.out
