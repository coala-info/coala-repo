cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - import-variants
label: pypgx_import-variants
doc: "Import SNV/indel data for target gene.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: gene
    type: string
    doc: Target gene.
    inputBinding:
      position: 1
  - id: vcf
    type: File
    doc: Input VCF file must be already BGZF compressed (.gz) and indexed (.tbi)
      to allow random access.
    inputBinding:
      position: 2
  - id: assembly
    type:
      - 'null'
      - string
    doc: "Reference genome assembly (default: 'GRCh37') (choices: 'GRCh37', 'GRCh38')."
    inputBinding:
      position: 103
      prefix: --assembly
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude specified samples.
    inputBinding:
      position: 103
      prefix: --exclude
  - id: platform
    type:
      - 'null'
      - string
    doc: "Genotyping platform used (default: 'WGS') (choices: 'WGS', 'Targeted', 'Chip',
      'LongRead'). When the platform is 'WGS', 'Targeted', or 'Chip', the command
      will assess whether every genotype call in the sliced VCF is haplotype phased
      (e.g. '0|1'). If the sliced VCF is fully phased, the command will return VcfFrame[Consolidated]
      or otherwise VcfFrame[Imported]. When the platform is 'LongRead', the command
      will return VcfFrame[Consolidated] after applying the phase-extension algorithm
      to estimate haplotype phase of any variants that could not be resolved by read-backed
      phasing."
    inputBinding:
      position: 103
      prefix: --platform
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify which samples should be included for analysis by providing a 
      text file (.txt, .tsv, .csv, or .list) containing one sample per line. 
      Alternatively, you can provide a list of samples.
    inputBinding:
      position: 103
      prefix: --samples
outputs:
  - id: imported_variants
    type: File
    doc: Output archive file with the semantic type VcfFrame[Imported] or 
      VcfFrame[Consolidated].
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
