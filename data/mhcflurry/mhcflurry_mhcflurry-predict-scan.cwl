cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhcflurry-predict-scan
label: mhcflurry_mhcflurry-predict-scan
doc: "Scan protein sequences using the MHCflurry presentation predictor.\n\nTool homepage:
  https://github.com/hammerlab/mhcflurry"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input CSV or FASTA
    inputBinding:
      position: 1
  - id: alleles
    type:
      - 'null'
      - type: array
        items: string
    doc: Alleles to predict
    inputBinding:
      position: 102
      prefix: --alleles
  - id: input_format
    type:
      - 'null'
      - string
    doc: "Format of input file. By default, it is guessed from\nthe file extension."
    inputBinding:
      position: 102
      prefix: --input-format
  - id: list_supported_alleles
    type:
      - 'null'
      - boolean
    doc: Print the list of supported alleles and exit
    inputBinding:
      position: 102
      prefix: --list-supported-alleles
  - id: list_supported_peptide_lengths
    type:
      - 'null'
      - boolean
    doc: Print the list of supported peptide lengths and exit
    inputBinding:
      position: 102
      prefix: --list-supported-peptide-lengths
  - id: models
    type:
      - 'null'
      - Directory
    doc: "Directory containing presentation models.Default: /roo\nt/.local/share/mhcflurry/4/2.2.0/models_class1_present\n\
      ation/models"
      /root/.local/share/mhcflurry/4/2.2.0/models_class1_presentation/models
    inputBinding:
      position: 102
      prefix: --models
  - id: no_affinity_percentile
    type:
      - 'null'
      - boolean
    doc: Do not include affinity percentile rank
    inputBinding:
      position: 102
      prefix: --no-affinity-percentile
  - id: no_flanking
    type:
      - 'null'
      - boolean
    doc: "Do not use flanking sequence information in\npredictions"
    inputBinding:
      position: 102
      prefix: --no-flanking
  - id: no_throw
    type:
      - 'null'
      - boolean
    doc: "Return NaNs for unsupported alleles or peptides\ninstead of raising"
    inputBinding:
      position: 102
      prefix: --no-throw
  - id: output_delimiter
    type:
      - 'null'
      - string
    doc: "Delimiter character for results. Default: ','"
    inputBinding:
      position: 102
      prefix: --output-delimiter
  - id: peptide_lengths
    type:
      - 'null'
      - string
    doc: "Peptide lengths to consider. Pass as START-END (e.g.\n8-11) or a comma-separated
      list (8,9,10,11). When\nusing START-END, the range is INCLUSIVE on both ends.\n\
      Default: 8-11."
    inputBinding:
      position: 102
      prefix: --peptide-lengths
  - id: results_all
    type:
      - 'null'
      - boolean
    doc: "Return results for all peptides regardless of\naffinity, etc."
    inputBinding:
      position: 102
      prefix: --results-all
  - id: sequence_column
    type:
      - 'null'
      - string
    doc: "Input CSV column name for sequences. Default:\n'sequence'"
    inputBinding:
      position: 102
      prefix: --sequence-column
  - id: sequence_id_column
    type:
      - 'null'
      - string
    doc: "Input CSV column name for sequence IDs. Default:\n'sequence_id'"
    inputBinding:
      position: 102
      prefix: --sequence-id-column
  - id: sequences
    type:
      - 'null'
      - type: array
        items: string
    doc: "Sequences to predict (exclusive with passing an input\nfile)"
    inputBinding:
      position: 102
      prefix: --sequences
  - id: threshold_affinity
    type:
      - 'null'
      - float
    doc: 'Threshold if filtering by affinity. Default: < 500'
    inputBinding:
      position: 102
      prefix: --threshold-affinity
  - id: threshold_affinity_percentile
    type:
      - 'null'
      - float
    doc: "Threshold if filtering by affinity percentile.\nDefault: < 2.0"
    inputBinding:
      position: 102
      prefix: --threshold-affinity-percentile
  - id: threshold_presentation_score
    type:
      - 'null'
      - float
    doc: "Threshold if filtering by presentation score. Default:\n> 0.7"
    inputBinding:
      position: 102
      prefix: --threshold-presentation-score
  - id: threshold_processing_score
    type:
      - 'null'
      - float
    doc: "Threshold if filtering by processing score. Default: >\n0.5"
    inputBinding:
      position: 102
      prefix: --threshold-processing-score
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output CSV
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhcflurry:2.1.5--pyh7e72e81_0
