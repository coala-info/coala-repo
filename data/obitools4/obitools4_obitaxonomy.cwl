cwlVersion: v1.2
class: CommandLineTool
baseCommand: obitaxonomy
label: obitools4_obitaxonomy
doc: "The provided text is an error log indicating a failure to initialize the container
  environment (no space left on device) and does not contain the help text or usage
  instructions for the tool.\n\nTool homepage: https://obitools4.metabarcoding.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obitaxonomy.out
