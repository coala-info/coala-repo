cwlVersion: v1.2
class: CommandLineTool
baseCommand: qcli.py
label: mzquality_blank-effect
doc: "CLI to the mzQuality\n\nmzQuality is a Tool for quality monitoring and reporting
  of mass spectrometry measurements.\n\nTool homepage: https://github.com/hankemeierlab/mzQuality"
inputs:
  - id: method
    type: string
    doc: 'The method to run. Supported methods are: measurement summary, blank_effect,
      rt_shifts, qc_correction, rsd qc, rsd replicates, rsd internal standard(s),
      plot information compound(s), export results as samples vs. compounds'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
stdout: mzquality_blank-effect.out
