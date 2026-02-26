cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhcflurry-predict
label: mhcflurry_mhcflurry-predict
doc: "Run MHCflurry predictor on specified peptides.\n\nTool homepage: https://github.com/hammerlab/mhcflurry"
inputs:
  - id: input_csv
    type:
      - 'null'
      - File
    doc: Input CSV
    inputBinding:
      position: 1
  - id: affinity_only
    type:
      - 'null'
      - boolean
    doc: Affinity prediction only (no antigen processing or presentation)
    inputBinding:
      position: 102
      prefix: --affinity-only
  - id: allele_column
    type:
      - 'null'
      - string
    doc: Input column name for alleles.
    default: allele
    inputBinding:
      position: 102
      prefix: --allele-column
  - id: alleles
    type:
      - 'null'
      - type: array
        items: string
    doc: Alleles to predict (exclusive with passing an input CSV)
    inputBinding:
      position: 102
      prefix: --alleles
  - id: always_include_best_allele
    type:
      - 'null'
      - boolean
    doc: Always include the best_allele column even when it is identical to the 
      allele column (i.e. all queries are monoallelic).
    inputBinding:
      position: 102
      prefix: --always-include-best-allele
  - id: c_flank_column
    type:
      - 'null'
      - string
    doc: Column giving C-terminal flanking sequence.
    default: c_flank
    inputBinding:
      position: 102
      prefix: --c-flank-column
  - id: list_supported_alleles
    type:
      - 'null'
      - boolean
    doc: Prints the list of supported alleles and exits
    inputBinding:
      position: 102
      prefix: --list-supported-alleles
  - id: list_supported_peptide_lengths
    type:
      - 'null'
      - boolean
    doc: Prints the list of supported peptide lengths and exits
    inputBinding:
      position: 102
      prefix: --list-supported-peptide-lengths
  - id: models
    type:
      - 'null'
      - Directory
    doc: Directory containing models. Either a binding affinity predictor or a 
      presentation predictor can be used.
    default: 
      /root/.local/share/mhcflurry/4/2.2.0/models_class1_presentation/models
    inputBinding:
      position: 102
      prefix: --models
  - id: n_flank_column
    type:
      - 'null'
      - string
    doc: Column giving N-terminal flanking sequence.
    default: n_flank
    inputBinding:
      position: 102
      prefix: --n-flank-column
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
    doc: Do not use flanking sequence information even when available
    inputBinding:
      position: 102
      prefix: --no-flanking
  - id: no_throw
    type:
      - 'null'
      - boolean
    doc: Return NaNs for unsupported alleles or peptides instead of raising
    inputBinding:
      position: 102
      prefix: --no-throw
  - id: output_delimiter
    type:
      - 'null'
      - string
    doc: Delimiter character for results.
    default: ','
    inputBinding:
      position: 102
      prefix: --output-delimiter
  - id: peptide_column
    type:
      - 'null'
      - string
    doc: Input column name for peptides.
    default: peptide
    inputBinding:
      position: 102
      prefix: --peptide-column
  - id: peptides
    type:
      - 'null'
      - type: array
        items: string
    doc: Peptides to predict (exclusive with passing an input CSV)
    inputBinding:
      position: 102
      prefix: --peptides
  - id: prediction_column_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output column names.
    default: mhcflurry_
    inputBinding:
      position: 102
      prefix: --prediction-column-prefix
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
