cwlVersion: v1.2
class: CommandLineTool
baseCommand: sesimcmc
label: sesimcmc
doc: "Sequence Motif MCMC (Note: The provided text is a container build error log
  and does not contain help information or argument definitions.)\n\nTool homepage:
  http://favorov.bioinfolab.net/SeSiMCMC/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sesimcmc:4.36--he1b5a44_0
stdout: sesimcmc.out
