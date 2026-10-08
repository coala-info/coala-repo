cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - htseq-clip
  - mapToId
label: htseq-clip_maptoid
doc: "extract \"name\" column from the annotation file and map the entries to unique id and print out in tab separated format\n\nTool homepage: https://github.com/EMBL-Hentze-group/htseq-clip"
inputs:
  - id: annotation
    type: File
    doc: flattened annotation file from "htseq-clip annotation -h" or sliding window file from
      "htseq-clip createSlidingWindows -h"
    inputBinding:
      position: 101
      prefix: --annotation
  - id: verbose_level
    type:
      - 'null'
      - string
    doc: 'Allowed choices: debug, info, warn, quiet (default: info)'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: output file name
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: region/window annotation mapped to a unique id (.txt[.gz])
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
  
