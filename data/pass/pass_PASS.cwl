cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/PASS
label: pass_PASS
doc: "v0.3.1 peptide assembly\n\nTool homepage: https://github.com/bcgsc/PASS"
inputs:
  - id: break_tie
    type:
      - 'null'
      - int
    doc: Break tie when no consensus amino acid at position, pick random amino acid
      (1 = yes, default = no)
    inputBinding:
      position: 101
      prefix: -q
  - id: ignore_header
    type:
      - 'null'
      - int
    doc: Ignore read name/header *will use less RAM if set to -h 1* (1 = yes, default
      = no)
    inputBinding:
      position: 101
      prefix: -h
  - id: ignore_read_mapping
    type:
      - 'null'
      - int
    doc: Ignore read mapping to consensus (1 = yes, default = no)
    inputBinding:
      position: 101
      prefix: -y
  - id: independent_assembly
    type:
      - 'null'
      - int
    doc: Independent (de novo) assembly i.e Targets used to recruit reads for de novo
      assembly, not guide/seed reference-based assemblies (1 = yes, 0 = no)
    inputBinding:
      position: 101
      prefix: -i
  - id: min_contig_size_track
    type:
      - 'null'
      - int
    doc: Minimum contig size to track amino acid coverage and read position
    inputBinding:
      position: 101
      prefix: -z
  - id: min_depth
    type: int
    doc: Minimum depth of coverage allowed for contigs (e.g. -w 1 = process all reads).
      The assembly will stop when 50+ contigs with coverage < -w have been seen.
    inputBinding:
      position: 101
      prefix: -w
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum number of overlapping amino acids with the seed/contig during overhang
      consensus build up
    inputBinding:
      position: 101
      prefix: -m
  - id: min_ratio
    type:
      - 'null'
      - float
    doc: Minimum ratio used to accept a overhang consensus amino acid
    inputBinding:
      position: 101
      prefix: -r
  - id: min_reads_extension
    type:
      - 'null'
      - int
    doc: Minimum number of peptide reads needed to call a amino acid during an extension
    inputBinding:
      position: 101
      prefix: -o
  - id: peptide_reads
    type: File
    doc: File containing all the peptide reads
    inputBinding:
      position: 101
      prefix: -f
  - id: read_space_restriction
    type:
      - 'null'
      - int
    doc: Apply read space restriction to seeds while -s option in use (1 = yes, default
      = no)
    inputBinding:
      position: 101
      prefix: -u
  - id: seed_sequences
    type:
      - 'null'
      - File
    doc: Fasta file containing sequences to use as seeds exclusively (specify only
      if different from read set)
    inputBinding:
      position: 101
      prefix: -s
  - id: track_coverage
    type:
      - 'null'
      - int
    doc: Track amino acid coverage and read position for each contig
    inputBinding:
      position: 101
      prefix: -c
  - id: trim_end
    type:
      - 'null'
      - int
    doc: Trim up to -t amino acid(s) on the contig end when all possibilities have
      been exhausted for an extension
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - int
    doc: Runs in verbose mode (1 = yes, default = no)
    inputBinding:
      position: 101
      prefix: -v
  - id: word_size
    type:
      - 'null'
      - int
    doc: Target sequence word size to hash
    inputBinding:
      position: 101
      prefix: -j
outputs:
  - id: output_basename
    type:
      - 'null'
      - File
    doc: Basename for your output files
    outputBinding:
      glob: $(inputs.output_basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pass:0.3.1--hdfd78af_0
