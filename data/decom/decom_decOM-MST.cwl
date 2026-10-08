cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - decOM-MST
label: decom_decOM-MST
doc: "Microbial source tracking for contamination assessment of ancient oral samples using k-mer-based methods (user-built matrix of sources)\n\nTool homepage: https://github.com/CamilaDuitama/decOM"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.path_sources)
        writable: true
      - '${ return inputs.read_files ? inputs.read_files : []; }'
inputs:
  - id: sink
    type:
      - 'null'
      - string
    doc: Name of your sink. It must be the same as the first element of key.fof.
      When this argument is set, -k/--key must be defined too.
    inputBinding:
      position: 101
      prefix: --sink
  - id: path_sinks
    type:
      - 'null'
      - File
    doc: '.txt file with a list of sinks limited by a newline. When this argument
      is set, -p_keys/--path_keys must be defined too.'
    inputBinding:
      position: 101
      prefix: --path_sinks
  - id: path_sources
    type: Directory
    doc: Folder with the matrix of sources created using kmtricks (kmtricks
      pipeline, aggregate and dump). It is staged writable, because kmtricks
      filter opens the matrix files read-write.
    inputBinding:
      position: 101
      prefix: --path_sources
      valueFrom: $(self.basename)
  - id: map_file
    type: File
    doc: '.csv file with two columns: SampleID and Env. All the samples used to
      build the input matrix of sources p_sources should be present in this
      table.'
    inputBinding:
      position: 101
      prefix: --map
  - id: key
    type:
      - 'null'
      - File
    doc: Filtering key (a kmtricks fof with only one sample). When this argument
      is set, -s/--sink must be defined too.
    inputBinding:
      position: 101
      prefix: --key
  - id: path_keys
    type:
      - 'null'
      - Directory
    doc: Folder with filtering keys (a kmtricks fof with only one sample). You
      should have as many .fof files as sinks. When this argument is set,
      -p_sinks/--path_sinks must be defined too.
    inputBinding:
      position: 101
      prefix: --path_keys
  - id: memory
    type: string
    doc: 'How much memory you want to use for this process. Ex: 10GB'
    inputBinding:
      position: 101
      prefix: --memory
  - id: threads
    type: int
    doc: 'Number of threads to use. Ex: 5'
    inputBinding:
      position: 101
      prefix: --threads
  - id: output
    type: string
    doc: Output folder where decOM writes the results. It must not exist yet.
    default: decOM_output
    inputBinding:
      position: 101
      prefix: --output
  - id: plot
    type:
      - 'null'
      - type: enum
        symbols:
          - 'True'
          - 'False'
    doc: True if you want a plot (in pdf and html format) with the source
      proportions of the sink, else False
    inputBinding:
      position: 101
      prefix: --plot
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: read_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Read files named in the key .fof files (and, for a user-built matrix,
      in p_sources/kmtricks.fof). They are staged in the working directory, so
      the .fof files should name them by file name only.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (status messages)
  - id: output_dir
    type: Directory
    doc: Output folder with the results
    outputBinding:
      glob: $(inputs.output)
  - id: result_table
    type: File
    doc: Source proportions of each sink (decOM_output.csv)
    outputBinding:
      glob: $(inputs.output)/decOM_output.csv
  - id: plots
    type:
      type: array
      items: File
    doc: Plots of the source proportions (pdf and html), when --plot is True
    outputBinding:
      glob:
        - $(inputs.output)/result_plot_sinks.pdf
        - $(inputs.output)/result_plot_sinks.html
successCodes:
  - 0
  - 1
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decom:0.0.32--pyhdfd78af_2
stdout: decom_decOM-MST.out
