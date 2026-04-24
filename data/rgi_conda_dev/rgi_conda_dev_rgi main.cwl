cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgi
label: rgi_conda_dev_rgi main
doc: "Resistance Gene Identifier - Version 3.1.2\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: alignment_tool
    type:
      - 'null'
      - string
    doc: choose between BLAST and DIAMOND. Options are BLAST or DIAMOND
    inputBinding:
      position: 101
      prefix: --alignment_tool
  - id: clean
    type:
      - 'null'
      - string
    doc: This removes temporary files in the results directory after run. 
      Options are NO or YES
    inputBinding:
      position: 101
      prefix: --clean
  - id: data
    type:
      - 'null'
      - string
    doc: Specify a data-type, i.e. wgs, chromosome, plasmid, etc.
    inputBinding:
      position: 101
      prefix: --data
  - id: data_version
    type:
      - 'null'
      - boolean
    doc: Prints data version number
    inputBinding:
      position: 101
      prefix: --data_version
  - id: db
    type:
      - 'null'
      - string
    doc: specify path to CARD blast databases
    inputBinding:
      position: 101
      prefix: --db
  - id: input_sequence
    type:
      - 'null'
      - File
    doc: input file must be in either FASTA (contig and protein), FASTQ(read) or
      gzip format! e.g myFile.fasta, myFasta.fasta.gz
    inputBinding:
      position: 101
      prefix: --input_sequence
  - id: input_type
    type:
      - 'null'
      - string
    doc: must be one of contig, orf, protein, read
    inputBinding:
      position: 101
      prefix: --input_type
  - id: loose_criteria
    type:
      - 'null'
      - string
    doc: The options are YES to include loose hits and NO to exclude loose hits.
    inputBinding:
      position: 101
      prefix: --loose_criteria
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads (CPUs) to use in the BLAST search
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: software_version
    type:
      - 'null'
      - boolean
    doc: Prints software number
    inputBinding:
      position: 101
      prefix: --software_version
  - id: verbose
    type:
      - 'null'
      - string
    doc: log progress to file. Options are OFF or ON
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output JSON file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi_conda_dev:3.1.2--py27_1
