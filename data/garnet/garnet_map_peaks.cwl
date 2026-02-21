cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnet_map_peaks
label: garnet_map_peaks
doc: "The provided text does not contain help information or usage instructions for
  garnet_map_peaks. It contains system log messages and a fatal error regarding container
  image building (no space left on device).\n\nTool homepage: https://github.com/fraenkel-lab/GarNet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnet:0.4.5--py35_0
stdout: garnet_map_peaks.out
