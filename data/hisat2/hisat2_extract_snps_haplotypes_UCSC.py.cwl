cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2_extract_snps_haplotypes_UCSC.py
label: hisat2_extract_snps_haplotypes_UCSC.py
doc: "Extract SNPs and haplotypes from a SNP file downloaded from UCSC (e.g.
  http://hgdownload.soe.ucsc.edu/goldenPath/hg38/database/snp144.txt.gz)\n\nTool
  homepage: https://daehwankimlab.github.io/hisat2"
inputs:
  - id: genome_file
    type: File
    doc: input genome file (e.g. genome.fa)
    inputBinding:
      position: 1
  - id: snp_fname
    type: File
    doc: input snp file downloaded from UCSC (plain text or gzipped file is accepted,
      e.g. snp144Common.txt or snp144Common.txt.gz)
    inputBinding:
      position: 2
  - id: base_fname
    type: string
    doc: base filename for SNPs and haplotypes
    inputBinding:
      position: 3
  - id: inter_gap
    type:
      - 'null'
      - int
    doc: Maximum distance for variants to be in the same haplotype
    inputBinding:
      position: 0
      prefix: --inter-gap
  - id: intra_gap
    type:
      - 'null'
      - int
    doc: Break a haplotype into several haplotypes
    inputBinding:
      position: 0
      prefix: --intra-gap
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: also print some statistics to stderr
    inputBinding:
      position: 0
      prefix: --verbose
  - id: testset
    type:
      - 'null'
      - boolean
    doc: print test reads
    inputBinding:
      position: 0
      prefix: --testset
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: SNP and haplotype files written with the base filename
    outputBinding:
      glob: $(inputs.base_fname)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
