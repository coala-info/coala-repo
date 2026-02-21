cwlVersion: v1.2
class: CommandLineTool
baseCommand: gem2_gem2rpm
label: gem2_gem2rpm
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build a SIF image due to insufficient disk space.\n\nTool
  homepage: https://github.com/fedora-ruby/gem2rpm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gem2:20200110--h9ee0642_1
stdout: gem2_gem2rpm.out
