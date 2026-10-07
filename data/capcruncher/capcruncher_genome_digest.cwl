cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - genome
  - digest
label: capcruncher_genome_digest
doc: "Performs in silico digestion of a genome in fasta format. Digests the supplied genome fasta file and generates a bed file containing the locations of all restriction fragments produced by the supplied restriction enzyme. A log file recording the number of restriction fragments is also generated.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: input_fasta
    type: File
    doc: "Genome FASTA file"
    inputBinding:
      position: 1
  - id: recognition_site
    type: string
    doc: "Recognition enzyme or sequence"
    inputBinding:
      position: 2
      prefix: -r
  - id: logfile
    type: string
    default: genome_digest.log
    doc: "Path for digestion log file"
    inputBinding:
      position: 2
      prefix: -l
  - id: output_file
    type: string
    default: genome_digested.bed
    doc: "Output file path"
    inputBinding:
      position: 2
      prefix: -o
  - id: remove_cutsite
    type:
      - 'null'
      - string
    doc: "Exclude the recognition sequence from the output (True or False)"
    inputBinding:
      position: 2
      prefix: --remove_cutsite
  - id: sort
    type:
      - 'null'
      - boolean
    doc: "Sorts the output bed file by chromosome and start coord."
    inputBinding:
      position: 2
      prefix: --sort
outputs:
  - id: digested_bed
    type: File
    doc: "Bed file of restriction fragments"
    outputBinding:
      glob: $(inputs.output_file)
  - id: log
    type: File
    doc: "Digestion log"
    outputBinding:
      glob: $(inputs.logfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
