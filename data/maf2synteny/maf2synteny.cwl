cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf2synteny
label: maf2synteny
doc: "A tool that postprocesses whole genome alignment (for two or more genomes) and
  produces coarse-grained synteny blocks. Input is a whole genome alignment in MAF
  or GFF format (Cactus or SibeliaZ).\n\nTool homepage: https://github.com/fenderglass/maf2synteny"
inputs:
  - id: out_dir
    type: string
    doc: path to the output directory [default = .]
    inputBinding:
      position: 1
      prefix: -o
  - id: simpl_params
    type:
      - 'null'
      - File
    doc: path to a file with custom simplification parameters, one line per
      level with two numbers `min_block max_gap` [default = not set]
    inputBinding:
      position: 2
      prefix: -s
  - id: block_sizes
    type:
      - 'null'
      - string
    doc: comma-separated list of synteny block scales [default = 5000]
    inputBinding:
      position: 3
      prefix: -b
  - id: alignment_file
    type: File
    doc: path to alignment file in maf or gff format
    inputBinding:
      position: 4
outputs:
  - id: out_dir_result
    type:
      - 'null'
      - Directory
    doc: Output directory with the synteny blocks
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maf2synteny:1.2--h9948957_5
