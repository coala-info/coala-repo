cwlVersion: v1.2
class: CommandLineTool
baseCommand: PoolSNP.sh
label: poolsnp_PoolSNP.sh
doc: "PoolSNP v. 1.05 - 13/11/2017\n\nTool homepage: https://github.com/capoony/PoolSNP"
inputs:
  - id: base_quality
    type:
      - 'null'
      - int
    doc: minimum base quality for every nucleotide
    inputBinding:
      position: 101
      prefix: base-quality=
      separate: false
  - id: jobs
    type:
      - 'null'
      - int
    doc: number of parallel jobs/cores used for the SNP calling
    inputBinding:
      position: 101
      prefix: jobs=
      separate: false
  - id: max_cov
    type: string
    doc: Either the maximum coverage percentile to be computed or an input file
    inputBinding:
      position: 101
      prefix: max-cov=
      separate: false
  - id: min_count
    type: int
    doc: minimum alternative allele count across all populations pooled
    inputBinding:
      position: 101
      prefix: min-count=
      separate: false
  - id: min_cov
    type: int
    doc: sample-wise minimum coverage
    inputBinding:
      position: 101
      prefix: min-cov=
      separate: false
  - id: min_freq
    type: float
    doc: minimum alternative allele frequency across all populations pooled
    inputBinding:
      position: 101
      prefix: min-freq=
      separate: false
  - id: miss_frac
    type: float
    doc: maximum allowed fraction of samples not fullfilling all parameters
    inputBinding:
      position: 101
      prefix: miss-frac=
      separate: false
  - id: mpileup
    type: File
    doc: The input mpileup
    inputBinding:
      position: 101
      prefix: mpileup=
      separate: false
  - id: names
    type: string
    doc: A comma separated list of samples names according to the order in the 
      mpileup file
    inputBinding:
      position: 101
      prefix: names=
      separate: false
  - id: output
    type: string
    doc: The output prefix (file name prefix; written in the working directory)
    inputBinding:
      position: 101
      prefix: output=
      separate: false
      valueFrom: $(runtime.outdir)/$(self)
  - id: badsites
    type:
      - 'null'
      - int
    doc: 1 to also write a bad-sites file (sites that did not pass the SNP calling criteria)
    inputBinding:
      position: 101
      prefix: badsites=
      separate: false
  - id: allsites
    type:
      - 'null'
      - int
    doc: 1 to report all sites irrespective of whether they are polymorphic (disables miss-frac)
    inputBinding:
      position: 101
      prefix: allsites=
      separate: false
  - id: reference
    type: File
    doc: The reference FASTA file
    inputBinding:
      position: 101
      prefix: reference=
      separate: false
outputs:
  - id: vcf
    type: File
    doc: Gzipped VCF file with allele counts and frequencies
    outputBinding:
      glob: $(inputs.output).vcf.gz
  - id: max_cov_file
    type:
      - 'null'
      - File
    doc: Maximum coverage thresholds per contig and sample
    outputBinding:
      glob: $(inputs.output)-cov-*.txt
  - id: bad_sites
    type:
      - 'null'
      - File
    doc: Gzipped bad-sites file
    outputBinding:
      glob: $(inputs.output)_BS.txt.gz
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poolsnp:1.0.1--py312h7e72e81_0
stdout: poolsnp_PoolSNP.sh.out
