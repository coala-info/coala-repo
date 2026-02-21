cwlVersion: v1.2
class: CommandLineTool
baseCommand: bloocoo
label: bloocoo_Bloocoo
doc: "Bloocoo is a k-mer based read error correction tool.\n\nTool homepage: http://gatb.inria.fr/software/bloocoo/"
inputs:
  - id: abundance_max
    type:
      - 'null'
      - int
    doc: max abundance threshold for solid kmers
    default: 2147483647
    inputBinding:
      position: 101
      prefix: -abundance-max
  - id: abundance_min
    type:
      - 'null'
      - string
    doc: min abundance threshold for solid kmers
    default: '3'
    inputBinding:
      position: 101
      prefix: -abundance-min
  - id: abundance_min_threshold
    type:
      - 'null'
      - int
    doc: min abundance hard threshold (only used when min abundance is "auto")
    default: 3
    inputBinding:
      position: 101
      prefix: -abundance-min-threshold
  - id: count_only
    type:
      - 'null'
      - boolean
    doc: do not correct, only count kmers
    inputBinding:
      position: 101
      prefix: -count-only
  - id: err_tab
    type:
      - 'null'
      - boolean
    doc: generate error tabs
    inputBinding:
      position: 101
      prefix: -err-tab
  - id: file
    type: File
    doc: reads file
    inputBinding:
      position: 101
      prefix: -file
  - id: from_h5
    type:
      - 'null'
      - boolean
    doc: do not re-compute kmer counts, suppose h5 file already computed (with previous
      run with -count-only)
    inputBinding:
      position: 101
      prefix: -from-h5
  - id: high_precision
    type:
      - 'null'
      - boolean
    doc: correct safely, correct less but introduce less mistakes
    inputBinding:
      position: 101
      prefix: -high-precision
  - id: high_recall
    type:
      - 'null'
      - boolean
    doc: correct a lot but can introduce more mistakes
    inputBinding:
      position: 101
      prefix: -high-recall
  - id: histo_max
    type:
      - 'null'
      - int
    doc: max number of values in kmers histogram
    default: 10000
    inputBinding:
      position: 101
      prefix: -histo-max
  - id: ion
    type:
      - 'null'
      - boolean
    doc: ion correction mode
    inputBinding:
      position: 101
      prefix: -ion
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of a kmer
    default: 31
    inputBinding:
      position: 101
      prefix: -kmer-size
  - id: max_disk
    type:
      - 'null'
      - int
    doc: max disk (in MBytes)
    default: 0
    inputBinding:
      position: 101
      prefix: -max-disk
  - id: max_memory
    type:
      - 'null'
      - int
    doc: max memory (in MBytes)
    default: 5000
    inputBinding:
      position: 101
      prefix: -max-memory
  - id: max_trim
    type:
      - 'null'
      - int
    doc: max number of bases that can be trimmed per read
    inputBinding:
      position: 101
      prefix: -max-trim
  - id: minimizer_size
    type:
      - 'null'
      - int
    doc: size of a minimizer
    default: 8
    inputBinding:
      position: 101
      prefix: -minimizer-size
  - id: minimizer_type
    type:
      - 'null'
      - int
    doc: minimizer type (0=lexi, 1=freq)
    default: 0
    inputBinding:
      position: 101
      prefix: -minimizer-type
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: number of cores
    default: 0
    inputBinding:
      position: 101
      prefix: -nb-cores
  - id: out_compress
    type:
      - 'null'
      - int
    doc: output compression level (0:none, 9:best)
    default: 0
    inputBinding:
      position: 101
      prefix: -out-compress
  - id: out_tmp
    type:
      - 'null'
      - Directory
    doc: output directory for temporary files
    default: .
    inputBinding:
      position: 101
      prefix: -out-tmp
  - id: repartition_type
    type:
      - 'null'
      - int
    doc: minimizer repartition (0=unordered, 1=ordered)
    default: 0
    inputBinding:
      position: 101
      prefix: -repartition-type
  - id: slow
    type:
      - 'null'
      - boolean
    doc: slower but better correction
    inputBinding:
      position: 101
      prefix: -slow
  - id: solidity_kind
    type:
      - 'null'
      - string
    doc: way to compute counts of several files (sum, min, max, one, all)
    default: sum
    inputBinding:
      position: 101
      prefix: -solidity-kind
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    default: 1
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: solid_kmers_out
    type:
      - 'null'
      - File
    doc: output file for solid kmers
    outputBinding:
      glob: $(inputs.solid_kmers_out)
  - id: out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bloocoo:1.0.7--h5b5514e_4
