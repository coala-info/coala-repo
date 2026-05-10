cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kaptive
  - extract
label: kaptive_extract
doc: "Extract entries from a Kaptive database\n\nTool homepage: https://kaptive.readthedocs.io/en/latest"
inputs:
  - id: db
    type: string
    doc: Kaptive database path or keyword
    inputBinding:
      position: 1
  - id: formats
    type:
      - 'null'
      - type: array
        items: string
    doc: Formats to extract
    inputBinding:
      position: 2
  - id: filter
    type:
      - 'null'
      - string
    doc: Python regular-expression to select loci to include in the database
    inputBinding:
      position: 103
      prefix: --filter
  - id: locus_regex
    type:
      - 'null'
      - string
    doc: Python regular-expression to match locus names in db source note
    inputBinding:
      position: 103
      prefix: --locus-regex
  - id: type_regex
    type:
      - 'null'
      - string
    doc: Python regular-expression to match locus types in db source note
    inputBinding:
      position: 103
      prefix: --type-regex
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debug messages to stderr
    inputBinding:
      position: 103
      prefix: --verbose
  - id: faa_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `faa_path`
    inputBinding:
      position: 104
      prefix: --faa
  - id: ffn_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `ffn_path`
    inputBinding:
      position: 105
      prefix: --ffn
  - id: fna_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `fna_path`
    inputBinding:
      position: 106
      prefix: --fna
outputs:
  - id: fna
    type:
      - 'null'
      - File
    doc: 'Convert to locus nucleotide sequences in fasta format. Accepts a single
      file or a directory (default: cwd)'
    outputBinding:
      glob: $(inputs.fna_path)
  - id: ffn
    type:
      - 'null'
      - File
    doc: 'Convert to locus gene nucleotide sequences in fasta format. Accepts a single
      file or a directory (default: cwd)'
    outputBinding:
      glob: $(inputs.ffn_path)
  - id: faa
    type:
      - 'null'
      - File
    doc: 'Convert to locus gene protein sequences in fasta format. Accepts a single
      file or a directory (default: cwd)'
    outputBinding:
      glob: $(inputs.faa_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaptive:3.1.0--pyhdfd78af_0
