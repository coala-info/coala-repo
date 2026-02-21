cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-openslide
label: python3-openslide
doc: "Python 3 bindings for the OpenSlide library. Note: The provided text appears
  to be a container build error log rather than CLI help text, so no arguments could
  be extracted.\n\nTool homepage: https://github.com/fperdigon/openslide_python3.7"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-openslide:v1.1.1-2-deb_cv1
stdout: python3-openslide.out
