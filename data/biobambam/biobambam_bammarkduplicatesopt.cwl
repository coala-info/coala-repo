cwlVersion: v1.2
class: CommandLineTool
baseCommand: bammarkduplicatesopt
label: biobambam_bammarkduplicatesopt
doc: "The provided text is an error log reporting a 'no space left on device' failure
  during the extraction of a Singularity/Apptainer container and does not contain
  the help text or argument definitions for the tool.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h02148a2_0
stdout: biobambam_bammarkduplicatesopt.out
