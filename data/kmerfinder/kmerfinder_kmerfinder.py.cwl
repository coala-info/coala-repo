cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmerfinder.py
label: kmerfinder_kmerfinder.py
doc: "Run KmerFinder on FASTA(.gz) or FASTQ(.gz) files.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kmerfinder"
inputs:
  - id: batch_file
    type:
      - 'null'
      - File
    doc: OPTION NOT AVAILABLE:file with multipe files listed
    inputBinding:
      position: 101
      prefix: --batch_file
  - id: db_batch
    type:
      - 'null'
      - string
    doc: "OPTION NOT AVAILABLE:file with paths to multiple\n                     \
      \   databases"
    inputBinding:
      position: 101
      prefix: --db_batch
  - id: db_path
    type:
      - 'null'
      - string
    doc: path to database and database file
    inputBinding:
      position: 101
      prefix: --db_path
  - id: extended_output
    type:
      - 'null'
      - boolean
    doc: Give extented output with taxonomy information
    inputBinding:
      position: 101
      prefix: --extended_output
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA(.gz) or FASTQ(.gz) file(s) to run KmerFinder on.
    inputBinding:
      position: 101
      prefix: --infile
  - id: kma_arguments
    type:
      - 'null'
      - string
    doc: OPTION NOT AVAILABLE:Extra arguments for KMA
    inputBinding:
      position: 101
      prefix: --kma_arguments
  - id: kma_path
    type:
      - 'null'
      - string
    doc: Path to kma program
    inputBinding:
      position: 101
      prefix: --kma_path
  - id: quiet
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tax
    type:
      - 'null'
      - File
    doc: "taxonomy file with additional data for each template\n                 \
      \       in all databases (family, taxid and organism)"
    inputBinding:
      position: 101
      prefix: --tax
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: folder to store the output
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerfinder:3.0.2--hdfd78af_0
