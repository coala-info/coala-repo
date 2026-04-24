cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cirtap
  - index
label: cirtap_index
doc: "Create an index of contents for all directories\n\n  This can be useful for
  generating valid paths before gathering inputs. The\n  output_index is a tab-separated
  file with each column representing the files\n  that are expected to be found for
  a genome that has full information\n  available from both PATRIC and RefSeq. If
  any of the files is missing the\n  value is 0.\n\nTool homepage: https://github.com/MGXlab/cirtap/"
inputs:
  - id: genomes_dir
    type: Directory
    doc: The location where all data is stored
    inputBinding:
      position: 1
  - id: jobs
    type:
      - 'null'
      - int
    doc: "Number of parallel reads to execute. Speeds things up\n                \
      \      when iterating over all the data dirs"
    inputBinding:
      position: 102
      prefix: --jobs
  - id: logfile
    type:
      - 'null'
      - File
    doc: Write logging information in this file
    inputBinding:
      position: 102
      prefix: --logfile
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Define loglevel
    inputBinding:
      position: 102
      prefix: --loglevel
outputs:
  - id: output_index
    type: File
    doc: The files to write all the info in
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0
