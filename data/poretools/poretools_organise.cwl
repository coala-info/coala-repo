cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poretools
  - organise
label: poretools_organise
doc: "Organise FAST5 files into a directory structure.\n\nTool homepage: https://github.com/arq5x/poretools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: The input FAST5 files.
    inputBinding:
      position: 1
  - id: destination_directory
    type: string
    doc: The destination directory.
    inputBinding:
      position: 2
  - id: copy
    type:
      - 'null'
      - boolean
    doc: Make a copy of files instead of moving
    inputBinding:
      position: 103
      prefix: --copy
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 103
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: destination_directory_dir
    type:
      - 'null'
      - Directory
    doc: The destination directory.
    outputBinding:
      glob: $(inputs.destination_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
stdout: poretools_organise.out
