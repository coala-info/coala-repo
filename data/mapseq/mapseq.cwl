cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapseq
label: mapseq
doc: "Classify a fasta file containing sequence reads to the default NCBI taxonomy
  and OTU classifications.\n\nTool homepage: https://github.com/jfmrod/MAPseq"
inputs:
  - id: input_fa
    type: File
    doc: Input fasta file
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - string
    doc: Database for classification
    inputBinding:
      position: 2
  - id: tax1
    type:
      - 'null'
      - type: array
        items: string
    doc: Taxonomy files
    inputBinding:
      position: 3
  - id: minid1
    type:
      - 'null'
      - int
    doc: minimum number of shared kmers to consider hit in second phase kmer 
      search
    inputBinding:
      position: 104
      prefix: -minid1
  - id: minid2
    type:
      - 'null'
      - int
    doc: minimum number of shared kmers to consider hit in alignment phase
    inputBinding:
      position: 104
      prefix: -minid2
  - id: minscore
    type:
      - 'null'
      - int
    doc: 'minimum score cutoff to consider for a classification, should be reduced
      when searching very small sequences, i.e.: primer search'
    inputBinding:
      position: 104
      prefix: -minscore
  - id: nthreads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 104
      prefix: -nthreads
  - id: otucounts
    type:
      - 'null'
      - File
    doc: computes summary of classification counts from the classification 
      output file
    inputBinding:
      position: 104
      prefix: -otucounts
  - id: otulim
    type:
      - 'null'
      - int
    doc: number of sequences per internal cluster to include in alignment phase
    inputBinding:
      position: 104
      prefix: -otulim
  - id: otutable
    type:
      - 'null'
      - type: array
        items: File
    doc: generates a tsv file with taxonomic labels as rows and samples as 
      columns from classification output files
    inputBinding:
      position: 104
      prefix: -otutable
  - id: print_align
    type:
      - 'null'
      - boolean
    doc: outputs alignments
    inputBinding:
      position: 104
      prefix: -print_align
  - id: print_hits
    type:
      - 'null'
      - boolean
    doc: outputs list of top hits for each input sequence
    inputBinding:
      position: 104
      prefix: -print_hits
  - id: tophits
    type:
      - 'null'
      - int
    doc: number of reference sequences to include in alignment phase
    inputBinding:
      position: 104
      prefix: -tophits
  - id: topotus
    type:
      - 'null'
      - int
    doc: number of internal reference otus to include in alignment phase
    inputBinding:
      position: 104
      prefix: -topotus
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapseq:2.1.1--ha34dc8c_0
stdout: mapseq.out
