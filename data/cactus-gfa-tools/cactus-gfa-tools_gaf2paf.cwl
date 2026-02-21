cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaf2paf
label: cactus-gfa-tools_gaf2paf
doc: "Convert minigraph GAF to PAF\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools"
inputs:
  - id: gaf_files
    type:
      type: array
      items: File
    doc: Input GAF file(s) to be converted
    inputBinding:
      position: 1
  - id: lengths
    type:
      - 'null'
      - File
    doc: TSV with contig length as first two columns (.fai will do).
    inputBinding:
      position: 102
      prefix: --lengths
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
stdout: cactus-gfa-tools_gaf2paf.out
