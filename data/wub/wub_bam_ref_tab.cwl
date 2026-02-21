cwlVersion: v1.2
class: CommandLineTool
baseCommand: wub_bam_ref_tab
label: wub_bam_ref_tab
doc: "The provided text contains build logs and error messages rather than the tool's
  help documentation. As a result, no arguments or functional descriptions could be
  extracted.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
stdout: wub_bam_ref_tab.out
