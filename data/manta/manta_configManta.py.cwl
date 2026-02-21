cwlVersion: v1.2
class: CommandLineTool
baseCommand: configManta.py
label: manta_configManta.py
doc: "No description available: The provided text contained container runtime error
  messages rather than tool help text.\n\nTool homepage: https://github.com/Illumina/manta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/manta:1.6.0--py27h9948957_6
stdout: manta_configManta.py.out
