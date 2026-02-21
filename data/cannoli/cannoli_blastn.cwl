cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cannoli-submit
  - blastn
label: cannoli_blastn
doc: "The provided text contains system error logs and does not include the help documentation
  for cannoli_blastn. Cannoli is a big data genomics tool that wraps common bioinformatics
  tools like BLASTN for use on Apache Spark.\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_blastn.out
