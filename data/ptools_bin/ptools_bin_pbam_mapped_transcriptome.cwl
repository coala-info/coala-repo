cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ptools_bin
  - pbam_mapped_transcriptome
label: ptools_bin_pbam_mapped_transcriptome
doc: "A tool within the ptools suite, likely used for processing BAM files mapped
  to a transcriptome. (Note: The provided help text contains only container build
  logs and no usage information.)\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
stdout: ptools_bin_pbam_mapped_transcriptome.out
