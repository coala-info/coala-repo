cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacoag
label: metacoag
doc: "MetaCoAG: Binning Metagenomic Contigs via Composition, Coverage and Assembly
  Graphs\n\nTool homepage: https://github.com/metagentools/MetaCoAG"
inputs:
  - id: abundance
    type: File
    doc: path to the abundance file
    inputBinding:
      position: 101
      prefix: --abundance
  - id: assembler
    type: string
    doc: name of the assembler used. (Supports SPAdes, MEGAHIT and Flye)
    inputBinding:
      position: 101
      prefix: --assembler
  - id: bin_mg_threshold
    type:
      - 'null'
      - float
    doc: minimum fraction of marker genes that should be present in a bin.
    inputBinding:
      position: 101
      prefix: --bin_mg_threshold
  - id: contigs
    type: File
    doc: path to the contigs file
    inputBinding:
      position: 101
      prefix: --contigs
  - id: d_limit
    type:
      - 'null'
      - int
    doc: distance limit for contig matching.
    inputBinding:
      position: 101
      prefix: --d_limit
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiter for output results. Supports a comma (,), a semicolon (;), a 
      tab ($'\t'), a space (" ") and a pipe (|) .
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: depth
    type:
      - 'null'
      - int
    doc: depth to consider for label propagation.
    inputBinding:
      position: 101
      prefix: --depth
  - id: graph
    type: File
    doc: path to the assembly graph file
    inputBinding:
      position: 101
      prefix: --graph
  - id: hmm
    type:
      - 'null'
      - File
    doc: path to marker.hmm file.
    inputBinding:
      position: 101
      prefix: --hmm
  - id: mg_threshold
    type:
      - 'null'
      - float
    doc: length threshold to consider marker genes.
    inputBinding:
      position: 101
      prefix: --mg_threshold
  - id: min_bin_size
    type:
      - 'null'
      - int
    doc: minimum size of a bin to output in base pairs (bp).
    inputBinding:
      position: 101
      prefix: --min_bin_size
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum length of contigs to consider for binning.
    inputBinding:
      position: 101
      prefix: --min_length
  - id: n_mg
    type:
      - 'null'
      - int
    doc: total number of marker genes.
    inputBinding:
      position: 101
      prefix: --n_mg
  - id: no_cut_tc
    type:
      - 'null'
      - boolean
    doc: do not use --cut_tc for hmmsearch.
    inputBinding:
      position: 101
      prefix: --no_cut_tc
  - id: nthreads
    type:
      - 'null'
      - int
    doc: number of threads to use.
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: p_inter
    type:
      - 'null'
      - float
    doc: maximum probability of an edge matching to create a new bin.
    inputBinding:
      position: 101
      prefix: --p_inter
  - id: p_intra
    type:
      - 'null'
      - float
    doc: minimum probability of an edge matching to assign to the same bin.
    inputBinding:
      position: 101
      prefix: --p_intra
  - id: paths
    type:
      - 'null'
      - File
    doc: path to the contigs.paths (metaSPAdes) or assembly.info (metaFlye) file
    inputBinding:
      position: 101
      prefix: --paths
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for the output file
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: output
    type: Directory
    doc: path to the output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacoag:1.2.2--py312h9ee0642_0
