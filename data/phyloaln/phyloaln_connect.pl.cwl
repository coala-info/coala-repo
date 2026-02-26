cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl /usr/local/bin/connect.pl
label: phyloaln_connect.pl
doc: "Concatenate multiple alignments into a matrix.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: block_file
    type:
      - 'null'
      - File
    doc: the block file of the positions of each alignments(default=not to 
      output)
    inputBinding:
      position: 101
      prefix: -b
  - id: codon_positions
    type:
      - 'null'
      - string
    doc: the codon positions to be written in the block file(default=no codon 
      position, '123' represents outputing all the three codon positions, '12' 
      represents outputing first and second positions)
    inputBinding:
      position: 101
      prefix: -c
  - id: fill_symbol
    type:
      - 'null'
      - string
    doc: the symbol to fill the sites of absent species in the 
      alignments(default='-')
    default: '-'
    inputBinding:
      position: 101
      prefix: -f
  - id: input_directory
    type: Directory
    doc: directory containing input FASTA alignment files
    inputBinding:
      position: 101
      prefix: -i
  - id: input_suffix
    type:
      - 'null'
      - string
    doc: the suffix of the input FASTA alignment files(default='.fa')
    default: .fa
    inputBinding:
      position: 101
      prefix: -x
  - id: input_type
    type:
      - 'null'
      - string
    doc: type of input format(phyloaln/orthograph/blastsearch, 
      default='phyloaln', also suitable for the format with same species name in
      all alignments, but the name shuold not contain separate symbol)
    default: phyloaln
    inputBinding:
      position: 101
      prefix: -t
  - id: output_nexus_block_file
    type:
      - 'null'
      - boolean
    doc: output the block file with NEXUS format, suitable for 
      IQ-TREE(default=no)
    inputBinding:
      position: 101
      prefix: -n
  - id: sequence_name_separator
    type:
      - 'null'
      - string
    doc: the symbol to separate the sequences name and the first space is the 
      species name in the 'phyloaln' format(default='.')
    default: .
    inputBinding:
      position: 101
      prefix: -s
  - id: species_list_file
    type:
      - 'null'
      - File
    doc: the list file with all the involved species you want to be included in 
      the output alignments, one species per line(default=automatically 
      generated, with all species found at least once in all the alignments)
    inputBinding:
      position: 101
      prefix: -l
outputs:
  - id: output_file
    type: File
    doc: output concatenated FASTA alignment file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
