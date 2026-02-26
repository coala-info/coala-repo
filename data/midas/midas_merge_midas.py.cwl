cwlVersion: v1.2
class: CommandLineTool
baseCommand: merge_midas.py
label: midas_merge_midas.py
doc: "merge MIDAS results across metagenomic samples\n\nTool homepage: https://github.com/snayfach/MIDAS"
inputs:
  - id: command
    type: string
    doc: Command to execute (species, genes, snps)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specific command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midas:1.3.2--py35_0
stdout: midas_merge_midas.py.out
