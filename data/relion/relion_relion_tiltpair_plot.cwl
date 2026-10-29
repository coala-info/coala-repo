cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tiltpair_plot
label: relion_relion_tiltpair_plot
doc: "Plot the orientation differences of tilt pairs (untilted and tilted particles) as an EPS file.\n\
  \nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: untilted_star
    type: File
    doc: Input STAR file with untilted particles
    inputBinding:
      position: 101
      prefix: --u
  - id: tilted_star
    type: File
    doc: Input STAR file with tilted particles
    inputBinding:
      position: 101
      prefix: --t
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output EPS file (RELION default: tiltpair.eps)'
    inputBinding:
      position: 101
      prefix: --o
    default: tiltpair.eps
  - id: symmetry
    type:
      - 'null'
      - string
    doc: 'Symmetry point group (RELION default: C1)'
    inputBinding:
      position: 101
      prefix: --sym
  - id: exp_tilt
    type:
      - 'null'
      - float
    doc: 'Choose symmetry operator that gives tilt angle closest to this value (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --exp_tilt
  - id: exp_beta
    type:
      - 'null'
      - float
    doc: 'Choose symmetry operator that gives beta angle closest to this value (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --exp_beta
  - id: dist_from_alpha
    type:
      - 'null'
      - float
    doc: 'Direction (alpha angle) of tilt axis from which to calculate distance (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --dist_from_alpha
  - id: dist_from_tilt
    type:
      - 'null'
      - float
    doc: 'Tilt angle from which to calculate distance (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --dist_from_tilt
  - id: max_tilt
    type:
      - 'null'
      - float
    doc: 'Maximum tilt angle to plot in the EPS file (RELION default: 90.)'
    inputBinding:
      position: 101
      prefix: --max_tilt
  - id: spot_radius
    type:
      - 'null'
      - float
    doc: 'Radius in pixels of the spots in the tiltpair plot (RELION default: 3)'
    inputBinding:
      position: 101
      prefix: --spot_radius
outputs:
  - id: plot
    type: File
    doc: EPS plot
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tiltpair_plot.out
