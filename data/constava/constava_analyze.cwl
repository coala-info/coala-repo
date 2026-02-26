cwlVersion: v1.2
class: CommandLineTool
baseCommand: constava analyze
label: constava_analyze
doc: "The `constava analyze` submodule analyzes the provided backbone dihedral angles
  and infers the propensities for each residue to reside in a given conformational
  state.\n\nTool homepage: https://github.com/bio2byte/constava"
inputs:
  - id: bootstrap
    type:
      - 'null'
      - type: array
        items: int
    doc: Do inference using <Int> samples obtained through bootstrapping. 
      Multiple values can be provided.
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: bootstrap_samples
    type:
      - 'null'
      - int
    doc: When bootstrapping, sample <Int> times from the input data.
    default: 500
    inputBinding:
      position: 101
      prefix: --bootstrap-samples
  - id: bootstrap_series
    type:
      - 'null'
      - type: array
        items: int
    doc: Do inference using <Int> samples obtained through bootstrapping. Return
      the results for every subsample rather than the average. This can result 
      in very large output files. Multiple values can be provided.
    inputBinding:
      position: 101
      prefix: --bootstrap-series
  - id: degrees
    type:
      - 'null'
      - boolean
    doc: Set this flag, if dihedrals in the input files are in degrees.
    inputBinding:
      position: 101
      prefix: --degrees
  - id: indent_size
    type:
      - 'null'
      - int
    doc: Sets the number of spaces used to indent the output document.
    inputBinding:
      position: 101
      prefix: --indent_size
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s) that contain the dihedral angles.
    inputBinding:
      position: 101
      prefix: --input
  - id: input_format
    type:
      - 'null'
      - string
    doc: "Format of the input file: {'auto', 'csv', 'xvg'}"
    default: auto
    inputBinding:
      position: 101
      prefix: --input-format
  - id: load_model
    type:
      - 'null'
      - File
    doc: Load a conformational state model from the given pickled file. If not 
      provided, the default model will be used.
    inputBinding:
      position: 101
      prefix: --load-model
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Format of output file: {'csv', 'json', 'tsv'}"
    default: auto
    inputBinding:
      position: 101
      prefix: --output-format
  - id: precision
    type:
      - 'null'
      - int
    doc: Sets the number of decimals in the output files.
    inputBinding:
      position: 101
      prefix: --precision
  - id: seed
    type:
      - 'null'
      - int
    doc: Set random seed for bootstrap sampling
    inputBinding:
      position: 101
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbosity level of screen output. Flag can be given multiple times 
      (up to 2) to gradually increase output to debugging mode.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - type: array
        items: int
    doc: Do inference using a moving reading-frame. Each reading frame consists 
      of <int> consecutive samples. Multiple values can be provided.
    inputBinding:
      position: 101
      prefix: --window
  - id: window_series
    type:
      - 'null'
      - type: array
        items: int
    doc: Do inference using a moving reading-frame. Each reading frame consists 
      of <int> consecutive samples. Return the results for every window rather 
      than the average. This can result in very large output files. Multiple 
      values can be provided.
    inputBinding:
      position: 101
      prefix: --window-series
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The file to write the results to.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
