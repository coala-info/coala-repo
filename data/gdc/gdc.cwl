cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdc
label: gdc
doc: "The provided text does not contain help documentation for the tool, but rather
  an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the gdc container image due to lack of disk space.\n\nTool homepage: http://sun.aei.polsl.pl/REFRESH/index.php?page=projects&project=gdc&subpage=about"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdc:2.0--h077b44d_6
stdout: gdc.out
