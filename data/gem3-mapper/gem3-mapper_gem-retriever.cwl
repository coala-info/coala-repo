cwlVersion: v1.2
class: CommandLineTool
baseCommand: gem-retriever
label: gem3-mapper_gem-retriever
doc: "Retrieve sequence regions from a GEM index. Each input line gives a region as sequence_name:strand:position:length.\n\nTool homepage: https://github.com/smarco/gem3-mapper"
inputs:
  - id: index_file
    type: File
    doc: "GEM index file (GEM archive, .gem)"
    inputBinding:
      position: 101
      prefix: --index
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input file with the regions to retrieve (default: stdin)"
    inputBinding:
      position: 101
      prefix: --input
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "Output prefix (default: stdout)"
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: The retrieved sequences (when no output prefix is given)
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: |
        ${ return inputs.output_prefix ? inputs.output_prefix + '*' : []; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gem3-mapper:3.6.1--hb1d24b7_13
stdout: gem3-mapper_gem-retriever.out
