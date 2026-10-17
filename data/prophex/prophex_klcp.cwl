cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophex
  - klcp
label: prophex_klcp
doc: "Constructs k-LCP array for prophex\n\nTool homepage: https://github.com/prophyle/prophex"
inputs:
  - id: idxbase
    type: File
    doc: Reference FASTA file with its prophex/bwa index files; the k-LCP file is
      written beside it (staged in the working directory)
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: length of k-mer
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
  - id: klcp
    type: File
    doc: The k-LCP file (<idxbase>.<k>.klcp)
    outputBinding:
      glob: $(inputs.idxbase.basename).*.klcp
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
stdout: prophex_klcp.out
