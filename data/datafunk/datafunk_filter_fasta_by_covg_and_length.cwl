cwlVersion: v1.2
class: CommandLineTool
baseCommand: datafunk filter_fasta_by_covg_and_length
label: datafunk_filter_fasta_by_covg_and_length
doc: "Filters a FASTA file based on coverage and length thresholds.\n\nTool homepage:
  https://github.com/cov-ert/datafunk"
inputs:
  - id: threshold
    type: string
    doc: Coverage threshold
    inputBinding:
      position: 1
  - id: input_fasta
    type: File
    doc: Input FASTA
    inputBinding:
      position: 102
      prefix: --input-fasta
  - id: min_covg
    type:
      - 'null'
      - int
    doc: Integer representing the minimum coverage percentage threshold. 
      Sequences with coverage (strictly) less than this will be excluded from 
      the filtered file.
    inputBinding:
      position: 102
      prefix: --min-covg
  - id: min_length
    type:
      - 'null'
      - int
    doc: Integer representing the minimum length threshold. Sequences with 
      length (strictly) less than this will be excluded from the filtered file.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run with high verbosity (debug level logging)
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Output file name for resulting filtered FASTA (default adds .filtered 
      to input file name)
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
