cwlVersion: v1.2
class: CommandLineTool
baseCommand: zrun
label: moreutils_zrun
doc: "Automatically uncompress arguments to command. Runs the program on the
  uncompressed copies of the compressed files given as arguments.\n\nTool
  homepage: https://github.com/madx/moreutils"
inputs:
  - id: program
    type: string
    doc: The program to run, for example cat or grep.
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the program that are not files.
    inputBinding:
      position: 2
  - id: compressed_files
    type:
      type: array
      items: File
    doc: Compressed files (.gz, .bz2, .xz) passed to the program.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_zrun.out
