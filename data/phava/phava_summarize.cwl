cwlVersion: v1.2
class: CommandLineTool
baseCommand: phava summarize
label: phava_summarize
doc: "Directory where data and output are stored\n\nTool homepage: https://github.com/patrickwest/PhaVa"
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
  - id: log_to_stdout
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
stdout: phava_summarize.out
