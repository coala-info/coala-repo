cwlVersion: v1.2
class: CommandLineTool
baseCommand: radtk
label: radtk
doc: "The provided text does not contain help information or usage instructions for
  the tool 'radtk'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  failing to fetch the tool's image.\n\nTool homepage: https://github.com/COMBINE-lab/radtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/radtk:0.2.0--ha6fb395_1
stdout: radtk.out
