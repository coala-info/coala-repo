cwlVersion: v1.2
class: CommandLineTool
baseCommand: alloshp_vcf2alignment
label: alloshp_vcf2alignment
doc: "A tool for converting VCF files to alignments. (Note: The provided help text
  contains system error messages regarding container extraction and does not list
  command-line arguments.)\n\nTool homepage: https://github.com/eead-csic-compbio/AlloSHP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alloshp:2025.09.12--h7b50bb2_0
stdout: alloshp_vcf2alignment.out
