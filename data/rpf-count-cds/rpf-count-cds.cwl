cwlVersion: v1.2
class: CommandLineTool
baseCommand: rpf-count-cds
label: rpf-count-cds
doc: "A tool for counting Ribosome Protected Fragments (RPF) on Coding Sequences (CDS).
  Note: The provided help text contains only system logs and error messages; no specific
  arguments or usage instructions were found in the input.\n\nTool homepage: https://github.com/xzt41/RPF-count-CDS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rpf-count-cds:0.0.1--py_0
stdout: rpf-count-cds.out
