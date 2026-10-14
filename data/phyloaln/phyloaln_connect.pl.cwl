cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - connect.pl
label: phyloaln_connect.pl
doc: "Concatenate multiple alignments into a matrix.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: input_directory
    type: Directory
    doc: "directory containing input FASTA alignment files"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "output concatenated FASTA alignment file (default all.fas)"
    default: "all.fas"
    inputBinding:
      position: 2
      prefix: "-o"
  - id: input_type
    type:
      - 'null'
      - string
    doc: "type of input format (phyloaln/orthograph/blastsearch, default='phyloaln', also suitable for the format with same species name in all alignments, but the name should not contain separate symbol)"
    inputBinding:
      position: 3
      prefix: "-t"
  - id: fill_symbol
    type:
      - 'null'
      - string
    doc: "the symbol to fill the sites of absent species in the alignments (default='-')"
    inputBinding:
      position: 4
      prefix: "-f"
  - id: sequence_name_separator
    type:
      - 'null'
      - string
    doc: "the symbol to separate the sequences name and the first space is the species name in the 'phyloaln' format (default='.')"
    inputBinding:
      position: 5
      prefix: "-s"
  - id: input_suffix
    type:
      - 'null'
      - string
    doc: "the suffix of the input FASTA alignment files (default='.fa')"
    inputBinding:
      position: 6
      prefix: "-x"
  - id: block_file_path
    type:
      - 'null'
      - string
    doc: "the block file of the positions of each alignments (default=not to output)"
    inputBinding:
      position: 7
      prefix: "-b"
  - id: output_nexus_block_file
    type:
      - 'null'
      - boolean
    doc: "output the block file with NEXUS format, suitable for IQ-TREE (default=no)"
    inputBinding:
      position: 8
      prefix: "-n"
  - id: codon_positions
    type:
      - 'null'
      - string
    doc: "the codon positions to be written in the block file (default=no codon position, '123' represents outputing all the three codon positions, '12' represents outputing first and second positions)"
    inputBinding:
      position: 9
      prefix: "-c"
  - id: species_list_file
    type:
      - 'null'
      - File
    doc: "the list file with all the involved species you want to be included in the output alignments, one species per line (default=automatically generated, with all species found at least once in all the alignments)"
    inputBinding:
      position: 10
      prefix: "-l"
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Concatenated alignment"
    outputBinding:
      glob: "$(inputs.output_file_path)"
  - id: block_file
    type:
      - 'null'
      - File
    doc: "Block file with the positions of each alignment"
    outputBinding:
      glob: "$(inputs.block_file_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
