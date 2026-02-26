cwlVersion: v1.2
class: CommandLineTool
baseCommand: clust-mst
label: rabbittclust_clust-mst
doc: "minimum-spanning-tree-based module for RabbitTClust\n\nTool homepage: https://github.com/RabbitBio/RabbitTClust"
inputs:
  - id: append
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
  - id: drlevel
    type:
      - 'null'
      - int
    doc: set the dimention reduction level for Kssd sketches, default 3 with a 
      dimention reduction of 1/4096
    default: 3
    inputBinding:
      position: 101
      prefix: --drlevel
  - id: fast
    type:
      - 'null'
      - boolean
    doc: use the kssd algorithm for sketching and distance computing for 
      clust-mst
    inputBinding:
      position: 101
      prefix: --fast
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
  - id: no_dense
    type:
      - 'null'
      - boolean
    doc: not calculate the density and ANI datas
    inputBinding:
      position: 101
      prefix: --no-dense
  - id: no_save
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
  - id: output_newick_tree
    type:
      - 'null'
      - boolean
    doc: output the newick tree format file for clust-mst
    inputBinding:
      position: 101
      prefix: --newick-tree
  - id: premsted
    type:
      - 'null'
      - string
    doc: clustering by the pre-generated mst files rather than genomes for 
      clust-mst
    inputBinding:
      position: 101
      prefix: --premsted
  - id: presketched
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
  - id: threshold
    type:
      - 'null'
      - float
    doc: set the distance threshold for clustering
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabbittclust:2.3.0--h43eeafb_0
stdout: rabbittclust_clust-mst.out
