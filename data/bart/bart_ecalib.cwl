cwlVersion: v1.2
class: CommandLineTool
baseCommand: ecalib
label: bart_ecalib
doc: "Estimate coil sensitivities using ESPIRiT calibration.\nOptionally outputs the
  eigenvalue maps.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: kspace
    type: File
    doc: k-space data
    inputBinding:
      position: 1
  - id: sensitivities
    type: File
    doc: Output file for sensitivities
    inputBinding:
      position: 2
  - id: ev_maps
    type:
      - 'null'
      - File
    doc: Optional output for eigenvalue maps
    inputBinding:
      position: 3
  - id: auto_threshold
    type:
      - 'null'
      - boolean
    doc: Automatically pick thresholds.
    inputBinding:
      position: 104
      prefix: -a
  - id: cal_size
    type:
      - 'null'
      - type: array
        items: int
    doc: Limits the size of the calibration region.
    inputBinding:
      position: 104
      prefix: -r
  - id: crop_value
    type:
      - 'null'
      - float
    doc: Crop the sensitivities if the eigenvalue is smaller than {crop_value}.
    inputBinding:
      position: 104
      prefix: -c
  - id: debug_level
    type:
      - 'null'
      - Directory
    doc: Debug level
    inputBinding:
      position: 104
      prefix: -d
  - id: first_part_only
    type:
      - 'null'
      - boolean
    doc: perform only first part of the calibration
    inputBinding:
      position: 104
      prefix: '-1'
  - id: intensity_correction
    type:
      - 'null'
      - boolean
    doc: intensity correction
    inputBinding:
      position: 104
      prefix: -I
  - id: ksize
    type:
      - 'null'
      - type: array
        items: int
    doc: kernel size
    inputBinding:
      position: 104
      prefix: -k
  - id: no_phase_rotation
    type:
      - 'null'
      - boolean
    doc: Do not rotate the phase with respect to the first principal component
    inputBinding:
      position: 104
      prefix: -P
  - id: noise_variance
    type:
      - 'null'
      - float
    doc: Variance of noise in data.
    inputBinding:
      position: 104
      prefix: -v
  - id: num_maps
    type:
      - 'null'
      - Directory
    doc: Number of maps to compute.
    inputBinding:
      position: 104
      prefix: -m
  - id: soft_sense
    type:
      - 'null'
      - boolean
    doc: create maps with smooth transitions (Soft-SENSE).
    inputBinding:
      position: 104
      prefix: -S
  - id: soft_weighting
    type:
      - 'null'
      - boolean
    doc: soft-weighting of the singular vectors.
    inputBinding:
      position: 104
      prefix: -W
  - id: threshold
    type:
      - 'null'
      - float
    doc: This determined the size of the null-space.
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_ecalib.out
