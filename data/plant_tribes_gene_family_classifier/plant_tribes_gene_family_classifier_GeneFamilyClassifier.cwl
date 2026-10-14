cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyClassifier
label: plant_tribes_gene_family_classifier_GeneFamilyClassifier
doc: "Gene family classification: classify protein sequences into the orthogroups (gene families) of a PlantTribes scaffold using BLASTP and/or HMMScan. Results are written to the geneFamilyClassification_dir folder in the working directory.\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: proteins
    type: File
    doc: 'Amino acids (proteins) sequences fasta file (proteins.fasta)'
    inputBinding:
      position: 101
      prefix: --proteins
  - id: scaffold
    type: Directory
    doc: 'Orthogroups or gene families proteins scaffold directory (for example 22Gv1.1), with the db, hmms, fasta and annot sub-folders'
    inputBinding:
      position: 101
      prefix: --scaffold
      valueFrom: $(self.path)
  - id: method
    type: string
    doc: 'Protein clustering method: gfam, orthofinder, orthomcl or another method name'
    inputBinding:
      position: 101
      prefix: --method
  - id: classifier
    type: string
    doc: 'Protein classification method: blastp, hmmscan or both'
    inputBinding:
      position: 101
      prefix: --classifier
  - id: config_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory containing the default configuration files for the selected scaffold'
    inputBinding:
      position: 101
      prefix: --config_dir
      valueFrom: $(self.path)
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'number of threads (CPUs) to use for HMMScan, BLASTP, and MAFFT (default 1)'
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: super_orthogroups
    type:
      - 'null'
      - string
    doc: 'SuperOrthogroups MCL clustering e-value matrix: min_evalue (default) or avg_evalue'
    inputBinding:
      position: 101
      prefix: --super_orthogroups
  - id: single_copy_custom
    type:
      - 'null'
      - File
    doc: 'Configuration file for single copy orthogroup custom selection (incompatible with single_copy_taxa)'
    inputBinding:
      position: 101
      prefix: --single_copy_custom
      valueFrom: $(self.path)
  - id: single_copy_taxa
    type:
      - 'null'
      - int
    doc: 'Minimum single copy taxa required in orthogroup (incompatible with single_copy_custom)'
    inputBinding:
      position: 101
      prefix: --single_copy_taxa
  - id: taxa_present
    type:
      - 'null'
      - int
    doc: 'Minimum taxa required in single copy orthogroup (requires single_copy_taxa)'
    inputBinding:
      position: 101
      prefix: --taxa_present
  - id: orthogroup_fasta
    type:
      - 'null'
      - boolean
    doc: 'Create orthogroup fasta files (requires coding_sequences for CDS orthogroup fasta)'
    inputBinding:
      position: 101
      prefix: --orthogroup_fasta
  - id: coding_sequences
    type:
      - 'null'
      - File
    doc: 'Corresponding coding sequences (CDS) fasta file (cds.fasta)'
    inputBinding:
      position: 101
      prefix: --coding_sequences
outputs:
  - id: classification_dir
    type: Directory
    doc: 'Gene family classification results'
    outputBinding:
      glob: 'geneFamilyClassification_dir'
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_classifier:1.0.4--0
stdout: GeneFamilyClassifier.log
