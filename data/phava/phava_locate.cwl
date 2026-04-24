cwlVersion: v1.2
class: CommandLineTool
baseCommand: phava_locate
label: phava_locate
doc: "Directory where data and output are stored *** USE THE SAME WORK DIRECTORY FOR
  ALL PHAVA OPERATIONS ***\n\nTool homepage: https://github.com/patrickwest/PhaVa"
inputs:
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: directory
    type: Directory
    doc: Directory where data and output are stored *** USE THE SAME WORK 
      DIRECTORY FOR ALL PHAVA OPERATIONS ***
    inputBinding:
      position: 101
      prefix: --dir
  - id: fasta
    type:
      - 'null'
      - File
    doc: Name of input assembly file to be searched
    inputBinding:
      position: 101
      prefix: --fasta
  - id: log
    type:
      - 'null'
      - boolean
    doc: Should the logging info be output to stdout? Otherwise, it will be 
      written to 'PhaVa.log'
    inputBinding:
      position: 101
      prefix: --log
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
stdout: phava_locate.out
