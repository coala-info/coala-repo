cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmerfinder.py
label: kmerfinder_kmerfinder.py
doc: "Run KmerFinder on FASTA(.gz) or FASTQ(.gz) files to predict the species\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kmerfinder"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "FASTA(.gz) or FASTQ(.gz) file(s) to run KmerFinder on (one FASTA assembly, or two FASTQ files for paired reads)"
    inputBinding:
      position: 1
      prefix: "--infile"
  - id: batch_file
    type: ['null', File]
    doc: "OPTION NOT AVAILABLE: file with multiple files listed"
    inputBinding:
      position: 1
      prefix: "--batch_file"
  - id: output_folder_path
    type: ['null', string]
    default: "kmerfinder_out"
    doc: "Folder to store the output"
    inputBinding:
      position: 1
      prefix: "--output_folder"
  - id: db_path
    type: ['null', string]
    doc: "Path to database and database file: prefix of the KMA database files given in db_files"
    inputBinding:
      position: 1
      prefix: "--db_path"
  - id: db_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files of the KMA database (*.comp.b, *.length.b, *.name, *.seq.b, ...), staged in the working directory so that db_path can name them"
  - id: db_batch
    type: ['null', string]
    doc: "OPTION NOT AVAILABLE: file with paths to multiple databases"
    inputBinding:
      position: 1
      prefix: "--db_batch"
  - id: kma_arguments
    type: ['null', string]
    doc: "OPTION NOT AVAILABLE: extra arguments for KMA"
    inputBinding:
      position: 1
      prefix: "--kma_arguments"
  - id: tax
    type: ['null', File]
    doc: "Taxonomy file with additional data for each template in all databases (family, taxid and organism)"
    inputBinding:
      position: 1
      prefix: "--tax"
  - id: extended_output
    type: ['null', boolean]
    doc: "Give extended output with taxonomy information"
    inputBinding:
      position: 1
      prefix: "--extended_output"
  - id: kma_path
    type: ['null', string]
    doc: "Path to kma program"
    inputBinding:
      position: 1
      prefix: "--kma_path"
  - id: quiet
    type: ['null', boolean]
    doc: "Do not print progress"
    inputBinding:
      position: 1
      prefix: "--quiet"
outputs:
  - id: output_folder
    type: Directory
    doc: "Folder with the KmerFinder results (results.spa, results.res, results.txt with --tax, data.json)"
    outputBinding:
      glob: $(inputs.output_folder_path)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.db_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerfinder:3.0.2--hdfd78af_0
stdout: kmerfinder.out
