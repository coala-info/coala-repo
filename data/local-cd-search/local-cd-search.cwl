cwlVersion: v1.2
class: CommandLineTool
baseCommand: local-cd-search
label: local-cd-search
doc: "A tool for local search against the Conserved Domain Database (CDD). Note: The
  provided text contains system error logs rather than help documentation, so specific
  arguments could not be extracted.\n\nTool homepage: https://github.com/apcamargo/local-cd-search"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/local-cd-search:0.3.1--pyhdfd78af_0
stdout: local-cd-search.out
