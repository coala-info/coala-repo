cwlVersion: v1.2
class: CommandLineTool
baseCommand: montreal-forced-aligner_mfa
label: montreal-forced-aligner_mfa validate
doc: "Validate the alignment files for a corpus.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
inputs:
  - id: corpus_path
    type: Directory
    doc: Path to the directory containing the corpus to validate.
    inputBinding:
      position: 1
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
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Path to the directory where validation output should be saved. Defaults
      to a subdirectory within the corpus directory.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/montreal-forced-aligner:3.3.8
