cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - autocycler
  - combine
label: autocycler_combine
doc: "combine Autocycler GFAs into one assembly\n\nTool homepage: https://github.com/rrwick/Autocycler"
inputs:
  - id: autocycler_dir
    type: Directory
    doc: Autocycler directory (required)
    inputBinding:
      position: 101
      prefix: --autocycler_dir
  - id: in_gfas
    type:
      type: array
      items: File
    doc: Autocycler cluster GFA files (one or more required)
    inputBinding:
      position: 101
      prefix: --in_gfas
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: autocycler_dir_out
    type: Directory
    doc: Autocycler directory with the new consensus_assembly files
    outputBinding:
      glob: $(inputs.autocycler_dir.basename)
  - id: consensus_assembly_fasta
    type: File
    doc: Consensus assembly in FASTA format
    outputBinding:
      glob: $(inputs.autocycler_dir.basename)/consensus_assembly.fasta
  - id: consensus_assembly_gfa
    type: File
    doc: Consensus assembly graph in GFA format
    outputBinding:
      glob: $(inputs.autocycler_dir.basename)/consensus_assembly.gfa
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.autocycler_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
stdout: autocycler_combine.out
