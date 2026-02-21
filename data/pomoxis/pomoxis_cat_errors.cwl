cwlVersion: v1.2
class: CommandLineTool
baseCommand: pomoxis_cat_errors
label: pomoxis_cat_errors
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log from a container runtime (Apptainer/Singularity) failing
  to fetch the tool image.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_cat_errors.out
