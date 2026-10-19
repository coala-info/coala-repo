cwlVersion: v1.2
class: CommandLineTool
baseCommand: retaxdump
label: recentrifuge_retaxdump
doc: "Get needed taxdump files from NCBI servers\n\nTool homepage: https://github.com/khyox/recentrifuge"
inputs:
  - id: nodes_path
    type:
      - 'null'
      - string
    doc: path for the nodes information files (nodes.dmp and names.dmp from 
      NCBI)
    inputBinding:
      position: 101
      prefix: --nodespath
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: nodes_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the downloaded nodes.dmp and names.dmp files
    outputBinding:
      glob: $(inputs.nodes_path)
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
stdout: recentrifuge_retaxdump.out
