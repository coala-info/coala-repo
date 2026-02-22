cwlVersion: v1.2
class: CommandLineTool
baseCommand: batman
label: batman
doc: "Bayesian AuTomated Metabolite ANalyser (BATMAN) for deconvolving resonance peaks
  from NMR spectra.\n\nTool homepage: https://github.com/mixandjam/Batman-Arkham-Combat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/batman:phenomenal-v1.2.12.0_cv1.1.72
stdout: batman.out
