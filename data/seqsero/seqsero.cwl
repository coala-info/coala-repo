cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqsero
label: seqsero
doc: "SeqSero: a bioinformatics tool for serotype prediction of Salmonella enterica\n\
  \nTool homepage: https://github.com/denglab/SeqSero2"
inputs:
  - id: bwa_algorithm
    type:
      - 'null'
      - string
    doc: "'sam'(bwa samse/sampe), 'mem'(bwa mem)"
    default: sam
    inputBinding:
      position: 101
      prefix: -b
  - id: data_type
    type: int
    doc: "'1'(pair-end reads, interleaved),'2'(pair-end reads, seperated),'3'(single-end
      reads), '4'(assembly)"
    inputBinding:
      position: 101
      prefix: -m
  - id: input_data
    type:
      type: array
      items: string
    doc: path/to/input_data
    inputBinding:
      position: 101
      prefix: -i
  - id: output_directory
    type:
      - 'null'
      - string
    doc: output directory name, if not set, the output directory would be 
      'SeqSero_result_'+time stamp+one random number
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seqsero:v1.0.1dfsg-1-deb_cv1
stdout: seqsero.out
