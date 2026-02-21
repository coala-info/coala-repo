cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribodiff
label: ribodiff
doc: "The provided text does not contain help information for the tool 'ribodiff'.
  It contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to fetch or build the container image.\n\nTool homepage: https://github.com/ml4bio/RiboDiffusion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribodiff:0.2.2--py27_1
stdout: ribodiff.out
