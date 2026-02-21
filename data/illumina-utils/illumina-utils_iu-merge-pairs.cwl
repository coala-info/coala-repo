cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iu-merge-pairs
label: illumina-utils_iu-merge-pairs
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Singularity/Apptainer) failing to
  build an image due to insufficient disk space.\n\nTool homepage: https://github.com/meren/illumina-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
stdout: illumina-utils_iu-merge-pairs.out
