cwlVersion: v1.2
class: CommandLineTool
baseCommand: PROG
label: salty
doc: "SALTy: A tool for rapid and accurate lineage assignment of bacterial genomes.\n\
  \nTool homepage: https://github.com/LanLab/salty"
inputs:
  - id: check
    type:
      - 'null'
      - boolean
    doc: check dependencies are installed
    inputBinding:
      position: 101
      prefix: --check
  - id: csv_format
    type:
      - 'null'
      - boolean
    doc: Output file in csv format.
    inputBinding:
      position: 101
      prefix: --csv_format
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwite existing output folder.
    inputBinding:
      position: 101
      prefix: --force
  - id: input_folder
    type:
      - 'null'
      - Directory
    doc: Folder of genomes (*.fasta or *.fna) and/or pair end reads (each 
      accession must have *_1.fastq.qz and *_2.fastq.
    inputBinding:
      position: 101
      prefix: --input_folder
  - id: kma_index
    type:
      - 'null'
      - File
    doc: Path to indexed KMA database.
    inputBinding:
      position: 101
      prefix: --kma_index
  - id: lineages
    type:
      - 'null'
      - File
    doc: Path to specific alleles for each lineage.
    inputBinding:
      position: 101
      prefix: --lineages
  - id: mlst_prediction
    type:
      - 'null'
      - boolean
    doc: Explained in ReadMe. Used as backup when lineage is unable to be called
      through SaLTy screening. Marked with *.
    inputBinding:
      position: 101
      prefix: --mlstPrediction
  - id: report
    type:
      - 'null'
      - boolean
    doc: Only generate summary report from previous SALTy outputs.
    inputBinding:
      position: 101
      prefix: --report
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Concatenate all output assignments into single file.
    inputBinding:
      position: 101
      prefix: --summary
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (speeds up parsing raw reads).
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output Folder to save result.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/salty:1.0.6--pyhdfd78af_0
