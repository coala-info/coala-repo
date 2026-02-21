cwlVersion: v1.2
class: CommandLineTool
baseCommand: poretools
label: poretools
doc: "The provided text does not contain help information or usage instructions for
  poretools; it contains error logs from a container runtime (Apptainer/Singularity)
  failure.\n\nTool homepage: https://github.com/arq5x/poretools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
stdout: poretools.out
