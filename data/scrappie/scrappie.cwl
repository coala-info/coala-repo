cwlVersion: v1.2
class: CommandLineTool
baseCommand: scrappie
label: scrappie
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a 'no space left on device' failure during image extraction.\n\nTool
  homepage: https://github.com/nanoporetech/scrappie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
stdout: scrappie.out
