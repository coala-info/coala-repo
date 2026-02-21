cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools-test
label: samtools-test
doc: "The provided text appears to be a container build log rather than CLI help text.
  No tool description or arguments could be extracted from the input.\n\nTool homepage:
  https://github.com/samtools/samtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/samtools-test:v1.9-4-deb_cv1
stdout: samtools-test.out
