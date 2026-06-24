cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasterq-dump
label: sra-tools_fasterq-dump
doc: A tool for dumping data from SRA accessions or paths in FASTQ/FASTA format,
  designed for speed and efficiency.
inputs:
  - id: input
    type: string
    doc: Path or accession to process
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: format (special, fastq, default=fastq)
    inputBinding:
      position: 102
      prefix: --format
  - id: outfile
    type: string
    doc: output-file
    inputBinding:
      position: 102
      prefix: --outfile
  - id: outdir
    type: string
    doc: output-dir
    inputBinding:
      position: 102
      prefix: --outdir
  - id: bufsize
    type:
      - 'null'
      - string
    doc: size of file-buffer
    inputBinding:
      position: 102
      prefix: --bufsize
  - id: curcache
    type:
      - 'null'
      - string
    doc: size of cursor-cache
    inputBinding:
      position: 102
      prefix: --curcache
  - id: mem
    type:
      - 'null'
      - string
    doc: memory limit for sorting
    inputBinding:
      position: 102
      prefix: --mem
  - id: temp
    type:
      - 'null'
      - Directory
    doc: where to put temp. files
    inputBinding:
      position: 102
      prefix: --temp
  - id: threads
    type:
      - 'null'
      - int
    doc: how many thread
    inputBinding:
      position: 102
      prefix: --threads
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show progress
    inputBinding:
      position: 102
      prefix: --progress
  - id: details
    type:
      - 'null'
      - boolean
    doc: print details
    inputBinding:
      position: 102
      prefix: --details
  - id: split_spot
    type:
      - 'null'
      - boolean
    doc: split spots into reads
    inputBinding:
      position: 102
      prefix: --split-spot
  - id: split_files
    type:
      - 'null'
      - boolean
    doc: write reads into different files
    inputBinding:
      position: 102
      prefix: --split-files
  - id: split_3
    type:
      - 'null'
      - boolean
    doc: writes single reads in special file
    inputBinding:
      position: 102
      prefix: --split-3
  - id: concatenate_reads
    type:
      - 'null'
      - boolean
    doc: writes whole spots into one file
    inputBinding:
      position: 102
      prefix: --concatenate-reads
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: print output to stdout
    inputBinding:
      position: 102
      prefix: --stdout
  - id: force
    type:
      - 'null'
      - boolean
    doc: force to overwrite existing file(s)
    inputBinding:
      position: 102
      prefix: --force
  - id: skip_technical
    type:
      - 'null'
      - boolean
    doc: skip technical reads
    inputBinding:
      position: 102
      prefix: --skip-technical
  - id: include_technical
    type:
      - 'null'
      - boolean
    doc: include technical reads
    inputBinding:
      position: 102
      prefix: --include-technical
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: filter by sequence-len
    inputBinding:
      position: 102
      prefix: --min-read-len
  - id: table
    type:
      - 'null'
      - string
    doc: which seq-table to use in case of pacbio
    inputBinding:
      position: 102
      prefix: --table
  - id: bases
    type:
      - 'null'
      - string
    doc: filter by bases
    inputBinding:
      position: 102
      prefix: --bases
  - id: append
    type:
      - 'null'
      - boolean
    doc: append to output-file
    inputBinding:
      position: 102
      prefix: --append
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: produce FASTA output
    inputBinding:
      position: 102
      prefix: --fasta
  - id: fasta_unsorted
    type:
      - 'null'
      - boolean
    doc: produce FASTA output, unsorted
    inputBinding:
      position: 102
      prefix: --fasta-unsorted
  - id: fasta_ref_tbl
    type:
      - 'null'
      - boolean
    doc: produce FASTA output from REFERENCE tbl
    inputBinding:
      position: 102
      prefix: --fasta-ref-tbl
  - id: fasta_concat_all
    type:
      - 'null'
      - boolean
    doc: concatenate all rows and produce FASTA
    inputBinding:
      position: 102
      prefix: --fasta-concat-all
  - id: internal_ref
    type:
      - 'null'
      - boolean
    doc: extract only internal REFERENCEs
    inputBinding:
      position: 102
      prefix: --internal-ref
  - id: external_ref
    type:
      - 'null'
      - boolean
    doc: extract only external REFERENCEs
    inputBinding:
      position: 102
      prefix: --external-ref
  - id: ref_name
    type:
      - 'null'
      - string
    doc: extract only these REFERENCEs
    inputBinding:
      position: 102
      prefix: --ref-name
  - id: ref_report
    type:
      - 'null'
      - boolean
    doc: enumerate references
    inputBinding:
      position: 102
      prefix: --ref-report
  - id: use_name
    type:
      - 'null'
      - boolean
    doc: print name instead of seq-id
    inputBinding:
      position: 102
      prefix: --use-name
  - id: seq_defline
    type:
      - 'null'
      - string
    doc: 'custom defline for sequence: $ac=accession, $sn=spot-name, $sg=spot-group,
      $si=spot-id, $ri=read-id, $rl=read-length'
    inputBinding:
      position: 102
      prefix: --seq-defline
  - id: qual_defline
    type:
      - 'null'
      - string
    doc: 'custom defline for qualities: same as seq-defline'
    inputBinding:
      position: 102
      prefix: --qual-defline
  - id: only_unaligned
    type:
      - 'null'
      - boolean
    doc: process only unaligned reads
    inputBinding:
      position: 102
      prefix: --only-unaligned
  - id: only_aligned
    type:
      - 'null'
      - boolean
    doc: process only aligned reads
    inputBinding:
      position: 102
      prefix: --only-aligned
  - id: disk_limit
    type:
      - 'null'
      - string
    doc: explicitly set disk-limit
    inputBinding:
      position: 102
      prefix: --disk-limit
  - id: disk_limit_tmp
    type:
      - 'null'
      - string
    doc: explicitly set disk-limit for temp. files
    inputBinding:
      position: 102
      prefix: --disk-limit-tmp
  - id: size_check
    type:
      - 'null'
      - string
    doc: 'switch to control: on=perform size-check (default), off=do not perform size-check,
      only=perform size-check only'
    inputBinding:
      position: 102
      prefix: --size-check
  - id: ngc
    type:
      - 'null'
      - File
    doc: PATH to ngc file
    inputBinding:
      position: 102
      prefix: --ngc
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level as number or enum string. One of 
      (fatal|sys|int|err|warn|info|debug) or (0-6)
    inputBinding:
      position: 102
      prefix: --log-level
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off all status messages for the program.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: option_file
    type:
      - 'null'
      - File
    doc: Read more options and parameters from the file.
    inputBinding:
      position: 102
      prefix: --option-file
outputs:
  - id: output_outfile
    type:
      - 'null'
      - File
    doc: output-file
    outputBinding:
      glob: $(inputs.outfile)
  - id: output_outdir
    type:
      - 'null'
      - Directory
    doc: output-dir
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.4.1--2_linux_64
s:url: https://github.com/ncbi/sra-tools
$namespaces:
  s: https://schema.org/
