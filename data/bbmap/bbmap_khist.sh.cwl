cwlVersion: v1.2
class: CommandLineTool
baseCommand: khist.sh
label: bbmap_khist
doc: "Generates a histogram of kmer counts for the input reads or assemblies (jgi.KmerNormalize;
  flags are the same as bbnorm.sh).\n\nTool homepage: https://sourceforge.net/projects/bbmap"
inputs:
  - id: in
    type: File
    doc: Primary input reads or assembly (fasta or fastq, may be gzipped)
    inputBinding:
      position: 101
      prefix: in=
      separate: false
  - id: in2
    type:
      - 'null'
      - File
    doc: Second input file for paired reads
    inputBinding:
      position: 101
      prefix: in2=
      separate: false
  - id: java_memory
    type:
      - 'null'
      - string
    doc: Set Java's memory usage, overriding autodetection (e.g. 4g gives -Xmx4g)
    inputBinding:
      position: 100
      prefix: -Xmx
      separate: false
  - id: k
    type:
      - 'null'
      - int
    doc: Kmer length (default 31)
    inputBinding:
      position: 101
      prefix: k=
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: Spawn exactly X hashing threads
    inputBinding:
      position: 101
      prefix: threads=
      separate: false
  - id: bits
    type:
      - 'null'
      - int
    doc: Bits per cell in the count-min sketch (default 32 for khist)
    inputBinding:
      position: 101
      prefix: bits=
      separate: false
  - id: hashes
    type:
      - 'null'
      - int
    doc: Number of times each kmer is hashed and stored (default 3)
    inputBinding:
      position: 101
      prefix: hashes=
      separate: false
  - id: prefilter
    type:
      - 'null'
      - boolean
    doc: Use a prefilter to remove low-depth kmers from the main hashtable (default
      true for khist)
    inputBinding:
      position: 101
      prefix: prefilter=
      separate: false
      valueFrom: '$(self ? "t" : "f")'
  - id: minprob
    type:
      - 'null'
      - float
    doc: Ignore kmers with probability of correctness below this
    inputBinding:
      position: 101
      prefix: minprob=
      separate: false
  - id: minqual
    type:
      - 'null'
      - int
    doc: Ignore kmers containing bases with quality below this
    inputBinding:
      position: 101
      prefix: minq=
      separate: false
  - id: histcol
    type:
      - 'null'
      - int
    doc: Number of histogram columns, 2 or 3
    inputBinding:
      position: 101
      prefix: histcol=
      separate: false
  - id: histlen
    type:
      - 'null'
      - int
    doc: Max kmer depth displayed in histogram
    inputBinding:
      position: 101
      prefix: histlen=
      separate: false
  - id: zerobin
    type:
      - 'null'
      - boolean
    doc: Put kmers with a count of 0 in the 0 bin instead of the 1 bin
    inputBinding:
      position: 101
      prefix: zerobin
  - id: hist_path
    type: string
    doc: Kmer depth histogram output file
    inputBinding:
      position: 102
      prefix: hist=
      separate: false
  - id: peaks_path
    type:
      - 'null'
      - string
    doc: Write the peaks to this file
    inputBinding:
      position: 102
      prefix: peaks=
      separate: false
outputs:
  - id: hist
    type: File
    doc: Kmer depth histogram file
    outputBinding:
      glob: $(inputs.hist_path)
  - id: peaks
    type:
      - 'null'
      - File
    doc: Peaks file
    outputBinding:
      glob: $(inputs.peaks_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
