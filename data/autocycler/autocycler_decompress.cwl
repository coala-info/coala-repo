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
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory where decompressed sequences will be saved (either -o or -f is
      required)
    outputBinding:
      glob: $(inputs.out_dir)
  - id: out_file
    type:
      - 'null'
      - File
    doc: FASTA file where decompressed sequences will be saved (either -o or -f is
      required)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
