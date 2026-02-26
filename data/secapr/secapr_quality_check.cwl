cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - secapr
  - quality_check
label: secapr_quality_check
doc: "This script runs a fastqc test on all fastq samples in a user-provided folder
  and creates an overview plot\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of computational cores for parallelization of computation.
    inputBinding:
      position: 101
      prefix: --cores
  - id: input
    type: Directory
    doc: The directory containing fastq files
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type: Directory
    doc: The output directory where quality-test results will be saved
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
