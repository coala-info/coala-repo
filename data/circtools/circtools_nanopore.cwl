cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circtools
  - nanopore
label: circtools_nanopore
doc: "circular RNA detection in Oxford Nanopore data\n\nTool homepage: https://github.com/dieterich-lab/circtools"
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: run
    type:
      - 'null'
      - boolean
    doc: 'Run the analysis'
    inputBinding:
      position: 101
      prefix: -r
  - id: check
    type:
      - 'null'
      - boolean
    doc: 'Check the installation for required software.'
    inputBinding:
      position: 101
      prefix: -c
  - id: download
    type:
      - 'null'
      - boolean
    doc: 'Download third-party data, such as genomes, required for the analysis.'
    inputBinding:
      position: 101
      prefix: -d
  - id: sample
    type:
      - 'null'
      - File
    doc: 'Sample input .fq.gz file that should be processed.'
    inputBinding:
      position: 101
      prefix: -s
  - id: reference_path
    type:
      - 'null'
      - Directory
    doc: 'Folder where the reference data is located. Default is ''./data''.'
    inputBinding:
      position: 101
      prefix: -R
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'Folder where the output data is stored.'
    inputBinding:
      position: 101
      prefix: -O
  - id: config
    type:
      - 'null'
      - string
    doc: 'Genome build of the sample (hg19, hg38, mm9, mm10, rn6, rn7, susScr11, canFam6); selects the genome reference files'
    inputBinding:
      position: 101
      prefix: -C
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads for parallel steps. Default: 4.'
    inputBinding:
      position: 101
      prefix: -t
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: 'Perform all of the input checks without starting the detection scripts.'
    inputBinding:
      position: 101
      prefix: -D
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: 'Keep all of the temporary files.'
    inputBinding:
      position: 101
      prefix: -k
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_path_dir
    type:
      - 'null'
      - Directory
    doc: 'Output folder'
    outputBinding:
      glob: $(inputs.output_path)
  - id: downloaded_data
    type:
      - 'null'
      - Directory
    doc: Reference data downloaded with --download (./data)
    outputBinding:
      glob: data
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
stdout: circtools_nanopore.out
