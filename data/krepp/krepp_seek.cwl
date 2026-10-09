cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - krepp
  - seek
label: krepp_seek
doc: "Seek query sequences in a sketch and estimate distances.\n\nTool homepage: https://github.com/bo1929/krepp"
inputs:
  - id: query
    type: File
    doc: "Query FASTA/FASTQ file path (gzip compatible)"
    inputBinding:
      position: 101
      prefix: --query
  - id: sketch_path
    type: File
    doc: "Sketch file to query"
    inputBinding:
      position: 101
      prefix: --sketch-path
  - id: hdist_th
    type:
      - 'null'
      - int
    doc: "Maximum Hamming distance for a k-mer to match [4]"
    inputBinding:
      position: 101
      prefix: --hdist-th
  - id: output_path_path
    type:
      - 'null'
      - string
    doc: "Write output to a file at this path [stdout]"
    inputBinding:
      position: 102
      prefix: --output-path
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use in OpenMP-based parallelism [1]"
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed for the LSH and other parts that require randomness [0]"
    inputBinding:
      position: 101
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increased verbosity and progress report"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: no_verbose
    type:
      - 'null'
      - boolean
    doc: "Disable increased verbosity and progress report"
    inputBinding:
      position: 101
      prefix: --no-verbose
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: "Output file (when --output-path is given)"
    outputBinding:
      glob: $(inputs.output_path_path)
  - id: stdout_out
    type: stdout
    doc: "Standard output (the result when --output-path is not given)"
stdout: krepp_seek.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
