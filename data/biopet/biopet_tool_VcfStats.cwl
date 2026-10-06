cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - VcfStats
label: biopet_tool_VcfStats
doc: "Generate statistics (general, info and genotype tags, sample-to-sample) from a VCF file.\n\
  \nTool homepage: https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '${ return [{"class": "Directory", "basename": inputs.output_dir, "listing": [], "writable":
        true}]; }'
inputs:
  - id: input_file
    type: File
    doc: Input VCF file (required)
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: reference_file
    type: File
    doc: Fasta reference which was used to call input VCF (required)
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
    inputBinding:
      position: 101
      prefix: --referenceFile
  - id: output_dir
    type: string
    doc: Path to directory for output (required)
    inputBinding:
      position: 101
      prefix: --outputDir
  - id: intervals
    type:
      - 'null'
      - File
    doc: Path to interval (BED) file (optional)
    inputBinding:
      position: 101
      prefix: --intervals
  - id: info_tag
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --infoTag
    doc: Summarize these info tags. Default is (QUAL, general, AC, AF, AN, DP)
    inputBinding:
      position: 101
  - id: genotype_tag
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --genotypeTag
    doc: Summarize these genotype tags. Default is (DP, GQ, AD, AD-ref, AD-alt, AD-used, AD-not_used,
      general)
    inputBinding:
      position: 101
  - id: all_info_tags
    type:
      - 'null'
      - boolean
    doc: Summarize all info tags. Default false
    inputBinding:
      position: 101
      prefix: --allInfoTags
  - id: all_genotype_tags
    type:
      - 'null'
      - boolean
    doc: Summarize all genotype tags. Default false
    inputBinding:
      position: 101
      prefix: --allGenotypeTags
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Binsize in estimated base pairs
    inputBinding:
      position: 101
      prefix: --binSize
  - id: write_bin_stats
    type:
      - 'null'
      - boolean
    doc: Write bin statistics. Default False
    inputBinding:
      position: 101
      prefix: --writeBinStats
  - id: general_wiggle
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --generalWiggle
    doc: Create a wiggle track with bin size <binSize> for these statistics (Total, Biallelic,
      SNP, Indel, ...)
    inputBinding:
      position: 101
  - id: genotype_wiggle
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --genotypeWiggle
    doc: Create a wiggle track with bin size <binSize> for these genotype fields (Total, Het,
      Hom, HomRef, HomVar, ...)
    inputBinding:
      position: 101
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: output
    type: Directory
    doc: Output directory with the statistics
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
