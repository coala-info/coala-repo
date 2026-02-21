cwlVersion: v1.2
class: CommandLineTool
baseCommand: msa_view
label: phast_msa_view
doc: "The provided text does not contain help information for phast_msa_view; it contains
  container runtime logs and a fatal error message regarding a SIF build failure.\n
  \nTool homepage: http://compgen.cshl.edu/phast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.6--h93e12ee_0
stdout: phast_msa_view.out
