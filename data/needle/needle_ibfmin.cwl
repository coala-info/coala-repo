cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - needle
  - ibfmin
label: needle_ibfmin
doc: "Constructs the Needle index from the minimiser files created by needle minimiser.\n\
  \nTool homepage: https://github.com/seqan/needle"
inputs:
  - id: minimiser_files
    type:
      type: array
      items: File
    doc: Please provide at least one minimiser file (made by needle minimiser). It
      is assumed that the header file exists in the same directory; the files are
      staged in the working directory.
    inputBinding:
      position: 1
      valueFrom: $(self.map(function(f) { return f.basename; }))
  - id: out
    type: string
    doc: Directory, where output files should be saved (created in the working directory).
    default: needle_out
    inputBinding:
      position: 5
      prefix: --out
      valueFrom: '$(self.endsWith("/") ? self : self + "/")'
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default 1).
    inputBinding:
      position: 10
      prefix: --threads
  - id: levels_by_genome
    type:
      - 'null'
      - File
    doc: Sequence file containing minimizers, only those minimizers will be considered
      for determining the expression thresholds.
    inputBinding:
      position: 10
      prefix: --levels-by-genome
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
      - $(inputs.minimiser_files)
      - entryname: $(inputs.out)
        entry: '$({"class": "Directory", "basename": inputs.out, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
stdout: needle_ibfmin.out
