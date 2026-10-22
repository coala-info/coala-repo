cwlVersion: v1.2
class: CommandLineTool
baseCommand: consensus.py
label: souporcell_consensus.py
doc: "consensus genotype calling and ambient RNA estimation\n\nTool homepage: https://github.com/wheaton5/souporcell"
inputs:
  - id: clusters
    type: File
    doc: "tsv cluster file from the troublet output"
    inputBinding:
      position: 11
      prefix: --clusters
  - id: alt_matrix
    type: File
    doc: "alt matrix file"
    inputBinding:
      position: 11
      prefix: --alt_matrix
  - id: ref_matrix
    type: File
    doc: "ref matrix file"
    inputBinding:
      position: 11
      prefix: --ref_matrix
  - id: ploidy
    type:
      - 'null'
      - int
    doc: "ploidy, must be 1 or 2, defaults to 2"
    inputBinding:
      position: 11
      prefix: --ploidy
  - id: soup_out
    type: string
    doc: "soup output"
    inputBinding:
      position: 11
      prefix: --soup_out
  - id: vcf_out
    type: string
    doc: "vcf output"
    inputBinding:
      position: 11
      prefix: --vcf_out
  - id: output_dir
    type: string
    doc: "output directory (created by the wrapper; soup_out and vcf_out are written inside it)"
    inputBinding:
      position: 11
      prefix: --output_dir
  - id: vcf
    type: File
    doc: "vcf file from which alt and ref matrix were created"
    inputBinding:
      position: 11
      prefix: --vcf
outputs:
  - id: soup_file
    type: File
    doc: Ambient RNA estimate
    outputBinding:
      glob: $(inputs.soup_out)
  - id: vcf_file
    type: File
    doc: Cluster genotypes
    outputBinding:
      glob: $(inputs.vcf_out)
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_dir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
