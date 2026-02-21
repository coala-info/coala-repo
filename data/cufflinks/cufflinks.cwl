cwlVersion: v1.2
class: CommandLineTool
baseCommand: cufflinks
label: cufflinks
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to build or extract a container
  image due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/santosjorge/cufflinks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cufflinks:2.2.1--py35_2
stdout: cufflinks.out
