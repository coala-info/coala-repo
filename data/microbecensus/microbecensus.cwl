cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_microbe_census.py
label: microbecensus
doc: "MicrobeCensus: Estimate average genome size (AGS) from metagenomic shotgun data.\n\nTool homepage:\
  \ https://github.com/snayfach/MicrobeCensus"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print program's progress to stdout (default = False).
    inputBinding:
      position: 101
      prefix: -v
  - id: rapsearch
    type:
      - 'null'
      - File
    doc: Path to external RAPsearch2 v2.15 binary; useful if the precompiled binary included with MicrobeCensus
      does not work on your system.
    inputBinding:
      position: 101
      prefix: -r
  - id: nreads
    type:
      - 'null'
      - int
    doc: Number of reads to sample from SEQFILES and use for average genome size estimation. To use all
      reads set to 100000000 (default = 2000000).
    inputBinding:
      position: 101
      prefix: -n
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for database search (default = 1).
    inputBinding:
      position: 101
      prefix: -t
  - id: quit_after_ags
    type:
      - 'null'
      - boolean
    doc: Quit after average genome size is obtained and do not estimate the number of genome equivalents
      in SEQFILES (default = False).
    inputBinding:
      position: 101
      prefix: -e
  - id: read_length
    type:
      - 'null'
      - int
    doc: All reads trimmed to this length; reads shorter than this discarded (50, 60, ..., 150, 175, 200,
      225, 250, 300, 350, 400, 450, 500; default = median read length).
    inputBinding:
      position: 101
      prefix: -l
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum base-level PHRED quality score (default = -5; no filtering).
    inputBinding:
      position: 101
      prefix: -q
  - id: mean_quality
    type:
      - 'null'
      - int
    doc: Minimum read-level PHRED quality score (default = -5; no filtering).
    inputBinding:
      position: 101
      prefix: -m
  - id: filter_duplicates
    type:
      - 'null'
      - boolean
    doc: Filter duplicate reads (default = False).
    inputBinding:
      position: 101
      prefix: -d
  - id: max_unknown
    type:
      - 'null'
      - int
    doc: Max percent of unknown bases per read (default = 100 percent; no filtering).
    inputBinding:
      position: 101
      prefix: -u
  - id: seqfiles
    type:
      type: array
      items: File
    doc: Input metagenome(s); for paired-end metagenomes give both files (joined with a comma on the command
      line); FASTQ/FASTA, optionally gzip or bzip2 compressed.
    inputBinding:
      position: 201
      itemSeparator: ','
  - id: outfile
    type: string
    doc: Name of the output file containing the results.
    inputBinding:
      position: 202
outputs:
  - id: results
    type: File
    doc: Estimated average genome size and genome equivalents.
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microbecensus:1.1.1--0
