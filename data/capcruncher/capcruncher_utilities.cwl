cwlVersion: v1.2
class: CommandLineTool
baseCommand: capcruncher
label: capcruncher_utilities
doc: "Command-line interface for capcruncher utilities.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: input_file
    type: File
    doc: Input file to process.
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: Path to a configuration file.
    inputBinding:
      position: 102
      prefix: --config
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files without prompting.
    inputBinding:
      position: 102
      prefix: --force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all output except errors.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file. If not specified, output will be printed to 
      stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
