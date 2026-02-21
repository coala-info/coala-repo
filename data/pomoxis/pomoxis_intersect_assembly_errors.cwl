cwlVersion: v1.2
class: CommandLineTool
baseCommand: pomoxis_intersect_assembly_errors
label: pomoxis_intersect_assembly_errors
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  while attempting to fetch the pomoxis image.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_intersect_assembly_errors.out
