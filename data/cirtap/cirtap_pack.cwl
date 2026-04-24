cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cirtap
  - pack
label: cirtap_pack
doc: "Create a gzipped tar archive from a list of genome ids in a file\n\nTool homepage:
  https://github.com/MGXlab/cirtap/"
inputs:
  - id: genomes_dir
    type: Directory
    doc: Path to the genomes directory containing all data
    inputBinding:
      position: 101
      prefix: --genomes-dir
  - id: input_list
    type: File
    doc: Single column file containing one genome id per line
    inputBinding:
      position: 101
      prefix: --input-list
  - id: logfile
    type:
      - 'null'
      - string
    doc: Write logging information in this file
    inputBinding:
      position: 101
      prefix: --logfile
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Define loglevel
    inputBinding:
      position: 101
      prefix: --loglevel
outputs:
  - id: output
    type: File
    doc: Output gzipped file to write. For now only gzip compression is 
      supported
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0
