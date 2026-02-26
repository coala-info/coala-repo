cwlVersion: v1.2
class: CommandLineTool
baseCommand: concoct
label: concoct
doc: "CONCOCT: COnditional co-Nstrained Clustering Of Transcriptomes\n\nTool homepage:
  https://github.com/BinPro/CONCOCT"
inputs:
  - id: basename
    type:
      - 'null'
      - string
    doc: Specify the basename for files or directory where outputwill be placed.
      Path to existing directory or basenamewith a trailing '/' will be 
      interpreted as a directory.If not provided, current directory will be 
      used.
    inputBinding:
      position: 101
      prefix: --basename
  - id: clusters
    type:
      - 'null'
      - int
    doc: specify maximal number of clusters for VGMM
    default: 400
    inputBinding:
      position: 101
      prefix: --clusters
  - id: composition_file
    type:
      - 'null'
      - File
    doc: specify the composition file, containing sequences in fasta format. It 
      is named the composition file since it is used to calculate the kmer 
      composition (the genomic signature) of each contig.
    inputBinding:
      position: 101
      prefix: --composition_file
  - id: converge_out
    type:
      - 'null'
      - boolean
    doc: Write convergence info to files.
    inputBinding:
      position: 101
      prefix: --converge_out
  - id: coverage_file
    type:
      - 'null'
      - File
    doc: specify the coverage file, containing a table where each row correspond
      to a contig, and each column correspond to a sample. The values are the 
      average coverage for this contig in that sample. All values are separated 
      with tabs.
    inputBinding:
      position: 101
      prefix: --coverage_file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug parameters.
    inputBinding:
      position: 101
      prefix: --debug
  - id: iterations
    type:
      - 'null'
      - int
    doc: Specify maximum number of iterations for the VBGMM.
    default: 500
    inputBinding:
      position: 101
      prefix: --iterations
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: specify kmer length
    default: 4
    inputBinding:
      position: 101
      prefix: --kmer_length
  - id: length_threshold
    type:
      - 'null'
      - int
    doc: specify the sequence length threshold, contigs shorter than this value 
      will not be included.
    default: 1000
    inputBinding:
      position: 101
      prefix: --length_threshold
  - id: no_cov_normalization
    type:
      - 'null'
      - boolean
    doc: By default the coverage is normalized with regards to samples, then 
      normalized with regards of contigs and finally log transformed. By setting
      this flag you skip the normalization and only do log transorm of the 
      coverage.
    inputBinding:
      position: 101
      prefix: --no_cov_normalization
  - id: no_original_data
    type:
      - 'null'
      - boolean
    doc: By default the original data is saved to disk. For big datasets, 
      especially when a large k is used for compositional data, this file can 
      become very large. Use this tag if you don't want to save the original 
      data.
    inputBinding:
      position: 101
      prefix: --no_original_data
  - id: no_total_coverage
    type:
      - 'null'
      - boolean
    doc: By default, the total coverage is added as a new column in the coverage
      data matrix, independently of coverage normalization but previous to log 
      transformation. Use this tag to escape this behaviour.
    inputBinding:
      position: 101
      prefix: --no_total_coverage
  - id: read_length
    type:
      - 'null'
      - int
    doc: specify read length for coverage
    default: 100
    inputBinding:
      position: 101
      prefix: --read_length
  - id: seed
    type:
      - 'null'
      - int
    doc: Specify an integer to use as seed for clustering. 0 gives a random 
      seed, 1 is the default seed and any other positive integer can be used. 
      Other values give ArgumentTypeError.
    default: 1
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: total_percentage_pca
    type:
      - 'null'
      - float
    doc: The percentage of variance explained by the principal components for 
      the combined data.
    inputBinding:
      position: 101
      prefix: --total_percentage_pca
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/concoct:1.1.0--py312hb1d17a5_9
stdout: concoct.out
