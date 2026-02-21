cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsk2ascii
label: dsk_dsk2ascii
doc: "The provided text does not contain help information or a description of the
  tool; it contains a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a 'no space left on device' failure during image construction.\n\nTool
  homepage: https://github.com/GATB/dsk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsk:2.3.3--h5ca1c30_7
stdout: dsk_dsk2ascii.out
