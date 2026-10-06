cwlVersion: v1.2
class: CommandLineTool
baseCommand: AlcoR
label: alcor_AlcoR
doc: "Alignment-free Computation of Low-complexity Regions. Provides tools for sequence
  information retrieval, extraction, mapping of low-complexity regions, simulation,
  and visualization.\n\nTool homepage: https://cobilab.github.io/alcor/"
inputs:
  - id: command
    type: string
    doc: 'The command to execute: info, extract, mapper, simulation, or visual'
    inputBinding:
      position: 1
  - id: verbose
    type: ['null', boolean]
    doc: Verbose mode (more information)
    inputBinding:
      position: 2
      prefix: -v
  - id: input_file
    type: ['null', File]
    doc: Input FASTA file to analyze (last argument, mandatory for every command
      except simulation)
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alcor:1.9--h077b44d_6
stdout: alcor_AlcoR.out
