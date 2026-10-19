cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - depot
  - import_reads
label: ra_depot_import_reads
doc: "Imports reads (FASTA, FASTQ or AFG) into a depot directory, which is created\
  \ if missing.\n\nTool homepage: https://github.com/mariokostelac/ra"
inputs:
  - id: depot
    type: string
    doc: depot path (directory name to create or fill)
    inputBinding:
      position: 102
      prefix: --depot
  - id: reads
    type: File
    doc: reads file
    inputBinding:
      position: 102
      prefix: --reads
  - id: reads_format
    type:
      - 'null'
      - string
    doc: 'reads format; supported: fasta, fastq, afg (default fasta)'
    inputBinding:
      position: 102
      prefix: --reads_format
outputs:
  - id: depot_out
    type: Directory
    doc: Depot directory with the imported reads
    outputBinding:
      glob: $(inputs.depot)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra:0.9--h503566f_8
