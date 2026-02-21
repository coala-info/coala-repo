cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - lmerge
label: svtools_svtools lmerge
doc: "Merge structural variant calls (Note: The provided text contained container
  execution logs and error messages rather than tool help text; no arguments could
  be extracted).\n\nTool homepage: https://github.com/hall-lab/svtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_svtools lmerge.out
