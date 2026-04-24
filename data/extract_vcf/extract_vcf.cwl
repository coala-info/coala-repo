cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract-codon-alignment
label: extract_vcf
doc: "Extract codon alignments from VCF files.\n\nTool homepage: https://github.com/moonso/extract_vcf"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: gene_list
    type:
      - 'null'
      - File
    doc: File containing a list of genes to extract
    inputBinding:
      position: 102
      prefix: --gene-list
  - id: include_intergenic
    type:
      - 'null'
      - boolean
    doc: Include intergenic regions in the output
    inputBinding:
      position: 102
      prefix: --include-intergenic
  - id: include_introns
    type:
      - 'null'
      - boolean
    doc: Include intronic regions in the output
    inputBinding:
      position: 102
      prefix: --include-introns
  - id: min_allele_frequency
    type:
      - 'null'
      - float
    doc: Minimum allele frequency required for a variant to be considered
    inputBinding:
      position: 102
      prefix: --min-allele-frequency
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage required for a codon to be included
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file
    inputBinding:
      position: 102
      prefix: --reference-genome
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract-codon-alignment:0.0.1--py_0
