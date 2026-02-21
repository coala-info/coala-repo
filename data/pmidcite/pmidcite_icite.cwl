cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pmidcite
  - icite
label: pmidcite_icite
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: http://github.com/dvklopfenstein/pmidcite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmidcite:0.3.1--pyhdfd78af_0
stdout: pmidcite_icite.out
