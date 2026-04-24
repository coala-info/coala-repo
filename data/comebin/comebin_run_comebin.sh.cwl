cwlVersion: v1.2
class: CommandLineTool
baseCommand: bash run_comebin.sh
label: comebin_run_comebin.sh
doc: "COMEBin version: 1.0.4\n\nTool homepage: https://github.com/ziyewang/COMEBin"
inputs:
  - id: bam_file_path
    type: string
    doc: path to access to the bam files
    inputBinding:
      position: 101
      prefix: -p
  - id: batch_size
    type:
      - 'null'
      - int
    doc: batch size for training process
    inputBinding:
      position: 101
      prefix: -b
  - id: contig_file
    type: string
    doc: metagenomic assembly file
    inputBinding:
      position: 101
      prefix: -a
  - id: embedding_size_comebin
    type:
      - 'null'
      - int
    doc: embedding size for comebin network
    inputBinding:
      position: 101
      prefix: -e
  - id: embedding_size_coverage
    type:
      - 'null'
      - int
    doc: embedding size for coverage network
    inputBinding:
      position: 101
      prefix: -c
  - id: num_views
    type:
      - 'null'
      - int
    doc: number of views for contrastive multiple-view learning
    inputBinding:
      position: 101
      prefix: -n
  - id: temperature
    type:
      - 'null'
      - float
    doc: temperature in loss function
    inputBinding:
      position: 101
      prefix: -l
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_dir
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comebin:1.0.4--hdfd78af_1
