cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quasitools
  - drmutations
label: quasitools_drmutations
doc: "Detects drug-resistant mutations from BAM files.\n\nTool homepage: https://github.com/phac-nml/quasitools/"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: reference_file
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 2
  - id: variants_file
    type: File
    doc: Variants file (e.g., VCF)
    inputBinding:
      position: 3
  - id: bed4_file
    type: File
    doc: BED4 file specifying regions of interest
    inputBinding:
      position: 4
  - id: mutation_db_file
    type: File
    doc: Mutation database file
    inputBinding:
      position: 5
  - id: min_freq
    type:
      - 'null'
      - float
    doc: the minimum required frequency.
    inputBinding:
      position: 106
      prefix: --min_freq
  - id: reporting_threshold
    type:
      - 'null'
      - int
    doc: the minimum percentage required for an entry in the drugresistant 
      report.
    inputBinding:
      position: 106
      prefix: --reporting_threshold
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
