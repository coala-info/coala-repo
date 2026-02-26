cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./HAPCUT2
label: hapcut2
doc: "robust and accurate haplotype assembly for diverse sequencing technologies\n\
  \nTool homepage: https://github.com/vibansal/HapCUT2/"
inputs:
  - id: fragments
    type: File
    doc: fragment_file
    inputBinding:
      position: 101
      prefix: --fragments
  - id: variantcalls
    type: File
    doc: variantcalls.vcf
    inputBinding:
      position: 101
      prefix: --VCF
outputs:
  - id: output
    type: File
    doc: haplotype_output_file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2
