cwlVersion: v1.2
class: CommandLineTool
baseCommand: unzstd
label: zstd_unzstd
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container build failure (Apptainer/Singularity).\n\nTool
  homepage: https://github.com/facebook/zstd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/zstd:v1.3.8dfsg-3-deb_cv1
stdout: zstd_unzstd.out
