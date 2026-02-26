cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi_merge
label: fermi_merge
doc: "Merge BWT indexes\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: input_bwt_files
    type:
      type: array
      items: File
    doc: Input BWT files to merge
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: force to overwrite the output file (effective with -o)
    inputBinding:
      position: 102
      prefix: -f
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
