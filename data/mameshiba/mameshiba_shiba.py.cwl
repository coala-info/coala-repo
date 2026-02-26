cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiba.py
label: mameshiba_shiba.py
doc: "Shiba v0.8.1 - Pipeline for identification of differential RNA splicing\n\n\
  Tool homepage: https://github.com/Sika-Zheng-Lab/Shiba"
inputs:
  - id: config
    type: File
    doc: Config file in yaml format
    inputBinding:
      position: 1
  - id: mame
    type:
      - 'null'
      - boolean
    doc: Execute MameShiba, a lightweight version of Shiba, for only splicing 
      analysis. Steps 5-7 will be skipped.
    inputBinding:
      position: 102
      prefix: --mame
  - id: processors
    type:
      - 'null'
      - int
    doc: Number of processors to use
    default: 1
    inputBinding:
      position: 102
      prefix: --process
  - id: start_step
    type:
      - 'null'
      - int
    doc: 'Start the pipeline from the specified step (default: 0, run all steps)'
    default: 0
    inputBinding:
      position: 102
      prefix: --start-step
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mameshiba:0.8.1--hdfd78af_1
stdout: mameshiba_shiba.py.out
