cwlVersion: v1.2
class: CommandLineTool
baseCommand: clust-greedy
label: rabbittclust_clust-greedy
doc: "greedy incremental clustering module for RabbitTClust\n\nTool homepage: https://github.com/RabbitBio/RabbitTClust"
inputs:
  - id: append_files
    type:
      - 'null'
      - string
    doc: append genome file or file list with the pre-generated sketch or MST 
      files
    inputBinding:
      position: 101
      prefix: --append
  - id: containment
    type:
      - 'null'
      - int
    doc: use AAF distance with containment coefficient, set the containCompress,
      the sketch size is in proportion with 1/containCompress
    inputBinding:
      position: 101
      prefix: --containment
  - id: distance_threshold
    type:
      - 'null'
      - float
    doc: set the distance threshold for clustering
    inputBinding:
      position: 101
      prefix: --threshold
  - id: input_file
    type:
      - 'null'
      - string
    doc: set the input file, single FASTA genome file (without -l option) or 
      genome list file (with -l option)
    inputBinding:
      position: 101
      prefix: --input
  - id: input_is_list
    type:
      - 'null'
      - boolean
    doc: input is genome list, one genome per line
    inputBinding:
      position: 101
      prefix: --list
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: set the kmer size
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: min_length
    type:
      - 'null'
      - int
    doc: set the filter minimum length (minLen), genome length less than minLen 
      will be ignore, default 10,000
    default: 10000
    inputBinding:
      position: 101
      prefix: --min-length
  - id: no_save_intermediate
    type:
      - 'null'
      - boolean
    doc: not save the intermediate files, such as sketches or MST
    inputBinding:
      position: 101
      prefix: --no-save
  - id: output_name
    type: string
    doc: set the output name of cluster result
    inputBinding:
      position: 101
      prefix: --output
  - id: presketched_files
    type:
      - 'null'
      - string
    doc: clustering by the pre-generated sketch files rather than genomes
    inputBinding:
      position: 101
      prefix: --presketched
  - id: sketch_function
    type:
      - 'null'
      - string
    doc: set the sketch function, such as MinHash, KSSD, default MinHash
    default: MinHash
    inputBinding:
      position: 101
      prefix: --function
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: set the sketch size for Jaccard Index and Mash distance, default 1000
    default: 1000
    inputBinding:
      position: 101
      prefix: --sketch-size
  - id: threads
    type:
      - 'null'
      - int
    doc: set the thread number, default all CPUs of the platform
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabbittclust:2.3.0--h43eeafb_0
stdout: rabbittclust_clust-greedy.out
