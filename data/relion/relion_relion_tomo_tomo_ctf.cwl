cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_tomo_ctf
label: relion_relion_tomo_tomo_ctf
doc: "Estimate the CTF of a tilt-series stack from the power spectra of image tiles.\n\nTool homepage:\
  \ https://github.com/3dem/relion"
inputs:
  - id: tilt_series
    type: File
    doc: Tilt sequence image stack (e.g. *.st:mrc)
    inputBinding:
      position: 101
      prefix: --ts
  - id: projections
    type: File
    doc: Tilt projections file (*.tlt)
    inputBinding:
      position: 101
      prefix: --p
  - id: output
    type: string
    doc: Output filename
    inputBinding:
      position: 101
      prefix: --o
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size in Å (RELION default: 1.0)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: voltage
    type:
      - 'null'
      - float
    doc: 'Voltage in kV (RELION default: 1.0)'
    inputBinding:
      position: 101
      prefix: --kV
  - id: spherical_aberration
    type:
      - 'null'
      - float
    doc: 'Spherical aberration in mm (RELION default: 2.7)'
    inputBinding:
      position: 101
      prefix: --Cs
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 5)'
    inputBinding:
      position: 101
      prefix: --j
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: CTF estimates and diagnostic images
    outputBinding:
      glob: $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_tomo_ctf.out
