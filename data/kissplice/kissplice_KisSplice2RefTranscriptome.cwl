cwlVersion: v1.2
class: CommandLineTool
baseCommand: kissplice_KisSplice2RefTranscriptome
label: kissplice_KisSplice2RefTranscriptome
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container environment (Apptainer/Singularity) failing
  to pull a Docker image due to lack of disk space.\n\nTool homepage: http://kissplice.prabi.fr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kissplice:2.6.5--h077b44d_1
stdout: kissplice_KisSplice2RefTranscriptome.out
