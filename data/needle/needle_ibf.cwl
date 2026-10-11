cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - needle
  - ibf
label: needle_ibf
doc: "Constructs the Needle index.\n\nTool homepage: https://github.com/seqan/needle"
inputs:
  - id: sequence_files
    type:
      type: array
      items: File
    doc: Please provide at least one sequence file.
    inputBinding:
      position: 1
  - id: out
    type: string
    doc: Directory, where output files should be saved (created in the working directory).
    default: needle_out
    inputBinding:
      position: 5
      prefix: --out
      valueFrom: '$(self.endsWith("/") ? self : self + "/")'
  - id: kmer
    type:
      - 'null'
      - int
    doc: Define k-mer size for the minimisers (default 20).
    inputBinding:
      position: 10
      prefix: --kmer
  - id: window
    type:
      - 'null'
      - int
    doc: Define window size for the minimisers (default 60).
    inputBinding:
      position: 10
      prefix: --window
  - id: shape
    type:
      - 'null'
      - long
    doc: Define a shape for the minimisers by the decimal of a bitvector, where 0
      symbolizes a position to be ignored, 1 a position considered (default ungapped).
    inputBinding:
      position: 10
      prefix: --shape
  - id: seed
    type:
      - 'null'
      - long
    doc: Define seed for the minimisers (default 0).
    inputBinding:
      position: 10
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default 1).
    inputBinding:
      position: 10
      prefix: --threads
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: If set, the IBFs are compressed.
    inputBinding:
      position: 10
      prefix: --compressed
  - id: fpr
    type:
      - 'null'
      - type: array
        items: double
        inputBinding:
          prefix: --fpr
    doc: List of bin false positive rate per expression level. If only one is given,
      that fpr is used for all expression levels.
    inputBinding:
      position: 10
  - id: expression_thresholds
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: --expression_thresholds
    doc: Which expression thresholds should be used for constructing the IBFs (values
      start at 1).
    inputBinding:
      position: 10
  - id: number_expression_thresholds
    type:
      - 'null'
      - int
    doc: Number of expression thresholds. Can be set alternatively to expression_thresholds,
      then the expression thresholds are determined automatically.
    inputBinding:
      position: 10
      prefix: --number_expression_thresholds
  - id: hash
    type:
      - 'null'
      - long
    doc: Number of hash functions that should be used when constructing one IBF (default
      1).
    inputBinding:
      position: 10
      prefix: --hash
  - id: include
    type:
      - 'null'
      - File
    doc: Sequence file containing minimizers, only those minimizers will be considered.
    inputBinding:
      position: 10
      prefix: --include
  - id: exclude
    type:
      - 'null'
      - File
    doc: Sequence file containing minimizers that should not be stored.
    inputBinding:
      position: 10
      prefix: --exclude
  - id: samples
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: --samples
    doc: 'Define which samples belong together, sum has to be equal to number of sequence
      files (default: every sequence file is one sample from one experiment).'
    inputBinding:
      position: 10
  - id: paired
    type:
      - 'null'
      - boolean
    doc: If set, experiments are paired.
    inputBinding:
      position: 10
      prefix: --paired
  - id: cutoff
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: --cutoff
    doc: 'Define for each sample, what number of found minimisers should be considered
      the result of a sequencing error and therefore be ignored (default: automatic
      cutoff based on the file size).'
    inputBinding:
      position: 10
  - id: experiment_names
    type:
      - 'null'
      - boolean
    doc: If set, names of the experiments are stored in a txt file.
  - id: levels_by_genome
    type:
      - 'null'
      - File
    doc: Sequence file containing minimizers, only those minimizers will be considered
      for determining the expression thresholds.
    inputBinding:
      position: 10
      prefix: --levels-by-genome
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Directory with the output files
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.out)
        entry: '$({"class": "Directory", "basename": inputs.out, "listing": []})'
        writable: true
arguments:
  - position: 10
    valueFrom: '${ return inputs.experiment_names ? ["--experiment-names", "1"] :
      []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
stdout: needle_ibf.out
