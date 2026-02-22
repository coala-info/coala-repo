cwlVersion: v1.2
class: CommandLineTool
baseCommand: beast
label: beast2-mcmc
doc: "BEAST is a cross-platform program for Bayesian evolutionary analysis of molecular
  sequences. It is entirely orientated towards rooted, time-measured phylogenies inferred
  using (strict or relaxed) molecular clock models.\n\nTool homepage: http://www.beast2.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/beast2-mcmc:v2.5.1dfsg-2-deb_cv1
stdout: beast2-mcmc.out
