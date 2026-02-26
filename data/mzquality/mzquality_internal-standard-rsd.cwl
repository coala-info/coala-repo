cwlVersion: v1.2
class: CommandLineTool
baseCommand: qcli.py
label: mzquality_internal-standard-rsd
doc: "CLI to the mzQuality\n\nmzQuality is a Tool for quality monitoring and reporting
  of mass spectrometry measurements.\n\nTool homepage: https://github.com/hankemeierlab/mzQuality"
inputs:
  - id: internal_standard_rsd
    type: string
    doc: internal-standard-rsd
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
stdout: mzquality_internal-standard-rsd.out
