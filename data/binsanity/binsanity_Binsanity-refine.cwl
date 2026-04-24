cwlVersion: v1.2
class: CommandLineTool
baseCommand: Binsanity-refine
label: binsanity_Binsanity-refine
doc: "Binsanity-refine uses combined coverage and composition (in the form of tetramer
  frequencies and GC%) to cluster contigs. The published workflow uses this to refine
  bins initially clustered soley on coverage. Binsanity-refine can be used as a stand
  alone script if you don't have more than 2 sample replicates\n\nTool homepage: https://github.com/edgraham/BinSanity"
inputs:
  - id: contig_files
    type: Directory
    doc: Specify directory containing your contigs
    inputBinding:
      position: 101
      prefix: -f
  - id: contig_size
    type:
      - 'null'
      - int
    doc: Specify the contig size cut-off (Default 1000 bp)
    inputBinding:
      position: 101
      prefix: -x
  - id: convergence_iterations
    type:
      - 'null'
      - int
    doc: "Specify the convergence iteration number (default is 200)\n            \
      \               e.g Number of iterations with no change in the number\n    \
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
  - id: damping_factor
    type:
      - 'null'
      - float
    doc: Specify a damping factor between 0.5 and 1, default is 0.9
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
  - id: kmer_type
    type:
      - 'null'
      - string
    doc: "Specify a number for kmer calculation. Default is 4.\n                 \
      \          Tetramer frequencies are recommended"
    inputBinding:
      position: 101
      prefix: -kmer
  - id: log_file
    type:
      - 'null'
      - File
    doc: 'Specify an output name for the log file. [Default: binsanity-refine.log]'
    inputBinding:
      position: 101
      prefix: --log
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Specify a max number of iterations (default is 4000)
    inputBinding:
      position: 101
      prefix: -m
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: "Give a name to the directory BinSanity results will be output in\n     \
      \                      [Default is 'BINSANITY-REFINEMENT']"
    inputBinding:
      position: 101
      prefix: -o
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Sepcify what prefix you want appended to final Bins {optional}
    inputBinding:
      position: 101
      prefix: --outPrefix
  - id: preference
    type:
      - 'null'
      - string
    doc: "Specify a preference (default is -25)\n                           Note:
      decreasing the preference leads to more lumping,\n                         \
      \  increasing will lead to more splitting. If your range\n                 \
      \          of coverages are low you will want to decrease the\n            \
      \               preference, if you have 10 or less replicates increasing\n \
      \                          the preference could benefit you. For complex datasets\n\
      \                           with low abundance organisms a preference\n    \
      \                       of -25 was found to be optimal"
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
stdout: binsanity_Binsanity-refine.out
