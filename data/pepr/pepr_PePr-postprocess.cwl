cwlVersion: v1.2
class: CommandLineTool
baseCommand: PePr-postprocess
label: pepr_PePr-postprocess
doc: "Post-process PePr peak calling results, including artifact removal and peak
  boundary refinement.\n\nTool homepage: https://github.com/shawnzhangyx/PePr/"
inputs:
  - id: chip
    type:
      - 'null'
      - type: array
        items: File
    doc: chip files separated by comma
    inputBinding:
      position: 101
      prefix: --chip
  - id: file_type
    type:
      - 'null'
      - string
    doc: read file types. bed, sam, bam
    inputBinding:
      position: 101
      prefix: --file-type
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: input files separated by comma
    inputBinding:
      position: 101
      prefix: --input
  - id: narrow_peak_boundary
    type:
      - 'null'
      - boolean
    doc: make peak width smaller but still contain the core binding region
    inputBinding:
      position: 101
      prefix: --narrow-peak-boundary
  - id: peak
    type:
      - 'null'
      - File
    doc: peak file
    inputBinding:
      position: 101
      prefix: --peak
  - id: remove_artefacts
    type:
      - 'null'
      - boolean
    doc: remove peaks that may be caused by excess PCR duplicates
    inputBinding:
      position: 101
      prefix: --remove-artefacts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepr:1.1.24--py35_0
stdout: pepr_PePr-postprocess.out
