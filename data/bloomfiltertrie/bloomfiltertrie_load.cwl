cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bft
  - load
label: bloomfiltertrie_load
doc: "Load a Bloom Filter Trie (BFT) from file_bft, optionally add genomes (-add_genomes) and query it.\n\nTool homepage: https://github.com/GuillaumeHolley/BloomFilterTrie"
inputs:
  - id: file_bft
    type: File
    doc: file that contains a BFT
    inputBinding:
      position: 1
  - id: add_genomes_list
    type: ['null', File]
    doc: '-add_genomes: file listing the k-mer files to add to the BFT; the new BFT is written to add_genomes_output'
    inputBinding:
      position: 2
      prefix: -add_genomes
      valueFrom: ${ return [inputs.add_genomes_type, self.path, inputs.add_genomes_output]; }
  - id: add_genomes_type
    type: string
    default: kmers
    doc: '-add_genomes file type: kmers or kmers_comp'
  - id: add_genomes_output
    type: string
    default: updated.bft
    doc: '-add_genomes output_file: where to write the new BFT'
  - id: genome_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The k-mer files named in add_genomes_list (staged in the working directory so the names resolve)
  - id: query_sequences_list
    type: ['null', File]
    doc: '-query_sequences: file listing the sequence files to query (one file name per line; each sequence file holds one sequence per line). One CSV is written per sequence file.'
    inputBinding:
      position: 3
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
      position: 4
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
      position: 5
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
      position: 6
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
  - id: updated_bft
    type: ['null', File]
    doc: The new BFT written by -add_genomes
    outputBinding:
      glob: '$(inputs.add_genomes_list ? inputs.add_genomes_output : [])'
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
stdout: bloomfiltertrie_load.log
