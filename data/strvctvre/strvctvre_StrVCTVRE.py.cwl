cwlVersion: v1.2
class: CommandLineTool
baseCommand: StrVCTVRE.py
label: strvctvre_StrVCTVRE.py
doc: "Annotate the pathogenicity of exonic deletions and duplications in GRCh38 (default)
  or GRCh37.\n\nTool homepage: https://github.com/andrewSharo/StrVCTVRE/tree/master"
inputs:
  - id: assembly
    type:
      - 'null'
      - string
    doc: Genome assembly of input, either GRCh38 or GRCh37
    inputBinding:
      position: 101
      prefix: --assembly
  - id: format
    type:
      - 'null'
      - string
    doc: "Input file format, either vcf or bed, defaults to vcf\n                \
      \        when not provided"
    inputBinding:
      position: 101
      prefix: --format
  - id: input_file
    type: File
    doc: Input file path
    inputBinding:
      position: 101
      prefix: --input
  - id: liftover_path
    type:
      - 'null'
      - File
    doc: "Liftover executable path, required if assembly is\n                    \
      \    GRCh37"
    inputBinding:
      position: 101
      prefix: --liftover
  - id: phyloP_file
    type:
      - 'null'
      - File
    doc: "phyloP file path, defaults to\n                        'data/hg38.phyloP100way.bw'
      when not provided"
    inputBinding:
      position: 101
      prefix: --phyloP
outputs:
  - id: output_file
    type: File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strvctvre:1.10--pyh7e72e81_0
