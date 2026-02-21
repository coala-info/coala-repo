cwlVersion: v1.2
class: CommandLineTool
baseCommand: sponge
label: moreutils_sponge
doc: "Soak up standard input and write to a file. Unlike a shell redirect, sponge
  soaks up all its input before opening the output file, allowing for reading from
  and writing to the same file in a pipeline.\n\nTool homepage: https://github.com/madx/moreutils"
inputs:
  - id: append
    type:
      - 'null'
      - boolean
    doc: Append to the output file instead of overwriting it.
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: output_file
    type: File
    doc: The file to write the soaked input to.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
