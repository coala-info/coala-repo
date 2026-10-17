cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophex
  - index
label: prophex_index
doc: "Constructs index for prophex\n\nTool homepage: https://github.com/prophyle/prophex"
inputs:
  - id: idxbase
    type: File
    doc: Reference FASTA file; the index files are written beside it (staged in
      the working directory)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length for k-LCP
    inputBinding:
      position: 102
      prefix: -k
  - id: parallel_construction
    type:
      - 'null'
      - boolean
    doc: construct k-LCP and SA in parallel
    inputBinding:
      position: 102
      prefix: -s
  - id: sampling_distance
    type:
      - 'null'
      - int
    doc: sampling distance for SA
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: index
    type: File
    doc: The FASTA file with its index files (.amb, .ann, .bwt, .pac, .sa)
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
    outputBinding:
      glob: $(inputs.idxbase.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.idxbase)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophex:0.1.1--h5bf99c6_2
stdout: prophex_index.out
