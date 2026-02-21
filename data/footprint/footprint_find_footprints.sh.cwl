cwlVersion: v1.2
class: CommandLineTool
baseCommand: footprint_find_footprints.sh
label: footprint_find_footprints.sh
doc: "A tool for finding genomic footprints (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://ohlerlab.mdc-berlin.de/software/Reproducible_footprinting_139/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/footprint:1.0.1--pl5321r41hdfd78af_0
stdout: footprint_find_footprints.sh.out
