cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taranys
  - analyze-schema
label: taranys_analyze-schema
doc: "Analyze a core gene schema: allele statistics, optional removal of subset, duplicated and no-CDS alleles, and Prokka annotation of the alleles.\n\nTool homepage: https://github.com/BU-ISCIII/taranys"
inputs:
  - id: input
    type: Directory
    doc: "Directory where the schema with the core gene files are located."
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "Output folder to save analyze schema"
    inputBinding:
      position: 1
      prefix: --output
  - id: remove_subset
    type: ['null', boolean]
    doc: "Remove allele subsequences from the schema."
    inputBinding:
      position: 1
      prefix: --remove-subset
  - id: no_remove_subset
    type: ['null', boolean]
    doc: "Negation of --remove-subset. Remove allele subsequences from the schema."
    inputBinding:
      position: 1
      prefix: --no-remove-subset
  - id: remove_duplicated
    type: ['null', boolean]
    doc: "Remove duplicated subsequences from the schema."
    inputBinding:
      position: 1
      prefix: --remove-duplicated
  - id: no_remove_duplicated
    type: ['null', boolean]
    doc: "Negation of --remove-duplicated. Remove duplicated subsequences from the schema."
    inputBinding:
      position: 1
      prefix: --no-remove-duplicated
  - id: remove_no_cds
    type: ['null', boolean]
    doc: "Remove no CDS alleles from the schema."
    inputBinding:
      position: 1
      prefix: --remove-no-cds
  - id: no_remove_no_cds
    type: ['null', boolean]
    doc: "Negation of --remove-no-cds. Remove no CDS alleles from the schema."
    inputBinding:
      position: 1
      prefix: --no-remove-no-cds
  - id: output_allele_annot
    type: ['null', boolean]
    doc: "output prokka/allele annotation for all alleles in locus."
    inputBinding:
      position: 1
      prefix: --output-allele-annot
  - id: no_output_allele_annot
    type: ['null', boolean]
    doc: "Negation of --output-allele-annot. output prokka/allele annotation for all alleles in locus."
    inputBinding:
      position: 1
      prefix: --no-output-allele-annot
  - id: genus
    type: ['null', string]
    doc: "Genus name for Prokka schema genes annotation. Default Genus."
    inputBinding:
      position: 1
      prefix: --genus
  - id: species
    type: ['null', string]
    doc: "Species name for Prokka schema genes annotation. Default species."
    inputBinding:
      position: 1
      prefix: --species
  - id: usegenus
    type: ['null', string]
    doc: "Use genus-specific BLAST databases for Prokka schema genes annotation (needs --genus). Default Genus."
    inputBinding:
      position: 1
      prefix: --usegenus
  - id: cpus
    type: ['null', int]
    doc: "Number of cpus used for execution. Default 1."
    inputBinding:
      position: 1
      prefix: --cpus
outputs:
  - id: output_dir
    type: Directory
    doc: "Output folder with the schema analysis."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taranys:3.0.1--pyhdfd78af_0
