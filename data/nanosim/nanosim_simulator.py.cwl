cwlVersion: v1.2
class: CommandLineTool
baseCommand: simulator.py
label: nanosim_simulator.py
doc: "Given error profiles, reference genome, metagenome,\nand/or transcriptome, simulate
  ONT DNA or RNA reads\n\nTool homepage: https://github.com/bcgsc/NanoSim"
inputs:
  - id: mode
    type:
      type: array
      items: string
    doc: "You may run the simulator on genome, transcriptome, or\nmetagenome mode."
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
stdout: nanosim_simulator.py.out
