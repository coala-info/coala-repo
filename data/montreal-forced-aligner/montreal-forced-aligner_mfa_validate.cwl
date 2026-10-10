cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mfa
  - validate
label: montreal-forced-aligner_mfa_validate
doc: "Validate the alignment files for a corpus.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
inputs:
  - id: corpus_path
    type: Directory
    doc: Path to the directory containing the corpus to validate.
    inputBinding:
      position: 1
  - id: dictionary_path
    type: File
    doc: Pronunciation dictionary of the corpus.
    inputBinding:
      position: 2
  - id: acoustic_model_path
    type:
      - 'null'
      - File
    doc: Acoustic model to validate the corpus against.
    inputBinding:
      position: 3
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL).
    inputBinding:
      position: 102
      prefix: --log_level
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all output except for errors.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/montreal-forced-aligner:3.3.8
stdout: montreal-forced-aligner_mfa_validate.out
