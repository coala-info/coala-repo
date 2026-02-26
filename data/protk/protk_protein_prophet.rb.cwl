cwlVersion: v1.2
class: CommandLineTool
baseCommand: protein_prophet.rb
label: protk_protein_prophet.rb
doc: "Run ProteinProphet on a set of pep.xml input files.\n\nTool homepage: https://github.com/iracooke/protk"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input pep.xml files
    inputBinding:
      position: 1
  - id: allpeps
    type:
      - 'null'
      - boolean
    doc: Consider all possible peptides in the database in the confidence model
    default: false
    inputBinding:
      position: 102
      prefix: --allpeps
  - id: confem
    type:
      - 'null'
      - boolean
    doc: Use the EM to compute probability given the confidence
    default: false
    inputBinding:
      position: 102
      prefix: --confem
  - id: delude
    type:
      - 'null'
      - boolean
    doc: Do NOT use peptide degeneracy information when assessing proteins
    default: false
    inputBinding:
      position: 102
      prefix: --delude
  - id: glyco
    type:
      - 'null'
      - boolean
    doc: Expect N-Glycosylation modifications as variable mod in a search or as 
      a parameter when building statistical models
    default: false
    inputBinding:
      position: 102
      prefix: --glyco
  - id: group_wts
    type:
      - 'null'
      - boolean
    doc: Check peptide's total weight (rather than actual weight) in the Protein
      Group against the threshold
    default: false
    inputBinding:
      position: 102
      prefix: --group-wts
  - id: instances
    type:
      - 'null'
      - boolean
    doc: Use Expected Number of Ion Instances to adjust the peptide 
      probabilities prior to NSP adjustment
    default: false
    inputBinding:
      position: 102
      prefix: --instances
  - id: iprophet_input
    type:
      - 'null'
      - boolean
    doc: Inputs are from iProphet
    default: false
    inputBinding:
      position: 102
      prefix: --iprophet-input
  - id: log_prob
    type:
      - 'null'
      - boolean
    doc: Use the log of probability in the confidence calculations
    default: false
    inputBinding:
      position: 102
      prefix: --log-prob
  - id: min_indep
    type:
      - 'null'
      - float
    doc: Minimum percentage of independent peptides required for a protein
    default: 0
    inputBinding:
      position: 102
      prefix: --minindep
  - id: min_prob
    type:
      - 'null'
      - float
    doc: Minimum peptide prophet probability for peptides to be considered
    default: 0.05
    inputBinding:
      position: 102
      prefix: --minprob
  - id: no_occam
    type:
      - 'null'
      - boolean
    doc: Do not attempt to derive the simplest protein list explaining observed 
      peptides
    default: false
    inputBinding:
      position: 102
      prefix: --no-occam
  - id: norm_protlen
    type:
      - 'null'
      - boolean
    doc: Normalize NSP using Protein Length
    default: false
    inputBinding:
      position: 102
      prefix: --norm-protlen
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: A string to prepend to the name of output files
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: replace_output
    type:
      - 'null'
      - boolean
    doc: Dont skip analyses for which the output file already exists
    default: false
    inputBinding:
      position: 102
      prefix: --replace-output
  - id: unmapped
    type:
      - 'null'
      - boolean
    doc: Report results for unmapped proteins
    default: false
    inputBinding:
      position: 102
      prefix: --unmapped
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
