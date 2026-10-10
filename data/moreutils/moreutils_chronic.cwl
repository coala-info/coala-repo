cwlVersion: v1.2
class: CommandLineTool
baseCommand: chronic
label: moreutils_chronic
doc: "Runs a command and hides its standard output and standard error unless the
  command fails (exits non-zero or crashes). Files named in the command are
  staged into the working directory through input_files.\n\nTool homepage: https://github.com/madx/moreutils"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.input_files ? inputs.input_files : [])"
inputs:
  - id: command
    type: string
    doc: The command to execute.
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to pass to the command.
    inputBinding:
      position: 2
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files used by the command; staged in the working directory so the
      command can name them by file name.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_chronic.out
stderr: moreutils_chronic.err
