cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - simulate
label: atlas_simulate
doc: "Simulating BAM (and optionally VCF) files with a matching reference genome.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
inputs:
  - id: chr_length
    type:
      - 'null'
      - string
    doc: "Chromosome length(s), comma-separated, e.g. \"10000\" or \"5000,8000\"."
    inputBinding:
      position: 1
      prefix: --chrLength
  - id: depth
    type:
      - 'null'
      - string
    doc: "Sequencing depth(s), comma-separated."
    inputBinding:
      position: 1
      prefix: --depth
  - id: ploidy
    type:
      - 'null'
      - string
    doc: "Ploidy per chromosome, e.g. \"2{3},1\"."
    inputBinding:
      position: 1
      prefix: --ploidy
  - id: sim_type
    type:
      - 'null'
      - string
    doc: "Type of simulation, e.g. one (single individual) or HW (Hardy-Weinberg population)."
    inputBinding:
      position: 1
      prefix: --type
  - id: sample_size
    type:
      - 'null'
      - int
    doc: "Number of individuals to simulate (population types)."
    inputBinding:
      position: 1
      prefix: --sampleSize
  - id: write_vcf
    type:
      - 'null'
      - boolean
    doc: "Simulate a VCF file of genotypes instead of BAM files."
    inputBinding:
      position: 1
      prefix: --vcf
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "Sequencing type: single or paired."
    inputBinding:
      position: 1
      prefix: --seqType
  - id: seq_cycles
    type:
      - 'null'
      - int
    doc: "Number of sequencing cycles (read length)."
    inputBinding:
      position: 1
      prefix: --seqCycles
  - id: num_read_groups
    type:
      - 'null'
      - int
    doc: "Number of read groups."
    inputBinding:
      position: 1
      prefix: --numReadGroups
  - id: theta
    type:
      - 'null'
      - float
    doc: "Population mutation rate theta."
    inputBinding:
      position: 1
      prefix: --theta
  - id: ref_div
    type:
      - 'null'
      - float
    doc: "Divergence from the reference."
    inputBinding:
      position: 1
      prefix: --refDiv
  - id: fragment_length
    type:
      - 'null'
      - string
    doc: "Fragment length distribution, e.g. \"gamma(10,0.2)[30,200]\"."
    inputBinding:
      position: 1
      prefix: --fragmentLength
  - id: base_quality
    type:
      - 'null'
      - string
    doc: "Base quality distribution, e.g. \"normal(30,10)[0,93]\"."
    inputBinding:
      position: 1
      prefix: --baseQuality
  - id: mapping_quality
    type:
      - 'null'
      - string
    doc: "Mapping quality distribution."
    inputBinding:
      position: 1
      prefix: --mappingQuality
  - id: pmd
    type:
      - 'null'
      - string
    doc: "Post-mortem damage model."
    inputBinding:
      position: 1
      prefix: --pmd
  - id: recal
    type:
      - 'null'
      - string
    doc: "Base quality recalibration model."
    inputBinding:
      position: 1
      prefix: --recal
  - id: fixed_seed
    type:
      - 'null'
      - int
    doc: "Set the random seed."
    inputBinding:
      position: 1
      prefix: --fixedSeed
  - id: out_prefix
    type: string
    doc: "Prefix for all output files (ATLAS --out)."
    default: "ATLAS_simulations"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: bams
    type: File[]
    doc: "Simulated BAM file(s) with index (none with --vcf)."
    secondaryFiles:
      - pattern: .bai
        required: false
    outputBinding:
      glob: $(inputs.out_prefix)*.bam
  - id: reference
    type: File
    doc: "Simulated reference genome with index."
    secondaryFiles:
      - pattern: .fai
        required: false
    outputBinding:
      glob: $(inputs.out_prefix).fasta
  - id: vcf
    type:
      - 'null'
      - File
    doc: "Simulated VCF file (with --vcf)."
    outputBinding:
      glob: $(inputs.out_prefix)*.vcf.gz
  - id: parameters
    type:
      - 'null'
      - File
    doc: "Parameters used for the run."
    outputBinding:
      glob: $(inputs.out_prefix).parameters
  - id: rg_info
    type:
      - 'null'
      - File
    doc: "Read group information."
    outputBinding:
      glob: $(inputs.out_prefix)_RGInfo.json
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_simulate.log
