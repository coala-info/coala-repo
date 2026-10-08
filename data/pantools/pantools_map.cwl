cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - map
label: pantools_map
doc: "Map single or paired-end short reads to one or multiple genomes in the pangenome.\
  \ One SAM or BAM file is generated for each genome included in the analysis.\n\n\
  Tool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool writes its results inside it) and returned as the output.
    inputBinding:
      position: 1
  - id: short_read_file
    type: File
    doc: First short-read archive in FASTQ format, which can be gz/bz2 compressed
      (the only one for single-end reads).
    inputBinding:
      position: 2
  - id: short_read_file_2
    type:
      - 'null'
      - File
    doc: Second short-read archive in FASTQ format (paired-end reads), which can be
      gz/bz2 compressed.
    inputBinding:
      position: 3
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel working threads, default is the number of cores or 8,
      whichever is lower.
    inputBinding:
      position: 102
      prefix: --threads=
      separate: false
  - id: selection_file
    type:
      - 'null'
      - File
    doc: Text file with rules to use a specific set of genomes and sequences. This
      automatically lowers the threshold for core genes.
    inputBinding:
      position: 102
      prefix: --selection-file=
      separate: false
  - id: include
    type:
      - 'null'
      - string
    doc: Only include a selection of genomes (for example 1,2).
    inputBinding:
      position: 102
      prefix: --include=
      separate: false
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude a selection of genomes (for example 3,4).
    inputBinding:
      position: 102
      prefix: --exclude=
      separate: false
  - id: output
    type:
      - 'null'
      - string
    doc: Name of the output directory for the alignment files (created in the working
      directory; default is the read_mapping folder inside the database).
    inputBinding:
      position: 102
      prefix: --output=
      separate: false
  - id: all_hits
    type:
      - 'null'
      - boolean
    doc: Return all hits rather than only the best.
    inputBinding:
      position: 102
      prefix: --all-hits
  - id: competitive
    type:
      - 'null'
      - boolean
    doc: 'Find the best mapping location in the complete pangenome (default: find
      the best location for each genome).'
    inputBinding:
      position: 102
      prefix: --competitive
  - id: best_hits
    type:
      - 'null'
      - string
    doc: 'In case of multiple "best" hits, return none, all best hits or a random
      best hit: none, random or all (default: random).'
    inputBinding:
      position: 102
      prefix: --best-hits=
      separate: false
  - id: previous_run
    type:
      - 'null'
      - File
    doc: The mapping_summary.txt file from a previous mapping run (random-best competitive
      mode) for a better estimation of coverage in a metagenomic setting.
    inputBinding:
      position: 102
      prefix: --previous-run=
      separate: false
  - id: out_format
    type:
      - 'null'
      - string
    doc: 'Writes the alignment files in BAM or SAM format or do not write any output
      files: BAM, SAM or none (default: SAM).'
    inputBinding:
      position: 102
      prefix: --out-format=
      separate: false
  - id: gap_open
    type:
      - 'null'
      - int
    doc: 'Gap open penalty (range: [-50..-1], default: -20).'
    inputBinding:
      position: 102
      prefix: --gap-open=
      separate: false
  - id: gap_extension
    type:
      - 'null'
      - int
    doc: 'Gap extension penalty (range: [-5..-1], default: -3).'
    inputBinding:
      position: 102
      prefix: --gap-extension=
      separate: false
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Process the fastq file as an interleaved paired-end archive.
    inputBinding:
      position: 102
      prefix: --interleaved
  - id: unmapped
    type:
      - 'null'
      - boolean
    doc: Check unmapped genomes.
    inputBinding:
      position: 102
      prefix: --unmapped
  - id: sensitivity
    type:
      - 'null'
      - string
    doc: 'Four settings that automatically set the parameters controlling the sensitivity,
      ranging from least to most sensitive: very-fast, fast, sensitive or very-sensitive.'
    inputBinding:
      position: 102
      prefix: --sensitivity=
      separate: false
  - id: clipping_stringency
    type:
      - 'null'
      - int
    doc: 'The stringency of soft-clipping (default: 1). 0: no soft clipping, 1: low,
      2: medium, 3: high.'
    inputBinding:
      position: 102
      prefix: --clipping-stringency=
      separate: false
  - id: min_hit_length
    type:
      - 'null'
      - int
    doc: 'The minimum acceptable length of alignment after soft-clipping (default:
      13, range: [10..100]).'
    inputBinding:
      position: 102
      prefix: --min-hit-length=
      separate: false
  - id: alignment_band
    type:
      - 'null'
      - int
    doc: 'The length of bound of banded alignment (default: 5, range: [1..100]).'
    inputBinding:
      position: 102
      prefix: --alignment-band=
      separate: false
  - id: num_kmer_samples
    type:
      - 'null'
      - int
    doc: 'The number of kmers sampled from read (default: 15, range: [1..r-k+1]).'
    inputBinding:
      position: 102
      prefix: --num-kmer-samples=
      separate: false
  - id: min_identity
    type:
      - 'null'
      - float
    doc: 'The minimum acceptable identity of the alignment (default: 0.5, range: [0,1]).'
    inputBinding:
      position: 102
      prefix: --min-identity=
      separate: false
  - id: max_num_locations
    type:
      - 'null'
      - int
    doc: 'The maximum number of locations of candidate hits to examine (default: 15,
      range: [1..100]).'
    inputBinding:
      position: 102
      prefix: --max-num-locations=
      separate: false
  - id: max_alignment_length
    type:
      - 'null'
      - int
    doc: 'The maximum acceptable length of alignment (default: 2000, range: [50..5000]).'
    inputBinding:
      position: 102
      prefix: --max-alignment-length=
      separate: false
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: 'The maximum acceptable length of fragment (default: 4998, range: [50..5000]).'
    inputBinding:
      position: 102
      prefix: --max-fragment-length=
      separate: false
  - id: read_group
    type:
      - 'null'
      - string
    doc: Complete read group header line string containing TAG:VALUE entries enclosed
      in single or double quotes. The successive TAG:VALUE entries are separated with
      a TAB (\t). The read group ID will be attached to every read in the output.
      An example is 'ID:foo\tSM:bar'. The available tags are ID, BC, CN, DS, DT, FO,
      KS, LB, PG, PI, PL, PM, PU and SM. \t will be converted to a TAB in the output.
      Must contain the read group ID. All other tags are optional.
    inputBinding:
      position: 102
      prefix: --read-group=
      separate: false
outputs:
  - id: database
    type: Directory
    doc: The pangenome database, with the mapping results written inside it.
    outputBinding:
      glob: $(inputs.database_directory.basename)
  - id: alignments
    type:
      type: array
      items: File
    doc: The SAM or BAM files (one per genome) and mapping_summary.txt.
    outputBinding:
      glob: '$(inputs.output ? inputs.output + ''/*'' : inputs.database_directory.basename
        + ''/read_mapping/*'')'
  - id: log
    type: stdout
    doc: Standard output (run log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$([{entry: inputs.database_directory, writable: true}].concat(inputs.output
      ? [{entryname: inputs.output, entry: {class: ''Directory'', basename: inputs.output,
      listing: []}, writable: true}] : []))'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_map.log
