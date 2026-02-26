cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy_merge_salmon
label: iobrpy_merge_salmon
doc: "Merge Salmon quant.sf files from multiple runs.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: num_processes
    type:
      - 'null'
      - int
    doc: Threads for loading quant.sf (I/O bound)
    inputBinding:
      position: 101
      prefix: --num_processes
  - id: path_salmon
    type: Directory
    doc: Root folder searched recursively for quant.sf
    inputBinding:
      position: 101
      prefix: --path_salmon
  - id: project
    type: string
    doc: Output file prefix
    inputBinding:
      position: 101
      prefix: --project
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
stdout: iobrpy_merge_salmon.out
