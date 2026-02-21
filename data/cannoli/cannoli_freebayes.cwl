cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cannoli
  - freebayes
label: cannoli_freebayes
doc: "Call variants using FreeBayes via the Cannoli pipeline. (Note: The provided
  text contains system error logs regarding a container build failure and does not
  include the actual help documentation for the tool's arguments.)\n\nTool homepage:
  https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_freebayes.out
