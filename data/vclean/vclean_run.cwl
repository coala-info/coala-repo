cwlVersion: v1.2
class: CommandLineTool
baseCommand: vclean
label: vclean_run
doc: "Run vClean\n\nTool homepage: https://github.com/TsumaR/vclean"
inputs:
  - id: input
    type: Directory
    doc: Put the input fasta directory
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - Directory
    doc: Set the database directory path. By default the VCLEANDB environment 
      vairable is used
    inputBinding:
      position: 102
      prefix: --db
  - id: f_table
    type:
      - 'null'
      - File
    doc: You want to only run lgb model, you have to input the features table 
      path.
    inputBinding:
      position: 102
      prefix: --f_table
  - id: mode
    type:
      - 'null'
      - boolean
    doc: True or False. If you want to calculate contamination value of 
      simulation data, set this value True
    inputBinding:
      position: 102
      prefix: --mode
  - id: nucleotide
    type:
      - 'null'
      - File
    inputBinding:
      position: 102
      prefix: --nucleotide
  - id: protein
    type:
      - 'null'
      - File
    doc: Not nessesary. you can input protein fasta file if you have. In 
      default, vDeteCon predict CDS using prodigal from nucleotide fasta file.
    inputBinding:
      position: 102
      prefix: --protein
  - id: skip_feature_table
    type:
      - 'null'
      - boolean
    doc: If you set True, skip features prediction step.
    inputBinding:
      position: 102
      prefix: --skip_feature_table
  - id: skip_lgb_step
    type:
      - 'null'
      - boolean
    doc: If you set True, skip contamination prediction step.
    inputBinding:
      position: 102
      prefix: --skip_lgb_step
  - id: threads
    type:
      - 'null'
      - int
    doc: Put the number of CPU to use.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: Put the threshold for the Contamination probability rate value. 
      default=0.6. if the contamination probability value is over the set score,
      the input fasta are assigned as CONTAMINATION.
    default: 0.6
    inputBinding:
      position: 102
      prefix: --threshold
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: Set the path of temporary file directory
    inputBinding:
      position: 102
      prefix: -tmp
  - id: translate_table
    type:
      - 'null'
      - int
    doc: put the translate table
    default: 11
    inputBinding:
      position: 102
      prefix: --translate_table
outputs:
  - id: output
    type: Directory
    doc: Put the output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vclean:0.2.1--pyhdfd78af_0
