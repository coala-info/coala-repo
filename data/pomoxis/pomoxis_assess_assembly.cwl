cwlVersion: v1.2
class: CommandLineTool
baseCommand: pomoxis_assess_assembly
label: pomoxis_assess_assembly
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) failing to fetch
  a Docker image.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_assess_assembly.out
