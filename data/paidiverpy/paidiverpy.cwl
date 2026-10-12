cwlVersion: v1.2
class: CommandLineTool
baseCommand: paidiverpy
label: paidiverpy
doc: "Paidiverpy image preprocessing\n\nTool homepage: https://github.com/paidiver/paidiverpy"
inputs:
  - id: benchmark_test
    type:
      - 'null'
      - string
    doc: "OPTIONAL: ONLY FOR BENCHMARK TESTING. Information for benchmark tests as
      a JSON string. E.g., '{\"cluster_type\": \"slurm\", \"cores\": [1,2,4,8,16,32],
      \"processes\": [1,2,4,8,16,32], \"memory\": [1,2,4,8,16,32,64], \"scale\": [1,2,4,8]
      }'"
    inputBinding:
      position: 101
      prefix: --benchmark_test
  - id: configuration_file
    type: File
    doc: Path to the configuration file 'config.yml'
    inputBinding:
      position: 101
      prefix: --configuration_file
  - id: validate
    type:
      - 'null'
      - boolean
    doc: 'OPTIONAL: ONLY FOR CONFIGURATION FILE CHECKING. Check the configuration
      file.'
    inputBinding:
      position: 101
      prefix: --validate
  - id: input_directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directories with images and metadata that the configuration file refers to by
      relative path (staged in the working directory)
  - id: output_dir_name
    type:
      - 'null'
      - string
    default: output
    doc: Name of the output directory, as set by `output_path` in the configuration file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Processed images and metadata written by paidiverpy
    outputBinding:
      glob: $(inputs.output_dir_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.input_directories ? inputs.input_directories : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paidiverpy:0.2.1--pyhdfd78af_0
stdout: paidiverpy.out
