cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -Xmx[available RAM in MB]m -jar RealPhy_v1.12.jar
label: realphy
doc: "RealPhy is a tool for phylogenetic analysis. It takes a folder of sequence files
  and outputs a phylogenetic tree.\n\nTool homepage: https://realphy.unibas.ch/fcgi/realphy"
inputs:
  - id: sequence_folder
    type: Directory
    doc: Folder containing fasta, genbank, or short read files.
    inputBinding:
      position: 1
  - id: output_folder
    type: Directory
    doc: Folder where output files will be generated. Must contain a config.txt 
      file.
    inputBinding:
      position: 2
  - id: bowtie_options
    type:
      - 'null'
      - File
    doc: Allows the user to provide command line parameters to bowtie2 in the 
      first line of a given text file.
    inputBinding:
      position: 103
      prefix: -bowtieOptions
  - id: clean
    type:
      - 'null'
      - boolean
    doc: If set, the whole analysis will be rerun and existing data will be 
      overwritten.
    inputBinding:
      position: 103
      prefix: -clean
  - id: config
    type:
      - 'null'
      - string
    doc: Specifies the location of the config.txt. If not set, it is assumed 
      that the config.txt is in the working directory.
    inputBinding:
      position: 103
      prefix: -config
  - id: delete
    type:
      - 'null'
      - boolean
    doc: If this option is set, all alignment output files and sequence cut 
      files will be deleted after the program is terminated.
    inputBinding:
      position: 103
      prefix: -delete
  - id: gap_threshold
    type:
      - 'null'
      - float
    doc: Specifies the proportion of input sequences that are allowed to contain
      gaps in the final sequence alignment.
    default: 0
    inputBinding:
      position: 103
      prefix: -gapThreshold
  - id: gaps
    type:
      - 'null'
      - boolean
    doc: If this option is set, the gapThreshold is automatically set to 100%, 
      unless a different gapThreshold is specified.
    inputBinding:
      position: 103
      prefix: -gaps
  - id: genes
    type:
      - 'null'
      - boolean
    doc: If set, genes (CDS) are extracted from a given genbank file.
    inputBinding:
      position: 103
      prefix: -genes
  - id: merge
    type:
      - 'null'
      - boolean
    doc: If this option is set, multiple references are selected, a final 
      polymorphism file will be generated which combines all polymorphism files 
      for all references.
    inputBinding:
      position: 103
      prefix: -merge
  - id: per_base_cov
    type:
      - 'null'
      - int
    doc: Polymorphisms will only be extracted for regions covered by more than 
      this threshold of reads.
    default: 10
    inputBinding:
      position: 103
      prefix: -perBaseCov
  - id: poly_threshold
    type:
      - 'null'
      - float
    doc: Polymorphisms occurring at a frequency lower than this threshold at any
      given alignment position will not be considered.
    default: 0.95
    inputBinding:
      position: 103
      prefix: -polyThreshold
  - id: quality
    type:
      - 'null'
      - int
    doc: Quality threshold for fastq files (PHRED+33). Bases below this 
      threshold will not be considered. Fasta files are converted to fastq with 
      quality 20.
    default: 20
    inputBinding:
      position: 103
      prefix: -quality
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: If set, suppresses any program output except for errors or warnings.
    inputBinding:
      position: 103
      prefix: -quiet
  - id: read_length
    type:
      - 'null'
      - int
    doc: Size of fragments to be produced from input sequences. Larger values 
      increase mapping time but can map more divergent sequences.
    default: 50
    inputBinding:
      position: 103
      prefix: -readLength
  - id: ref
    type:
      - 'null'
      - string
    doc: The file name of a sequence data set without the extension. Sets the 
      reference sequence.
    default: random
    inputBinding:
      position: 103
      prefix: -ref
  - id: ref_n
    type:
      - 'null'
      - string
    doc: The file name of a sequence data set without the extension. N is the 
      n-th reference genome.
    inputBinding:
      position: 103
      prefix: -refN
  - id: root
    type:
      - 'null'
      - string
    doc: The file name of a sequence data set without the extension. Specifies 
      the root of the tree.
    default: random
    inputBinding:
      position: 103
      prefix: -root
  - id: seed_length
    type:
      - 'null'
      - int
    doc: Specifies k-mer length in bowtie2.
    default: 22
    inputBinding:
      position: 103
      prefix: -seedLength
  - id: suffix
    type:
      - 'null'
      - string
    doc: Appends a suffix to the reference output folder.
    default: not set
    inputBinding:
      position: 103
      prefix: -suffix
  - id: tree_builder
    type:
      - 'null'
      - int
    doc: 'Specifies the tree building method: 0=Do not build a tree, 1=treepuzzle,
      2=raxml, 3=max. parsimony (dnapars), 4=PhyML (default).'
    default: 4
    inputBinding:
      position: 103
      prefix: -treeBuilder
  - id: tree_options
    type:
      - 'null'
      - File
    doc: Allows the user to provide command line parameters to the tree program 
      in the first line of a given text file.
    inputBinding:
      position: 103
      prefix: -treeOptions
  - id: var_only
    type:
      - 'null'
      - boolean
    doc: If set, homologous positions that are conserved in all input sequences 
      are put out. If set, the reconstructed tree may be wrong.
    inputBinding:
      position: 103
      prefix: -varOnly
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/realphy:1.13--hdfd78af_1
stdout: realphy.out
