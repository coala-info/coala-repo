cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnqc
  - infersexe
label: hmnqc_infersexe
doc: "Infer sex based on coverage of autosomes and sex chromosomes from BAM files.\n\
  \nTool homepage: https://github.com/guillaume-gricourt/HmnQc"
inputs:
  - id: input_sample_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Bam files
    inputBinding:
      position: 101
      prefix: --input-sample-bam
  - id: input_sample_bed
    type: File
    doc: Bed File
    inputBinding:
      position: 101
      prefix: --input-sample-bed
  - id: parameter_simple
    type:
      - 'null'
      - boolean
    doc: Mean coverage for ChrAutosome, ChrX and ChrY are shown by default
    inputBinding:
      position: 101
      prefix: --parameter-simple
  - id: parameter_threads
    type:
      - 'null'
      - int
    doc: Threads
    inputBinding:
      position: 101
      prefix: --parameter-threads
  - id: parameter_verification
    type:
      - 'null'
      - boolean
    doc: If sexe can be guess with name sample, it will be checked again 
      coverage
    inputBinding:
      position: 101
      prefix: --parameter-verification
outputs:
  - id: output_hmnqc_xlsx
    type: File
    doc: Excel output
    outputBinding:
      glob: $(inputs.output_hmnqc_xlsx)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnqc:0.5.1--pyhdfd78af_0
