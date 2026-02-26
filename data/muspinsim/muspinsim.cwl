cwlVersion: v1.2
class: CommandLineTool
baseCommand: muspinsim
label: muspinsim
doc: "Muon Spin Simulation software for simulating muon experiments. It calculates
  the evolution of muon polarization under the influence of internal and external
  magnetic fields.\n\nTool homepage: https://github.com/muon-spectroscopy-computational-project/muspinsim"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file containing the simulation parameters and spin system 
      definition.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muspinsim:2.3.0
stdout: muspinsim.out
