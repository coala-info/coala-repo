cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - HPC.daligner
label: daligner_HPC.daligner
doc: "Write a shell script (UNIX commands) that runs daligner, LAsort and
  LAmerge on all blocks of a split DAZZ_DB database, either comparing the reads
  against each other or mapping them to a reference database. The script is
  written to standard output, or to bundle files with -f.\n\nTool homepage:
  https://github.com/thegenemyers/DALIGNER"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run all commands in script in verbose mode.
    inputBinding:
      position: 1
      prefix: -v
  - id: sort_by_a_position
    type:
      - 'null'
      - boolean
    doc: Instruct LAsort & LAmerge to sort only on (a,ab).
    inputBinding:
      position: 1
      prefix: -a
  - id: las_subdirectories
    type:
      - 'null'
      - boolean
    doc: Put .las files for each target block in a sub-directory
    inputBinding:
      position: 1
      prefix: -d
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Look for alignments of length >= -l. Default 1500.
    inputBinding:
      position: 1
      prefix: -l
      separate: false
  - id: trace_spacing
    type:
      - 'null'
      - int
    doc: Use -s as the trace point spacing for encoding alignments. Default 100.
    inputBinding:
      position: 1
      prefix: -s
      separate: false
  - id: band_width
    type:
      - 'null'
      - int
    doc: Look for k-mers in averlapping bands of size 2^-w. Default 6.
    inputBinding:
      position: 1
      prefix: -w
      separate: false
  - id: kmer_frequency_cutoff
    type:
      - 'null'
      - int
    doc: Ignore k-mers that occur >= -t times in a block.
    inputBinding:
      position: 1
      prefix: -t
      separate: false
  - id: memory_gb
    type:
      - 'null'
      - int
    doc: Use only -M GB of memory by ignoring most frequent k-mers.
    inputBinding:
      position: 1
      prefix: -M
      separate: false
  - id: sort_dir
    type:
      - 'null'
      - string
    doc: Do first level sort and merge in directory -P. Default /tmp.
    inputBinding:
      position: 1
      prefix: -P
      separate: false
  - id: block_compares
    type:
      - 'null'
      - int
    doc: Number of block compares per daligner job. Default 4.
    inputBinding:
      position: 1
      prefix: -B
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: Use -T threads. Default 4.
    inputBinding:
      position: 1
      prefix: -T
      separate: false
  - id: bundle_prefix
    type:
      - 'null'
      - string
    doc: Place script bundles in separate files with prefix <name>
    inputBinding:
      position: 1
      prefix: -f
      separate: false
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (must be <= 32). Default 16 (20 when mapping to a reference).
    inputBinding:
      position: 1
      prefix: -k
      separate: false
  - id: modimer_percentage
    type:
      - 'null'
      - int
    doc: Modimer percentage (take % of the k-mers). Default 28 (50 when mapping).
    inputBinding:
      position: 1
      prefix: -%
      separate: false
  - id: hit_coverage
    type:
      - 'null'
      - int
    doc: A seed hit if the k-mers in band cover >= -h bps in the targest read. Default 50 (70 when mapping).
    inputBinding:
      position: 1
      prefix: -h
      separate: false
  - id: min_identity
    type:
      - 'null'
      - double
    doc: Look for alignments with -e percent similarity. Default .75 (.85 when mapping).
    inputBinding:
      position: 1
      prefix: -e
      separate: false
  - id: hgap_min_length
    type:
      - 'null'
      - int
    doc: HGAP option, align only target reads of length >= -H.
    inputBinding:
      position: 1
      prefix: -H
      separate: false
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference database (.db or .dam) to map the reads to
    inputBinding:
      position: 2
    secondaryFiles:
      - pattern: '${ return "." + self.nameroot + ".idx"; }'
      - pattern: '${ return "." + self.nameroot + ".bps"; }'
      - pattern: '${ return "." + self.nameroot + ".hdr"; }'
        required: false
  - id: mask_tracks
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -m
          separate: false
    doc: Soft mask the blocks with the specified mask track.
    inputBinding:
      position: 3
  - id: reads
    type: File
    doc: Reads database (.db or .dam), usually split with DBsplit
    inputBinding:
      position: 4
    secondaryFiles:
      - pattern: '${ return "." + self.nameroot + ".idx"; }'
      - pattern: '${ return "." + self.nameroot + ".bps"; }'
      - pattern: '${ return "." + self.nameroot + ".hdr"; }'
        required: false
  - id: block_range
    type:
      - 'null'
      - string
    doc: Only compare blocks <first>[-<last>]
    inputBinding:
      position: 5
outputs:
  - id: script
    type: stdout
    doc: Shell script with the daligner, LAsort and LAmerge commands
  - id: bundle_files
    type:
      type: array
      items: File
    doc: Script bundle files written when bundle_prefix is given
    outputBinding:
      glob: '$(inputs.bundle_prefix ? inputs.bundle_prefix + ".*" : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
stdout: daligner_HPC.daligner.out
