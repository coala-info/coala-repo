cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virprof
  - download-genomes
label: virprof_download-genomes
doc: "Download genomes from NCBI.\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs:
  - id: auto_len
    type:
      - 'null'
      - boolean
    doc: Automatically determine min/max length
    inputBinding:
      position: 101
      prefix: --auto-len
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum genome length
    inputBinding:
      position: 101
      prefix: --max-len
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum genome length
    inputBinding:
      position: 101
      prefix: --min-len
  - id: ncbi_api_key
    type:
      - 'null'
      - string
    doc: NCBI API Key
    inputBinding:
      position: 101
      prefix: --ncbi-api-key
  - id: ncbi_taxonomy
    type: File
    doc: Path to NCBI taxonomy (tree or raw)
    inputBinding:
      position: 101
      prefix: --ncbi-taxonomy
  - id: no_auto_len
    type:
      - 'null'
      - boolean
    doc: Do not automatically determine min/max length
    inputBinding:
      position: 101
      prefix: --no-auto-len
  - id: outgroup
    type:
      - 'null'
      - string
    doc: Include outgroup species (yes|no|only)
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: species
    type: string
    doc: Species to download
    inputBinding:
      position: 101
      prefix: --species
  - id: out_accs_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `out_accs_path`
    inputBinding:
      position: 102
      prefix: --out-accs
  - id: out_fasta_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `out_fasta_path`
    inputBinding:
      position: 103
      prefix: --out-fasta
  - id: out_gb_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `out_gb_path`
    inputBinding:
      position: 104
      prefix: --out-gb
outputs:
  - id: out_accs
    type:
      - 'null'
      - File
    doc: Output file for accessions
    outputBinding:
      glob: $(inputs.out_accs_path)
  - id: out_fasta
    type:
      - 'null'
      - File
    doc: Output file for FASTA genomes
    outputBinding:
      glob: $(inputs.out_fasta_path)
  - id: out_gb
    type:
      - 'null'
      - File
    doc: Output file for GenBank genomes
    outputBinding:
      glob: $(inputs.out_gb_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
