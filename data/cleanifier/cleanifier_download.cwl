cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cleanifier
  - download
label: cleanifier_download
doc: "Download the human index from Zenodo.\n\nTool homepage: https://gitlab.com/rahmannlab/cleanifier"
inputs:
  - id: dir
    type:
      - 'null'
      - string
    doc: "directory name to store the index; default current directory"
    inputBinding:
      position: 101
      prefix: --dir
  - id: version
    type:
      - 'null'
      - string
    doc: "index version (probabilistic or exact); default probabilistic."
    inputBinding:
      position: 101
      prefix: --version
  - id: checksum
    type:
      - 'null'
      - boolean
    doc: "check the checksum of the downloaded file, might take some time"
    inputBinding:
      position: 101
      prefix: --checksum
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: "Downloaded human index files"
    outputBinding:
      glob: "$(inputs.dir ? inputs.dir + '/*' : '*.{hash,info}')"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0
stdout: cleanifier_download.out
