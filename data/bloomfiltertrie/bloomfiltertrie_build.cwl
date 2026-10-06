cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bft
  - build
label: bloomfiltertrie_build
doc: "Build a Bloom Filter Trie (BFT) from the k-mer files listed in list_genome_files and write it to output_file.\n\nTool homepage: https://github.com/GuillaumeHolley/BloomFilterTrie"
inputs:
  - id: k
    type: int
    doc: length of k-mers (a multiple of 9, at most 63)
    inputBinding:
      position: 1
  - id: kmer_type
    type: string
    default: kmers
    doc: 'type of the genome files: kmers (one k-mer per line) or kmers_comp (compressed k-mers)'
    inputBinding:
      position: 2
  - id: list_genome_files
    type: File
    doc: file that contains a list of files (one path and name per line) to be inserted in the BFT
    inputBinding:
      position: 3
  - id: output_file
    type: string
    doc: file where to write the BFT
    inputBinding:
      position: 4
  - id: genome_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The k-mer files named in list_genome_files (staged in the working directory so the names resolve)
  - id: query_sequences_list
    type: ['null', File]
    doc: '-query_sequences: file listing the sequence files to query (one file name per line; each sequence file holds one sequence per line). One CSV is written per sequence file.'
    inputBinding:
      position: 5
      prefix: -query_sequences
      valueFrom: ${ return [String(inputs.query_sequences_threshold), inputs.query_sequences_kmers, self.path]; }
  - id: query_sequences_threshold
    type: float
    default: 1.0
    doc: '-query_sequences threshold: fraction (0 < threshold <= 1) of the k-mers of each query that must occur in a sample to report it present'
  - id: query_sequences_kmers
    type: string
    default: canonical
    doc: '-query_sequences k-mer kind: canonical or non_canonical'
  - id: query_kmers_list
    type: ['null', File]
    doc: '-query_kmers: file listing the k-mer files to query. One CSV is written per k-mer file.'
    inputBinding:
      position: 6
      prefix: -query_kmers
      valueFrom: ${ return [inputs.query_kmers_type, self.path]; }
  - id: query_kmers_type
    type: string
    default: kmers
    doc: '-query_kmers file type: kmers or kmers_comp'
  - id: query_branching_list
    type: ['null', File]
    doc: '-query_branching: file listing the k-mer files whose branching k-mers are counted (count printed to the log)'
    inputBinding:
      position: 7
      prefix: -query_branching
      valueFrom: ${ return [inputs.query_branching_type, self.path]; }
  - id: query_branching_type
    type: string
    default: kmers
    doc: '-query_branching file type: kmers or kmers_comp'
  - id: extract_kmers_file
    type: ['null', string]
    doc: '-extract_kmers: name of the k-mers file to write with all k-mers stored in the BFT'
    inputBinding:
      position: 8
      prefix: -extract_kmers
      valueFrom: ${ return [inputs.extract_kmers_type, self]; }
  - id: extract_kmers_type
    type: string
    default: kmers
    doc: '-extract_kmers file type: kmers or kmers_comp'
  - id: query_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The query files named in the query list files (staged in the working directory so the names resolve)
outputs:
  - id: bft
    type: File
    doc: The BFT file
    outputBinding:
      glob: $(inputs.output_file)
  - id: query_results
    type:
      type: array
      items: File
    doc: 'One CSV per queried file (-query_sequences / -query_kmers): columns are the genomes, rows the queries, 1 = present'
    outputBinding:
      glob: '*.csv'
  - id: extracted_kmers
    type: ['null', File]
    doc: k-mers extracted from the BFT (-extract_kmers)
    outputBinding:
      glob: $(inputs.extract_kmers_file)
  - id: log
    type: stdout
    doc: Run log, including the number of k-mers present and branching k-mers
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.genome_files)
      - $(inputs.query_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bloomfiltertrie:0.8.7--h779adbc_2
stdout: bloomfiltertrie_build.log
