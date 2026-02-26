cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ms2pip
  - annotate-spectra
label: ms2pip_annotate-spectra
doc: "Annotate observed spectra.\n\nTool homepage: http://compomics.github.io/projects/ms2pip_c"
inputs:
  - id: psms
    type: string
    doc: PSMs
    inputBinding:
      position: 1
  - id: spectrum_file
    type: File
    doc: Spectrum file
    inputBinding:
      position: 2
  - id: model
    type:
      - 'null'
      - string
    doc: Model to use for annotation
    inputBinding:
      position: 103
      prefix: --model
  - id: ms2_tolerance
    type:
      - 'null'
      - float
    doc: MS2 tolerance
    inputBinding:
      position: 103
      prefix: --ms2-tolerance
  - id: output_name
    type:
      - 'null'
      - string
    doc: Output name
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
    doc: Spectrum ID pattern
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
stdout: ms2pip_annotate-spectra.out
