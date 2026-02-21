cwlVersion: v1.2
class: CommandLineTool
baseCommand: rawtools
label: rawtools
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  failing to pull or build the image.\n\nTool homepage: https://github.com/kevinkovalchik/RawTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rawtools:2.0.4--hdfd78af_0
stdout: rawtools.out
