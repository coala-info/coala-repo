cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - megagta
  - search
label: megagta_search
doc: "A* search for the contigs of the genes in a gene list on a succinct de
  Bruijn graph, starting from the starting k-mers found by megagta findstart.
  The gene list has one line per gene: gene name, forward HMM, reverse HMM and
  aligned reference protein file.\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.sdbg_files.concat(inputs.gene_files).concat(inputs.starting_kmers_files))
inputs:
  - id: succinct_dbg
    type: string
    doc: Prefix of the succinct de Bruijn graph files
    inputBinding:
      position: 1
  - id: gene_list
    type: File
    doc: Gene list file (gene, forward HMM, reverse HMM, aligned reference)
    inputBinding:
      position: 2
  - id: starting_kmers_prefix
    type: string
    doc: Prefix of the starting k-mer files (<prefix>_<gene>_starting_kmers.txt)
    inputBinding:
      position: 3
  - id: output_prefix
    type: string
    doc: Prefix of the output files (<prefix>_raw_contigs_<gene>.fasta)
    inputBinding:
      position: 4
  - id: prune_len
    type: int
    doc: Prune the search if the score does not improve after this many steps
    inputBinding:
      position: 5
  - id: low_cov_penalty
    type: float
    doc: Penalty for coverage-one edges (0 to 1)
    inputBinding:
      position: 6
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (default: 0, auto detect)'
    inputBinding:
      position: 7
  - id: sdbg_files
    type:
      type: array
      items: File
    doc: Succinct de Bruijn graph files written by megagta buildgraph
  - id: gene_files
    type:
      type: array
      items: File
    doc: Forward and reverse HMM files and aligned reference files named in the
      gene list
  - id: starting_kmers_files
    type:
      type: array
      items: File
    doc: Starting k-mer files written by megagta findstart
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: raw_contigs
    type:
      type: array
      items: File
    doc: Contigs found for each gene
    outputBinding:
      glob: $(inputs.output_prefix)_raw_contigs_*.fasta
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdout: megagta_search.out
