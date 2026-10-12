cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - paladin
  - prepare
label: paladin_prepare
doc: "Prepare a reference database for PALADIN by downloading or using a local copy.\n
  \nTool homepage: https://github.com/ToniWestbrook/paladin"
inputs:
  - id: local_reference
    type:
      - 'null'
      - File
    doc: Skip download, use local copy of reference database (may be indexed). The index
      files are written beside it.
    inputBinding:
      position: 101
      prefix: -f
  - id: proxy_address
    type:
      - 'null'
      - string
    doc: HTTP or SOCKS proxy address
    inputBinding:
      position: 101
      prefix: -P
  - id: reference_database
    type:
      - 'null'
      - int
    doc: 'Reference Database: 1: UniProtKB Reviewed (Swiss-Prot), 2: UniProtKB Clustered
      90% (UniRef90)'
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written beside the local reference (empty when the reference is downloaded)
    outputBinding:
      glob: "$(inputs.local_reference ? inputs.local_reference.basename + '.*' : [])"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.local_reference)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
stdout: paladin_prepare.out
