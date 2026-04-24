cwlVersion: v1.2
class: CommandLineTool
baseCommand: simka
label: simka
doc: "Simka computes pairwise distances between samples based on k-mers.\n\nTool homepage:
  https://github.com/GATB/simka"
inputs:
  - id: abundance_max
    type:
      - 'null'
      - int
    doc: max abundance a kmer can have to be considered
    inputBinding:
      position: 101
      prefix: -abundance-max
  - id: abundance_min
    type:
      - 'null'
      - int
    doc: min abundance a kmer need to be considered
    inputBinding:
      position: 101
      prefix: -abundance-min
  - id: complex_dist
    type:
      - 'null'
      - boolean
    doc: compute all complex distances (Jensen-Shannon...)
    inputBinding:
      position: 101
      prefix: -complex-dist
  - id: count_cmd
    type:
      - 'null'
      - string
    doc: command to submit counting job
    inputBinding:
      position: 101
      prefix: -count-cmd
  - id: count_file
    type:
      - 'null'
      - File
    doc: filename to the couting job template
    inputBinding:
      position: 101
      prefix: -count-file
  - id: data_info
    type:
      - 'null'
      - boolean
    doc: compute (and display) information before running Simka, such as the 
      number of reads per dataset
    inputBinding:
      position: 101
      prefix: -data-info
  - id: input_file
    type: File
    doc: 'input file of samples. One sample per line: id1: filename1...'
    inputBinding:
      position: 101
      prefix: -in
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: keep temporary files
    inputBinding:
      position: 101
      prefix: -keep-tmp
  - id: kmer_shannon_index
    type:
      - 'null'
      - float
    doc: minimal Shannon index a kmer should have to be kept. Float in [0,2]
    inputBinding:
      position: 101
      prefix: -kmer-shannon-index
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of a kmer
    inputBinding:
      position: 101
      prefix: -kmer-size
  - id: max_count
    type:
      - 'null'
      - string
    doc: maximum number of simultaneous counting jobs (a higher value improve 
      execution time but increase temporary disk usage)
    inputBinding:
      position: 101
      prefix: -max-count
  - id: max_memory
    type:
      - 'null'
      - int
    doc: max memory (MB)
    inputBinding:
      position: 101
      prefix: -max-memory
  - id: max_merge
    type:
      - 'null'
      - string
    doc: maximum number of simultaneous merging jobs (1 job = 1 core)
    inputBinding:
      position: 101
      prefix: -max-merge
  - id: max_reads
    type:
      - 'null'
      - int
    doc: 'maximum number of reads per sample to process. Can be -1: use all reads.
      Can be 0: estimate it'
    inputBinding:
      position: 101
      prefix: -max-reads
  - id: merge_cmd
    type:
      - 'null'
      - string
    doc: command to submit merging job
    inputBinding:
      position: 101
      prefix: -merge-cmd
  - id: merge_file
    type:
      - 'null'
      - File
    doc: filename to the merging job template
    inputBinding:
      position: 101
      prefix: -merge-file
  - id: min_read_size
    type:
      - 'null'
      - int
    doc: minimal size a read should have to be kept
    inputBinding:
      position: 101
      prefix: -min-read-size
  - id: min_shannon_index
    type:
      - 'null'
      - float
    doc: minimal Shannon index a read should have to be kept. Float in [0,2]
    inputBinding:
      position: 101
      prefix: -min-shannon-index
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: number of cores
    inputBinding:
      position: 101
      prefix: -nb-cores
  - id: output_tmp_dir
    type: Directory
    doc: output directory for temporary files
    inputBinding:
      position: 101
      prefix: -out-tmp
  - id: simple_dist
    type:
      - 'null'
      - boolean
    doc: compute all simple distances (Chord, Hellinger...)
    inputBinding:
      position: 101
      prefix: -simple-dist
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory for result files (distance matrices)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simka:1.5.3--h077b44d_5
