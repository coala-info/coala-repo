cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat-3n-table
label: hisat-3n_hisat-3n-table
doc: "Generate a 3N-conversion table (per-position counts of converted and
  unconverted bases) from a sorted HISAT-3N SAM alignment file.\n\nTool homepage:
  https://github.com/fulcrumgenomics/hisat-3n"
inputs:
  - id: alignments
    type: File
    doc: SORTED SAM file produced by hisat-3n (use - for standard input)
    inputBinding:
      position: 1
      prefix: --alignments
  - id: ref
    type: File
    doc: Reference file in FASTA format
    inputBinding:
      position: 1
      prefix: --ref
  - id: output_name
    type: string
    doc: File name to save the 3N table (tsv format)
    inputBinding:
      position: 1
      prefix: --output-name
  - id: base_change
    type: string
    doc: 'The base-change rule: char1 is the nucleotide converted from, char2 the
      nucleotide converted to (the same value as given to hisat-3n)'
    inputBinding:
      position: 1
      prefix: --base-change
  - id: unique_only
    type:
      - 'null'
      - boolean
    doc: Only count the base which is in unique mapped reads
    inputBinding:
      position: 1
      prefix: --unique-only
  - id: multiple_only
    type:
      - 'null'
      - boolean
    doc: Only count the base which is in multiple mapped reads
    inputBinding:
      position: 1
      prefix: --multiple-only
  - id: cg_only
    type:
      - 'null'
      - boolean
    doc: Only count CG and ignore CH in reference
    inputBinding:
      position: 1
      prefix: --CG-only
  - id: added_chrname
    type:
      - 'null'
      - boolean
    doc: Add this option if you used --add-chrname during HISAT-3N alignment
    inputBinding:
      position: 1
      prefix: --added-chrname
  - id: removed_chrname
    type:
      - 'null'
      - boolean
    doc: Add this option if you used --remove-chrname during HISAT-3N alignment
    inputBinding:
      position: 1
      prefix: --removed-chrname
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to launch
    inputBinding:
      position: 1
      prefix: --threads
outputs:
  - id: table
    type: File
    doc: 3N conversion table (tsv)
    outputBinding:
      glob: $(inputs.output_name)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat-3n:0.0.3--h503566f_0
stdout: hisat-3n_hisat-3n-table.out
