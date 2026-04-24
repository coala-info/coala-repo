cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyClassifier
label: plant_tribes_gene_family_classifier_GeneFamilyClassifier
doc: "GENE FAMILY CLASSIFICATION\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs:
  - id: classifier
    type: string
    doc: 'Protein classification method If BLASTP: blastp If HMMScan: hmmscan If BLASTP
      and HMMScan: both'
    inputBinding:
      position: 101
      prefix: --classifier
  - id: coding_sequences
    type:
      - 'null'
      - string
    doc: Corresponding coding sequences (CDS) fasta file (cds.fasta)
    inputBinding:
      position: 101
      prefix: --coding_sequences
  - id: config_dir
    type:
      - 'null'
      - Directory
    doc: (Optional) Absolute path to the directory containing the default 
      configuration files for the selected scaffold defined by the value of the 
      --scaffold parameter (e.g., /home/configs/22Gv1.1). If this parameter is 
      not used, the directory containing the default configuration files is set 
      to ~home/config.
    inputBinding:
      position: 101
      prefix: --config_dir
  - id: method
    type: string
    doc: 'Protein clustering method If GFam: gfam If OrthoFinder: orthofinder If OrthoMCL:
      orthomcl If Other non PlantTribes method: methodname, where "methodname" a nonempty
      string of word characters (alphanumeric or "_"). No embedded special charaters
      or white spaces.'
    inputBinding:
      position: 101
      prefix: --method
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads (CPUs) to used for HMMScan, BLASTP, and MAFFT
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: orthogroup_fasta
    type:
      - 'null'
      - boolean
    doc: Create orthogroup fasta files - requires "--coding_sequences" for CDS 
      orthogroup fasta
    inputBinding:
      position: 101
      prefix: --orthogroup_fasta
  - id: proteins
    type: string
    doc: Amino acids (proteins) sequences fasta file (proteins.fasta)
    inputBinding:
      position: 101
      prefix: --proteins
  - id: scaffold
    type: string
    doc: 'Orthogroups or gene families proteins scaffold. This can either be an absolute
      path to the directory containing the scaffolds (e.g., /home/scaffolds/22Gv1.1)
      or just the scaffold (e.g., 22Gv1.1). If the latter, ~home/data is prepended
      to the scaffold to create the absolute path. the scaffold to create the absolute
      path. If Monocots clusters (version 1.0): 12Gv1.0 If Angiosperms clusters (version
      1.0): 22Gv1.0 If Angiosperms clusters (version 1.1): 22Gv1.1 If Green plants
      clusters (version 1.0): 30Gv1.0 If Other non PlantTribes clusters: XGvY.Z, where
      "X" is the number species in the scaffold, and "Y.Z" version number such as
      12Gv1.0. Please look at one of the PlantTribes scaffold data on how data files
      and directories are named, formated, and organized.'
    inputBinding:
      position: 101
      prefix: --scaffold
  - id: single_copy_custom
    type:
      - 'null'
      - string
    doc: Configuration file for single copy orthogroup custom selection - 
      incompatible with "--single_copy_taxa". This must be an absolute path to 
      the configuration file (e.g., 
      '~/home/scaffolds/22Gv1.1.singleCopy.config') or the string 'default'. If 
      the latter, the config is defined to be 
      ~/config_dir/~scaffold.singleCopy.config. See the single copy 
      configuration files the config sub-directory of the installation on how to
      customize the single copy selection.
    inputBinding:
      position: 101
      prefix: --single_copy_custom
  - id: single_copy_taxa
    type:
      - 'null'
      - int
    doc: Minimum single copy taxa required in orthogroup - incompatible with 
      "--single_copy_custom"
    inputBinding:
      position: 101
      prefix: --single_copy_taxa
  - id: super_orthogroups
    type:
      - 'null'
      - string
    doc: 'SuperOrthogroups MCL clustering - blastp e-value matrix between all pairs
      of orthogroups If minimum e-value: min_evalue (default) If average e-value:
      avg_evalue'
    inputBinding:
      position: 101
      prefix: --super_orthogroups
  - id: taxa_present
    type:
      - 'null'
      - int
    doc: Minimum taxa required in single copy orthogroup - requires 
      "--single_copy_taxa"
    inputBinding:
      position: 101
      prefix: --taxa_present
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/plant_tribes_gene_family_classifier:1.0.4--0
stdout: plant_tribes_gene_family_classifier_GeneFamilyClassifier.out
