cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - vcfgeno
label: mccortex_vcfgeno
doc: "Genotype a VCF after running vcfcov to add sample coverage.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence status output normally printed to STDERR.
    inputBinding:
      position: 1
      prefix: --quiet
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output files if they already exist.
    inputBinding:
      position: 1
      prefix: --force
  - id: out
    type: string
    default: vcfgeno.vcf
    doc: Output VCF file.
    inputBinding:
      position: 1
      prefix: --out
  - id: out_fmt
    type:
      - 'null'
      - string
    doc: 'Output format: vcf, vcfgz, bcf or ubcf.'
    inputBinding:
      position: 1
      prefix: --out-fmt
  - id: err
    type:
      - 'null'
      - string
    doc: Comma-separated list of sample error rates per bp (default 0.01).
    inputBinding:
      position: 1
      prefix: --err
  - id: cov
    type:
      - 'null'
      - string
    doc: Comma-separated list of genome coverage per colour. Give exactly one of --cov and --kcov.
    inputBinding:
      position: 1
      prefix: --cov
  - id: kcov
    type:
      - 'null'
      - string
    doc: Comma-separated list of k-mer coverage per colour. Give exactly one of --cov and --kcov.
    inputBinding:
      position: 1
      prefix: --kcov
  - id: ploidy
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ploidy
    doc: Ploidy as <ploidy> or sample:chr:ploidy; 'sample' and 'chr' can be comma-separated lists and '.' means all. Applied in order. Can be given multiple times.
    inputBinding:
      position: 1
  - id: llk
    type:
      - 'null'
      - boolean
    doc: Print all log likelihoods.
    inputBinding:
      position: 1
      prefix: --llk
  - id: rm_cov
    type:
      - 'null'
      - boolean
    doc: Remove tags set by the 'vcfcov' command.
    inputBinding:
      position: 1
      prefix: --rm-cov
  - id: read_len
    type:
      - 'null'
      - string
    doc: Comma-separated list to override read lengths.
    inputBinding:
      position: 1
      prefix: --read-len
  - id: vcf
    type: File
    doc: Input VCF file, after running vcfcov (biallelic, ploidy 1 or 2).
    inputBinding:
      position: 100
outputs:
  - id: vcf_out
    type: File
    doc: Genotyped VCF file.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
