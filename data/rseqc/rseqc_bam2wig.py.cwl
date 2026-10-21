cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bam2wig.py
label: rseqc_bam2wig.py
doc: 'Convert BAM file into wig file. BAM file must be sorted and indexed using SAMtools.

  Note: SAM format file is not supported.


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: input_file
  type: File
  secondaryFiles:
  - pattern: .bai
    required: true
  doc: Alignment file in BAM format. BAM file must be sorted and indexed using samTools.
    .bam and .bai files should be placed in the same directory.
  inputBinding:
    position: 1
    prefix: --input-file
- id: chrom_size
  type: File
  doc: 'Chromosome size file. Tab or space separated text file with 2 columns: first
    column is chromosome name/ID, second column is chromosome size. Chromosome name
    (such as "chr1") should be consistent between this file and the BAM file.'
  inputBinding:
    position: 1
    prefix: --chromSize
- id: out_prefix
  type: string
  doc: Prefix of output wiggle files(s). One wiggle file will be generated for non
    strand-specific data, two wiggle files ("Prefix_Forward.wig" and "Prefix_Reverse.wig")
    will be generated for strand-specific RNA-seq data.
  inputBinding:
    position: 1
    prefix: --out-prefix
- id: wigsum
  type:
  - 'null'
  - int
  doc: 'Specified wigsum. Eg: 1,000,000,000 equals to coverage of 10 million 100nt
    reads. Ignore this option to disable normalization.'
  inputBinding:
    position: 1
    prefix: --wigsum
- id: skip_multi_hits
  type:
  - 'null'
  - boolean
  doc: Skip non-unique hit reads.
  inputBinding:
    position: 1
    prefix: --skip-multi-hits
- id: strand
  type:
  - 'null'
  - string
  doc: 'How read(s) were stranded during sequencing. For example: --strand=''1++,1--,2+-,2-+''
    means that this is a pair-end, strand-specific RNA-seq data, and the strand rule
    is: read1 mapped to ''+'' => parental gene on ''+''; read1 mapped to ''-'' =>
    parental gene on ''-''; read2 mapped to ''+'' => parental gene on ''-''; read2
    mapped to ''-'' => parental gene on ''+''. If you are not sure about the strand
    rule, run ''infer_experiment.py''. default=none (Not a strand specific RNA-seq
    data).'
  inputBinding:
    position: 1
    prefix: --strand
- id: mapq
  type:
  - 'null'
  - int
  doc: Minimum mapping quality to determine "uniquely mapped". default=30
  inputBinding:
    position: 1
    prefix: --mapq
outputs:
- id: wig_files
  type:
    type: array
    items: File
  doc: 'Wiggle file(s): Prefix.wig, or Prefix.Forward.wig and Prefix.Reverse.wig for
    strand-specific data.'
  outputBinding:
    glob: $(inputs.out_prefix)*.wig
- id: bigwig_files
  type:
  - 'null'
  - type: array
    items: File
  doc: BigWig file(s) made from the wiggle file(s) when wigToBigWig is available.
  outputBinding:
    glob: $(inputs.out_prefix)*.bw
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
