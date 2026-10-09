cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - combine-counts
label: hatchet_combine_counts
doc: "Perform adaptive binning, compute RDR and BAF for each bin, and produce a BB file.

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: array
    type: Directory
    doc: "Directory containing array files (output from \"count-reads\" command)"
    inputBinding:
      position: 10
      prefix: -A
  - id: totalcounts
    type: File
    doc: "Total read counts in the format \"SAMPLE COUNT\" used to normalize by the different number of reads extracted from each sample"
    inputBinding:
      position: 10
      prefix: -t
  - id: baffile
    type: File
    doc: "1bed file containing SNP information from tumor samples (i.e., baf/bulk.1bed)"
    inputBinding:
      position: 10
      prefix: -b
  - id: referencefasta
    type: File
    secondaryFiles:
      - '.fai'
    doc: Path to the reference genome fasta file
    inputBinding:
      position: 10
      prefix: -r
  - id: outfile
    type: string
    doc: Filename for output (a bare file name is written to the working directory)
    inputBinding:
      position: 10
      prefix: -o
      valueFrom: "$(self.indexOf('/') < 0 ? './' + self : self)"
  - id: refversion
    type: string
    doc: Version of reference genome used in BAM files
    inputBinding:
      position: 10
      prefix: -V
  - id: msr
    type:
      - 'null'
      - int
    doc: Minimum SNP reads per bin (default 5000)
    inputBinding:
      position: 10
      prefix: --msr
  - id: mtr
    type:
      - 'null'
      - int
    doc: Minimum total reads per bin (default 5000)
    inputBinding:
      position: 10
      prefix: --mtr
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of parallel processes to use (default 1)
    inputBinding:
      position: 10
      prefix: -j
  - id: phase
    type:
      - 'null'
      - File
    doc: VCF file containing phasing for heterozygous germline SNPs
    inputBinding:
      position: 10
      prefix: -p
  - id: max_blocksize
    type:
      - 'null'
      - int
    doc: Maximum size of phasing block (default 25000)
    inputBinding:
      position: 10
      prefix: -s
  - id: max_spb
    type:
      - 'null'
      - int
    doc: Maximum number of SNPs per phasing block (default 10)
    inputBinding:
      position: 10
      prefix: -m
  - id: alpha
    type:
      - 'null'
      - float
    doc: Significance level for phase blocking adjacent SNPs. Higher means less trust in phasing. (default 0.1)
    inputBinding:
      position: 10
      prefix: -a
  - id: ss_em
    type:
      - 'null'
      - boolean
    doc: Use single-sample EM BAF inference (instead of multi-sample)
    inputBinding:
      position: 10
      prefix: --ss_em
  - id: not_compressed
    type:
      - 'null'
      - boolean
    doc: Non-compressed intermediate files
    inputBinding:
      position: 10
      prefix: -z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: bb_file
    type: File
    doc: BB file with RDR and BAF of each bin
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
stdout: hatchet_combine_counts.out
