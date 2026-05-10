cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - autocycler
  - decompress
label: autocycler_decompress
doc: "decompress contigs from a unitig graph\n\nTool homepage: https://github.com/rrwick/Autocycler"
inputs:
  - id: in_gfa
    type: File
    doc: Autocycler GFA file (required)
    inputBinding:
      position: 101
      prefix: --in_gfa
  - id: out_dir_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `out_dir_path`
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: out_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `out_file_path`
    inputBinding:
      position: 103
      prefix: --out-file
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory where decompressed sequences will be saved (either -o or -f 
      is required)
    outputBinding:
      glob: $(inputs.out_dir_path)
  - id: out_file
    type:
      - 'null'
      - File
    doc: FASTA file where decompressed sequences will be saved (either -o or -f 
      is required)
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
