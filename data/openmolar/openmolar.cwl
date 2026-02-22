cwlVersion: v1.2
class: CommandLineTool
baseCommand: openmolar
label: openmolar
doc: "Openmolar is a dental practice management software. (Note: The provided text
  appears to be a system error log rather than help text, so no arguments could be
  extracted.)\n\nTool homepage: https://github.com/rowinggolfer/openmolar1"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/openmolar:v1.0.15-gd81f9e5-1-deb_cv1
stdout: openmolar.out
