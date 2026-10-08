cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taranys
  - allele-calling
label: taranys_allele-calling
doc: "Call the alleles of each locus of a core gene schema in one or more assemblies using BLAST.\n\nTool homepage: https://github.com/BU-ISCIII/taranys"
inputs:
  - id: schema
    type: Directory
    doc: "Directory where the schema with the core gene files are located."
    inputBinding:
      position: 1
      prefix: --schema
  - id: reference
    type: Directory
    doc: "Directory where the schema reference allele files are located."
    inputBinding:
      position: 1
      prefix: --reference
  - id: annotation
    type: File
    doc: "Annotation file."
    inputBinding:
      position: 1
      prefix: --annotation
  - id: hit_lenght_perc
    type: ['null', float]
    doc: "Threshold value to consider in blast hit percentage regarding the reference length. Values from 0 to 1. Default 0.8."
    inputBinding:
      position: 1
      prefix: --hit_lenght_perc
  - id: perc_identity
    type: ['null', int]
    doc: "Percentage of identity to consider in blast. Default 85."
    inputBinding:
      position: 1
      prefix: --perc-identity
  - id: output
    type: string
    doc: "Output folder to save reference alleles"
    inputBinding:
      position: 1
      prefix: --output
  - id: force
    type: ['null', boolean]
    doc: "Overwrite the output folder if it exists"
    inputBinding:
      position: 1
      prefix: --force
  - id: no_force
    type: ['null', boolean]
    doc: "Negation of --force. Overwrite the output folder if it exists"
    inputBinding:
      position: 1
      prefix: --no-force
  - id: snp
    type: ['null', boolean]
    doc: "Create SNP file for alleles in assembly in relation with reference allele"
    inputBinding:
      position: 1
      prefix: --snp
  - id: no_snp
    type: ['null', boolean]
    doc: "Negation of --snp. Create SNP file for alleles in assembly in relation with reference allele"
    inputBinding:
      position: 1
      prefix: --no-snp
  - id: alignment
    type: ['null', boolean]
    doc: "Create alignment files"
    inputBinding:
      position: 1
      prefix: --alignment
  - id: no_alignment
    type: ['null', boolean]
    doc: "Negation of --alignment. Create alignment files"
    inputBinding:
      position: 1
      prefix: --no-alignment
  - id: proteine_threshold
    type: ['null', int]
    doc: "Threshold of protein coverage to consider as TPR. Default 80."
    inputBinding:
      position: 1
      prefix: --proteine-threshold
  - id: increase_sequence
    type: ['null', int]
    doc: "Increase the number of triplet sequences to find the stop codon. Default 20."
    inputBinding:
      position: 1
      prefix: --increase-sequence
  - id: cpus
    type: ['null', int]
    doc: "Number of cpus used for execution. Default 1."
    inputBinding:
      position: 1
      prefix: --cpus
  - id: assemblies
    type: File[]
    doc: "Assembly FASTA files to call alleles in."
    inputBinding:
      position: 10
outputs:
  - id: output_dir
    type: Directory
    doc: "Output folder with the allele calling results."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taranys:3.0.1--pyhdfd78af_0
