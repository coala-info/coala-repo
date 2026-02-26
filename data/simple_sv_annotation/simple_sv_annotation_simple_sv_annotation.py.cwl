cwlVersion: v1.2
class: CommandLineTool
baseCommand: simple_sv_annotation.py
label: simple_sv_annotation_simple_sv_annotation.py
doc: "Simplify SV annotations from snpEff to highlight exon impact. Requires the\n\
  pyvcf module.\n\nTool homepage: https://github.com/AstraZeneca-NGS/simple_sv_annotation"
inputs:
  - id: vcf
    type: File
    doc: VCF file with snpEff annotations
    inputBinding:
      position: 1
  - id: exonnums
    type:
      - 'null'
      - string
    doc: "List of custom exon numbers. A transcript listed in\nthis file will be annotated
      with the numbers found in\nthis file, not the numbers found in the snpEff result"
    inputBinding:
      position: 102
      prefix: --exonNums
  - id: gene_list
    type:
      - 'null'
      - File
    doc: "File with names of genes (one per line) for\nprioritisation"
    inputBinding:
      position: 102
      prefix: --gene_list
  - id: known_fusion_pairs
    type:
      - 'null'
      - File
    doc: "File with known fusion gene pairs, one pair per line\ndelimited by comma"
    inputBinding:
      position: 102
      prefix: --known_fusion_pairs
  - id: known_fusion_promiscuous
    type:
      - 'null'
      - File
    doc: "File with known promiscuous fusion genes, one gene\nname per line"
    inputBinding:
      position: 102
      prefix: --known_fusion_promiscuous
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Output file name (must not exist). Does not support\nbgzipped output. Use
      \"-\" for stdout."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simple_sv_annotation:2019.02.18--py_0
