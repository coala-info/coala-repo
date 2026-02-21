cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-neuro_cmrep_vskel
label: meta-neuro_cmrep_vskel
doc: "A tool within the meta-neuro package (Note: The provided text contains container
  runtime error logs rather than tool help text, so specific arguments could not be
  extracted).\n\nTool homepage: https://github.com/bagari/meta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
stdout: meta-neuro_cmrep_vskel.out
