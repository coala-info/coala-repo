cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbam_mapped_transcriptome
label: ptools_bin_pbam_mapped_transcriptome
doc: "A tool to process mapped transcriptome data. Based on the source code, it requires
  at least one input file as a positional argument.\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs:
  - id: input_file
    type: File
    doc: Input file to be processed (read as text)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
stdout: ptools_bin_pbam_mapped_transcriptome.out
