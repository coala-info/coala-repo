cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - portcullis
  - full
label: portcullis_full
doc: "Runs prep, junc, filter, and optionally bamfilt, as a complete pipeline. Assumes
  that the self-trained machine learning approach for filtering is to be used.\n\n\
  Tool homepage: https://github.com/maplesond/portcullis"
inputs:
  - id: genome_file
    type: File
    doc: Genome file
    inputBinding:
      position: 1
  - id: bam_files
    type:
      type: array
      items: File
    doc: BAM files
    inputBinding:
      position: 2
  - id: bam_filter
    type:
      - 'null'
      - boolean
    doc: 'Filter out alignments corresponding with false junctions. Warning: this
      is time consuming; make sure you really want to do this first!'
    inputBinding:
      position: 103
      prefix: --bam_filter
  - id: canonical
    type:
      - 'null'
      - string
    doc: "Keep junctions based on their splice site status. Valid options: OFF,C,S,N.
      Where C = Canonical junctions (GT-AG), S = Semi-canonical junctions (AT-AC,
      or GC-AG), N = Non-canonical. OFF means, keep all junctions (i.e. don't filter
      by canonical status). User can separate options by a comma to keep two categories."
    default: OFF
    inputBinding:
      position: 103
      prefix: --canonical
  - id: copy
    type:
      - 'null'
      - boolean
    doc: Whether to copy files from input data to prepared data where possible, 
      otherwise will use symlinks. Will require more time and disk space to 
      prepare input but is potentially more robust.
    inputBinding:
      position: 103
      prefix: --copy
  - id: exon_gff
    type:
      - 'null'
      - boolean
    doc: Output exon-based junctions in GFF format.
    inputBinding:
      position: 103
      prefix: --exon_gff
  - id: extra
    type:
      - 'null'
      - boolean
    doc: Calculate additional metrics that take some time to generate. 
      Automatically activates BAM splitting mode (--separate).
    inputBinding:
      position: 103
      prefix: --extra
  - id: force
    type:
      - 'null'
      - boolean
    doc: Whether or not to clean the output directory before processing, thereby
      forcing full preparation of the genome and bam files. By default 
      portcullis will only do what it thinks it needs to.
    inputBinding:
      position: 103
      prefix: --force
  - id: intron_gff
    type:
      - 'null'
      - boolean
    doc: Output intron-based junctions in GFF format.
    inputBinding:
      position: 103
      prefix: --intron_gff
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Whether keep any temporary files created during the prepare stage of 
      portcullis. This might include BAM files and indexes.
    inputBinding:
      position: 103
      prefix: --keep_temp
  - id: max_length
    type:
      - 'null'
      - int
    doc: Filter junctions longer than this value. Default (0) is to not filter 
      based on length.
    default: 0
    inputBinding:
      position: 103
      prefix: --max_length
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Only keep junctions with a number of split reads greater than or equal 
      to this number
    default: 1
    inputBinding:
      position: 103
      prefix: --min_cov
  - id: orientation
    type:
      - 'null'
      - string
    doc: 'The orientation of the reads that produced the BAM alignments: "F" (Single-end
      forward orientation); "R" (single-end reverse orientation); "FR" (paired-end,
      with reads sequenced towards center of fragment -> <-. This is usual setting
      for most Illumina paired end sequencing); "RF" (paired-end, reads sequenced
      away from center of fragment <- ->); "FF" (paired-end, reads both sequenced
      in forward orientation); "RR" (paired-end, reads both sequenced in reverse orientation);
      "UNKNOWN" (default, portcullis will workaround any calculations requiring orientation
      information)'
    default: UNKNOWN
    inputBinding:
      position: 103
      prefix: --orientation
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    default: portcullis_out
    inputBinding:
      position: 103
      prefix: --output
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference annotation of junctions in BED format. Any junctions found by
      the junction analysis tool will be preserved if found in this reference 
      file regardless of any other filtering criteria. If you need to convert a 
      reference annotation from GTF or GFF to BED format portcullis contains 
      scripts for this.
    inputBinding:
      position: 103
      prefix: --reference
  - id: save_bad
    type:
      - 'null'
      - boolean
    doc: Saves bad junctions (i.e. junctions that fail the filter), as well as 
      good junctions (those that pass)
    inputBinding:
      position: 103
      prefix: --save_bad
  - id: separate
    type:
      - 'null'
      - boolean
    doc: Separate spliced from unspliced reads.
    inputBinding:
      position: 103
      prefix: --separate
  - id: source
    type:
      - 'null'
      - string
    doc: The value to enter into the "source" field in GFF files.
    default: portcullis
    inputBinding:
      position: 103
      prefix: --source
  - id: strandedness
    type:
      - 'null'
      - string
    doc: 'Whether BAM alignments were generated using a type of strand specific RNAseq
      library: "unstranded" (Standard Illumina); "firststrand" (dUTP, NSR, NNSR);
      "secondstrand" (Ligation, Standard SOLiD, flux sim reads); "UNKNOWN" (default,
      portcullis will workaround any calculations requiring strandedness information)'
    default: UNKNOWN
    inputBinding:
      position: 103
      prefix: --strandedness
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use. Note that increasing the number of 
      threads will also increase memory requirements.
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: training_rule
    type:
      - 'null'
      - string
    doc: 'Pre-set to use for the self-training. Currently supported: balanced, precise.
      Default: balanced.'
    default: balanced
    inputBinding:
      position: 103
      prefix: --training_rule
  - id: use_csi
    type:
      - 'null'
      - boolean
    doc: Whether to use CSI indexing rather than BAI indexing. CSI has the 
      advantage that it supports very long target sequences (probably not an 
      issue unless you are working on huge genomes). BAI has the advantage that 
      it is more widely supported (useful for viewing in genome browsers).
    inputBinding:
      position: 103
      prefix: --use_csi
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra information
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/portcullis:1.2.4--py39hc87ae8a_4
stdout: portcullis_full.out
