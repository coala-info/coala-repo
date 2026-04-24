cwlVersion: v1.2
class: CommandLineTool
baseCommand: sistr
label: sistr_cmd
doc: "Salmonella In Silico Typing Resource (SISTR) command line tool for serovar prediction
  from whole-genome sequence data.\n\nTool homepage: https://github.com/phac-nml/sistr_cmd/"
inputs:
  - id: input_fasta
    type:
      type: array
      items: File
    doc: Input fasta file(s) to perform serovar prediction on.
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files.
    inputBinding:
      position: 101
      prefix: --keep-tmp
  - id: more_results
    type:
      - 'null'
      - boolean
    doc: Output more detailed results.
    inputBinding:
      position: 101
      prefix: --more-results
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format (json, csv, pickle).
    inputBinding:
      position: 101
      prefix: --output-format
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet output.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: run_mashing
    type:
      - 'null'
      - boolean
    doc: Run Mash for serovar prediction.
    inputBinding:
      position: 101
      prefix: --run-mashing
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Base directory for temporary files.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_prediction
    type: File
    doc: Output file for prediction results.
    outputBinding:
      glob: $(inputs.output_prediction)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sistr_cmd:1.1.3--pyhdc42f0e_2
