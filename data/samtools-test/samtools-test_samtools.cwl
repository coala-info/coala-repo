cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools-test_samtools
label: samtools-test_samtools
doc: "The provided text is a system error log from a container build process and does
  not contain help information or argument definitions for the tool.\n\nTool homepage:
  https://github.com/samtools/samtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/samtools-test:v1.9-4-deb_cv1
stdout: samtools-test_samtools.out
