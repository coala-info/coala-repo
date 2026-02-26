cwlVersion: v1.2
class: CommandLineTool
baseCommand: BuildDatabase
label: repeatmodeler_BuildDatabase
doc: "Format FASTA files for use with RepeatModeler\n\nTool homepage: https://www.repeatmasker.org/RepeatModeler"
inputs:
  - id: seqfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Sequence files in fasta format
    inputBinding:
      position: 1
  - id: batch_file
    type:
      - 'null'
      - File
    doc: The name of a file which contains the names of fasta files to process. 
      The files names are listed one per line and should be fully qualified.
    inputBinding:
      position: 102
      prefix: -batch
  - id: database_name
    type: string
    doc: The name of the database to create.
    inputBinding:
      position: 102
      prefix: -name
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: The name of a directory containing fasta files to be processed. The 
      files are recognized by their suffix. Only *.fa and *.fasta files are 
      processed.
    inputBinding:
      position: 102
      prefix: -dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatmodeler:2.0.7--pl5321hdfd78af_0
stdout: repeatmodeler_BuildDatabase.out
