cwlVersion: v1.2
class: CommandLineTool
baseCommand: beast
label: beast-mcmc
doc: "BEAST is a cross-platform program for Bayesian evolutionary analysis of molecular
  sequences. It is entirely orientated towards rooted, time-measured phylogenies inferred
  using strict or relaxed molecular clock models.\n\nTool homepage: https://beast.community"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/beast-mcmc:v1.10.4dfsg-1-deb_cv1
stdout: beast-mcmc.out
