cwlVersion: v1.2
class: CommandLineTool
baseCommand: covid-spike-classification
label: covid-spike-classification
doc: "Classify COVID spike protein sequences.\n\nTool homepage: https://github.com/kblin/covid-spike-classification/"
inputs:
  - id: reads
    type: File
    doc: A zip file or directory containing the ab1 files to call variants on.
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Debug mode: Keep bam file around when the parsing crashes'
    inputBinding:
      position: 102
      prefix: --debug
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Select which input format to expect. Choices: ab1, fasta, fastq.'
    default: ab1
    inputBinding:
      position: 102
      prefix: --input-format
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress noisy output from the tools run
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference FASTA file to use
    default: /ref/NC_045512.fasta
    inputBinding:
      position: 102
      prefix: --reference
  - id: show_unexpected
    type:
      - 'null'
      - boolean
    doc: Show unexpected mutations instead of reporting 'no known mutation'
    inputBinding:
      position: 102
      prefix: --show-unexpected
  - id: silence_warnings
    type:
      - 'null'
      - boolean
    doc: Silence D614G warnings.
    inputBinding:
      position: 102
      prefix: --silence-warnings
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Print results to stdout in addition to writing them to disk
    inputBinding:
      position: 102
      prefix: --stdout
  - id: zip_results
    type:
      - 'null'
      - boolean
    doc: Create a zipfile from the output directory instead of the output 
      directory.
    inputBinding:
      position: 102
      prefix: --zip-results
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: File to write result CSV and fastq files to
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/covid-spike-classification:0.6.4--pyhdfd78af_0
