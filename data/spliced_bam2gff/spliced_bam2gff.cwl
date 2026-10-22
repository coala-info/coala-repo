cwlVersion: v1.2
class: CommandLineTool
baseCommand: spliced_bam2gff
label: spliced_bam2gff
doc: "A tool to convert spliced BAM alignments into GFF format, typically used in
  transcriptomic pipelines like PASA.\n\nTool homepage: https://github.com/nanoporetech/spliced_bam2gff"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file containing spliced alignments.
    inputBinding:
      position: 10
  - id: loci_dir
    type:
      - 'null'
      - string
    doc: Write output partitioned into "loci" to this directory. Turns off 
      output to stdout.
    inputBinding:
      position: 1
      prefix: -L
  - id: minimap2
    type:
      - 'null'
      - boolean
    doc: Input is from minimap2.
    inputBinding:
      position: 2
      prefix: -M
  - id: keep_secondary
    type:
      - 'null'
      - boolean
    doc: Do NOT discard secondary and supplementary alignments.
    inputBinding:
      position: 3
      prefix: -S
  - id: bundle_size
    type:
      - 'null'
      - int
    doc: Bundle together loci in batches with at least this size. (default -1)
    inputBinding:
      position: 4
      prefix: -b
  - id: deletion_intron_size
    type:
      - 'null'
      - int
    doc: Classify all deletions larger than this as introns (-1 means off). 
      (default -1)
    inputBinding:
      position: 5
      prefix: -d
  - id: strand_tag
    type:
      - 'null'
      - boolean
    doc: Use strand tag as feature orientation then read strand if not 
      available.
    inputBinding:
      position: 6
      prefix: -g
  - id: read_strand
    type:
      - 'null'
      - boolean
    doc: Use read strand (from BAM flag) as feature orientation.
    inputBinding:
      position: 7
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of cores to use. (default 8)
    inputBinding:
      position: 8
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: GFF output (empty when loci_dir is given)
  - id: loci_output
    type:
      - 'null'
      - Directory
    doc: Directory of per-locus GFF files written with loci_dir
    outputBinding:
      glob: $(inputs.loci_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spliced_bam2gff:1.3--he881be0_1
stdout: spliced_bam2gff.out
