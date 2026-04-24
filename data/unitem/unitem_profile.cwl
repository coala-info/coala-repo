cwlVersion: v1.2
class: CommandLineTool
baseCommand: unitem profile
label: unitem_profile
doc: "Identify marker genes and calculate assembly statistics.\n\nTool homepage: https://github.com/dparks1134/UniteM"
inputs:
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 1
  - id: bin_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: directories with bins from different binning methods
    inputBinding:
      position: 102
      prefix: --bin_dirs
  - id: bin_file
    type:
      - 'null'
      - File
    doc: "tab-separated file indicating directories with bins\n                  \
      \      from binning methods (two columns: method name and\n                \
      \        directory)"
    inputBinding:
      position: 102
      prefix: --bin_file
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of CPUs
    inputBinding:
      position: 102
      prefix: --cpus
  - id: keep_intermediate
    type:
      - 'null'
      - boolean
    doc: keep intermediate gene calling results
    inputBinding:
      position: 102
      prefix: --keep_intermediate
  - id: marker_dir
    type:
      - 'null'
      - Directory
    doc: "directory containing Pfam and TIGRfam marker genes\n                   \
      \     data"
    inputBinding:
      position: 102
      prefix: --marker_dir
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output of logger
    inputBinding:
      position: 102
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unitem:1.2.6--pyhdfd78af_0
stdout: unitem_profile.out
