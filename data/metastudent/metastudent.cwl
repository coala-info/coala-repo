cwlVersion: v1.2
class: CommandLineTool
baseCommand: metastudent
label: metastudent
doc: "!!! Make sure your input fasta file contains at most 500 sequences !!!\n\nTool
  homepage: https://github.com/Rostlab/MetaStudent"
inputs:
  - id: all_predictions
    type:
      - 'null'
      - boolean
    doc: Include all predictions
    inputBinding:
      position: 101
      prefix: --all-predictions
  - id: blast_kickstart_databases
    type:
      - 'null'
      - type: array
        items: File
    doc: BLAST result files to use for kickstarting
    inputBinding:
      position: 101
      prefix: --blast-kickstart-databases
  - id: blast_only
    type:
      - 'null'
      - boolean
    doc: Run only BLAST analysis
    inputBinding:
      position: 101
      prefix: --blast-only
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug output
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: no_names
    type:
      - 'null'
      - boolean
    doc: Do not include names in output
    inputBinding:
      position: 101
      prefix: --no-names
  - id: ontologies
    type:
      - 'null'
      - type: array
        items: string
    doc: Ontologies to use (e.g., MFO, BPO, CCO, MFO,BPO)
    inputBinding:
      position: 101
      prefix: --ontologies
  - id: output_blast
    type:
      - 'null'
      - boolean
    doc: Output BLAST results
    inputBinding:
      position: 101
      prefix: --output-blast
  - id: result_file_prefix
    type: string
    doc: Output result file prefix
    inputBinding:
      position: 101
      prefix: -o
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Suppress output messages
    inputBinding:
      position: 101
      prefix: --silent
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files
    inputBinding:
      position: 101
      prefix: --temp-dir
  - id: with_images
    type:
      - 'null'
      - boolean
    doc: Include images in output
    inputBinding:
      position: 101
      prefix: --with-images
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metastudent:v2.0.1-6-deb_cv1
stdout: metastudent.out
