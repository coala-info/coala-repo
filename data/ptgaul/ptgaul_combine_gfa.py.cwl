cwlVersion: v1.2
class: CommandLineTool
baseCommand: combine_gfa.py
label: ptgaul_combine_gfa.py
doc: "This script is used to merge the edges from assembly graph.\n\nTool homepage:
  https://github.com/Bean061/ptgaul"
inputs:
  - id: input_edges_file
    type:
      - 'null'
      - File
    doc: input edge fasta file
    inputBinding:
      position: 101
      prefix: --input_edges_file
  - id: sorted_depth
    type:
      - 'null'
      - File
    doc: input depth file
    inputBinding:
      position: 101
      prefix: --sorted_depth
  - id: outputdir_path
    type: string
    doc: Output or path parameter `outputdir_path`
    inputBinding:
      position: 102
      prefix: --outputdir
outputs:
  - id: outputdir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.outputdir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
