cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_ctf_toolbox
label: relion_relion_ctf_toolbox
doc: "Pre-multiply particles with their CTF, or simulate a CTF image.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input STAR file with CTF information
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output rootname (for multiple images: insert this string before each image''s extension)'
    inputBinding:
      position: 101
      prefix: --o
  - id: apply_orient
    type:
      - 'null'
      - boolean
    doc: Also apply the in-plane rotation and translation to the CTF-premultiplied images
    inputBinding:
      position: 101
      prefix: --apply_orient
  - id: simulate
    type:
      - 'null'
      - string
    doc: Output name for simulated CTF image
    inputBinding:
      position: 101
      prefix: --simulate
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size (A) (RELION default: 1.)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: box
    type:
      - 'null'
      - int
    doc: 'Box size (pix) (RELION default: 256)'
    inputBinding:
      position: 101
      prefix: --box
  - id: kV
    type:
      - 'null'
      - float
    doc: 'Voltage (kV) (RELION default: 300)'
    inputBinding:
      position: 101
      prefix: --kV
  - id: Q0
    type:
      - 'null'
      - float
    doc: 'Amplitude contrast (RELION default: 0.1)'
    inputBinding:
      position: 101
      prefix: --Q0
  - id: Cs
    type:
      - 'null'
      - float
    doc: 'Spherical aberration (mm) (RELION default: 2.7)'
    inputBinding:
      position: 101
      prefix: --Cs
  - id: defU
    type:
      - 'null'
      - float
    doc: 'Defocus in U-direction (A) (RELION default: 20000)'
    inputBinding:
      position: 101
      prefix: --defU
  - id: defV
    type:
      - 'null'
      - float
    doc: 'Defocus in V-direction (A, default = defU) (RELION default: -1.)'
    inputBinding:
      position: 101
      prefix: --defV
  - id: defAng
    type:
      - 'null'
      - float
    doc: 'Defocus angle (deg) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --defAng
  - id: phase_shift
    type:
      - 'null'
      - float
    doc: 'Phase shift (deg) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --phase_shift
  - id: ctf_intact_first_peak
    type:
      - 'null'
      - boolean
    doc: Leave CTFs intact until first peak
    inputBinding:
      position: 101
      prefix: --ctf_intact_first_peak
  - id: ctf_intact_after_first_peak
    type:
      - 'null'
      - boolean
    doc: Leave CTFs intact after first peak
    inputBinding:
      position: 101
      prefix: --ctf_intact_after_first_peak
  - id: ctf_pad
    type:
      - 'null'
      - boolean
    doc: Pre-multiply with a 2x finer-sampled CTF that is then downscaled
    inputBinding:
      position: 101
      prefix: --ctf_pad
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Pre-multiplied images or the simulated CTF image
    outputBinding:
      glob:
        - $(inputs.output)*
        - $(inputs.simulate)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_ctf_toolbox.out
