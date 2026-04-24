cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - qa
label: checkm-genome_checkm qa
doc: "Assess bins for contamination and completeness.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: marker_file
    type: File
    doc: marker file specified during analyze command
    inputBinding:
      position: 1
  - id: analyze_dir
    type: Directory
    doc: directory specified during analyze command
    inputBinding:
      position: 2
  - id: aai_strain
    type:
      - 'null'
      - float
    doc: 'AAI threshold used to identify strain heterogeneity (default: 0.9)'
    inputBinding:
      position: 103
      prefix: --aai_strain
  - id: coverage_file
    type:
      - 'null'
      - File
    doc: file containing coverage of each sequence; coverage information added 
      to table type 2 (see coverage command)
    inputBinding:
      position: 103
      prefix: --coverage_file
  - id: e_value
    type:
      - 'null'
      - float
    doc: 'e-value cut off (default: 1e-10)'
    inputBinding:
      position: 103
      prefix: --e_value
  - id: exclude_markers
    type:
      - 'null'
      - File
    doc: file specifying markers to exclude from marker sets
    inputBinding:
      position: 103
      prefix: --exclude_markers
  - id: ignore_thresholds
    type:
      - 'null'
      - boolean
    doc: ignore model-specific score thresholds
    inputBinding:
      position: 103
      prefix: --ignore_thresholds
  - id: individual_markers
    type:
      - 'null'
      - boolean
    doc: treat marker as independent (i.e., ignore co-located set structure)
    inputBinding:
      position: 103
      prefix: --individual_markers
  - id: length
    type:
      - 'null'
      - float
    doc: 'percent overlap between target and query (default: 0.7)'
    inputBinding:
      position: 103
      prefix: --length
  - id: out_format
    type:
      - 'null'
      - int
    doc: "desired output: (default: 1)\n                          1. summary of bin
      completeness and contamination\n                          2. extended summary
      of bin statistics (includes GC, genome size, ...)\n                        \
      \  3. summary of bin quality for increasingly basal lineage-specific marker
      sets\n                          4. list of marker genes and their counts\n \
      \                         5. list of bin id, marker gene id, gene id\n     \
      \                     6. list of marker genes present multiple times in a bin\n\
      \                          7. list of marker genes present multiple times on
      the same scaffold\n                          8. list indicating position of
      each marker gene within a bin\n                          9. FASTA file of marker
      genes identified in each bin"
    inputBinding:
      position: 103
      prefix: --out_format
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress console output
    inputBinding:
      position: 103
      prefix: --quiet
  - id: skip_adj_correction
    type:
      - 'null'
      - boolean
    doc: do not exclude adjacent marker genes when estimating contamination
    inputBinding:
      position: 103
      prefix: --skip_adj_correction
  - id: skip_pseudogene_correction
    type:
      - 'null'
      - boolean
    doc: skip identification and filtering of pseudogenes
    inputBinding:
      position: 103
      prefix: --skip_pseudogene_correction
  - id: tab_table
    type:
      - 'null'
      - boolean
    doc: print tab-separated values table
    inputBinding:
      position: 103
      prefix: --tab_table
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (default: 1)'
    inputBinding:
      position: 103
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify an alternative directory for temporary files
    inputBinding:
      position: 103
      prefix: --tmpdir
outputs:
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: produce file showing alignment of multi-copy genes and their AAI 
      identity
    outputBinding:
      glob: $(inputs.alignment_file)
  - id: file
    type:
      - 'null'
      - File
    doc: 'print results to file (default: stdout)'
    outputBinding:
      glob: $(inputs.file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
