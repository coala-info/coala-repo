cwlVersion: v1.2
class: CommandLineTool
baseCommand: ShortStack
label: shortstack_ShortStack
doc: "ShortStack is a tool for analyzing small RNA sequencing data, particularly for
  identifying and characterizing microRNAs.\n\nTool homepage: https://github.com/MikeAxtell/ShortStack"
inputs:
  - id: bamfile
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more BAM alignment files
    inputBinding:
      position: 1
  - id: readfile
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more files of reads (fq, fa, gzip OK)
    inputBinding:
      position: 2
  - id: adapter
    type:
      - 'null'
      - string
    doc: 3-primer adapter sequence to trim off ofreads. If given applies to all 
      input fastq files. Mutually exclusive with --autotrim.
    inputBinding:
      position: 103
      prefix: --adapter
  - id: align_only
    type:
      - 'null'
      - boolean
    doc: If this switch is set, ShortStack quits after performing alignments 
      without any analyses performed.
    inputBinding:
      position: 103
      prefix: --align_only
  - id: autotrim
    type:
      - 'null'
      - boolean
    doc: If this switch is set, automatically discover the 3-prime adapter from 
      each input readfile, and trim it. This uses the sequence from 
      --autotrim_key to discover the adapter sequence. Mutually exlcusive with 
      --adapter.
    inputBinding:
      position: 103
      prefix: --autotrim
  - id: autotrim_key
    type:
      - 'null'
      - string
    doc: Sequence of an abundant, known small RNA to be used to discover the 
      3-prime adapter sequence. Has no effect unless --autotrim is specified. 
      Defaults to TCGGACCAGGCTTCATTCCCC (miR166). Can be upper or lower-case, T 
      or U and must be 20-30 bases long.
    inputBinding:
      position: 103
      prefix: --autotrim_key
  - id: autotrim_only
    type: boolean
    doc: If this switch is set, ShortStack quits after performing auto-trimming 
      of input reads.
    inputBinding:
      position: 103
      prefix: --autotrim_only
  - id: dicermax
    type:
      - 'null'
      - int
    doc: 'Maximum size of a valid Dicer-processed small RNA. Must be integer >= 15
      and <= dicermax. Default: 24.'
    inputBinding:
      position: 103
      prefix: --dicermax
  - id: dicermin
    type:
      - 'null'
      - int
    doc: 'Minimum size of a valid Dicer-processed small RNA. Must be integer >= 15
      and <= dicermax. Default: 20.'
    inputBinding:
      position: 103
      prefix: --dicermin
  - id: dn_mirna
    type:
      - 'null'
      - boolean
    doc: If this switch is set, a de novo search for new MIRNA loci will be 
      performed. By default, de novo MIRNA finding is not performed and MIRNA 
      searches are limited to loci matching RNAs from --known_miRNAs that align 
      to the genome
    inputBinding:
      position: 103
      prefix: --dn_mirna
  - id: genomefile
    type: File
    doc: FASTA file of the reference genome
    inputBinding:
      position: 103
      prefix: --genomefile
  - id: known_mirnas
    type:
      - 'null'
      - File
    doc: FASTA file of known/suspected mature microRNAs
    inputBinding:
      position: 103
      prefix: --known_miRNAs
  - id: locifile
    type:
      - 'null'
      - File
    doc: File listing intervals to analyze. Can be simple tab-delimited, .bed, 
      or .gff3. Tab-delimited format is column 1 with coordinates 
      Chr:start-stop, column 2 with names. Input file assumed to be simple 
      tab-delimited unless file name ends in .bed or .gff3. Mutually exclusive 
      with --locus.
    inputBinding:
      position: 103
      prefix: --locifile
  - id: locus
    type:
      - 'null'
      - string
    doc: Analyze the specified interval, given in format Chr:start-stop. 
      Mutually exclusive with --locifile.
    inputBinding:
      position: 103
      prefix: --locus
  - id: make_bigwigs
    type:
      - 'null'
      - boolean
    doc: If this switch is set then bigwigs will be made from alignments.
    inputBinding:
      position: 103
      prefix: --make_bigwigs
  - id: mincov
    type:
      - 'null'
      - float
    doc: 'Minimum alignment depth required to nucleate a small RNA cluster during
      de novo cluster search. In units of reads per million. Must be a floating point
      number. Default: 0.5'
    inputBinding:
      position: 103
      prefix: --mincov
  - id: mmap
    type:
      - 'null'
      - string
    doc: 'Protocol for multi-mapped reads: u, f, or r - default: u'
    inputBinding:
      position: 103
      prefix: --mmap
  - id: nohp
    type:
      - 'null'
      - boolean
    doc: If this switch is set, RNA folding will not take place, thus MIRNA loci
      cannot be annotated. This does however save CPU time.
    inputBinding:
      position: 103
      prefix: --nohp
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory name. Defaults to ShortStack_time
    inputBinding:
      position: 103
      prefix: --outdir
  - id: pad
    type:
      - 'null'
      - int
    doc: 'Initial peaks (continuous regions with depth exceeding argument mincov are
      merged if they are this distance or less from each other. Must be an integer
      >= 1. Default: 200'
    inputBinding:
      position: 103
      prefix: --pad
  - id: strand_cutoff
    type:
      - 'null'
      - float
    doc: 'Cutoff for calling the strandedness of a small RNA locus. Must be a floating
      point > 0.5 and < 1. Default: 0.8.'
    inputBinding:
      position: 103
      prefix: --strand_cutoff
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (integer) - default: 1'
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shortstack:4.1.2--hdfd78af_0
stdout: shortstack_ShortStack.out
