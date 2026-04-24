cwlVersion: v1.2
class: CommandLineTool
baseCommand: cirtap collect
label: cirtap_collect
doc: "Create sequence sets based on the installed files\n\nTool homepage: https://github.com/MGXlab/cirtap/"
inputs:
  - id: genomes_dir
    type: Directory
    doc: Directory containing genomes
    inputBinding:
      position: 1
  - id: output_path
    type: Directory
    doc: Path to output directory
    inputBinding:
      position: 2
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Remove all intermediate files produced
    inputBinding:
      position: 103
      prefix: --cleanup
  - id: index_path
    type: string
    doc: Path to index
    inputBinding:
      position: 103
      prefix: --index-path
  - id: jobs
    type:
      - 'null'
      - int
    doc: Parallel jobs to run
    inputBinding:
      position: 103
      prefix: --jobs
  - id: logfile
    type:
      - 'null'
      - File
    doc: Write logging information in this file
    inputBinding:
      position: 103
      prefix: --logfile
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Define loglevel
    inputBinding:
      position: 103
      prefix: --loglevel
  - id: target_set
    type:
      - 'null'
      - string
    doc: Sequence set to create. One of `SSU` (based on .PATRIC.frn) and 
      `proteins` (based on .PATRIC.faa)
    inputBinding:
      position: 103
      prefix: --target-set
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0
stdout: cirtap_collect.out
