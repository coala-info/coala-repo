cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms2rescore
label: ms2rescore
doc: "Sensitive PSM rescoring with predicted features.\n\nTool homepage: https://compomics.github.io/projects/ms2rescore/"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: path to MS²Rescore configuration file (see README.md)
    inputBinding:
      position: 101
      prefix: --config-file
  - id: disable_update_check
    type:
      - 'null'
      - boolean
    doc: Disable automatic check for software updates
    default: false
    inputBinding:
      position: 101
      prefix: --disable-update-check
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: path to FASTA file
    inputBinding:
      position: 101
      prefix: --fasta-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: logging level
    default: info
    inputBinding:
      position: 101
      prefix: --log-level
  - id: processes
    type:
      - 'null'
      - int
    doc: number of parallel processes available to MS²Rescore
    inputBinding:
      position: 101
      prefix: --processes
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Enable profiling with cProfile
    inputBinding:
      position: 101
      prefix: --profile
  - id: psm_file
    type:
      - 'null'
      - type: array
        items: File
    doc: path to PSM file (PIN, mzIdentML, MaxQuant msms, X!Tandem XML...)
    inputBinding:
      position: 101
      prefix: --psm-file
  - id: psm_file_type
    type:
      - 'null'
      - string
    doc: PSM file type
    default: infer
    inputBinding:
      position: 101
      prefix: --psm-file-type
  - id: spectrum_path
    type:
      - 'null'
      - File
    doc: path to MGF/mzML spectrum file or directory with spectrum files
    inputBinding:
      position: 101
      prefix: --spectrum-path
  - id: write_report
    type:
      - 'null'
      - boolean
    doc: boolean whether to write an HTML report
    default: true
    inputBinding:
      position: 101
      prefix: --write-report
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: Path and stem for output file names
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms2rescore:3.2.1--pyhdfd78af_0
