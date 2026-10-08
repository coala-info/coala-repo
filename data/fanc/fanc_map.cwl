cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - map
label: fanc_map
doc: "Map reads in a FASTQ file to a reference genome (iterative mapping with Bowtie 2 or BWA).\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "Input FASTQ file(s) (or gzipped FASTQ)."
    inputBinding:
      position: 1
  - id: index_dir
    type: Directory
    doc: "Folder that holds the Bowtie 2 or BWA genome index files."
  - id: index_base
    type: string
    doc: "Base name of the index inside index_dir (e.g. chrI for chrI.1.bt2). Index type is determined automatically."
    inputBinding:
      position: 2
      valueFrom: $(inputs.index_dir.path)/$(self)
  - id: output
    type: string
    doc: "Output BAM/SAM file, or output folder when several input files are given."
    inputBinding:
      position: 3
  - id: min_size
    type:
      - 'null'
      - int
    doc: "Minimum length of read before extension. Default 25."
    inputBinding:
      position: 20
      prefix: --min-size
  - id: step_size
    type:
      - 'null'
      - int
    doc: "Number of base pairs to extend at each round of mapping. Default is 10."
    inputBinding:
      position: 20
      prefix: --step-size
  - id: trim_front
    type:
      - 'null'
      - boolean
    doc: "Trim reads from front instead of back."
    inputBinding:
      position: 20
      prefix: --trim-front
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads used for mapping. Default: 1"
    inputBinding:
      position: 20
      prefix: --threads
  - id: quality
    type:
      - 'null'
      - int
    doc: "Mapping quality cutoff. Alignments with a quality score lower than this will be sent to another mapping iteration. Default: 3 (BWA), 30 (Bowtie2)"
    inputBinding:
      position: 20
      prefix: --quality
  - id: restriction_enzyme
    type:
      - 'null'
      - string
    doc: "Name (case sensitive) of restriction enzyme used in Hi-C experiment. Will be used to split reads by predicted ligation junction before mapping. You can omit this if you do not want to split your reads by ligation junction. Restriction names can be any supported by Biopython, which obtains data from REBASE (http://rebase.neb.com/rebase/rebase.html). For restriction enzyme cocktails, separate enzyme names with \",\""
    inputBinding:
      position: 20
      prefix: --restriction-enzyme
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: "Maximum number of alignments per read to be reported."
    inputBinding:
      position: 20
      prefix: --max-alignments
  - id: all_alignments
    type:
      - 'null'
      - boolean
    doc: "Report all valid alignments of a read Warning: very slow!."
    inputBinding:
      position: 20
      prefix: --all-alignments
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Number of reads processed (mapped and merged) in one go per worker. The default 100000 works well for large indexes (e.g. human, mouse). Smaller indexes (e.g. yeast) will finish individual bowtie2 processes very quickly - set this number higher to spawn new processes less frequently."
    inputBinding:
      position: 20
      prefix: --batch-size
  - id: fanc_parallel
    type:
      - 'null'
      - boolean
    doc: "Use FAN-C parallelisation, which launches multiple mapper jobs. This may be faster in some cases than relying on the internal paralellisation of the mapper, but has potentially high disk I/O and memory usage."
    inputBinding:
      position: 20
      prefix: --fanc-parallel
  - id: split_fastq
    type:
      - 'null'
      - boolean
    doc: "Split FASTQ file into 10M chunks before mapping. Easier on tmp partitions."
    inputBinding:
      position: 20
      prefix: --split-fastq
  - id: memory_map
    type:
      - 'null'
      - boolean
    doc: "Map Bowtie2 index to memory. Enable if you you system has enough memory to hold the entire Bowtie2 index."
    inputBinding:
      position: 20
      prefix: --memory-map
  - id: no_iterative
    type:
      - 'null'
      - boolean
    doc: "Do not use iterative mapping strategy. (much faster, less sensitive)."
    inputBinding:
      position: 20
      prefix: --no-iterative
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Copy original file to temporary directory.Reduces network I/O."
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: mapped
    type:
      type: array
      items: File
    doc: "Mapped reads (a file, or the files in the output folder)."
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
