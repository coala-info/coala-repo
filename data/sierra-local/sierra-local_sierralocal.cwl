cwlVersion: v1.2
class: CommandLineTool
baseCommand: sierralocal
label: sierra-local_sierralocal
doc: "Local execution of Stanford HIVdb algorithm for mutation-based resistance scoring
  of sequences.\n\nTool homepage: https://github.com/PoonLab/sierra-local"
inputs:
  - id: fasta
    type:
      type: array
      items: File
    doc: List of input files.
    inputBinding:
      position: 1
  - id: alignment
    type:
      - 'null'
      - string
    doc: Alignment program to use, "post" for post align and "nuc" for nucamino
    inputBinding:
      position: 102
      prefix: -alignment
  - id: apobec_csv
    type:
      - 'null'
      - File
    doc: Path to CSV APOBEC csv file
    inputBinding:
      position: 102
      prefix: -apobec_csv
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Deletes NucAmino alignment file after processing.
    inputBinding:
      position: 102
      prefix: --cleanup
  - id: forceupdate
    type:
      - 'null'
      - boolean
    doc: Forces update of HIVdb algorithm. Requires network connection.
    inputBinding:
      position: 102
      prefix: --forceupdate
  - id: json
    type:
      - 'null'
      - File
    doc: Path to JSON HIVdb APOBEC DRM file
    inputBinding:
      position: 102
      prefix: -json
  - id: mutation_csv
    type:
      - 'null'
      - File
    doc: Path to CSV file to determine mutation type
    inputBinding:
      position: 102
      prefix: -mutation_csv
  - id: sdrms_csv
    type:
      - 'null'
      - File
    doc: Path to CSV file to determine SDRM mutations
    inputBinding:
      position: 102
      prefix: -sdrms_csv
  - id: unusual_csv
    type:
      - 'null'
      - File
    doc: Path to CSV file to determine if is unusual
    inputBinding:
      position: 102
      prefix: -unusual_csv
  - id: updater_outdir
    type:
      - 'null'
      - Directory
    doc: Path to folder to store updated files from updater
    inputBinding:
      position: 102
      prefix: -updater_outdir
  - id: xml
    type:
      - 'null'
      - File
    doc: Path to HIVdb ASI2 XML file
    inputBinding:
      position: 102
      prefix: -xml
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output filename.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sierra-local:0.4.3--py310hdfd78af_0
