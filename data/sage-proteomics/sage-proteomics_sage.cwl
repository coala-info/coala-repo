cwlVersion: v1.2
class: CommandLineTool
baseCommand: sage
label: sage-proteomics_sage
doc: "Sage - Proteomics searching so fast it feels like magic!\n\nTool homepage: https://github.com/lazear/sage"
inputs:
  - id: parameters
    type: File
    doc: Path to configuration parameters (JSON file)
    inputBinding:
      position: 1
  - id: mzml_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: Paths to mzML files to process. Overrides mzML files listed in the 
      configuration file.
    inputBinding:
      position: 2
  - id: annotate_matches
    type:
      - 'null'
      - boolean
    doc: Write matched fragments output file.
    inputBinding:
      position: 103
      prefix: --annotate-matches
  - id: batch_size
    type:
      - 'null'
      - int
    doc: 'Number of files to load and search in parallel (default = # of CPUs/2)'
    default: '# of CPUs/2'
    inputBinding:
      position: 103
      prefix: --batch-size
  - id: disable_telemetry_i_dont_want_to_improve_sage
    type:
      - 'null'
      - boolean
    doc: Disable sending telemetry data
    inputBinding:
      position: 103
      prefix: --disable-telemetry-i-dont-want-to-improve-sage
  - id: fasta
    type:
      - 'null'
      - File
    doc: Path to FASTA database. Overrides the FASTA file specified in the 
      configuration file.
    inputBinding:
      position: 103
      prefix: --fasta
  - id: write_parquet
    type:
      - 'null'
      - boolean
    doc: Write search output in parquet format instead of tsv
    inputBinding:
      position: 103
      prefix: --parquet
  - id: write_pin
    type:
      - 'null'
      - boolean
    doc: Write percolator-compatible `.pin` output files
    inputBinding:
      position: 103
      prefix: --write-pin
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Path where search and quant results will be written. Overrides the 
      directory specified in the configuration file.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sage-proteomics:0.14.7--hc1c3326_2
