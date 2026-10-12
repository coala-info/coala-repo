cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2paragraph.py
label: paragraph_vcf2paragraph.py
doc: 'Convert a VCF / BCF file of variants into a paragraph graph JSON file.\n\nTool homepage: https://github.com/Illumina/paragraph'
inputs:
  - id: input
    type: File
    doc: 'Input VCF / BCF file'
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: 'Output JSON file'
    inputBinding:
      position: 2
  - id: reference
    type: File
    doc: 'Reference FASTA for checking REF and resolving <DEL>'
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: --reference-sequence
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'More logging'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: graph_type
    type:
      - 'null'
      - string
    doc: 'Select the type of graph to generate (alleles or haplotypes).'
    inputBinding:
      position: 101
      prefix: --graph-type
  - id: retrieve_reference_sequence
    type:
      - 'null'
      - boolean
    doc: 'Retrieve reference sequence for REF nodes'
    inputBinding:
      position: 101
      prefix: --retrieve-reference-sequence
  - id: max_ref_node_length
    type:
      - 'null'
      - int
    doc: 'Maximum length of reference nodes before they get padded and truncated.'
    inputBinding:
      position: 101
      prefix: --max-ref-node-length
  - id: read_length
    type:
      - 'null'
      - int
    doc: 'Read length, used to add reference padding for disambiguation.'
    inputBinding:
      position: 101
      prefix: --read-length
  - id: target_region
    type:
      - 'null'
      - string
    doc: 'Target regions for read retrieval'
    inputBinding:
      position: 101
      prefix: --target-region
  - id: ins_info_key
    type:
      - 'null'
      - string
    doc: 'Key for symbolic <INS> in INFO field'
    inputBinding:
      position: 101
      prefix: --ins-info-key
  - id: alt_paths
    type:
      - 'null'
      - boolean
    doc: 'Create all possible ALT paths in addition to reference paths.'
    inputBinding:
      position: 101
      prefix: --alt-paths
  - id: alt_splitting
    type:
      - 'null'
      - boolean
    doc: 'Also split long alternate alleles (e.g. long insertions)'
    inputBinding:
      position: 101
      prefix: --alt-splitting
  - id: recursion_limit
    type:
      - 'null'
      - int
    doc: 'Set the recursion limit for large graphs (required for sorting)'
    inputBinding:
      position: 101
      prefix: --recursion-limit
outputs:
  - id: output
    type: File
    doc: 'Output JSON file'
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paragraph:2.3--h8908b6f_0
