cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgs2ncbi
label: wgs2ncbi_prepare
doc: "prepares whole genome sequencing projects for submission to NCBI\n\nTool homepage:
  https://github.com/naturalis/wgs2ncbi"
inputs:
  - id: action
    type: string
    doc: The action to perform (prepare, process, convert, prune, trim, 
      compress)
    inputBinding:
      position: 1
  - id: config_file
    type: File
    doc: Configuration file
    inputBinding:
      position: 102
      prefix: -conf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgs2ncbi:1.1.2--pl526_0
stdout: wgs2ncbi_prepare.out
