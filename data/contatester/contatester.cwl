cwlVersion: v1.2
class: CommandLineTool
baseCommand: contatester
label: contatester
doc: "Wrapper for the detection and determination of the presence of cross contaminant\n\
  \nTool homepage: https://github.com/CNRGH/contatester"
inputs:
  - id: accounting
    type:
      - 'null'
      - string
    doc: msub option for calculation time imputation
    inputBinding:
      position: 101
      prefix: --accounting
  - id: check
    type:
      - 'null'
      - boolean
    doc: enable contaminant check for each VCF provided if a VCF is marked as 
      contaminated
    inputBinding:
      position: 101
      prefix: --check
  - id: dagname
    type:
      - 'null'
      - string
    doc: DAG file name for pegasus
    inputBinding:
      position: 101
      prefix: --dagname
  - id: experiment
    type:
      - 'null'
      - string
    doc: Experiment type, could be WG for Whole Genome or EX for Exome
    default: WG
    inputBinding:
      position: 101
      prefix: --experiment
  - id: file
    type: File
    doc: VCF file version 4.2 to process. If -f is used don't use -l (Mandatory)
    inputBinding:
      position: 101
      prefix: --file
  - id: list
    type: File
    doc: input text file, one vcf by lane. If -l is used don't use -f 
      (Mandatory)
    inputBinding:
      position: 101
      prefix: --list
  - id: mail
    type:
      - 'null'
      - string
    doc: send an email at the end of the job
    inputBinding:
      position: 101
      prefix: --mail
  - id: report
    type:
      - 'null'
      - boolean
    doc: create a pdf report for contamination estimation
    default: no report
    inputBinding:
      position: 101
      prefix: --report
  - id: thread
    type:
      - 'null'
      - int
    doc: number of threads used by job(optional)
    default: 4|1
    inputBinding:
      position: 101
      prefix: --thread
  - id: threshold
    type:
      - 'null'
      - int
    doc: Threshold for contaminated status(optional)
    default: 4
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: folder for storing all output files (optional)
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contatester:1.0.0--py311r44he3b539c_4
