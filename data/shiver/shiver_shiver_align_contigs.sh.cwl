cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiver_shiver_align_contigs.sh
label: shiver_shiver_align_contigs.sh
doc: "Aligns contigs to references based on blast hits. In normal usage this script
  requires 4 arguments: the initialisation directory, the configuration file, a fasta
  file of contigs, and a sample ID for naming output. Alternatively, it can be called
  with '--test' and a configuration file to test the configuration.\n\nTool homepage:
  https://github.com/ChrisHIV/shiver"
inputs:
  - id: initialisation_directory
    type: Directory
    doc: The initialisation directory created using the shiver_init.sh command.
    inputBinding:
      position: 1
  - id: configuration_file
    type: File
    doc: The configuration file, containing all parameter choices.
    inputBinding:
      position: 2
  - id: contigs_fasta
    type: File
    doc: A fasta file of contigs (output from processing the short reads with an
      assembly program).
    inputBinding:
      position: 3
  - id: sample_id
    type: string
    doc: A sample ID ('SID') used for naming the output from this script.
    inputBinding:
      position: 4
  - id: test_config
    type:
      - 'null'
      - boolean
    doc: Test whether the configuration file is OK and exit.
    inputBinding:
      position: 105
      prefix: --test
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiver:1.7.3--hdfd78af_0
stdout: shiver_shiver_align_contigs.sh.out
