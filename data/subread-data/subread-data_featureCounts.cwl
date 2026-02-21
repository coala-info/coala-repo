cwlVersion: v1.2
class: CommandLineTool
baseCommand: featureCounts
label: subread-data_featureCounts
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain the help documentation or usage instructions for the tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://subread.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/subread-data:v1.6.3dfsg-1-deb_cv1
stdout: subread-data_featureCounts.out
