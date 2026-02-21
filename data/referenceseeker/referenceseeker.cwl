cwlVersion: v1.2
class: CommandLineTool
baseCommand: referenceseeker
label: referenceseeker
doc: "The provided text does not contain help information or usage instructions for
  referenceseeker; it is a fatal error log from a container runtime (Singularity/Apptainer)
  attempting to fetch the tool's image.\n\nTool homepage: https://github.com/oschwengers/referenceseeker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/referenceseeker:1.8.0--pyhdfd78af_0
stdout: referenceseeker.out
