cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2-pipeline
label: hisat2-pipeline
doc: "A pipeline for processing RNA-Seq data with HISAT2 and Stringtie.\n\nTool homepage:
  https://github.com/mcamagna/HISAT2-pipeline"
inputs:
  - id: genome_folder
    type:
      - 'null'
      - Directory
    doc: The folder where the genome fasta and gff file is located
    inputBinding:
      position: 101
      prefix: --genome_folder
  - id: hisat_options
    type:
      - 'null'
      - string
    doc: May be used to pass additional options to HISAT2. Provided parameters 
      must be surrounded by quotation marks, e.g. --hisat_options 
      "--very-sensitive --no-spliced-alignment"
    inputBinding:
      position: 101
      prefix: --hisat_options
  - id: reads_folder
    type:
      - 'null'
      - Directory
    doc: The folder where the reads are located
    inputBinding:
      position: 101
      prefix: --reads_folder
  - id: skip_mapping
    type:
      - 'null'
      - boolean
    doc: Skip mapping to genome
    inputBinding:
      position: 101
      prefix: --skip_mapping
  - id: stringtie_options
    type:
      - 'null'
      - string
    doc: May be used to pass additional options to Stringtie. Provided 
      parameters must be surrounded by quotation marks, e.g. --stringtie_options
      "-m 150 -t"
    inputBinding:
      position: 101
      prefix: --stringtie_options
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads used
    inputBinding:
      position: 101
      prefix: --threads
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Answer all questions with 'yes'
    inputBinding:
      position: 101
      prefix: --yes
outputs:
  - id: outfolder
    type:
      - 'null'
      - Directory
    doc: The folder where the results will be written to
    outputBinding:
      glob: $(inputs.outfolder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2-pipeline:1.1.1--pyhdfd78af_0
