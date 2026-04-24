cwlVersion: v1.2
class: CommandLineTool
baseCommand: neat_model-fraglen
label: neat_model-fraglen
doc: "Generate fragment length model from a BAM or SAM file_list.\n\nTool homepage:
  https://github.com/ncsa/NEAT/"
inputs:
  - id: input_file
    type: File
    doc: Bam or sam input file_list.
    inputBinding:
      position: 101
      prefix: -i
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads for a fragment length to consider it in the 
      model. The default is 2, to handle smaller datasets. Set to 0 to turn off 
      filtering. For a larger dataset, try 100 and adjust from there.
    inputBinding:
      position: 101
      prefix: --min_reads
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set this flag to overwrite existing output.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to use to name files
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory. Will create if not present.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neat:4.3.5--pyhdfd78af_0
