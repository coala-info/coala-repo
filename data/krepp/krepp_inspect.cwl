cwlVersion: v1.2
class: CommandLineTool
baseCommand: krepp inspect
label: krepp_inspect
doc: "Display statistics and information for a given index.\n\nTool homepage: https://github.com/bo1929/krepp"
inputs:
  - id: index_dir
    type: Directory
    doc: Directory <path> containing reference index.
    inputBinding:
      position: 101
      prefix: --index-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
stdout: krepp_inspect.out
