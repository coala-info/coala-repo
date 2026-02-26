cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ms2pip
  - correlate
label: ms2pip_correlate
doc: "Compare predicted and observed intensities and optionally compute correlations.\n\
  \nTool homepage: http://compomics.github.io/projects/ms2pip_c"
inputs:
  - id: psms
    type: File
    doc: PSM file
    inputBinding:
      position: 1
  - id: spectrum_file
    type: File
    doc: Spectrum file
    inputBinding:
      position: 2
  - id: add_ion_mobility
    type:
      - 'null'
      - boolean
    doc: Add ion mobility information
    inputBinding:
      position: 103
      prefix: --add-ion-mobility
  - id: add_retention_time
    type:
      - 'null'
      - boolean
    doc: Add retention time information
    inputBinding:
      position: 103
      prefix: --add-retention-time
  - id: compute_correlations
    type:
      - 'null'
      - boolean
    doc: Compute correlations
    inputBinding:
      position: 103
      prefix: --compute-correlations
  - id: model
    type:
      - 'null'
      - string
    doc: MS2PIP model to use
    inputBinding:
      position: 103
      prefix: --model
  - id: model_dir
    type:
      - 'null'
      - string
    doc: Directory containing MS2PIP models
    inputBinding:
      position: 103
      prefix: --model-dir
  - id: ms2_tolerance
    type:
      - 'null'
      - float
    doc: Tolerance for MS2 peaks
    inputBinding:
      position: 103
      prefix: --ms2-tolerance
  - id: output_name
    type:
      - 'null'
      - string
    doc: Output file name
    inputBinding:
      position: 103
      prefix: --output-name
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes to use
    inputBinding:
      position: 103
      prefix: --processes
  - id: psm_filetype
    type:
      - 'null'
      - string
    doc: Type of PSM file
    inputBinding:
      position: 103
      prefix: --psm-filetype
  - id: spectrum_id_pattern
    type:
      - 'null'
      - string
    doc: Pattern to extract spectrum IDs
    inputBinding:
      position: 103
      prefix: --spectrum-id-pattern
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms2pip:4.1.0--py312h0fa9677_2
stdout: ms2pip_correlate.out
