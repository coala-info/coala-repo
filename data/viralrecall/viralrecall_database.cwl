cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - viralrecall_database
label: viralrecall_database
doc: "Download the HMM database for Viralrecall (needs network access).\n\nTool homepage: https://github.com/abdealijivaji/ViralRecall_3.0"
inputs:
  - id: db_dir
    type:
      - 'null'
      - string
    doc: Directory to download the HMM database. Default is current working directory
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: name
    type:
      - 'null'
      - string
    doc: Name to give the database directory. Default is "hmm"
    inputBinding:
      position: 101
      prefix: --name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: database
    type: Directory
    doc: The prepared HMM database directory
    outputBinding:
      glob: "${ return (inputs.db_dir ? inputs.db_dir.replace(/\\/+$/, '') + '/' : '') + (inputs.name ? inputs.name : 'hmm'); }"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralrecall:3.0.2--pyhdfd78af_0
stdout: viralrecall_database.out
