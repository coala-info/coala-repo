cwlVersion: v1.2
class: CommandLineTool
baseCommand: samhaplotag
label: samhaplotag_10xSpoof
doc: "The provided text does not contain help documentation or usage instructions
  for the tool. It consists of container runtime (Apptainer/Singularity) error logs
  indicating a failure to fetch the OCI image.\n\nTool homepage: https://github.com/wtsi-hpag/SamHaplotag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samhaplotag:0.0.4--h9948957_4
stdout: samhaplotag_10xSpoof.out
