cwlVersion: v1.2
class: CommandLineTool
baseCommand: Binsanity-lc
label: binsanity_Binsanity2-beta
doc: "Binsanity2 is a workflow script that will subset assemblies using kmeans and
  subsequently binning the resultant clusters of contigs using coverage and affinity
  propagation (AP) followed by a compositional based refinement.\n\nTool homepage:
  https://github.com/edgraham/BinSanity"
inputs:
  - id: checkm_threads
    type:
      - 'null'
      - int
    doc: 'Indicate how many threads you want dedicated to the subprocess CheckM [Default:
      1]'
    inputBinding:
      position: 101
      prefix: --checkm_threads
  - id: cluster_number
    type:
      - 'null'
      - int
    doc: Indicate a number of initial clusters for kmean [Default:25]
    inputBinding:
      position: 101
      prefix: -C
  - id: convergence_iterations
    type:
      - 'null'
      - int
    doc: "Specify the convergence iteration number [Default:400]\n               \
      \             e.g Number of iterations with no change in the number \n     \
      \                       of estimated clusters that stops the convergence."
    inputBinding:
      position: 101
      prefix: -v
  - id: coverage_file
    type: File
    doc: Specify a Coverage File
    inputBinding:
      position: 101
      prefix: -c
  - id: dampening_factor
    type:
      - 'null'
      - float
    doc: 'Specify a damping factor between 0.5 and 1 [Default: 0.95]'
    inputBinding:
      position: 101
      prefix: -d
  - id: fasta_file_name
    type: File
    doc: Specify the fasta file containing contigs you want to cluster
    inputBinding:
      position: 101
      prefix: -l
  - id: fasta_location
    type: Directory
    doc: Specify directory containing Fasta File to be clustered
    inputBinding:
      position: 101
      prefix: -f
  - id: kmer
    type:
      - 'null'
      - int
    doc: 'Indicate a number for the kmer calculation [Default: 4]'
    inputBinding:
      position: 101
      prefix: --kmer
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: 'Specify a max number of iterations [Default: 4000]'
    inputBinding:
      position: 101
      prefix: -m
  - id: output_directory
    type: Directory
    doc: "Give a name to the directory BinSanity results will be output in \n    \
      \                        [Default:'BINSANITY-RESULTS']"
    inputBinding:
      position: 101
      prefix: -o
  - id: preference
    type:
      - 'null'
      - string
    doc: "Specify a preference [Default: -3]\n                            Note: decreasing
      the preference leads to more lumping, \n                            increasing
      will lead to more splitting. If your range\n                            of coverages
      are low you will want to decrease the\n                            preference,
      if you have 10 or less replicates increasing\n                            the
      preference could benefit you."
    inputBinding:
      position: 101
      prefix: -p
  - id: prefix
    type:
      - 'null'
      - string
    doc: Specify a prefix to append to the start of all directories generated 
      during Binsanity
    inputBinding:
      position: 101
      prefix: --Prefix
  - id: refine_preference
    type:
      - 'null'
      - string
    doc: 'Specify a preference for refinement [Default: -25]'
    inputBinding:
      position: 101
      prefix: --refine-preference
  - id: size_cut_off
    type:
      - 'null'
      - int
    doc: Specify the contig size cut-off [Default:1000 bp]
    inputBinding:
      position: 101
      prefix: -x
  - id: skip_kmeans
    type:
      - 'null'
      - boolean
    doc: "If you want to bypass kmeans clustering and ONLY us affinity propagation
      set this flag. \n                            This will replicated the BinsanityWF
      functionality. The default action without this flag\n                      \
      \      is to implement an initial kmeans clustering. The kmeans clustering step
      decreases the overall\n                            memory requirments for the
      script so skipping kmeans will lead to greater memory allocation. \n       \
      \                     It is recommended that users only implement this flag
      if they are working with small assemblies\n                            that
      are < 25,000 contigs or if the user knows they have ample memory. For reference
      using this\n                            flag with an assembly ~100,000 contigs
      used >600GB of RAM on our lab server."
    inputBinding:
      position: 101
      prefix: --skip-kmeans
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
stdout: binsanity_Binsanity2-beta.out
