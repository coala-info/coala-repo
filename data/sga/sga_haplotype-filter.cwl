cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - haplotype-filter
label: sga_haplotype-filter
doc: 'Remove haplotypes and their associated variants from a data set.


  Tool homepage: https://github.com/jts/sga'
inputs:
  - id: haplotype_file
    type: File
    doc: Haplotype file
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: vcf_file
    type: File
    doc: VCF file
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: haploid
    type:
      - 'null'
      - boolean
    doc: force use of the haploid model
    inputBinding:
      position: 103
      prefix: --haploid
  - id: reads
    type:
      - 'null'
      - File
    doc: Load the FM-index of the reads in FILE (needs a population index, FILE prefix + .popidx, written by merging per-sample indexes).
    inputBinding:
      position: 103
      prefix: --reads
      valueFrom: $(self.basename)
    secondaryFiles:
      - ^.bwt
      - ^.rbwt
      - ^.sai
      - ^.rsai
      - ^.popidx
  - id: reference
    type:
      - 'null'
      - File
    doc: Load the reference genome from FILE.
    inputBinding:
      position: 103
      prefix: --reference
      valueFrom: $(self.basename)
    secondaryFiles:
      - .fai
      - ^.bwt
      - ^.rbwt
      - ^.sai
      - ^.rsai
      - ^.ssa
  - id: threads
    type:
      - 'null'
      - int
    doc: use NUM threads to compute the overlaps
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 103
      prefix: --verbose
  - id: out_prefix_path
    type: string
    doc: write the passed haplotypes and variants to STR.vcf and STR.fa
    inputBinding:
      position: 104
      prefix: -o
outputs:
  - id: passed_vcf
    type:
      - 'null'
      - File
    doc: Passed haplotypes and variants.
    outputBinding:
      glob: $(inputs.out_prefix_path).vcf
  - id: passed_haplotypes
    type:
      - 'null'
      - File
    doc: Passed haplotype sequences.
    outputBinding:
      glob: $(inputs.out_prefix_path).fa
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.haplotype_file)
      - $(inputs.vcf_file)
      - '${ return inputs.reads ? inputs.reads : []; }'
      - '${ return inputs.reference ? inputs.reference : []; }'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
