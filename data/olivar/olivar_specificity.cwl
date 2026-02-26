cwlVersion: v1.2
class: CommandLineTool
baseCommand: olivar_specificity
label: olivar_specificity
doc: "Calculate primer specificity using BLAST.\n\nTool homepage: https://gitlab.com/treangenlab/olivar"
inputs:
  - id: csv_file
    type: File
    doc: 'Path to the csv file of a primer pool. Required columns: "amplicon_id" (amplicon
      name), "fP" (sequence of forward primer), "rP" (sequence of reverse primer).'
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - string
    doc: Optional, path to the BLAST database. Note that this path should end 
      with the name of the BLAST database (e.g., 
      "example_input/Human/GRCh38_primary").
    inputBinding:
      position: 102
      prefix: --db
  - id: max_amp_len
    type:
      - 'null'
      - int
    doc: Maximum length of predicted non-specific amplicon. Ignored is no BLAST 
      database is provided.
    default: 1500
    inputBinding:
      position: 102
      prefix: --max-amp-len
  - id: pool
    type:
      - 'null'
      - int
    doc: Primer pool number
    default: 1
    inputBinding:
      position: 102
      prefix: --pool
  - id: temperature
    type:
      - 'null'
      - float
    doc: PCR annealing temperature
    default: 60.0
    inputBinding:
      position: 102
      prefix: --temperature
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: title
    type:
      - 'null'
      - string
    doc: Name of validation
    default: olivar-specificity
    inputBinding:
      position: 102
      prefix: --title
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output path (output to current directory by default).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
