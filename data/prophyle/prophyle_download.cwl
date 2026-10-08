cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophyle
  - download
label: prophyle_download
doc: "Download genomic libraries and associated data.\n\nTool homepage: https://github.com/karel-brinda/prophyle"
inputs:
  - id: libraries
    type:
      type: array
      items: string
    doc: genomic library ['bacteria', 'viruses', 'plasmids', 'hmp', 'all']
    inputBinding:
      position: 1
  - id: advanced_configuration
    type:
      - 'null'
      - type: array
        items: string
    doc: advanced configuration (a JSON dictionary)
    inputBinding:
      position: 102
      prefix: -c
  - id: force_rewrite
    type:
      - 'null'
      - boolean
    doc: rewrite library files if they already exist
    inputBinding:
      position: 102
      prefix: -F
  - id: log_file
    type:
      - 'null'
      - string
    doc: log file
    inputBinding:
      position: 102
      prefix: -l
  - id: output_directory
    type:
      - 'null'
      - string
    doc: directory for the tree and the sequences
    inputBinding:
      position: 102
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: library_directory
    type:
      - 'null'
      - Directory
    doc: directory with the downloaded tree and sequences
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
stdout: prophyle_download.out
