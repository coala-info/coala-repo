cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sansa
  - compvcf
label: sansa_compvcf
doc: "Compare two VCF/BCF files and report differences.\n\nTool homepage: https://github.com/dellytools/sansa"
inputs:
  - id: input_file
    type: File
    doc: input VCF/BCF file
    inputBinding:
      position: 1
  - id: base_file
    type: File
    doc: base VCF/BCF file
    inputBinding:
      position: 102
      prefix: --base
  - id: bp_diff
    type:
      - 'null'
      - int
    doc: max. SV breakpoint offset
    inputBinding:
      position: 102
      prefix: --bpdiff
  - id: filter_pass
    type:
      - 'null'
      - boolean
    doc: Filter sites for PASS
    inputBinding:
      position: 102
      prefix: --pass
  - id: ignore_duplicate_ids
    type:
      - 'null'
      - boolean
    doc: Ignore duplicate IDs
    inputBinding:
      position: 102
      prefix: --ignore
  - id: ignore_sv_type
    type:
      - 'null'
      - boolean
    doc: Ignore the SV type
    inputBinding:
      position: 102
      prefix: --nosvt
  - id: max_allele_count
    type:
      - 'null'
      - int
    doc: max. allele count
    inputBinding:
      position: 102
      prefix: --maxac
  - id: max_sv_divergence
    type:
      - 'null'
      - float
    doc: max. SV allele divergence
    inputBinding:
      position: 102
      prefix: --divergence
  - id: max_sv_size
    type:
      - 'null'
      - int
    doc: max. SV size
    inputBinding:
      position: 102
      prefix: --maxsize
  - id: min_allele_count
    type:
      - 'null'
      - int
    doc: min. allele count
    inputBinding:
      position: 102
      prefix: --minac
  - id: min_size_ratio
    type:
      - 'null'
      - float
    doc: min. SV size ratio
    inputBinding:
      position: 102
      prefix: --sizeratio
  - id: min_sv_quality
    type:
      - 'null'
      - int
    doc: min. SV site quality
    inputBinding:
      position: 102
      prefix: --quality
  - id: min_sv_size
    type:
      - 'null'
      - int
    doc: min. SV size
    inputBinding:
      position: 102
      prefix: --minsize
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 102
      prefix: --outprefix
  - id: require_matching_ct
    type:
      - 'null'
      - boolean
    doc: Require matching CT value in addition to SV type
    inputBinding:
      position: 102
      prefix: --ct
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sansa:0.2.5--h4d20210_0
stdout: sansa_compvcf.out
