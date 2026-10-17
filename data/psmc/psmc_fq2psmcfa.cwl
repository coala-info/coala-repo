cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fq2psmcfa
label: psmc_fq2psmcfa
doc: "Convert a diploid consensus FASTQ into the PSMCFA input of psmc (one K/T/N character per bin)\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: input_fastq
    type: File
    doc: "Diploid consensus sequence in FASTQ format (IUPAC codes for heterozygous sites); may be gzipped"
    inputBinding:
      position: 100
  - id: min_quality
    type:
      - 'null'
      - int
    doc: "Minimum base quality (default: 10)"
    inputBinding:
      position: 1
      prefix: "-q"
  - id: mask_pseudo
    type:
      - 'null'
      - boolean
    doc: "Mask the pseudo-autosomal regions of sequences named X or chrX (build 36 coordinates)"
    inputBinding:
      position: 2
      prefix: "-x"
  - id: transversions_only
    type:
      - 'null'
      - boolean
    doc: "Only count transversions as heterozygous sites"
    inputBinding:
      position: 3
      prefix: "-v"
  - id: transitions_only
    type:
      - 'null'
      - boolean
    doc: "Only count transitions as heterozygous sites"
    inputBinding:
      position: 4
      prefix: "-n"
  - id: cpg_only
    type:
      - 'null'
      - boolean
    doc: "Only use CpG sites"
    inputBinding:
      position: 5
      prefix: "-c"
  - id: exclude_cpg
    type:
      - 'null'
      - boolean
    doc: "Exclude CpG sites"
    inputBinding:
      position: 6
      prefix: "-C"
  - id: min_good
    type:
      - 'null'
      - int
    doc: "Minimum number of good bases a sequence needs to be written (default: 10000; at least 20 percent must be good)"
    inputBinding:
      position: 7
      prefix: "-g"
  - id: block_size
    type:
      - 'null'
      - int
    doc: "Bin size in bp (default: 100)"
    inputBinding:
      position: 8
      prefix: "-s"
outputs:
  - id: psmcfa
    type: stdout
    doc: "PSMCFA sequence for psmc"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: diploid.psmcfa
