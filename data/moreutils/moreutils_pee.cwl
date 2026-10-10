cwlVersion: v1.2
class: CommandLineTool
baseCommand: pee
label: moreutils_pee
doc: "Pipes standard input to the specified commands. It is similar to tee, but
  for pipes.\n\nTool homepage: https://github.com/madx/moreutils"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.input_files ? inputs.input_files : [])"
inputs:
  - id: commands
    type:
      type: array
      items: string
    doc: List of commands to which the standard input will be piped.
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: File sent to the standard input of pee.
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
stdin: $(inputs.input_file.path)
stdout: moreutils_pee.out
