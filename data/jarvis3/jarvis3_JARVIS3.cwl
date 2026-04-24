cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./JARVIS3
label: jarvis3_JARVIS3
doc: "Lossless compression and decompression of genomic\n      sequences for minimal
  storage and analysis purposes.\n      Measure an upper bound of the sequence complexity.\n\
  \nTool homepage: https://github.com/cobilab/jarvis3"
inputs:
  - id: input_file
    type: File
    doc: "Input sequence filename (to compress) -- MANDATORY.\n           File to
      compress is the last argument."
    inputBinding:
      position: 1
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Compression level (integer).\n           It defines compressibility in balance
      with computational\n           resources (RAM & time). Use -s for levels perception."
    inputBinding:
      position: 102
      prefix: --level
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Decompression mode.
    inputBinding:
      position: 102
      prefix: --decompress
  - id: estimate
    type:
      - 'null'
      - boolean
    doc: "It creates a file with the extension \".iae\" with the\n           respective
      information content. If the file is FASTA or\n           FASTQ it will only
      use the \"ACGT\" (genomic) sequence."
    inputBinding:
      position: 102
      prefix: --estimate
  - id: explanation
    type:
      - 'null'
      - boolean
    doc: Explanation of the context and repeat models.
    inputBinding:
      position: 102
      prefix: --explanation
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force mode. Overwrites old files.
    inputBinding:
      position: 102
      prefix: --force
  - id: hidden_size
    type:
      - 'null'
      - int
    doc: Hidden size of the neural network (integer).
    inputBinding:
      position: 102
      prefix: --hidden-size
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: "Neural Network leaning rate (double).\n           The 0 value turns the
      Neural Network off."
    inputBinding:
      position: 102
      prefix: --learning-rate
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress bar.
    inputBinding:
      position: 102
      prefix: --progress
  - id: progress_extended
    type:
      - 'null'
      - boolean
    doc: Show compression progress for each 5%.
    inputBinding:
      position: 102
      prefix: --progress-extended
  - id: seed
    type:
      - 'null'
      - int
    doc: Pseudo-random seed.
    inputBinding:
      position: 102
      prefix: --seed
  - id: show_levels
    type:
      - 'null'
      - boolean
    doc: Show pre-computed compression levels (configured).
    inputBinding:
      position: 102
      prefix: --show-levels
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode (more information).
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Compressed/decompressed output filename.
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jarvis3:3.7--h7b50bb2_3
