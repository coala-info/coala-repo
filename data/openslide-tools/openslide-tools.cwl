cwlVersion: v1.2
class: CommandLineTool
baseCommand: openslide-tools
label: openslide-tools
doc: "A collection of tools for reading and manipulating whole-slide images. (Note:
  The provided text appears to be a container build error log rather than CLI help
  text, so no arguments could be extracted.)\n\nTool homepage: https://github.com/Dart9000/OpenX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/openslide-tools:v3.4.1dfsg-4-deb_cv1
stdout: openslide-tools.out
