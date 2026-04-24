cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsk
label: dsk
doc: "DSK (Disruptive Sequence K-mer) is a tool for constructing k-mer sets from sequencing
  data.\n\nTool homepage: https://github.com/GATB/dsk/"
inputs:
  - id: abundance_max
    type:
      - 'null'
      - int
    doc: max abundance threshold for solid kmers
    inputBinding:
      position: 101
      prefix: -abundance-max
  - id: abundance_min
    type:
      - 'null'
      - int
    doc: min abundance threshold for solid kmers
    inputBinding:
      position: 101
      prefix: -abundance-min
  - id: abundance_min_threshold
    type:
      - 'null'
      - int
    doc: min abundance hard threshold (only used when min abundance is "auto")
    inputBinding:
      position: 101
      prefix: -abundance-min-threshold
  - id: file
    type: File
    doc: reads file
    inputBinding:
      position: 101
      prefix: -file
  - id: histo
    type:
      - 'null'
      - int
    doc: output the kmer abundance histogram
    inputBinding:
      position: 101
      prefix: -histo
  - id: histo2d
    type:
      - 'null'
      - int
    doc: compute the 2D histogram (with first file = genome, remaining files = 
      reads)
    inputBinding:
      position: 101
      prefix: -histo2D
  - id: histo_max
    type:
      - 'null'
      - int
    doc: max number of values in kmers histogram
    inputBinding:
      position: 101
      prefix: -histo-max
  - id: kff
    type:
      - 'null'
      - boolean
    doc: also output kmers in kff format
    inputBinding:
      position: 101
      prefix: -kff
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of a kmer
    inputBinding:
      position: 101
      prefix: -kmer-size
  - id: max_disk
    type:
      - 'null'
      - int
    doc: max disk (in MBytes)
    inputBinding:
      position: 101
      prefix: -max-disk
  - id: max_memory
    type:
      - 'null'
      - int
    doc: max memory (in MBytes)
    inputBinding:
      position: 101
      prefix: -max-memory
  - id: minimizer_size
    type:
      - 'null'
      - int
    doc: size of a minimizer
    inputBinding:
      position: 101
      prefix: -minimizer-size
  - id: minimizer_type
    type:
      - 'null'
      - int
    doc: minimizer type (0=lexi, 1=freq)
    inputBinding:
      position: 101
      prefix: -minimizer-type
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: number of cores
    inputBinding:
      position: 101
      prefix: -nb-cores
  - id: out
    type:
      - 'null'
      - File
    doc: output file
    inputBinding:
      position: 101
      prefix: -out
  - id: out_compress
    type:
      - 'null'
      - int
    doc: h5 compression level (0:none, 9:best)
    inputBinding:
      position: 101
      prefix: -out-compress
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: -out-dir
  - id: out_tmp
    type:
      - 'null'
      - Directory
    doc: output directory for temporary files
    inputBinding:
      position: 101
      prefix: -out-tmp
  - id: repartition_type
    type:
      - 'null'
      - int
    doc: minimizer repartition (0=unordered, 1=ordered)
    inputBinding:
      position: 101
      prefix: -repartition-type
  - id: solid_kmers_out
    type:
      - 'null'
      - File
    doc: output file for solid kmers (only when constructing a graph)
    inputBinding:
      position: 101
      prefix: -solid-kmers-out
  - id: solidity_custom
    type:
      - 'null'
      - string
    doc: when solidity-kind is custom, specifies list of files where kmer must 
      be present
    inputBinding:
      position: 101
      prefix: -solidity-custom
  - id: solidity_kind
    type:
      - 'null'
      - string
    doc: way to compute counts of several files (sum, min, max, one, all, 
      custom)
    inputBinding:
      position: 101
      prefix: -solidity-kind
  - id: storage_type
    type:
      - 'null'
      - string
    doc: storage type of kmer counts ('hdf5' or 'file')
    inputBinding:
      position: 101
      prefix: -storage-type
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsk:2.3.3--h5ca1c30_7
stdout: dsk.out
