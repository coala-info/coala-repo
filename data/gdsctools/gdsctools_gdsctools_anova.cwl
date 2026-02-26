cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdsctools_anova
label: gdsctools_gdsctools_anova
doc: "Welcome to GDSCTools standalone\n\nTool homepage: http://pypi.python.org/pypi/gdsctools"
inputs:
  - id: do_not_open_report
    type:
      - 'null'
      - boolean
    doc: By default, opens the index.html page. Set this option if you do not 
      want to open the html page automatically.
    inputBinding:
      position: 101
      prefix: --do-not-open-report
  - id: drug
    type:
      - 'null'
      - string
    doc: The name of a valid drug identifier to be found in the header of the 
      IC50 matrix
    inputBinding:
      position: 101
      prefix: --drug
  - id: exclude_msi
    type:
      - 'null'
      - boolean
    doc: Include msi factor in the analysis
    inputBinding:
      position: 101
      prefix: --exclude-msi
  - id: fdr_threshold
    type:
      - 'null'
      - float
    doc: FDR (False discovery Rate) used in the multitesting analysis to correct
      the pvalues
    inputBinding:
      position: 101
      prefix: --FDR-threshold
  - id: feature
    type:
      - 'null'
      - string
    doc: The name of a valid feature to be found in the Genomic Feature matrix
    inputBinding:
      position: 101
      prefix: --feature
  - id: input_drug_decode
    type:
      - 'null'
      - File
    doc: a decoder file
    inputBinding:
      position: 101
      prefix: --input-drug-decode
  - id: input_features
    type:
      - 'null'
      - File
    doc: A matrix of genomic features. One column with COSMIC identifiers should
      match those from the IC50s matrix. Then columns named TISSUE_FACTOR, 
      MSI_FACTOR, MEDIA_FACTOR should be provided. Finally, other columns will 
      be considered as genomic features (e.g., mutation)
    inputBinding:
      position: 101
      prefix: --input-features
  - id: input_ic50
    type: File
    doc: A file in TSV format with IC50s. First column should be the COSMIC 
      identifiers Following columns contain the IC50s for a set of drugs. The 
      header must be COSMIC_ID, Drug_1_IC50, Drug_2_IC50, ...
    inputBinding:
      position: 101
      prefix: --input-ic50
  - id: no_html
    type:
      - 'null'
      - boolean
    doc: If set, no images or HTML are created. For testing only
    inputBinding:
      position: 101
      prefix: --no-html
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: directory where to save images and HTML files.
    inputBinding:
      position: 101
      prefix: --output-directory
  - id: print_drug_names
    type:
      - 'null'
      - boolean
    doc: Print the drug names
    inputBinding:
      position: 101
      prefix: --print-drug-names
  - id: print_feature_names
    type:
      - 'null'
      - boolean
    doc: Print the features names
    inputBinding:
      position: 101
      prefix: --print-feature-names
  - id: print_tissue_names
    type:
      - 'null'
      - boolean
    doc: Print the unique tissue names
    inputBinding:
      position: 101
      prefix: --print-tissue-names
  - id: read_settings
    type:
      - 'null'
      - File
    doc: Read settings from a json file. Type --save-settings <filename.json> to
      create an example. Note that the FDR-threshold and include_MSI_factor will
      be replaced if --exclude-msi or fdr-threshold are used.
    inputBinding:
      position: 101
      prefix: --read-settings
  - id: save_settings
    type:
      - 'null'
      - File
    doc: Save settings into a json file
    inputBinding:
      position: 101
      prefix: --save-settings
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Print summary about the data (e.g., tissue)
    inputBinding:
      position: 101
      prefix: --summary
  - id: test
    type:
      - 'null'
      - boolean
    doc: Use a small IC50 data set and run the one-drug-one- feature analyse 
      with a couple of unit tests.
    inputBinding:
      position: 101
      prefix: --test
  - id: tissue
    type:
      - 'null'
      - string
    doc: The name of a specific cancer type i.e., tissue to restrict the 
      analysis to.
    inputBinding:
      position: 101
      prefix: --tissue
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose option.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdsctools:1.0.1--py_0
stdout: gdsctools_gdsctools_anova.out
