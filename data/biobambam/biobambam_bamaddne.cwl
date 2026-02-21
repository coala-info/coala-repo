cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamaddne
label: biobambam_bamaddne
doc: "The provided text is a system error log (Singularity/Apptainer build failure)
  and does not contain help text or argument definitions for the tool.\n\nTool homepage:
  https://gitlab.com/german.tischler/biobambam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h02148a2_0
stdout: biobambam_bamaddne.out
