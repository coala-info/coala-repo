cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_filter_transcripts
label: talon_filter_transcripts
doc: "Filter the transcripts inside a TALON database to produce a transcript pass list. The list can be used by downstream tools to decide which transcripts and other features to report.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs:
  - id: database
    type: File
    doc: "TALON database"
    inputBinding:
      position: 101
      prefix: --db
  - id: annot
    type: string
    doc: "Which annotation version to use. Will determine which annotation transcripts are considered known or novel relative to. Note: must be in the TALON database."
    inputBinding:
      position: 101
      prefix: --annot
  - id: datasets
    type:
      - 'null'
      - string
    doc: "Datasets to include. Can be provided as a comma-delimited list on the command line, or as a file with one dataset per line. If this option is omitted, all datasets will be included."
    inputBinding:
      position: 101
      prefix: --datasets
  - id: include_annot
    type:
      - 'null'
      - boolean
    doc: "Include all transcripts from the annotation, regardless of if they were observed in the data."
    inputBinding:
      position: 101
      prefix: --includeAnnot
  - id: max_frac_a
    type:
      - 'null'
      - float
    doc: "Maximum fraction of As to allow in the window located immediately after any read assigned to a novel transcript (helps to filter out internal priming artifacts). Default = 0.5. Use 1 if you prefer not to filter out internal priming events."
    inputBinding:
      position: 101
      prefix: --maxFracA
  - id: min_count
    type:
      - 'null'
      - int
    doc: "Number of minimum occurrences required for a novel transcript PER dataset. Default = 5"
    inputBinding:
      position: 101
      prefix: --minCount
  - id: min_datasets
    type:
      - 'null'
      - int
    doc: "Minimum number of datasets novel transcripts must be found in. Default = all datasets provided"
    inputBinding:
      position: 101
      prefix: --minDatasets
  - id: allow_genomic
    type:
      - 'null'
      - boolean
    doc: "If this option is set, transcripts from the Genomic novelty category will be permitted in the output (provided they pass the thresholds). Default behavior is to filter out genomic transcripts since they are unlikely to be real novel isoforms."
    inputBinding:
      position: 101
      prefix: --allowGenomic
  - id: exclude_ism
    type:
      - 'null'
      - boolean
    doc: "If this option is set, transcripts from the ISM novelty category will be excluded from the output. Default behavior is to include those that pass other filtering thresholds."
    inputBinding:
      position: 101
      prefix: --excludeISM
  - id: outfile
    type: string
    doc: "Outfile name"
    inputBinding:
      position: 101
      prefix: --o
outputs:
  - id: pass_list
    type: File
    doc: "Transcript pass list (gene ID, transcript ID)"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
