cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - bench
label: truvari
doc: "Performance metrics for structural variant calling\n\nTool homepage: https://github.com/spiralgenetics/truvari"
inputs:
  - id: base_vcf
    type: File
    doc: Baseline truth VCF
    inputBinding:
      position: 101
      prefix: --base
  - id: comp_vcf
    type: File
    doc: Comparison VCF
    inputBinding:
      position: 101
      prefix: --comp
  - id: includebed
    type:
      - 'null'
      - File
    doc: Bed file of regions in which to analyze variants
    inputBinding:
      position: 101
      prefix: --includebed
  - id: no_ref
    type:
      - 'null'
      - string
    doc: Don't include specific reference genotypes (e.g., '0/0')
    inputBinding:
      position: 101
      prefix: --no-ref
  - id: passonly
    type:
      - 'null'
      - boolean
    doc: Only consider variants with FILTER == PASS
    inputBinding:
      position: 101
      prefix: --passonly
  - id: pctovl
    type:
      - 'null'
      - float
    doc: Threshold for reciprocal overlap
    inputBinding:
      position: 101
      prefix: --pctovl
  - id: pctsim
    type:
      - 'null'
      - float
    doc: Threshold for sequence similarity
    inputBinding:
      position: 101
      prefix: --pctsim
  - id: pctsize
    type:
      - 'null'
      - float
    doc: Threshold for size similarity
    inputBinding:
      position: 101
      prefix: --pctsize
  - id: refdist
    type:
      - 'null'
      - int
    doc: Max reference location distance
    inputBinding:
      position: 101
      prefix: --refdist
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference fasta file
    inputBinding:
      position: 101
      prefix: --ref
  - id: typeignore
    type:
      - 'null'
      - boolean
    doc: Variant types don't need to match to compare
    inputBinding:
      position: 101
      prefix: --typeignore
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
