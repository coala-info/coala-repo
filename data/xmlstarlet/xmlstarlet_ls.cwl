cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xml
  - ls
label: xmlstarlet_ls
doc: "List a directory as XML\n\nTool homepage: http://xmlstar.sourceforge.net/"
inputs:
  - id: dir
    type:
      - 'null'
      - Directory
    doc: 'Directory to list (default is the current directory).'
    inputBinding:
      position: 1
outputs:
  - id: output
    type: stdout
    doc: Standard output of xml ls.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlstarlet:1.6.1
stdout: xmlstarlet_ls.out
