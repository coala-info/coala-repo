cwlVersion: v1.2
class: CommandLineTool
baseCommand: extracthifi
label: pbtk_extracthifi
doc: "extract HiFi reads (>= Q20) from full CCS reads.bam output\n\nTool homepage:
  https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: input_bam
    type: File
    doc: Input CCS BAM.
    inputBinding:
      position: 1
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    default: 0
    inputBinding:
      position: 102
      prefix: --num-threads
outputs:
  - id: output_bam
    type: File
    doc: Ouput HiFi BAM.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
