cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - needle
  - count
label: needle_count
doc: "Get expression value depending on minimizers. This function is only used to\
  \ test the validity of Needle's estimation approach. It estimates the expression\
  \ value for all sequences in the genome file based on the exact minimiser occurrences\
  \ of the given sequence files.\n\nTool homepage: https://github.com/seqan/needle"
inputs:
  - id: sequence_files
    type:
      type: array
      items: File
    doc: List of sequence files. Please provide at least one sequence file.
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
  - id: genome
    type:
      - 'null'
      - File
    doc: Please provide one sequence file with transcripts.
    inputBinding:
      position: 10
      prefix: --genome
  - id: exclude
    type:
      - 'null'
      - File
    doc: Sequence file containing minimizers that should not be stored.
    inputBinding:
      position: 10
      prefix: --exclude
  - id: paired
    type:
      - 'null'
      - boolean
    doc: If set, experiments are paired.
    inputBinding:
      position: 10
      prefix: --paired
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
stdout: needle_count.out
