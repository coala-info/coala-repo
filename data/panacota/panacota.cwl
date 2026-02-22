cwlVersion: v1.2
class: CommandLineTool
baseCommand: panacota
label: panacota
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a Singularity/Apptainer container execution failure
  (no space left on device).\n\nTool homepage: https://github.com/gem-pasteur/PanACoTA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
stdout: panacota.out
