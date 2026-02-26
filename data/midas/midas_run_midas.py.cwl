cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_midas.py
label: midas_run_midas.py
doc: "Estimate species abundance and intra-species genomic variation from an individual
  metagenome\n\nTool homepage: https://github.com/snayfach/MIDAS"
inputs:
  - id: command
    type: string
    doc: Command to run (species, genes, snps)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midas:1.3.2--py35_0
stdout: midas_run_midas.py.out
