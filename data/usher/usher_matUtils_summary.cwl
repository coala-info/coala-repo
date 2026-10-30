cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- matUtils
- summary
label: usher_matUtils_summary
doc: 'matUtils summary: calculates basic statistics and counts samples, mutations,
  and clades in the input mutation-annotated tree (MAT).


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: input_mat
  type: File
  doc: Input mutation-annotated tree file [REQUIRED]. If only this argument is set,
    print the count of samples and nodes in the tree.
  inputBinding:
    position: 101
    prefix: --input-mat
- id: input_gtf
  type:
  - 'null'
  - File
  doc: Input GTF annotation file. Required for --translate / -t
  inputBinding:
    position: 101
    prefix: --input-gtf
- id: input_fasta
  type:
  - 'null'
  - File
  doc: Input FASTA reference sequence. Required for --translate / -t
  inputBinding:
    position: 101
    prefix: --input-fasta
- id: output_directory
  type:
  - 'null'
  - string
  doc: 'Write output files to the target directory. Default is current directory.
    [default: ./]'
  inputBinding:
    position: 101
    prefix: --output-directory
- id: samples
  type:
  - 'null'
  - string
  doc: Write a tsv listing all samples in the tree, their parsimony score (terminal
    branch length), and the ID of their parent node.
  inputBinding:
    position: 101
    prefix: --samples
- id: clades
  type:
  - 'null'
  - string
  doc: Write a tsv listing all clades and the (inclusive and exclusive of nested clades)
    count of associated samples.
  inputBinding:
    position: 101
    prefix: --clades
- id: sample_clades
  type:
  - 'null'
  - string
  doc: Write a tsv of all samples and their associated clade values
  inputBinding:
    position: 101
    prefix: --sample-clades
- id: mutations
  type:
  - 'null'
  - string
  doc: Write a tsv listing all mutations in the tree and their occurrence count.
  inputBinding:
    position: 101
    prefix: --mutations
- id: translate
  type:
  - 'null'
  - string
  doc: Write a tsv listing the amino acid and nucleotide mutations at each node.
  inputBinding:
    position: 101
    prefix: --translate
- id: aberrant
  type:
  - 'null'
  - string
  doc: Write a tsv listing duplicate sample identifiers and internal nodes with no
    mutations and/or branch length 0.
  inputBinding:
    position: 101
    prefix: --aberrant
- id: haplotype
  type:
  - 'null'
  - string
  doc: Write a tsv listing haplotypes represented by comma-delimited sets of mutations
    and their total frequency across the tree.
  inputBinding:
    position: 101
    prefix: --haplotype
- id: calculate_roho
  type:
  - 'null'
  - string
  doc: Write a tsv containing the distribution of RoHO values calculated for all homoplasic
    mutations.
  inputBinding:
    position: 101
    prefix: --calculate-roho
- id: get_all_basic
  type:
  - 'null'
  - boolean
  doc: Use default filenames and save samples, clades, mutations, and aberrant summary
    tables to the output directory.
  inputBinding:
    position: 101
    prefix: --get-all-basic
- id: threads
  type:
  - 'null'
  - int
  doc: 'Number of threads to use when possible [DEFAULT uses all available cores,
    20 detected on this machine] [default: 20]'
  inputBinding:
    position: 101
    prefix: --threads
- id: expanded_roho
  type:
  - 'null'
  - boolean
  doc: Use to include date and other contextual information in RoHO table output.
    Significantly slows calculation time.
  inputBinding:
    position: 101
    prefix: --expanded-roho
- id: mutation_stats
  type:
  - 'null'
  - boolean
  doc: Print counts of different kinds of mutations
  inputBinding:
    position: 101
    prefix: --mutation-stats
- id: node_stats
  type:
  - 'null'
  - string
  doc: Write a tsv file containing, for each internal node, the number of descendents,
    the number of mutations, the mutational density, and the number of reversion mutations
    since the last annotation.
  inputBinding:
    position: 101
    prefix: --node-stats
outputs:
- id: output_directory_dir
  type:
  - 'null'
  - Directory
  doc: Directory named by --output-directory
  outputBinding:
    glob: '${ return inputs.output_directory ? inputs.output_directory : []; }'
- id: samples_file
  type:
  - 'null'
  - File
  doc: Output file named by --samples. Write a tsv listing all samples in the tree,
    their parsimony score (terminal branch length), and the ID of their parent node.
  outputBinding:
    glob: '${ return inputs.samples ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.samples : inputs.samples) : []; }'
- id: clades_file
  type:
  - 'null'
  - File
  doc: Output file named by --clades. Write a tsv listing all clades and the (inclusive
    and exclusive of nested clades) count of associated samples.
  outputBinding:
    glob: '${ return inputs.clades ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.clades : inputs.clades) : []; }'
- id: sample_clades_file
  type:
  - 'null'
  - File
  doc: Output file named by --sample-clades. Write a tsv of all samples and their
    associated clade values
  outputBinding:
    glob: '${ return inputs.sample_clades ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.sample_clades : inputs.sample_clades) : []; }'
- id: mutations_file
  type:
  - 'null'
  - File
  doc: Output file named by --mutations. Write a tsv listing all mutations in the
    tree and their occurrence count.
  outputBinding:
    glob: '${ return inputs.mutations ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.mutations : inputs.mutations) : []; }'
- id: translate_file
  type:
  - 'null'
  - File
  doc: Output file named by --translate. Write a tsv listing the amino acid and nucleotide
    mutations at each node.
  outputBinding:
    glob: '${ return inputs.translate ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.translate : inputs.translate) : []; }'
- id: aberrant_file
  type:
  - 'null'
  - File
  doc: Output file named by --aberrant. Write a tsv listing duplicate sample identifiers
    and internal nodes with no mutations and/or branch length 0.
  outputBinding:
    glob: '${ return inputs.aberrant ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.aberrant : inputs.aberrant) : []; }'
- id: haplotype_file
  type:
  - 'null'
  - File
  doc: Output file named by --haplotype. Write a tsv listing haplotypes represented
    by comma-delimited sets of mutations and their total frequency across the tree.
  outputBinding:
    glob: '${ return inputs.haplotype ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.haplotype : inputs.haplotype) : []; }'
- id: calculate_roho_file
  type:
  - 'null'
  - File
  doc: Output file named by --calculate-roho. Write a tsv containing the distribution
    of RoHO values calculated for all homoplasic mutations.
  outputBinding:
    glob: '${ return inputs.calculate_roho ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.calculate_roho : inputs.calculate_roho) : []; }'
- id: node_stats_file
  type:
  - 'null'
  - File
  doc: Output file named by --node-stats. Write a tsv file containing, for each internal
    node, the number of descendents, the number of mutations, the mutational density,
    and the number of reversion mutations since the last annotation.
  outputBinding:
    glob: '${ return inputs.node_stats ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.node_stats : inputs.node_stats) : []; }'
- id: stdout_log
  type: stdout
  doc: 'Standard output: counts of samples and nodes, and mutation statistics when
    requested.'
stdout: matUtils_summary_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
