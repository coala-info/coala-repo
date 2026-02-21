cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcalm
label: bcalm
doc: "De Bruijn graph construction tool for genomic data\n\nTool homepage: https://github.com/GATB/bcalm"
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
      - int
    doc: min abundance threshold for solid kmers
    default: 2
    inputBinding:
      position: 101
      prefix: -abundance-min
  - id: all_abundance_counts
    type:
      - 'null'
      - boolean
    doc: output all k-mer abundance counts instead of mean
    inputBinding:
      position: 101
      prefix: -all-abundance-counts
  - id: bloom
    type:
      - 'null'
      - string
    doc: bloom type ('basic', 'cache', 'neighbor')
    default: neighbor
    inputBinding:
      position: 101
      prefix: -bloom
  - id: branching_nodes
    type:
      - 'null'
      - string
    doc: branching type ('none' or 'stored')
    default: stored
    inputBinding:
      position: 101
      prefix: -branching-nodes
  - id: config_only
    type:
      - 'null'
      - boolean
    doc: dump config only
    inputBinding:
      position: 101
      prefix: -config-only
  - id: debloom
    type:
      - 'null'
      - string
    doc: debloom type ('none', 'original' or 'cascading')
    default: cascading
    inputBinding:
      position: 101
      prefix: -debloom
  - id: debloom_impl
    type:
      - 'null'
      - string
    doc: debloom impl ('basic', 'minimizer')
    default: minimizer
    inputBinding:
      position: 101
      prefix: -debloom-impl
  - id: edge_km
    type:
      - 'null'
      - int
    doc: edge km representation
    default: 0
    inputBinding:
      position: 101
      prefix: -edge-km
  - id: histo
    type:
      - 'null'
      - int
    doc: output the kmer abundance histogram
    default: 0
    inputBinding:
      position: 101
      prefix: -histo
  - id: histo_2d
    type:
      - 'null'
      - int
    doc: compute the 2D histogram (with first file = genome, remaining files = reads)
    default: 0
    inputBinding:
      position: 101
      prefix: -histo2D
  - id: input_file
    type: File
    doc: reads file
    inputBinding:
      position: 101
      prefix: -in
  - id: integer_precision
    type:
      - 'null'
      - int
    doc: integers precision (0 for optimized value)
    default: 0
    inputBinding:
      position: 101
      prefix: -integer-precision
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
  - id: minimizer_size
    type:
      - 'null'
      - int
    doc: size of a minimizer
    default: 10
    inputBinding:
      position: 101
      prefix: -minimizer-size
  - id: minimizer_type
    type:
      - 'null'
      - int
    doc: minimizer type (0=lexi, 1=freq)
    default: 1
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
  - id: nb_glue_partitions
    type:
      - 'null'
      - int
    doc: number of glue partitions (automatically calculated by default)
    default: 0
    inputBinding:
      position: 101
      prefix: -nb-glue-partitions
  - id: no_mphf
    type:
      - 'null'
      - boolean
    doc: don't construct the MPHF
    inputBinding:
      position: 101
      prefix: -no-mphf
  - id: out_compress
    type:
      - 'null'
      - int
    doc: h5 compression level (0:none, 9:best)
    default: 0
    inputBinding:
      position: 101
      prefix: -out-compress
  - id: output_tmp
    type:
      - 'null'
      - Directory
    doc: output directory for temporary files
    default: .
    inputBinding:
      position: 101
      prefix: -out-tmp
  - id: redo_bcalm
    type:
      - 'null'
      - boolean
    doc: debug function, redo the bcalm algo
    inputBinding:
      position: 101
      prefix: -redo-bcalm
  - id: redo_bglue
    type:
      - 'null'
      - boolean
    doc: debug function, redo bglue
    inputBinding:
      position: 101
      prefix: -redo-bglue
  - id: redo_links
    type:
      - 'null'
      - boolean
    doc: debug function, redo links
    inputBinding:
      position: 101
      prefix: -redo-links
  - id: repartition_type
    type:
      - 'null'
      - int
    doc: minimizer repartition (0=unordered, 1=ordered)
    default: 1
    inputBinding:
      position: 101
      prefix: -repartition-type
  - id: skip_bcalm
    type:
      - 'null'
      - boolean
    doc: debug function, skip bcalm
    inputBinding:
      position: 101
      prefix: -skip-bcalm
  - id: skip_bglue
    type:
      - 'null'
      - boolean
    doc: debug function, skip bglue
    inputBinding:
      position: 101
      prefix: -skip-bglue
  - id: skip_links
    type:
      - 'null'
      - boolean
    doc: debug function, skip links
    inputBinding:
      position: 101
      prefix: -skip-links
  - id: solidity_custom
    type:
      - 'null'
      - type: array
        items: File
    doc: when solidity-kind is custom, specifies list of files where kmer must be
      present
    inputBinding:
      position: 101
      prefix: -solidity-custom
  - id: storage_type
    type:
      - 'null'
      - string
    doc: storage type of kmer counts ('hdf5' or 'file')
    default: hdf5
    inputBinding:
      position: 101
      prefix: -storage-type
  - id: topology_stats
    type:
      - 'null'
      - int
    doc: topological information level (0 for none)
    default: 0
    inputBinding:
      position: 101
      prefix: -topology-stats
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
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcalm:2.2.3--h43eeafb_6
