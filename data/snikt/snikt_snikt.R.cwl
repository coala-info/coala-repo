cwlVersion: v1.2
class: CommandLineTool
baseCommand: snikt.R
label: snikt_snikt.R
doc: "FastQ QC and sequence over-representation check. A wrapper around seqtk to plot
  per-position nucleotide composition for finding and trimming adapter contamination
  in fastq reads. Also filters reads by a length threshold.\n\nTool homepage: https://github.com/piyuranjan/SNIKT"
inputs:
  - id: fastq
    type: File
    doc: 'Sequence file in fastQ format with exts: .fq, .fq.gz, .fastq, .fastq.gz'
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug with traceback; enables -v.
    inputBinding:
      position: 102
      prefix: --debug
  - id: filter
    type:
      - 'null'
      - int
    doc: Filter (drop) reads with length < nt after any trimming.
    default: 500
    inputBinding:
      position: 102
      prefix: --filter
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: If fastq file is gzipped. Autodetected normally using the file 
      extension. For large datasets, prior decompression of fastq may be faster.
      Only gzip is supported within; prior decompression needed for any other 
      method.
    inputBinding:
      position: 102
      prefix: --gzip
  - id: hide
    type:
      - 'null'
      - float
    doc: Hide the composition tail by a fraction of total bases. Significantly 
      improves speed, removes end-tail (3') distortion for variable length read 
      sets.
    default: 0.01
    inputBinding:
      position: 102
      prefix: --hide
  - id: illumina
    type:
      - 'null'
      - boolean
    doc: 'This presets options that are better for short-read Illumina datasets. Sets:
      -f 0 -Z 50 -z 50 --hide=0 Defaults are configured for long-read Nanopore fastq.'
    inputBinding:
      position: 102
      prefix: --illumina
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep intermediate (temporary) directory.
    inputBinding:
      position: 102
      prefix: --keep
  - id: notrim
    type:
      - 'null'
      - boolean
    doc: 'Disable positional trimming; useful for short-read data Takes precedence
      over and sets: -T 0 -t 0'
    inputBinding:
      position: 102
      prefix: --notrim
  - id: out
    type:
      - 'null'
      - string
    doc: Prefix for output files
    default: fastqNoExtension
    inputBinding:
      position: 102
      prefix: --out
  - id: skim
    type:
      - 'null'
      - int
    doc: Use top num reads for pre- or no-trim graphs. This improves speed. No 
      effect on post-trim graphs. Use 0 to disable skimming and utilize all 
      reads.
    default: 10000
    inputBinding:
      position: 102
      prefix: --skim
  - id: trim3
    type:
      - 'null'
      - int
    doc: Trim nt bases from aligned 3' side.
    default: interactive
    inputBinding:
      position: 102
      prefix: --trim3
  - id: trim5
    type:
      - 'null'
      - int
    doc: Trim nt bases from aligned 5' side.
    default: interactive
    inputBinding:
      position: 102
      prefix: --trim5
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable status messages.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: Path to generate QC file and report.
    default: ./
    inputBinding:
      position: 102
      prefix: --workdir
  - id: xbreaks
    type:
      - 'null'
      - int
    doc: Suggest number of ticks/breaks on x-axis in all graphs. Can be set if 
      the breaks or gridlines are too sparse or dense to determine appropriate 
      trimming. Internal algorithm adjusts ticks.
    default: 6
    inputBinding:
      position: 102
      prefix: --xbreaks
  - id: zoom3
    type:
      - 'null'
      - int
    doc: Zoom-in from aligned 3' ending to nt bases.
    default: 100
    inputBinding:
      position: 102
      prefix: --zoom3
  - id: zoom5
    type:
      - 'null'
      - int
    doc: Zoom-in from aligned 5' beginning to nt bases.
    default: 300
    inputBinding:
      position: 102
      prefix: --zoom5
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snikt:0.5.0--r44hdfd78af_3
stdout: snikt_snikt.R.out
