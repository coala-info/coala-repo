cwlVersion: v1.2
class: CommandLineTool
baseCommand: hal2maf
label: progressivecactus_hal2maf
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process (Apptainer/Singularity).\n\nTool
  homepage: https://github.com/glennhickey/progressiveCactus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/progressivecactus:0.1
stdout: progressivecactus_hal2maf.out
