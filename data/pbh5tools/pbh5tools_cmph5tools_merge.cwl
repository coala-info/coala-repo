cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmph5tools.py
  - merge
label: pbh5tools_cmph5tools_merge
doc: "Merge two or more cmp.h5 files. The input.cmp.h5 files must have been aligned to the same reference sequences.\n\nTool homepage: https://github.com/PacificBiosciences/pbh5tools"
inputs:
  - id: input_cmp_h5
    type:
      type: array
      items: File
    doc: input filenames (must be aligned to the same reference sequences)
    inputBinding:
      position: 1
  - id: out_file
    type:
      - 'null'
      - string
    doc: output filename [out.cmp.h5]
    inputBinding:
      position: 100
      prefix: --outFile
  - id: references_file
    type:
      - 'null'
      - File
    doc: References file (-W)
    inputBinding:
      position: 101
      prefix: --referencesFile
outputs:
  - id: merged_cmp_h5
    type: File
    doc: Merged cmp.h5 file
    outputBinding:
      glob: '$(inputs.out_file ? inputs.out_file : "out.cmp.h5")'
  - id: stdout
    type: stdout
    doc: Standard output
stdout: pbh5tools_cmph5tools_merge_stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
