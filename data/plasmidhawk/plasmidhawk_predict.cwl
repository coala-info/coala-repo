cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidhawk_predict
label: plasmidhawk_predict
doc: "Choose prediction mode (max, supermax, correct), default max. supermax is max
  mode, but output top 50 labs\n\nTool homepage: https://gitlab.com/treangenlab/plasmidhawk"
inputs:
  - id: prediction_mode
    type: string
    doc: Choose prediction mode (max, supermax, correct), default max. supermax 
      is max mode, but output top 50 labs
    inputBinding:
      position: 1
  - id: input_pangenome_fasta
    type: File
    doc: input pan-genome fasta file
    inputBinding:
      position: 2
  - id: input_pangenome_annotated_meta
    type: File
    doc: Lab ownership metadata file
    inputBinding:
      position: 3
  - id: input_files
    type:
      type: array
      items: File
    doc: a list of input fasta file names. If there is one file and it ends with
      a non-fasta suffix it is assumed that this file contains a list of input 
      files separated by a newline
    inputBinding:
      position: 4
  - id: identity
    type:
      - 'null'
      - int
    doc: Minimum alignment identity [0,100]
    inputBinding:
      position: 105
      prefix: --identity
  - id: skip
    type:
      - 'null'
      - boolean
    doc: Use nucmer results already present in work-dir instead of rerunning
    inputBinding:
      position: 105
      prefix: --skip
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 105
      prefix: --thread
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output
    inputBinding:
      position: 105
      prefix: --verbose
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: output lab-of-origin prediction
    inputBinding:
      position: 105
      prefix: --work-dir
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output lab-of-origin prediction
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidhawk:1.0.3--hdfd78af_0
