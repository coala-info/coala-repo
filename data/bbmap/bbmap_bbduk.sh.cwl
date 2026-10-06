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
    doc: Process non-AGCT IUPAC reference bases by making all possible 
      unambiguous copies.
    inputBinding:
      position: 101
      prefix: copyundefined
  - id: editdistance
    type:
      - 'null'
      - int
    doc: Maximum edit distance from ref kmers (subs and indels).
    inputBinding:
      position: 101
      prefix: editdistance=
      separate: false
  - id: hammingdistance
    type:
      - 'null'
      - int
    doc: Maximum Hamming distance for ref kmers (subs only).
    inputBinding:
      position: 101
      prefix: hammingdistance=
      separate: false
  - id: in
    type: File
    doc: Main input. in=stdin.fq will pipe from stdin.
    inputBinding:
      position: 101
      prefix: in=
      separate: false
  - id: in2
    type:
      - 'null'
      - File
    doc: Input for 2nd read of pairs in a different file.
    inputBinding:
      position: 101
      prefix: in2=
      separate: false
  - id: interleaved
    type:
      - 'null'
      - string
    doc: t/f overrides interleaved autodetection.
    inputBinding:
      position: 101
      prefix: interleaved=
      separate: false
  - id: k
    type:
      - 'null'
      - int
    doc: Kmer length used for finding contaminants.
    inputBinding:
      position: 101
      prefix: k=
      separate: false
  - id: ktrim
    type:
      - 'null'
      - string
    doc: Trim reads to remove bases matching reference kmers (f, r, l).
    inputBinding:
      position: 101
      prefix: ktrim=
      separate: false
  - id: literal
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-delimited list of literal reference sequences.
    inputBinding:
      position: 101
      prefix: literal=
      itemSeparator: ','
      separate: false
  - id: maskmiddle
    type:
      - 'null'
      - string
    doc: Treat the middle base of a kmer as a wildcard.
    inputBinding:
      position: 101
      prefix: maskmiddle=
      separate: false
  - id: minavgquality
    type:
      - 'null'
      - int
    doc: Reads with average quality (after trimming) below this will be 
      discarded.
    inputBinding:
      position: 101
      prefix: minavgquality=
      separate: false
  - id: mink
    type:
      - 'null'
      - int
    doc: Look for shorter kmers at read tips down to this length.
    inputBinding:
      position: 101
      prefix: mink=
      separate: false
  - id: minlength
    type:
      - 'null'
      - int
    doc: Reads shorter than this after trimming will be discarded.
    inputBinding:
      position: 101
      prefix: minlength=
      separate: false
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Grant permission to overwrite files.
    inputBinding:
      position: 101
      prefix: overwrite
  - id: qin
    type:
      - 'null'
      - string
    doc: 'Input quality offset: 33 (Sanger), 64, or auto.'
    inputBinding:
      position: 101
      prefix: qin=
      separate: false
  - id: qtrim
    type:
      - 'null'
      - string
    doc: Trim read ends to remove bases with quality below trimq (rl, f, r, l, 
      w).
    inputBinding:
      position: 101
      prefix: qtrim=
      separate: false
  - id: rcomp
    type:
      - 'null'
      - boolean
    doc: Look for reverse-complements of kmers.
    inputBinding:
      position: 101
      prefix: rcomp
  - id: reads
    type:
      - 'null'
      - int
    doc: If positive, quit after processing X reads or pairs.
    inputBinding:
      position: 101
      prefix: reads=
      separate: false
  - id: ref
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma-delimited list of reference files or keywords (adapters, 
      artifacts, phix, etc).
    inputBinding:
      position: 101
      prefix: ref=
      itemSeparator: ','
      separate: false
  - id: samplerate
    type:
      - 'null'
      - float
    doc: Set lower to only process a fraction of input reads.
    inputBinding:
      position: 101
      prefix: samplerate=
      separate: false
  - id: samref
    type:
      - 'null'
      - File
    doc: Optional reference fasta for processing sam files.
    inputBinding:
      position: 101
      prefix: samref=
      separate: false
  - id: tbo
    type:
      - 'null'
      - boolean
    doc: Trim adapters based on where paired reads overlap.
    inputBinding:
      position: 101
      prefix: tbo
  - id: threads
    type:
      - 'null'
      - string
    doc: Set number of threads to use.
    inputBinding:
      position: 101
      prefix: threads=
      separate: false
  - id: touppercase
    type:
      - 'null'
      - boolean
    doc: Change all bases upper-case.
    inputBinding:
      position: 101
      prefix: touppercase
  - id: tpe
    type:
      - 'null'
      - boolean
    doc: When kmer right-trimming, trim both reads to the minimum length of 
      either.
    inputBinding:
      position: 101
      prefix: tpe
  - id: trimq
    type:
      - 'null'
      - float
    doc: Regions with average quality BELOW this will be trimmed.
    inputBinding:
      position: 101
      prefix: trimq=
      separate: false
  - id: ziplevel
    type:
      - 'null'
      - int
    doc: Compression level; 1 (min) through 9 (max).
    inputBinding:
      position: 101
      prefix: ziplevel=
      separate: false
  - id: bhist_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `bhist_path`
    inputBinding:
      position: 102
      prefix: bhist=
      separate: false
  - id: gchist_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `gchist_path`
    inputBinding:
      position: 103
      prefix: gchist=
      separate: false
  - id: lhist_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `lhist_path`
    inputBinding:
      position: 104
      prefix: lhist=
      separate: false
  - id: out_path
    type:
      - 'null'
      - string
    doc: Write reads here that do not contain kmers matching the database.
    inputBinding:
      position: 105
      prefix: out=
      separate: false
  - id: out2_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `out2_path`
    inputBinding:
      position: 106
      prefix: out2=
      separate: false
  - id: outm_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `outm_path`
    inputBinding:
      position: 107
      prefix: outm=
      separate: false
  - id: outm2_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `outm2_path`
    inputBinding:
      position: 108
      prefix: outm2=
      separate: false
  - id: outs_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `outs_path`
    inputBinding:
      position: 109
      prefix: outs=
      separate: false
  - id: qhist_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `qhist_path`
    inputBinding:
      position: 110
      prefix: qhist=
      separate: false
  - id: refstats_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `refstats_path`
    inputBinding:
      position: 111
      prefix: refstats=
      separate: false
  - id: rpkm_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `rpkm_path`
    inputBinding:
      position: 112
      prefix: rpkm=
      separate: false
  - id: stats_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `stats_path`
    inputBinding:
      position: 113
      prefix: stats=
      separate: false
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Write reads here that do not contain kmers matching the database.
    outputBinding:
      glob: $(inputs.out_path)
  - id: out2
    type:
      - 'null'
      - File
    doc: Use this to write 2nd read of pairs to a different file.
    outputBinding:
      glob: $(inputs.out2_path)
  - id: outm
    type:
      - 'null'
      - File
    doc: Write reads here that fail filters (matching kmers or quality/length 
      filters).
    outputBinding:
      glob: $(inputs.outm_path)
  - id: outm2
    type:
      - 'null'
      - File
    doc: Use this to write 2nd read of pairs to a different file (matches).
    outputBinding:
      glob: $(inputs.outm2_path)
  - id: outs
    type:
      - 'null'
      - File
    doc: Use this to write singleton reads whose mate was trimmed shorter than 
      minlen.
    outputBinding:
      glob: $(inputs.outs_path)
  - id: stats
    type:
      - 'null'
      - File
    doc: Write statistics about which contaminants were detected.
    outputBinding:
      glob: $(inputs.stats_path)
  - id: refstats
    type:
      - 'null'
      - File
    doc: Write statistics on a per-reference-file basis.
    outputBinding:
      glob: $(inputs.refstats_path)
  - id: rpkm
    type:
      - 'null'
      - File
    doc: Write RPKM for each reference sequence (for RNA-seq).
    outputBinding:
      glob: $(inputs.rpkm_path)
  - id: bhist
    type:
      - 'null'
      - File
    doc: Base composition histogram by position.
    outputBinding:
      glob: $(inputs.bhist_path)
  - id: qhist
    type:
      - 'null'
      - File
    doc: Quality histogram by position.
    outputBinding:
      glob: $(inputs.qhist_path)
  - id: lhist
    type:
      - 'null'
      - File
    doc: Read length histogram.
    outputBinding:
      glob: $(inputs.lhist_path)
  - id: gchist
    type:
      - 'null'
      - File
    doc: Read GC content histogram.
    outputBinding:
      glob: $(inputs.gchist_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
