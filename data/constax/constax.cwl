cwlVersion: v1.2
class: CommandLineTool
baseCommand: constax
label: constax
doc: "Classify sequences using various methods.\n\nTool homepage: https://github.com/liberjul/CONSTAXv2"
inputs:
  - id: blast
    type:
      - 'null'
      - boolean
    doc: Use BLAST instead of UTAX if specified
    default: false
    inputBinding:
      position: 101
      prefix: --blast
  - id: check
    type:
      - 'null'
      - boolean
    doc: If specified, runs checks but stops before training or classifying
    default: false
    inputBinding:
      position: 101
      prefix: --check
  - id: combine_only
    type:
      - 'null'
      - boolean
    doc: Only combine taxonomy without rerunning classifiers
    default: false
    inputBinding:
      position: 101
      prefix: --combine_only
  - id: conf
    type:
      - 'null'
      - float
    doc: Classification confidence threshold
    default: 0.8
    inputBinding:
      position: 101
      prefix: --conf
  - id: conservative
    type:
      - 'null'
      - boolean
    doc: If specified, use conservative consensus rule (2 False = False winner)
    default: false
    inputBinding:
      position: 101
      prefix: --conservative
  - id: consistent
    type:
      - 'null'
      - boolean
    doc: If specified, show if the consensus taxonomy is consistent with the 
      real hierarchical taxonomy
    default: false
    inputBinding:
      position: 101
      prefix: --consistent
  - id: constax_path
    type:
      - 'null'
      - string
    doc: Path to CONSTAX scripts
    default: false
    inputBinding:
      position: 101
      prefix: --constax_path
  - id: db
    type:
      - 'null'
      - File
    doc: Database to train classifiers, in FASTA format
    default: ''
    inputBinding:
      position: 101
      prefix: --db
  - id: evalue
    type:
      - 'null'
      - float
    doc: Maximum expect value of BLAST hits to use, for use with -b option
    default: 1.0
    inputBinding:
      position: 101
      prefix: --evalue
  - id: high_level_db
    type:
      - 'null'
      - File
    doc: FASTA database file of representative sequences for assignment of high 
      level taxonomy
    default: false
    inputBinding:
      position: 101
      prefix: --high_level_db
  - id: high_level_percent_identity
    type:
      - 'null'
      - float
    doc: Threshold of aligned sequence percent identity to report high-level 
      taxonomy matches
    default: 1.0
    inputBinding:
      position: 101
      prefix: --high_level_percent_identity
  - id: high_level_query_coverage
    type:
      - 'null'
      - int
    doc: Threshold of sequence query coverage to report high-level taxonomy 
      matches
    default: 75
    inputBinding:
      position: 101
      prefix: --high_level_query_coverage
  - id: input
    type:
      - 'null'
      - File
    doc: Input file in FASTA format containing sequence records to classify
    default: otus.fasta
    inputBinding:
      position: 101
      prefix: --input
  - id: isolates
    type:
      - 'null'
      - File
    doc: FASTA formatted file of isolates to use BLAST against
    default: false
    inputBinding:
      position: 101
      prefix: --isolates
  - id: isolates_percent_identity
    type:
      - 'null'
      - float
    doc: Threshold of aligned sequence percent identity to report isolate 
      matches
    default: 1.0
    inputBinding:
      position: 101
      prefix: --isolates_percent_identity
  - id: isolates_query_coverage
    type:
      - 'null'
      - int
    doc: Threshold of sequence query coverage to report isolate matches
    default: 75
    inputBinding:
      position: 101
      prefix: --isolates_query_coverage
  - id: make_plot
    type:
      - 'null'
      - boolean
    doc: If specified, run R script to make plot of classified taxa
    default: false
    inputBinding:
      position: 101
      prefix: --make_plot
  - id: mem
    type:
      - 'null'
      - int
    doc: Memory available to use for RDP, in MB. 32000MB recommended for UNITE, 
      128000MB for SILVA
    default: 32000
    inputBinding:
      position: 101
      prefix: --mem
  - id: mhits
    type:
      - 'null'
      - int
    doc: Maximum number of BLAST hits to use, for use with -b option
    default: 10
    inputBinding:
      position: 101
      prefix: --mhits
  - id: msu_hpcc
    type:
      - 'null'
      - boolean
    doc: '**THIS ARGUMENT HAS BEEN DEPRECATED IN VERSION 2.0.19** If specified, use
      executable paths on Michigan State University HPCC. Overrides other path arguments'
    default: false
    inputBinding:
      position: 101
      prefix: --msu_hpcc
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel computing steps
    default: 1
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: p_iden
    type:
      - 'null'
      - float
    doc: Minimum proportion identity of BLAST hits to use, for use with -b 
      option
    default: 0.0
    inputBinding:
      position: 101
      prefix: --p_iden
  - id: pathfile
    type:
      - 'null'
      - File
    doc: File with paths to SINTAX, UTAX, RDP, and CONSTAX executables
    default: pathfile.txt
    inputBinding:
      position: 101
      prefix: --pathfile
  - id: rdp_path
    type:
      - 'null'
      - string
    doc: Path to RDP classifier.jar file
    default: false
    inputBinding:
      position: 101
      prefix: --rdp_path
  - id: select_by_keyword
    type:
      - 'null'
      - string
    doc: Takes a keyword argument and --input FASTA file to produce a filtered 
      database with headers containing the keyword with name --output
    default: false
    inputBinding:
      position: 101
      prefix: --select_by_keyword
  - id: sintax_path
    type:
      - 'null'
      - string
    doc: Path to USEARCH/VSEARCH executable for SINTAX classification
    default: false
    inputBinding:
      position: 101
      prefix: --sintax_path
  - id: tax
    type:
      - 'null'
      - Directory
    doc: Directory for taxonomy assignments
    default: ./taxonomy_assignments
    inputBinding:
      position: 101
      prefix: --tax
  - id: train
    type:
      - 'null'
      - boolean
    doc: Complete training if specified
    default: false
    inputBinding:
      position: 101
      prefix: --train
  - id: trainfile
    type:
      - 'null'
      - Directory
    doc: Path to which training files will be written
    default: ./training_files
    inputBinding:
      position: 101
      prefix: --trainfile
  - id: utax_path
    type:
      - 'null'
      - string
    doc: Path to USEARCH executable for UTAX classification
    default: false
    inputBinding:
      position: 101
      prefix: --utax_path
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory for classifications
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/constax:2.0.20--pyhdfd78af_0
