cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quasitools
  - complexity
  - bam
label: quasitools_complexity_bam
doc: "Report the k-mer complexity of the pileup for each k-mer position in the reference, using several measures (Gregori et al. 2016).\n\nTool homepage: https://github.com/phac-nml/quasitools/"
inputs:
  - id: reference_location
    type: File
    doc: "Reference FASTA file"
    inputBinding:
      position: 1
  - id: bam_location
    type: File
    doc: "BAM alignment file"
    secondaryFiles:
      - pattern: ^.bai
        required: false
      - pattern: .bai
        required: false
    inputBinding:
      position: 2
  - id: k
    type: int
    doc: "Length of the k-mer"
    inputBinding:
      position: 3
  - id: haplotype_filter
    type:
      - 'null'
      - float
    doc: "Filter between 0 and 100; abundances below it are removed from each positional list (default 0)."
    inputBinding:
      position: 100
      prefix: --haplotype_filter
  - id: output_location
    type:
      - 'null'
      - string
    doc: "Output the quasispecies complexity in CSV format to the specified file."
    inputBinding:
      position: 101
      prefix: --output_location
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Complexity CSV file
    outputBinding:
      glob: $(inputs.output_location)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
