cwlVersion: v1.2
class: CommandLineTool
baseCommand: xyalign
label: xyalign_strip_reads
doc: "Limit XYalign to only the steps required to strip reads from a provided bam\
  \ file.\n\nTool homepage: https://github.com/WilsonSayresLab/XYalign"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: Full path to input bam files (indexed). If more than one provided, only the
      first will be used for modules other than CHROM_STATS
    inputBinding:
      position: 101
      prefix: --bam
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
  - id: bwa_path
    type:
      - 'null'
      - string
    doc: Path to bwa. Default is 'bwa'
    inputBinding:
      position: 101
      prefix: --bwa_path
  - id: chromosomes
    type:
      type: array
      items: string
    doc: Chromosomes to analyze (names must match reference exactly). For humans,
      we recommend at least chr19, chrX, chrY. Generally, we suggest including the
      sex chromosomes and at least one autosome. To analyze all chromosomes use '--chromosomes
      ALL' or '--chromosomes all'.
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cores/threads to use. Default is 1
    inputBinding:
      position: 101
      prefix: --cpus
  - id: fastq_compression
    type:
      - 'null'
      - int
    doc: Compression level for fastqs output from repair.sh. Between (inclusive) 0
      and 9. Default is 3. 1 through 9 indicate compression levels. If 0, fastqs will
      be uncompressed.
    inputBinding:
      position: 101
      prefix: --fastq_compression
  - id: logfile
    type:
      - 'null'
      - string
    doc: Name of logfile. Will overwrite if exists. Default is sample_xyalign.log
    inputBinding:
      position: 101
      prefix: --logfile
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Include flag to preserve temporary files.
    inputBinding:
      position: 101
      prefix: --no_cleanup
  - id: read_group_id
    type:
      - 'null'
      - string
    doc: If read groups are present in a bam file, they are used by default in remapping
      steps. However, if read groups are not present in a file, there are two options
      for proceeding. If '--read_group_id None' is provided (case sensitive), then
      no read groups will be used in subsequent mapping steps. Otherwise, any other
      string provided to this flag will be used as a read group ID. Default is '--read_group_id
      xyalign'
    inputBinding:
      position: 101
      prefix: --read_group_id
  - id: ref
    type: File
    doc: Path to reference sequence (including file name). Must have a .fai index
      beside it.
    inputBinding:
      position: 101
      prefix: --ref
    secondaryFiles:
      - pattern: .fai
        required: false
  - id: repairsh_path
    type:
      - 'null'
      - string
    doc: Path to bbmap's repair.sh script. Default is 'repair.sh'
    inputBinding:
      position: 101
      prefix: --repairsh_path
  - id: reporting_level
    type:
      - 'null'
      - string
    doc: Set level of messages printed to console. Default is 'INFO'. Choose from
      (in decreasing amount of reporting) DEBUG, INFO, ERROR or CRITICAL
    inputBinding:
      position: 101
      prefix: --reporting_level
  - id: sambamba_path
    type:
      - 'null'
      - string
    doc: Path to sambamba. Default is 'sambamba'
    inputBinding:
      position: 101
      prefix: --sambamba_path
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Name/ID of sample - for use in plot titles and file naming. Default is sample
    inputBinding:
      position: 101
      prefix: --sample_id
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: Path to samtools. Default is 'samtools'
    inputBinding:
      position: 101
      prefix: --samtools_path
  - id: shufflesh_path
    type:
      - 'null'
      - string
    doc: Path to bbmap's shuffle.sh script. Default is 'shuffle.sh'
    inputBinding:
      position: 101
      prefix: --shufflesh_path
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: Include flag if reads are single-end and NOT paired-end.
    inputBinding:
      position: 101
      prefix: --single_end
  - id: skip_compatibility_check
    type:
      - 'null'
      - boolean
    doc: Include flag to prevent check of compatibility between input bam and reference
      fasta
    inputBinding:
      position: 101
      prefix: --skip_compatibility_check
  - id: xmx
    type:
      - 'null'
      - string
    doc: Memory to be provided to java programs via -Xmx. E.g., use the flag '--xmx
      4g' to pass '-Xmx4g' as a flag when running java programs (currently just repair.sh).
      Default is 'None' (i.e., nothing provided on the command line), which will allow
      repair.sh to automatically allocate memory. Note that if you're using --STRIP_READS
      on deep coverage whole genome data, you might need quite a bit of memory, e.g.
      '--xmx 16g', '--xmx 32g', or more depending on how many reads are present per
      read group.
    inputBinding:
      position: 101
      prefix: --xmx
  - id: output_dir
    type: string
    default: xyalign_output
    doc: Output directory. XYalign will create a directory structure within this directory
    inputBinding:
      position: 101
      prefix: --output_dir
outputs:
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 1
    valueFrom: --STRIP_READS
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xyalign:1.1.5--py_1
stdout: xyalign_strip_reads.out
