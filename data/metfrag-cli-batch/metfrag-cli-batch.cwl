cwlVersion: v1.2
class: CommandLineTool
baseCommand: metfrag-cli-batch
label: metfrag-cli-batch
doc: "MetFrag command line batch processing tool.\n\nTool homepage: http://c-ruttkies.github.io/MetFrag/"
inputs:
  - id: input_file
    type: File
    doc: Input file containing compounds and/or settings.
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    doc: Optional configuration file for MetFrag.
    inputBinding:
      position: 102
      prefix: --config-file
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing results if they exist.
    inputBinding:
      position: 102
      prefix: --force
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level (DEBUG, INFO, WARN, ERROR).
    inputBinding:
      position: 102
      prefix: --log-level
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing.
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: output_dir
    type: Directory
    doc: Directory to store the results.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: settings_file
    type:
      - 'null'
      - File
    doc: Optional settings file to override default settings.
    inputBinding:
      position: 102
      prefix: --settings-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metfrag-cli-batch:v2.4.3_cv0.6
stdout: metfrag-cli-batch.out
