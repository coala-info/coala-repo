cwlVersion: v1.2
class: CommandLineTool
baseCommand: GenFSGopher.pl
label: uscdc-datasets-sars-cov-2_GenFSGopher.pl
doc: "Reads a standard dataset spreadsheet and downloads its data\n\nTool homepage:
  https://github.com/CDCgov/datasets-sars-cov-2"
inputs:
  - id: spreadsheet_dataset_tsv
    type: File
    doc: The input dataset spreadsheet file
    inputBinding:
      position: 1
  - id: citation
    type:
      - 'null'
      - boolean
    doc: Print the recommended citation for this script and exit
    inputBinding:
      position: 102
      prefix: --citation
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: Compress files in the output directory
    inputBinding:
      position: 102
      prefix: --compressed
  - id: format
    type:
      - 'null'
      - string
    doc: 'The input format. Default: tsv. No other format is accepted at this time.'
    inputBinding:
      position: 102
      prefix: --format
  - id: layout
    type:
      - 'null'
      - string
    doc: 'Layout for organizing output files. Options: onedir, hashsums, byrun, byformat,
      cfsan.'
    inputBinding:
      position: 102
      prefix: --layout
  - id: norun
    type:
      - 'null'
      - boolean
    doc: Do not run anything; just create a Makefile.
    inputBinding:
      position: 102
      prefix: --norun
  - id: numcpus
    type:
      - 'null'
      - int
    doc: How many jobs to run at once. Be careful of disk I/O.
    inputBinding:
      position: 102
      prefix: --numcpus
  - id: output_directory
    type: Directory
    doc: The output directory
    inputBinding:
      position: 102
      prefix: --outdir
  - id: shuffled
    type:
      - 'null'
      - boolean
    doc: Output the reads as interleaved instead of individual forward and 
      reverse files.
    inputBinding:
      position: 102
      prefix: --shuffled
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Choose a different temp directory than the system default
    inputBinding:
      position: 102
      prefix: --tempdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/uscdc-datasets-sars-cov-2:0.7.2--hdfd78af_0
stdout: uscdc-datasets-sars-cov-2_GenFSGopher.pl.out
