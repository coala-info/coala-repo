cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanosim_simulator.py
label: nanosim_simulator.py
doc: "NanoSim: A nanopore sequence simulator. (Note: The provided text contains system
  error messages regarding container execution and does not list the tool's command-line
  arguments.)\n\nTool homepage: https://github.com/bcgsc/NanoSim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
stdout: nanosim_simulator.py.out
