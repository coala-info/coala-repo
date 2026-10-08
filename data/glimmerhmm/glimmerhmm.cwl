cwlVersion: v1.2
class: CommandLineTool
baseCommand: glimmerhmm
label: glimmerhmm
doc: GlimmerHMM gene finder for eukaryotic genomes
inputs:
  - id: genome_file
    type: File
    doc: Genome file
    inputBinding:
      position: 1
  - id: training_dir
    type: Directory
    doc: Training directory for genome
    inputBinding:
      position: 2
  - id: protein_domain_file
    type:
      - 'null'
      - File
    doc: If protein domain searches are available, read them from file file_name
    inputBinding:
      position: 103
      prefix: -p
  - id: training_dir_option
    type:
      - 'null'
      - Directory
    doc: Training directory is specified by dir_name (introduced for 
      compatibility with earlier versions)
    inputBinding:
      position: 103
      prefix: -d
  - id: output_file
    type: string
    default: glimmerhmm_out.txt
    doc: Print output in file_name; if n>1 for top best predictions, output is 
      in file_name.1, file_name.2, ... , file_name.n
    inputBinding:
      position: 103
      prefix: -o
  - id: top_predictions
    type:
      - 'null'
      - int
    doc: Print top n best predictions
    inputBinding:
      position: 103
      prefix: -n
  - id: gff_format
    type:
      - 'null'
      - boolean
    doc: Print output in gff format
    inputBinding:
      position: 103
      prefix: -g
  - id: no_svm
    type:
      - 'null'
      - boolean
    doc: Don't use svm splice site predictions
    inputBinding:
      position: 103
      prefix: -v
  - id: no_partial_genes
    type:
      - 'null'
      - boolean
    doc: Don't make partial gene predictions
    inputBinding:
      position: 103
      prefix: -f
outputs:
  - id: output_output_file
    type: File[]
    doc: Print output in file_name; if n>1 for top best predictions, output is 
      in file_name.1, file_name.2, ... , file_name.n
    outputBinding:
      glob: $(inputs.output_file)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimmerhmm:3.0.4--pl5321h503566f_10
s:url: https://github.com/kblin/glimmerhmm
$namespaces:
  s: https://schema.org/
