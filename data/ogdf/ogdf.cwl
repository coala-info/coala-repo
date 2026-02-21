cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogdf
label: ogdf
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull the image due to insufficient disk space. It does not
  contain help text or usage information for the ogdf tool.\n\nTool homepage: https://github.com/ogdf/ogdf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ogdf:201207--h9f5acd7_6
stdout: ogdf.out
