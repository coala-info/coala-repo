cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfacs
label: perl-gfacs
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or run the image due to lack of disk space. It does
  not contain the help text or usage information for the tool 'perl-gfacs'.\n\nTool
  homepage: https://gitlab.com/PlantGenomicsLab/gFACs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-gfacs:1.1.1--hdfd78af_1
stdout: perl-gfacs.out
