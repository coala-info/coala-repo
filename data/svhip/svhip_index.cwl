cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svhip
  - index
label: svhip_index
doc: "Index SVHIP data\n\nTool homepage: https://github.com/chrisBioInf/Svhip"
inputs:
  - id: input_file
    type: File
    doc: The input directory or file (Required).
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF file written next to the input (input name plus .gtf).
    outputBinding:
      glob: '*.gtf'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
stdout: svhip_index.out
