cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiver_init.sh
label: shiver_shiver_init.sh
doc: "Initialises shiver files.\n\nTool homepage: https://github.com/ChrisHIV/shiver"
inputs:
  - id: output_directory
    type: string
    doc: an output directory for the initialisation files.
    inputBinding:
      position: 1
  - id: configuration_file
    type: File
    doc: the configuration file, containing all your parameter choices etc.
    inputBinding:
      position: 2
  - id: alignment_of_references
    type: File
    doc: your chosen alignment of references
    inputBinding:
      position: 3
  - id: adapters_fasta
    type: File
    doc: a fasta file of the adapters used in sequencing
    inputBinding:
      position: 4
  - id: primers_fasta
    type: File
    doc: a fasta file of the primers used in sequencing
    inputBinding:
      position: 5
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory_dir
    type:
      - 'null'
      - Directory
    doc: an output directory for the initialisation files.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiver:1.7.3--hdfd78af_0
stdout: shiver_shiver_init.sh.out
