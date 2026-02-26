cwlVersion: v1.2
class: CommandLineTool
baseCommand: read_analysis.py
label: nanosim_read_analysis.py
doc: "Read characterization step\nGiven raw ONT reads, reference genome, metagenome,
  and/or\ntranscriptome, learn read features and output error profiles\n\nTool homepage:
  https://github.com/bcgsc/NanoSim"
inputs:
  - id: mode
    type: string
    doc: Subcommand for read analysis mode
    inputBinding:
      position: 1
  - id: mode_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected mode
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
stdout: nanosim_read_analysis.py.out
