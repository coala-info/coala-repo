cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bbduk.sh
label: bbmap_bbduk
doc: "Compares reads to the kmers in a reference dataset, optionally allowing an edit
  distance. Splits the reads into two outputs - those that match the reference, and
  those that don't. Can also trim (remove) the matching parts of the reads rather
  than binning the reads.\n\nTool homepage: https://sourceforge.net/projects/bbmap"
inputs:
  - id: copyundefined
    type:
      - 'null'
      - boolean
    doc: Process non-AGCT IUPAC reference bases by making all possible unambiguous
      copies.
    default: false
    inputBinding:
      position: 101
      prefix: copyundefined
  - id: editdistance
    type:
      - 'null'
      - int
    doc: Maximum edit distance from ref kmers (subs and indels).
    default: 0
    inputBinding:
      position: 101
      prefix: editdistance
  - id: hammingdistance
    type:
      - 'null'
      - int
    doc: Maximum Hamming distance for ref kmers (subs only).
    default: 0
    inputBinding:
      position: 101
      prefix: hammingdistance
  - id: in
    type: File
    doc: Main input. in=stdin.fq will pipe from stdin.
    inputBinding:
      position: 101
      prefix: in
  - id: in2
    type:
      - 'null'
      - File
    doc: Input for 2nd read of pairs in a different file.
    inputBinding:
      position: 101
      prefix: in2
  - id: interleaved
    type:
      - 'null'
      - string
    doc: t/f overrides interleaved autodetection.
    default: auto
    inputBinding:
      position: 101
      prefix: interleaved
  - id: k
    type:
      - 'null'
      - int
    doc: Kmer length used for finding contaminants.
    default: 31
    inputBinding:
      position: 101
      prefix: k
  - id: ktrim
    type:
      - 'null'
      - string
    doc: Trim reads to remove bases matching reference kmers (f, r, l).
    default: f
    inputBinding:
      position: 101
      prefix: ktrim
  - id: literal
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-delimited list of literal reference sequences.
    inputBinding:
      position: 101
      prefix: literal
  - id: maskmiddle
    type:
      - 'null'
      - string
    doc: Treat the middle base of a kmer as a wildcard.
    default: t
    inputBinding:
      position: 101
      prefix: maskmiddle
  - id: minavgquality
    type:
      - 'null'
      - int
    doc: Reads with average quality (after trimming) below this will be discarded.
    default: 0
    inputBinding:
      position: 101
      prefix: minavgquality
  - id: mink
    type:
      - 'null'
      - int
    doc: Look for shorter kmers at read tips down to this length.
    default: 0
    inputBinding:
      position: 101
      prefix: mink
  - id: minlength
    type:
      - 'null'
      - int
    doc: Reads shorter than this after trimming will be discarded.
    default: 10
    inputBinding:
      position: 101
      prefix: minlength
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Grant permission to overwrite files.
    default: true
    inputBinding:
      position: 101
      prefix: overwrite
  - id: qin
    type:
      - 'null'
      - string
    doc: 'Input quality offset: 33 (Sanger), 64, or auto.'
    default: auto
    inputBinding:
      position: 101
      prefix: qin
  - id: qtrim
    type:
      - 'null'
      - string
    doc: Trim read ends to remove bases with quality below trimq (rl, f, r, l, w).
    default: f
    inputBinding:
      position: 101
      prefix: qtrim
  - id: rcomp
    type:
      - 'null'
      - boolean
    doc: Look for reverse-complements of kmers.
    default: true
    inputBinding:
      position: 101
      prefix: rcomp
  - id: reads
    type:
      - 'null'
      - int
    doc: If positive, quit after processing X reads or pairs.
    default: -1
    inputBinding:
      position: 101
      prefix: reads
  - id: ref
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma-delimited list of reference files or keywords (adapters, artifacts,
      phix, etc).
    inputBinding:
      position: 101
      prefix: ref
  - id: samplerate
    type:
      - 'null'
      - float
    doc: Set lower to only process a fraction of input reads.
    default: 1
    inputBinding:
      position: 101
      prefix: samplerate
  - id: samref
    type:
      - 'null'
      - File
    doc: Optional reference fasta for processing sam files.
    inputBinding:
      position: 101
      prefix: samref
  - id: tbo
    type:
      - 'null'
      - boolean
    doc: Trim adapters based on where paired reads overlap.
    default: false
    inputBinding:
      position: 101
      prefix: tbo
  - id: threads
    type:
      - 'null'
      - string
    doc: Set number of threads to use.
    default: auto
    inputBinding:
      position: 101
      prefix: threads
  - id: touppercase
    type:
      - 'null'
      - boolean
    doc: Change all bases upper-case.
    default: false
    inputBinding:
      position: 101
      prefix: touppercase
  - id: tpe
    type:
      - 'null'
      - boolean
    doc: When kmer right-trimming, trim both reads to the minimum length of either.
    default: false
    inputBinding:
      position: 101
      prefix: tpe
  - id: trimq
    type:
      - 'null'
      - float
    doc: Regions with average quality BELOW this will be trimmed.
    default: 6
    inputBinding:
      position: 101
      prefix: trimq
  - id: ziplevel
    type:
      - 'null'
      - int
    doc: Compression level; 1 (min) through 9 (max).
    default: 2
    inputBinding:
      position: 101
      prefix: ziplevel
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Write reads here that do not contain kmers matching the database.
    outputBinding:
      glob: $(inputs.out)
  - id: out2
    type:
      - 'null'
      - File
    doc: Use this to write 2nd read of pairs to a different file.
    outputBinding:
      glob: $(inputs.out2)
  - id: outm
    type:
      - 'null'
      - File
    doc: Write reads here that fail filters (matching kmers or quality/length filters).
    outputBinding:
      glob: $(inputs.outm)
  - id: outm2
    type:
      - 'null'
      - File
    doc: Use this to write 2nd read of pairs to a different file (matches).
    outputBinding:
      glob: $(inputs.outm2)
  - id: outs
    type:
      - 'null'
      - File
    doc: Use this to write singleton reads whose mate was trimmed shorter than minlen.
    outputBinding:
      glob: $(inputs.outs)
  - id: stats
    type:
      - 'null'
      - File
    doc: Write statistics about which contaminants were detected.
    outputBinding:
      glob: $(inputs.stats)
  - id: refstats
    type:
      - 'null'
      - File
    doc: Write statistics on a per-reference-file basis.
    outputBinding:
      glob: $(inputs.refstats)
  - id: rpkm
    type:
      - 'null'
      - File
    doc: Write RPKM for each reference sequence (for RNA-seq).
    outputBinding:
      glob: $(inputs.rpkm)
  - id: bhist
    type:
      - 'null'
      - File
    doc: Base composition histogram by position.
    outputBinding:
      glob: $(inputs.bhist)
  - id: qhist
    type:
      - 'null'
      - File
    doc: Quality histogram by position.
    outputBinding:
      glob: $(inputs.qhist)
  - id: lhist
    type:
      - 'null'
      - File
    doc: Read length histogram.
    outputBinding:
      glob: $(inputs.lhist)
  - id: gchist
    type:
      - 'null'
      - File
    doc: Read GC content histogram.
    outputBinding:
      glob: $(inputs.gchist)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
