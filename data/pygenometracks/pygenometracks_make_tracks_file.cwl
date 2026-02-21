cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_tracks_file
label: pygenometracks_make_tracks_file
doc: "The provided text contains container runtime logs and an error message rather
  than the tool's help documentation. As a result, no arguments could be extracted.\n
  \nTool homepage: //github.com/maxplanck-ie/pyGenomeTracks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygenometracks:3.9--pyhdfd78af_0
stdout: pygenometracks_make_tracks_file.out
