cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gogstools
  - ogs_merge
label: gogstools_ogs_merge
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/genouest/ogs-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gogstools:0.1.2--py310hdfd78af_0
stdout: gogstools_ogs_merge.out
