cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepbgc
  - pipeline
label: deepbgc_pipeline
doc: "Run DeepBGC pipeline: Preparation, BGC detection, BGC classification and generate
  the report directory.\n\nTool homepage: https://github.com/Merck/DeepBGC"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Input sequence file path (FASTA, GenBank, Pfam CSV)
    inputBinding:
      position: 1
  - id: classifier_score
    type:
      - 'null'
      - float
    doc: 'DeepBGC classification score threshold for assigning classes to BGCs (default:
      0.5)'
    inputBinding:
      position: 102
      prefix: --classifier-score
  - id: classifiers
    type:
      - 'null'
      - type: array
        items: string
    doc: Trained classification model name (run "deepbgc download" to download 
      models) or path to trained model pickle file. Can be provided multiple 
      times (-c first -c second)
    inputBinding:
      position: 102
      prefix: --classifier
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --debug
  - id: detectors
    type:
      - 'null'
      - type: array
        items: string
    doc: Trained detection model name (run "deepbgc download" to download 
      models) or path to trained model pickle file. Can be provided multiple 
      times (-d first -d second)
    inputBinding:
      position: 102
      prefix: --detector
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Label for detected clusters (equal to --detector by default). If 
      multiple detectors are provided, a label should be provided for each one
    inputBinding:
      position: 102
      prefix: --label
  - id: limit_to_record
    type:
      - 'null'
      - type: array
        items: string
    doc: Process only specific record ID. Can be provided multiple times
    inputBinding:
      position: 102
      prefix: --limit-to-record
  - id: merge_max_nucl_gap
    type:
      - 'null'
      - int
    doc: 'Merge detected BGCs within given number of nucleotides (default: 0)'
    inputBinding:
      position: 102
      prefix: --merge-max-nucl-gap
  - id: merge_max_protein_gap
    type:
      - 'null'
      - int
    doc: 'Merge detected BGCs within given number of proteins (default: 0)'
    inputBinding:
      position: 102
      prefix: --merge-max-protein-gap
  - id: min_bio_domains
    type:
      - 'null'
      - int
    doc: 'Minimum number of known biosynthetic (as defined by antiSMASH) protein domains
      in a BGC (default: 0)'
    inputBinding:
      position: 102
      prefix: --min-bio-domains
  - id: min_domains
    type:
      - 'null'
      - int
    doc: 'Minimum number of protein domains in a BGC (default: 1)'
    inputBinding:
      position: 102
      prefix: --min-domains
  - id: min_nucl
    type:
      - 'null'
      - int
    doc: 'Minimum BGC nucleotide length (default: 1)'
    inputBinding:
      position: 102
      prefix: --min-nucl
  - id: min_proteins
    type:
      - 'null'
      - int
    doc: 'Minimum number of proteins in a BGC (default: 1)'
    inputBinding:
      position: 102
      prefix: --min-proteins
  - id: minimal_output
    type:
      - 'null'
      - boolean
    doc: Produce minimal output with just the GenBank sequence file
    inputBinding:
      position: 102
      prefix: --minimal-output
  - id: no_classifier
    type:
      - 'null'
      - boolean
    doc: Disable BGC classification
    inputBinding:
      position: 102
      prefix: --no-classifier
  - id: no_detector
    type:
      - 'null'
      - boolean
    doc: Disable BGC detection
    inputBinding:
      position: 102
      prefix: --no-detector
  - id: prodigal_meta_mode
    type:
      - 'null'
      - boolean
    doc: Run Prodigal in '-p meta' mode to enable detecting genes in short 
      contigs
    inputBinding:
      position: 102
      prefix: --prodigal-meta-mode
  - id: protein
    type:
      - 'null'
      - boolean
    doc: Accept amino-acid protein sequences as input (experimental). Will treat
      each file as a single record with multiple proteins.
    inputBinding:
      position: 102
      prefix: --protein
  - id: score
    type:
      - 'null'
      - float
    doc: 'Average protein-wise DeepBGC score threshold for extracting BGC regions
      from Pfam sequences (default: 0.5)'
    inputBinding:
      position: 102
      prefix: --score
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Custom output directory path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbgc:0.1.31--pyhca03a8a_0
