cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbam2bam
label: ptools_bin_pbam2bam
doc: "A tool for converting pBAM files to BAM files, supporting different modes such
  as genome-based conversion.\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs:
  - id: mode
    type: string
    doc: The conversion mode to use (e.g., 'genome')
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
stdout: ptools_bin_pbam2bam.out
