cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit5_phase_common
label: shapeit5_phase_common
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a Singularity/Apptainer container due to insufficient
  disk space.\n\nTool homepage: https://odelaneau.github.io/shapeit5/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
stdout: shapeit5_phase_common.out
