cwlVersion: v1.2
class: CommandLineTool
baseCommand: markermagu
label: marker-magu_markermagu
doc: "A tool for identifying and analyzing marker genes (Note: The provided help text
  contains only container runtime error messages and no usage information).\n\nTool
  homepage: https://github.com/cmmr/Marker-MAGu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marker-magu:0.4.0--pyhdfd78af_1
stdout: marker-magu_markermagu.out
