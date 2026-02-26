cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ropebwt3
  - ssa
label: ropebwt3_ssa
doc: "Builds a suffix array for a FM-index.\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: in_fmd
    type: File
    doc: Input FM-index file
    inputBinding:
      position: 1
  - id: sample_rate
    type:
      - 'null'
      - int
    doc: sample rate one SA per 2**INT bases
    default: 8
    inputBinding:
      position: 102
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 4
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output to file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
