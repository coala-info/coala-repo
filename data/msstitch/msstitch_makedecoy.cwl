cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch_makedecoy
label: msstitch_makedecoy
doc: "Create decoy sequences for MS/MS analysis.\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: dbfile
    type:
      - 'null'
      - File
    doc: Database lookup file
    inputBinding:
      position: 101
      prefix: --dbfile
  - id: ignore_target_hits
    type:
      - 'null'
      - boolean
    doc: Do not remove tryptic peptides from sequence where they match target DB
    inputBinding:
      position: 101
      prefix: --ignore-target-hits
  - id: in_memory
    type:
      - 'null'
      - boolean
    doc: Load sqlite lookup in memory in case of not having access to a fast 
      file system
    inputBinding:
      position: 101
      prefix: --in-memory
  - id: input_file
    type: File
    doc: Input file of {} format
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_target
    type:
      - 'null'
      - boolean
    doc: If this flag is passed, sequences that are shuffled the --max-shuffle 
      amount of times will be kept as unshuffled tryptic reversed peptides. In 
      case you want to keep the target/decoy DB the same sizes
    inputBinding:
      position: 101
      prefix: --keep-target
  - id: max_shuffle
    type:
      - 'null'
      - int
    doc: Amount of times to attempt to shuffle a decoy reversed peptide to make 
      it not match target peptides, before discarding it. Used when using 
      tryptic peptide reversal (not protein reversal)
    inputBinding:
      position: 101
      prefix: --maxshuffle
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of peptide to be included
    inputBinding:
      position: 101
      prefix: --minlen
  - id: miss_cleavage
    type:
      - 'null'
      - int
    doc: Amount of missed cleavages to allow when trypsinizing, default is 0
    inputBinding:
      position: 101
      prefix: --miscleav
  - id: notrypsin
    type:
      - 'null'
      - boolean
    doc: Do not trypsinize. In case of using a pretrypsinized FASTA file
    inputBinding:
      position: 101
      prefix: --notrypsin
  - id: scramble
    type:
      - 'null'
      - string
    doc: 'Decoy scrambling method, use: "tryp_rev": tryptic reverse, or "prot_rev":
      full (protein) reverse.'
    inputBinding:
      position: 101
      prefix: --scramble
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to output in
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
