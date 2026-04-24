cwlVersion: v1.2
class: CommandLineTool
baseCommand: VCF2cytosure
label: vcf2cytosure
doc: "convert SV vcf files to cytosure\n\nTool homepage: https://github.com/NBISweden/vcf2cytosure"
inputs:
  - id: bins
    type:
      - 'null'
      - int
    doc: the number of coverage bins per probes
    inputBinding:
      position: 101
      prefix: --bins
  - id: blacklist
    type:
      - 'null'
      - File
    doc: Blacklist bed format file to exclude completely contained variants.
    inputBinding:
      position: 101
      prefix: --blacklist
  - id: cn
    type:
      - 'null'
      - File
    doc: add probes using cnvkit cn file(cannot be used together with 
      --coverage)
    inputBinding:
      position: 101
      prefix: --cn
  - id: coverage
    type:
      - 'null'
      - File
    doc: Coverage file
    inputBinding:
      position: 101
      prefix: --coverage
  - id: dp
    type:
      - 'null'
      - string
    doc: read depth tag of snv vcf file. This option is only used if you use snv
      to set the heigth of the probes. The dp tag is a tag which is used to 
      retrieve the depth of coverage across the snv (default=DP)
    inputBinding:
      position: 101
      prefix: --dp
  - id: frequency
    type:
      - 'null'
      - float
    doc: Maximum frequency.
    inputBinding:
      position: 101
      prefix: --frequency
  - id: frequency_tag
    type:
      - 'null'
      - string
    doc: Frequency tag of the info field.
    inputBinding:
      position: 101
      prefix: --frequency_tag
  - id: genome
    type:
      - 'null'
      - string
    doc: Human genome version. Use 37 for GRCh37/hg19, 38 for GRCh38 template.
    inputBinding:
      position: 101
      prefix: --genome
  - id: maxbnd
    type:
      - 'null'
      - int
    doc: Maxixmum BND size, BND events exceeding this size are discarded
    inputBinding:
      position: 101
      prefix: --maxbnd
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: Disable any filtering
    inputBinding:
      position: 101
      prefix: --no-filter
  - id: sex
    type:
      - 'null'
      - string
    doc: Sample sex male/female.
    inputBinding:
      position: 101
      prefix: --sex
  - id: size
    type:
      - 'null'
      - int
    doc: Minimum variant size.
    inputBinding:
      position: 101
      prefix: --size
  - id: snv
    type:
      - 'null'
      - File
    doc: snv vcf file, use coverage annotation to position the height of the 
      probes(cannot be used together with --coverage)
    inputBinding:
      position: 101
      prefix: --snv
  - id: vcf
    type: File
    doc: VCF file
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file (default = the prefix of the input vcf)
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2cytosure:0.9.3--pyh7e72e81_0
