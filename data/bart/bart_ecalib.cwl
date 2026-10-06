cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, ecalib]
requirements:
  - class: InlineJavascriptRequirement
label: bart_ecalib
doc: "Estimate coil sensitivities using ESPIRiT calibration.\nOptionally outputs the
  eigenvalue maps.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: kspace
    type: File
    doc: k-space data
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: sensitivities
    type: string
    doc: Output file for sensitivities
    inputBinding:
      position: 11
  - id: ev_maps
    type:
      - 'null'
      - string
    doc: Optional output for eigenvalue maps
    inputBinding:
      position: 12
  - id: auto_threshold
    type:
      - 'null'
      - boolean
    doc: Automatically pick thresholds.
    inputBinding:
      position: 1
      prefix: -a
  - id: cal_size
    type:
      - 'null'
      - string
    doc: Limits the size of the calibration region.
    inputBinding:
      position: 1
      prefix: -r
  - id: crop_value
    type:
      - 'null'
      - float
    doc: Crop the sensitivities if the eigenvalue is smaller than {crop_value}.
    inputBinding:
      position: 1
      prefix: -c
  - id: debug_level
    type:
      - 'null'
      - int
    doc: Debug level
    inputBinding:
      position: 1
      prefix: -d
  - id: first_part_only
    type:
      - 'null'
      - boolean
    doc: perform only first part of the calibration
    inputBinding:
      position: 1
      prefix: '-1'
  - id: intensity_correction
    type:
      - 'null'
      - boolean
    doc: intensity correction
    inputBinding:
      position: 1
      prefix: -I
  - id: ksize
    type:
      - 'null'
      - string
    doc: kernel size
    inputBinding:
      position: 1
      prefix: -k
  - id: no_phase_rotation
    type:
      - 'null'
      - boolean
    doc: Do not rotate the phase with respect to the first principal component
    inputBinding:
      position: 1
      prefix: -P
  - id: noise_variance
    type:
      - 'null'
      - float
    doc: Variance of noise in data.
    inputBinding:
      position: 1
      prefix: -v
  - id: num_maps
    type:
      - 'null'
      - int
    doc: Number of maps to compute.
    inputBinding:
      position: 1
      prefix: -m
  - id: soft_sense
    type:
      - 'null'
      - boolean
    doc: create maps with smooth transitions (Soft-SENSE).
    inputBinding:
      position: 1
      prefix: -S
  - id: soft_weighting
    type:
      - 'null'
      - boolean
    doc: soft-weighting of the singular vectors.
    inputBinding:
      position: 1
      prefix: -W
  - id: threshold
    type:
      - 'null'
      - float
    doc: This determined the size of the null-space.
    inputBinding:
      position: 1
      prefix: -t
outputs:
  - id: sensitivities_out
    type: File
    doc: Output file for sensitivities
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.sensitivities).cfl
  - id: ev_maps_out
    type:
      - 'null'
      - File
    doc: Array written as ev_maps.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.ev_maps).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
