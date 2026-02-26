cwlVersion: v1.2
class: CommandLineTool
baseCommand: MHG
label: mhg_MHG
doc: "Make blastn database & Build blastn queries\n\nTool homepage: https://github.com/NakhlehLab/Maximal-Homologous-Groups"
inputs:
  - id: blast
    type:
      - 'null'
      - Directory
    doc: Blastn bin directory; try to call 'makeblastdb, blastn' straightly if 
      no path is inputted by default(if blast folder is added as an environemnt 
      variable
    inputBinding:
      position: 101
      prefix: --blast
  - id: database
    type:
      - 'null'
      - Directory
    doc: Directory to store blast nucleotide databases for each sequence in 
      genome directory. By default write to current folder 'blastn_db'
    default: blastn_db
    inputBinding:
      position: 101
      prefix: --database
  - id: gapextend
    type:
      - 'null'
      - int
    doc: Blastn gap extend penalty, default 2
    default: 2
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: Blastn gap open penalty, default 5
    default: 5
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: genome
    type: Directory
    doc: Genome nucleotide sequence directory (Required)
    inputBinding:
      position: 101
      prefix: --genome
  - id: query
    type:
      - 'null'
      - Directory
    doc: Output folder storing all blastn queries in xml format. By defualt 
      write to current folder 'blastn_against_bank'
    default: blastn_against_bank
    inputBinding:
      position: 101
      prefix: --query
  - id: thread
    type:
      - 'null'
      - int
    doc: Blastn thread number, default 1
    default: 1
    inputBinding:
      position: 101
      prefix: --thread
  - id: threshold
    type:
      - 'null'
      - float
    doc: Bitscore threshold for determining true homology
    inputBinding:
      position: 101
      prefix: --threshold
  - id: word_size
    type:
      - 'null'
      - int
    doc: Blastn word size, default 28
    default: 28
    inputBinding:
      position: 101
      prefix: --word_size
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File containing the final partitioned MHGs, each line represents a MHG 
      containing different blocks
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhg:1.1.0--hdfd78af_0
