cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar medusa.jar
label: medusa
doc: "Medusa version 1.6\n\nTool homepage: https://github.com/combogenomics/medusa"
inputs:
  - id: distance_estimation
    type:
      - 'null'
      - boolean
    doc: 'allows for the estimation of the distance between pairs of contigs based
      on the reference genome(s): in this case the scaffolded contigs will be separated
      by a number of N characters equal to this estimate. The estimated distances
      are also saved in the <targetGenome>_distanceTable file. By default the scaffolded
      contigs are separated by 100 Ns'
    inputBinding:
      position: 101
      prefix: -d
  - id: drafts_folder
    type:
      - 'null'
      - Directory
    doc: indicates the path to the comparison drafts folder
    inputBinding:
      position: 101
      prefix: -f
  - id: gexf_format
    type:
      - 'null'
      - boolean
    doc: Conting network and path cover are given in gexf format.
    inputBinding:
      position: 101
      prefix: -gexf
  - id: medusa_scripts_folder
    type:
      - 'null'
      - Directory
    doc: The folder containing the medusa scripts.
    inputBinding:
      position: 101
      prefix: -scriptPath
  - id: n50_fasta_file
    type:
      - 'null'
      - File
    doc: 'allows the calculation of the N50 statistic on a FASTA file. In this case
      the usage is the following: java -jar medusa.jar -n50 <name_of_the_fasta>. All
      the other options will be ignored.'
    inputBinding:
      position: 101
      prefix: -n50
  - id: output_name
    type:
      - 'null'
      - string
    doc: indicates the name of output fasta file.
    inputBinding:
      position: 101
      prefix: -o
  - id: random_rounds
    type:
      - 'null'
      - int
    doc: allows the user to run a given number of cleaning rounds and keep the 
      best solution. Since the variability is small 5 rounds are usually 
      sufficient to find the best score.
    inputBinding:
      position: 101
      prefix: -random
  - id: target_genome
    type: File
    doc: indicates the name of the target genome file.
    inputBinding:
      position: 101
      prefix: -i
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print on console the information given by the package MUMmer. This 
      option is strongly suggested to understand if MUMmer is not running 
      properly.
    inputBinding:
      position: 101
      prefix: -v
  - id: weighting_scheme_w2
    type:
      - 'null'
      - boolean
    doc: is optional and allows for a sequence similarity based weighting 
      scheme. Using a different weighting scheme may lead to better results.
    inputBinding:
      position: 101
      prefix: -w2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/medusa:1.6--1
stdout: medusa.out
