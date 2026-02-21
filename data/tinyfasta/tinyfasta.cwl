cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinyfasta
label: tinyfasta
doc: "The provided text appears to be a container engine log (Apptainer/Singularity)
  indicating a failure to fetch or build the image, rather than the help text for
  the tinyfasta tool itself. As a result, no CLI arguments or descriptions could be
  extracted.\n\nTool homepage: https://github.com/tjelvar-olsson/tinyfasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinyfasta:0.1.0--py_0
stdout: tinyfasta.out
