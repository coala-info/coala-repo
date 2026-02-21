cwlVersion: v1.2
class: CommandLineTool
baseCommand: zstd
label: zstd
doc: "The provided text does not contain help information for the zstd command-line
  tool. It appears to be a log of a failed container build process (Apptainer/Singularity)
  attempting to fetch a zstd image from a container registry.\n\nTool homepage: https://github.com/facebook/zstd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/zstd:v1.3.8dfsg-3-deb_cv1
stdout: zstd.out
