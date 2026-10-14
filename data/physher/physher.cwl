cwlVersion: v1.2
class: CommandLineTool
baseCommand: physher
label: physher
doc: "A tool for phylogenetic inference and analysis using JSON configuration files.\n
  \nTool homepage: https://github.com/4ment/physher"
inputs:
  - id: input_file_name
    type: File
    doc: JSON configuration file
    inputBinding:
      position: 200
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named inside the JSON configuration (alignment, tree), staged
      in the working directory so the names resolve.
  - id: seed
    type:
      - 'null'
      - int
    doc: initialize seed
    inputBinding:
      position: 102
      prefix: --seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physher:2.0.1--h4656aac_3
stdout: physher.out
