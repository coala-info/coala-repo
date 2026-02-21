cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctsim
label: ctsim
doc: "CTSim (Computed Tomography Simulator) is a software package for simulating the
  process of computed tomography.\n\nTool homepage: https://github.com/kingtaurus/CTSim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ctsim:v6.0.2-2-deb_cv1
stdout: ctsim.out
