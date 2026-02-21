cwlVersion: v1.2
class: CommandLineTool
baseCommand: bed2gtf
label: bed2gtf
doc: "A tool to convert BED files to GTF format. Note: The provided help text appears
  to be an error log regarding a failed container build ('no space left on device')
  and does not contain usage instructions or argument definitions.\n\nTool homepage:
  https://github.com/alejandrogzi/bed2gtf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bed2gtf:1.9.3--h4ac6f70_0
stdout: bed2gtf.out
