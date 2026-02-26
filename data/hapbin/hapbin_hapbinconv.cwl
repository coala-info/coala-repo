cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapbinconv
label: hapbin_hapbinconv
doc: "Convert between ASCII hap and binary hapbin formats.\n\nTool homepage: https://github.com/evotools/hapbin"
inputs:
  - id: hap_file
    type: File
    doc: ASCII Hap file
    inputBinding:
      position: 101
      prefix: --hap
outputs:
  - id: output_file
    type: File
    doc: Binary output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapbin:1.3.0--h503566f_6
