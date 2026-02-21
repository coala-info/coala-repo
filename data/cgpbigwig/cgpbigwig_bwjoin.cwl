cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgpbigwig_bwjoin
label: cgpbigwig_bwjoin
doc: "Join multiple bigWig files into a single bigWig file.\n\nTool homepage: https://github.com/cancerit/cgpBigWig"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more input bigWig files to be joined.
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: The output bigWig file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgpbigwig:1.7.0--h523f0d1_0
