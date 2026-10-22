cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmds
label: seer_kmds
doc: "kmds: control for population structure. 1) filter and subsample with --no_mds and --size 2) combine, and do metric multidimensional scaling with --mds_concat\n\nTool homepage: https://github.com/johnlees/seer"
inputs:
  - id: kmers
    type: File
    doc: "dsm kmer output file (not needed if using --mds_concat)"
    inputBinding:
      position: 1
      prefix: --kmers
  - id: pheno
    type: File
    doc: ".pheno metadata"
    inputBinding:
      position: 1
      prefix: --pheno
  - id: output
    type: ['null', string]
    doc: "Output prefix for new dsm file"
    inputBinding:
      position: 1
      prefix: --output
  - id: no_mds
    type: ['null', boolean]
    doc: "Do not perform MDS; output subsampled matrix instead"
    inputBinding:
      position: 1
      prefix: --no_mds
  - id: write_distances
    type: ['null', boolean]
    doc: "Write csv of distance matrix"
    inputBinding:
      position: 1
      prefix: --write_distances
  - id: mds_concat
    type: ['null', File]
    doc: "List of subsampled matrices to use in MDS. Performs only MDS; implies --no_filtering"
    inputBinding:
      position: 1
      prefix: --mds_concat
  - id: pc
    type: ['null', int]
    doc: "Number of principal coordinates to output (default 10)"
    inputBinding:
      position: 1
      prefix: --pc
  - id: size
    type: ['null', int]
    doc: "Number of kmers to use in MDS (default 1000000)"
    inputBinding:
      position: 1
      prefix: --size
  - id: threads
    type: ['null', int]
    doc: "Number of threads. Suggested: 20"
    inputBinding:
      position: 1
      prefix: --threads
  - id: no_filtering
    type: ['null', boolean]
    doc: "Turn off all filtering and do not output new kmer file"
    inputBinding:
      position: 1
      prefix: --no_filtering
  - id: max_length
    type: ['null', int]
    doc: "Maximum kmer length (default 100)"
    inputBinding:
      position: 1
      prefix: --max_length
  - id: maf
    type: ['null', float]
    doc: "Minimum kmer frequency (default 0.01)"
    inputBinding:
      position: 1
      prefix: --maf
  - id: min_words
    type: ['null', int]
    doc: "Minimum kmer occurences. Overrides --maf"
    inputBinding:
      position: 1
      prefix: --min_words
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix
    outputBinding:
      glob: $(inputs.output)*
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer_kmds.out
