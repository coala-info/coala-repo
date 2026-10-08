cwlVersion: v1.2
class: CommandLineTool
baseCommand: extractHAIRS
label: hapcut2_extractHAIRS
doc: "Extract haplotype informative reads (HAIRS) from coordinate sorted BAM/CRAM files (for a single individual). The fragment file is the input of HAPCUT2.\n\nTool homepage: https://github.com/vibansal/HapCUT2/"
inputs:
  - id: bam
    type:
      type: array
      items: File
      inputBinding:
        prefix: --bam
    doc: sorted and indexed BAM/CRAM file; the option can be used more than
      once to specify multiple files for the same sample
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 1
  - id: variants
    type: File
    doc: variant file with genotypes for a single individual in VCF format
      (unzipped)
    inputBinding:
      position: 2
      prefix: --VCF
  - id: qvoffset
    type:
      - 'null'
      - int
    doc: quality value offset, 33/64 depending on how quality values were
      encoded, default is 33
    inputBinding:
      position: 10
      prefix: --qvoffset
  - id: mbq
    type:
      - 'null'
      - int
    doc: minimum base quality to consider a base for haplotype fragment,
      default 13
    inputBinding:
      position: 11
      prefix: --mbq
  - id: mmq
    type:
      - 'null'
      - int
    doc: minimum read mapping quality to consider a read for phasing,
      default 20
    inputBinding:
      position: 12
      prefix: --mmq
  - id: realign_variants
    type:
      - 'null'
      - int
    doc: perform sensitive realignment and scoring of variants (0 or 1)
    inputBinding:
      position: 13
      prefix: --realign_variants
  - id: hic
    type:
      - 'null'
      - int
    doc: sets default maxIS to 40MB, prints matrix in new HiC format (0 or
      1)
    inputBinding:
      position: 14
      prefix: --hic
  - id: tenx
    type:
      - 'null'
      - int
    doc: 10X reads (0 or 1). Output fragments MUST be processed with the
      LinkFragments.py script after extractHAIRS to work with HapCUT2
    inputBinding:
      position: 15
      prefix: --10X
  - id: pacbio
    type:
      - 'null'
      - int
    doc: Pacific Biosciences reads (0 or 1). Similar to --realign_variants,
      but with alignment parameters tuned for PacBio reads
    inputBinding:
      position: 16
      prefix: --pacbio
  - id: ont
    type:
      - 'null'
      - int
    doc: Oxford nanopore technology reads (0 or 1). Similar to
      --realign_variants, but with alignment parameters tuned for Oxford
      Nanopore Reads
    inputBinding:
      position: 17
      prefix: --ONT
  - id: new_format
    type:
      - 'null'
      - int
    doc: prints matrix in new format (0 or 1). Requires --new_format option
      when running HapCUT2
    inputBinding:
      position: 18
      prefix: --new_format
  - id: maxis
    type:
      - 'null'
      - int
    doc: maximum insert size for a paired-end read to be considered as a
      single fragment for phasing, default 1000
    inputBinding:
      position: 19
      prefix: --maxIS
  - id: minis
    type:
      - 'null'
      - int
    doc: minimum insert size for a paired-end read to be considered as
      single fragment for phasing, default 0
    inputBinding:
      position: 20
      prefix: --minIS
  - id: peonly
    type:
      - 'null'
      - int
    doc: do not use single end reads (0 or 1), default is 0 (use all reads)
    inputBinding:
      position: 21
      prefix: --PEonly
  - id: indels
    type:
      - 'null'
      - int
    doc: extract reads spanning INDELS (0 or 1), default is 0, variants need
      to specified in VCF format to use this option
    inputBinding:
      position: 22
      prefix: --indels
  - id: noquality
    type:
      - 'null'
      - int
    doc: if the bam file does not have quality string, this value will be
      used as the uniform quality value, default 0
    inputBinding:
      position: 23
      prefix: --noquality
  - id: triallelic
    type:
      - 'null'
      - int
    doc: include variants with genotype 1/2 for parsing (0 or 1), default 0
    inputBinding:
      position: 24
      prefix: --triallelic
  - id: ref
    type:
      - 'null'
      - File
    doc: reference sequence file (in fasta format, gzipped is okay),
      optional but required for indels and CRAM files, should be indexed
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 25
      prefix: --ref
  - id: region
    type:
      - 'null'
      - string
    doc: "chromosome and region in BAM file (chr:start-end), useful to process individual chromosomes or genomic regions"
    inputBinding:
      position: 26
      prefix: --region
  - id: ep
    type:
      - 'null'
      - int
    doc: set to 1 to estimate HMM parameters from aligned reads (only with
      long reads), default = 1
    inputBinding:
      position: 27
      prefix: --ep
  - id: hom
    type:
      - 'null'
      - int
    doc: set to 1 to include homozygous variants for processing, default = 0
      (only heterozygous)
    inputBinding:
      position: 28
      prefix: --hom
  - id: out_path
    type:
      - 'null'
      - string
    doc: output filename for haplotype fragments, if not provided, fragments
      will be output to stdout
    inputBinding:
      position: 29
      prefix: --out
outputs:
  - id: fragments
    type:
      - 'null'
      - File
    doc: output filename for haplotype fragments
    outputBinding:
      glob: $(inputs.out_path)
  - id: stdout
    type: stdout
    doc: Haplotype fragments when out_path is not given
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2
stdout: hapcut2_extractHAIRS.out
