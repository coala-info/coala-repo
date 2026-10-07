cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cirtap
  - collect
label: cirtap_collect
doc: "Create sequence sets based on the installed files\n\nTool homepage: https://github.com/MGXlab/cirtap/"
inputs:
  - id: genomes_dir
    type: Directory
    doc: Directory containing genomes
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: Output FASTA file with the collected sequences (gzipped when the name ends
      in .gz)
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
    type: File
    doc: Path to the index file created by cirtap index
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
      - string
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
  - id: output_fasta
    type: File
    doc: Collected sequences
    outputBinding:
      glob: $(inputs.output_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Logging information file
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0
stdout: cirtap_collect.out
