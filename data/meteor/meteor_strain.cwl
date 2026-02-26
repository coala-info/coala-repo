cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meteor
  - strain
label: meteor_strain
doc: "Perform variant calling and strain analysis on mapped samples.\n\nTool homepage:
  https://github.com/metagenopolis/meteor"
inputs:
  - id: core_size
    type:
      - 'null'
      - int
    doc: 'Number of signature genes per species (MSP) used to estimate their respective
      abundance (default: 100).'
    default: 100
    inputBinding:
      position: 101
      prefix: --core_size
  - id: keep_consensus
    type:
      - 'null'
      - boolean
    doc: 'Keep consensus marker genes (default: False, set to True to recompute strain)'
    default: false
    inputBinding:
      position: 101
      prefix: --kc
  - id: mapped_sample_dir
    type: Directory
    doc: Path to the mapped sample directory.
    inputBinding:
      position: 101
      prefix: -i
  - id: max_depth
    type:
      - 'null'
      - int
    doc: 'Maximum number of reads taken in account (default: 100).'
    default: 100
    inputBinding:
      position: 101
      prefix: -d
  - id: min_depth
    type:
      - 'null'
      - int
    doc: 'Minimum depth (default: >= 3). Values should be comprised between 1 and
      the maximum depth (10000 reads are taken in account).'
    default: 3
    inputBinding:
      position: 101
      prefix: -p
  - id: min_frequency
    type:
      - 'null'
      - float
    doc: 'Minimum frequency for alleles (default: >= 0.10).'
    default: 0.1
    inputBinding:
      position: 101
      prefix: -f
  - id: min_gene_coverage
    type:
      - 'null'
      - float
    doc: 'Minimum gene coverage from 0 to 1 (default: >= 0.5).'
    default: 0.5
    inputBinding:
      position: 101
      prefix: -c
  - id: min_msp_coverage
    type:
      - 'null'
      - int
    doc: 'Minimum percentage of signature genes from the MSP that are covered (default:
      >= 80%). Values should be comprised between 1% and 100%'
    default: 80
    inputBinding:
      position: 101
      prefix: -m
  - id: min_snp_depth
    type:
      - 'null'
      - int
    doc: 'Minimum snp depth (default: >= 3). Values should be comprised between 1
      and the maximum depth (10000 reads are taken in account), take in account that
      s >= p.'
    default: 3
    inputBinding:
      position: 101
      prefix: -s
  - id: ploidy
    type:
      - 'null'
      - int
    doc: 'Ploidy (default: 1).'
    default: 1
    inputBinding:
      position: 101
      prefix: -l
  - id: ref_dir
    type: Directory
    doc: Path to reference directory (Path containing *_reference.json)
    inputBinding:
      position: 101
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to perform variant calling (default: 1).'
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: tmp_path
    type:
      - 'null'
      - Directory
    doc: Path to the directory where temporary files are stored
    inputBinding:
      position: 101
      prefix: --tmp
outputs:
  - id: strain_dir
    type: Directory
    doc: Path to output directory.
    outputBinding:
      glob: $(inputs.strain_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
