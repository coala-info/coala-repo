cwlVersion: v1.2
class: CommandLineTool
baseCommand: mispipe
label: moreutils_mispipe
doc: "Pipe two commands together and return the exit status of the first command.
  Files named in the commands are staged into the working directory through
  input_files.\n\nTool homepage: https://github.com/madx/moreutils"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.input_files ? inputs.input_files : [])"
inputs:
  - id: command1
    type: string
    doc: The first command to execute in the pipeline.
    inputBinding:
      position: 1
  - id: command2
    type: string
    doc: The second command to execute in the pipeline.
    inputBinding:
      position: 2
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files used by the commands; staged in the working directory so the
      commands can name them by file name.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_mispipe.out
