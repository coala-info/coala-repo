cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-load
label: segway_genomedata-load
doc: "The provided text does not contain help information for the tool; it contains
  a fatal error log from a container runtime (Apptainer/Singularity) indicating a
  'no space left on device' failure during image extraction. No arguments could be
  parsed from the input text.\n\nTool homepage: http://segway.hoffmanlab.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segway:3.0.4--pyh7cba7a3_1
stdout: segway_genomedata-load.out
