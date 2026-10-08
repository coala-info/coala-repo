cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - decOM-CV
label: decom_decOM-CV
doc: "Microbial source tracking for contamination assessment of ancient oral samples using k-mer-based methods (5-fold cross validation)\n\nTool homepage: https://github.com/CamilaDuitama/decOM"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.path_sources)
        writable: true
      - '${ return inputs.read_files ? inputs.read_files : []; }'
inputs:
  - id: path_sinks
    type: File
    doc: '.txt file with a list of sinks limited by a newline.'
    inputBinding:
      position: 101
      prefix: --path_sinks
  - id: path_sources
    type: Directory
    doc: Folder downloaded from
      https://zenodo.org/record/6513520/files/decOM_sources.tar.gz It is
      staged writable, because kmtricks filter opens the matrix files read-
      write.
    inputBinding:
      position: 101
      prefix: --path_sources
      valueFrom: $(self.basename)
  - id: path_keys
    type: Directory
    doc: Folder with filtering keys (a kmtricks fof with only one sample). You
      should have as many .fof files as sinks.
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
  - id: fold
    type: int
    doc: Fold being processed from 5-fold cross validation. The help says 1,2,3,4
      or 5, but the code accepts only 0,1,2,3 or 4
    inputBinding:
      position: 101
      prefix: --fold
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
    doc: Source proportions of each sink (decOM_output_fold_$(inputs.fold).csv)
    outputBinding:
      glob: $(inputs.output)/decOM_output_fold_$(inputs.fold).csv
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
stdout: decom_decOM-CV.out
