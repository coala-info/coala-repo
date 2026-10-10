cwlVersion: v1.2
class: CommandLineTool
baseCommand: sponge
label: moreutils_sponge
doc: "Soak up standard input and write to a file. Unlike a shell redirect, sponge
  soaks up all its input before opening the output file, allowing for reading from
  and writing to the same file in a pipeline.\n\nTool homepage: https://github.com/madx/moreutils"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: output_file_name
    type: string
    doc: The file to write the soaked input to.
    inputBinding:
      position: 2
  - id: input_file
    type: File
    doc: File sent to the standard input of sponge.
  - id: append
    type:
      - 'null'
      - boolean
    doc: Append to the output file instead of overwriting it.
    inputBinding:
      position: 1
      prefix: -a
outputs:
  - id: output_file
    type: File
    doc: The file the soaked input was written to.
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdin: $(inputs.input_file.path)
