cwlVersion: v1.2
class: CommandLineTool
baseCommand: Binsanity-wf
label: binsanity_Binsanity-wf
doc: "Binsanity-wf is a workflow script that runs Binsanity and Binsanity-refine sequentially.\n\
  \nTool homepage: https://github.com/edgraham/BinSanity"
inputs:
  - id: bin_prefix
    type:
      - 'null'
      - string
    doc: Sepcify what prefix you want appended to final Bins {optional}
    inputBinding:
      position: 101
      prefix: --binPrefix
  - id: convergence_iteration
    type:
      - 'null'
      - int
    doc: "Specify the convergence iteration number [Default: 400]\n              \
      \              e.g Number of iterations with no change in the number\n     \
      \                       of estimated clusters that stops the convergence."
    default: 400
    inputBinding:
      position: 101
      prefix: -v
  - id: coverage_file
    type:
      - 'null'
      - File
    doc: "Specify a Transformed Coverage File\ne.g Log transformed"
    inputBinding:
      position: 101
      prefix: -c
  - id: dampening_factor
    type:
      - 'null'
      - float
    doc: 'Specify a damping factor between 0.5 and 1, [Default: 0.95]'
    default: 0.95
    inputBinding:
      position: 101
      prefix: -d
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Specify the fasta file containing contigs you want to cluster
    inputBinding:
      position: 101
      prefix: -l
  - id: fasta_location
    type:
      - 'null'
      - Directory
    doc: Specify directory containing your contigs
    inputBinding:
      position: 101
      prefix: -f
  - id: kmer
    type:
      - 'null'
      - int
    doc: 'Indicate a number for the kmer calculation, the [Default: 4]'
    default: 4
    inputBinding:
      position: 101
      prefix: --kmer
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: 'Specify a max number of iterations [Default: 4000]'
    default: 4000
    inputBinding:
      position: 101
      prefix: -m
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: "Give a name to the directory BinSanity results will be output in\n     \
      \                       [Default: 'BINSANITY-RESULTS']"
    default: BINSANITY-RESULTS
    inputBinding:
      position: 101
      prefix: -o
  - id: preference
    type:
      - 'null'
      - string
    doc: "Specify a preference [Default: -3]\n                            Note: decreasing
      the preference leads to more lumping,\n                            increasing
      will lead to more splitting. If your range\n                            of coverages
      are low you will want to decrease the\n                            preference,
      if you have 10 or less replicates increasing\n                            the
      preference could benefit you."
    default: '-3'
    inputBinding:
      position: 101
      prefix: -p
  - id: prefix
    type:
      - 'null'
      - string
    doc: Specify a prefix to append to the start of all files generated during 
      Binsanity
    inputBinding:
      position: 101
      prefix: --Prefix
  - id: refine_preference
    type:
      - 'null'
      - string
    doc: 'Specify a preference for refinement. [Default: -25]'
    default: '-25'
    inputBinding:
      position: 101
      prefix: --refine-preference
  - id: size_threshold
    type:
      - 'null'
      - int
    doc: 'Specify the contig size cut-off [Default: 1000 bp]'
    default: 1000
    inputBinding:
      position: 101
      prefix: -x
  - id: threads
    type:
      - 'null'
      - int
    doc: Indicate how many threads you want dedicated to the subprocess CheckM. 
      [Default=1]
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
stdout: binsanity_Binsanity-wf.out
