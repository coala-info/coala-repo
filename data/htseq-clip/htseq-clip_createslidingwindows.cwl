cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - htseq-clip
  - createSlidingWindows
label: htseq-clip_createslidingwindows
doc: "creates sliding windows out of the flattened annotation file\nTool homepage: https://github.com/EMBL-Hentze-group/htseq-clip"
inputs:
  - id: input_file
    type: File
    doc: flattend annotation file, see "htseq-clip annotation -h"
    inputBinding:
      position: 101
      prefix: --input
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'window size (in number of base pairs) for sliding window (default: 50)'
    inputBinding:
      position: 101
      prefix: --windowSize
  - id: window_step
    type:
      - 'null'
      - int
    doc: 'window step size for sliding window (default: 20)'
    inputBinding:
      position: 101
      prefix: --windowStep
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
    doc: annotation sliding windows file (.bed[.gz])
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
  
