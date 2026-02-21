cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - htshax
label: seqhax_htshax
doc: "The provided text is a system error log regarding a container build failure
  ('no space left on device') and does not contain CLI help information or argument
  definitions.\n\nTool homepage: https://github.com/kdmurray91/seqhax"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
stdout: seqhax_htshax.out
