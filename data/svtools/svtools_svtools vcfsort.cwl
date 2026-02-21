cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - vcfsort
label: svtools_svtools vcfsort
doc: "Sort VCF files (Note: The provided help text contained only system logs and
  error messages; no argument definitions were found in the input).\n\nTool homepage:
  https://github.com/hall-lab/svtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_svtools vcfsort.out
