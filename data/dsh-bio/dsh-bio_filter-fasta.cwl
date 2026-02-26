cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-bio_filter-fasta
label: dsh-bio_filter-fasta
doc: "Filters FASTA files based on various criteria.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file to filter.
    inputBinding:
      position: 1
  - id: exclude_ids
    type:
      - 'null'
      - File
    doc: File containing sequence IDs to exclude. Sequences with IDs present in 
      this file will be removed.
    inputBinding:
      position: 102
      prefix: --exclude-ids
  - id: include_ids
    type:
      - 'null'
      - File
    doc: File containing sequence IDs to include. Only sequences with IDs 
      present in this file will be kept.
    inputBinding:
      position: 102
      prefix: --include-ids
  - id: keep_only_ids
    type:
      - 'null'
      - boolean
    doc: If specified, only sequences whose IDs are provided via --include-ids 
      will be kept. This is a shortcut for --include-ids.
    inputBinding:
      position: 102
      prefix: --keep-only-ids
  - id: max_gc_content
    type:
      - 'null'
      - float
    doc: Maximum GC content (0.0 to 1.0) to include.
    inputBinding:
      position: 102
      prefix: --max-gc-content
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum sequence length to include.
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_gc_content
    type:
      - 'null'
      - float
    doc: Minimum GC content (0.0 to 1.0) to include.
    inputBinding:
      position: 102
      prefix: --min-gc-content
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length to include.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: remove_ids
    type:
      - 'null'
      - boolean
    doc: If specified, sequences whose IDs are provided via --exclude-ids will 
      be removed. This is a shortcut for --exclude-ids.
    inputBinding:
      position: 102
      prefix: --remove-ids
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Output FASTA file. If not specified, results are printed to standard 
      output.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
