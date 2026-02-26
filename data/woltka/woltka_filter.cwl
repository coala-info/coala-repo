cwlVersion: v1.2
class: CommandLineTool
baseCommand: woltka filter
label: woltka_filter
doc: "Filter a profile by per-sample abundance.\n\nTool homepage: https://github.com/qiyunzhu/woltka"
inputs:
  - id: input_file
    type: File
    doc: Path to input profile.
    inputBinding:
      position: 101
      prefix: --input
  - id: min_count
    type:
      - 'null'
      - int
    doc: Per-sample minimum count threshold.
    inputBinding:
      position: 101
      prefix: --min-count
  - id: min_percent
    type:
      - 'null'
      - float
    doc: Per-sample minimum percentage threshold.
    inputBinding:
      position: 101
      prefix: --min-percent
outputs:
  - id: output_file
    type: File
    doc: Path to output profile.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
