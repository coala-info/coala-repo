cwlVersion: v1.2
class: CommandLineTool
baseCommand: epigrass
label: epigrass
doc: "Epigrass is a software for epidemiological simulation and analysis on graph
  structures.\n\nTool homepage: https://github.com/fccoelho/epigrass"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/epigrass:v2.4.7-1-deb_cv1
stdout: epigrass.out
