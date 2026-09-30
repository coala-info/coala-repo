cwlVersion: v1.2
class: CommandLineTool
baseCommand: extracthifi
label: extracthifi
doc: "extract HiFi reads (>= Q20) from full CCS reads.bam output\n\nTool homepage:
  https://github.com/PacificBiosciences/extracthifi"
inputs:
  - id: input_bam
    type: File
    doc: Input CCS BAM.
    inputBinding:
      position: 1
  - id: output_bam
    type: string
    doc: Ouput HiFi BAM.
    inputBinding:
      position: 2
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 102
      prefix: --num-threads
outputs:
  - id: out_output_bam
    type: File
    doc: Ouput HiFi BAM.
    outputBinding:
      glob: '$(inputs.output_bam)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extracthifi:1.0.0--h9ee0642_1
