cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-annotator
label: vcf-annotator
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) failing
  to pull the image.\n\nTool homepage: https://github.com/rpetit3/vcf-annotator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-annotator:0.7--hdfd78af_0
stdout: vcf-annotator.out
