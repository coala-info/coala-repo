cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - SchemaEvaluator
label: chewbbaca_SchemaEvaluator
doc: "Build an interactive report for schema evaluation.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: schema_directory
    type: Directory
    doc: "Path to the schema's directory."
    inputBinding:
      position: 1
      prefix: --schema-directory
  - id: output_directory
    type: string
    doc: "Path to the output directory where the report HTML files will be created."
    default: "schema_report"
    inputBinding:
      position: 1
      prefix: --output-directory
  - id: genes_list
    type:
      - 'null'
      - File
    doc: "Path to a file with the list of loci in the schema that the process should analyse (one per line, full paths or loci IDs)."
    inputBinding:
      position: 1
      prefix: --genes-list
  - id: annotations
    type:
      - 'null'
      - File
    doc: "Path to the TSV file created by the UniprotFinder module."
    inputBinding:
      position: 1
      prefix: --annotations
  - id: translation_table
    type:
      - 'null'
      - int
    doc: "Genetic code used to translate coding sequences (CDSs)."
    inputBinding:
      position: 1
      prefix: --translation-table
  - id: size_threshold
    type:
      - 'null'
      - float
    doc: "Coding sequence (CDS) size variation threshold."
    inputBinding:
      position: 1
      prefix: --size-threshold
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: "Minimum sequence length value. The module identifies alleles shorter than this value."
    inputBinding:
      position: 1
      prefix: --minimum-length
  - id: cpu_cores
    type:
      - 'null'
      - int
    doc: "Number of CPU cores that will be used to run the process (chewie resets to a lower value if it is equal to or exceeds the total number of available CPU cores). (default: 1)"
    inputBinding:
      position: 1
      prefix: --cpu-cores
  - id: loci_reports
    type:
      - 'null'
      - boolean
    doc: "Create a detailed report page for each locus."
    inputBinding:
      position: 1
      prefix: --loci-reports
  - id: light
    type:
      - 'null'
      - boolean
    doc: "Skips MSA computation with MAFFT and does not add the Phylogenetic Tree and MSA components to the loci reports."
    inputBinding:
      position: 1
      prefix: --light
  - id: add_sequences
    type:
      - 'null'
      - boolean
    doc: "Adds Code Editor components with the DNA and Protein sequences to the loci reports."
    inputBinding:
      position: 1
      prefix: --add-sequences
outputs:
  - id: results_dir
    type: Directory
    doc: "Schema evaluation report directory."
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
