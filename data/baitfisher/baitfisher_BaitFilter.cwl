cwlVersion: v1.2
class: CommandLineTool
baseCommand: BaitFilter
label: baitfisher_BaitFilter
doc: "BaitFilter is designed to post-process the output of the BaitFisher program
  to select appropriate bait regions, filter baits based on specificity (BLAST), and
  convert bait files to uploadable formats.\n\nTool homepage: https://github.com/cmayer/BaitFisher-package"
inputs:
  - id: blast_evalue_cutoff
    type:
      - 'null'
      - float
    doc: Maximum E-value specified when calling the blast program.
    inputBinding:
      position: 101
      prefix: --blast-evalue-cutoff
  - id: blast_executable
    type:
      - 'null'
      - string
    doc: Name of or path to the blast executable.
    default: blastn
    inputBinding:
      position: 101
      prefix: --blast-executable
  - id: blast_extra_commandline
    type:
      - 'null'
      - string
    doc: Extra command line parameters passed to the blast program (e.g., '-num_threads
      20').
    inputBinding:
      position: 101
      prefix: --blast-extra-commandline
  - id: blast_first_hit_evalue
    type:
      - 'null'
      - float
    doc: Maximum E-value for the best hit of the bait against the genome.
    default: 1e-06
    inputBinding:
      position: 101
      prefix: --blast-first-hit-evalue
  - id: blast_min_hit_coverage
    type:
      - 'null'
      - float
    doc: Minimum query hit coverage at least one bait must have in each tiling stack.
    inputBinding:
      position: 101
      prefix: --blast-min-hit-coverage-of-baits-in-tiling-stack
  - id: blast_result_file
    type:
      - 'null'
      - File
    doc: Use a pre-computed blast result file to skip the blast analysis.
    inputBinding:
      position: 101
      prefix: --blast-result-file
  - id: blast_second_hit_evalue
    type:
      - 'null'
      - float
    doc: Maximum E-value for the second best hit. Threshold for ambiguous binding.
    default: 1e-06
    inputBinding:
      position: 101
      prefix: --blast-second-hit-evalue
  - id: convert
    type:
      - 'null'
      - string
    doc: "Produces the final output file for upload to a bait company. Allowed parameters:
      'four-column-upload'."
    inputBinding:
      position: 101
      prefix: --convert
  - id: id_prefix
    type:
      - 'null'
      - string
    doc: Prefix string for all probe IDs in the four-column-upload file.
    inputBinding:
      position: 101
      prefix: --ID-prefix
  - id: ignore_rest
    type:
      - 'null'
      - boolean
    doc: Ignores the rest of the labeled arguments following this flag.
    inputBinding:
      position: 101
      prefix: --ignore_rest
  - id: input_bait_file
    type: File
    doc: Name of the input bait locus file obtained from BaitFisher or a previous
      BaitFilter run.
    inputBinding:
      position: 101
      prefix: --input-bait-file-name
  - id: mode
    type:
      - 'null'
      - string
    doc: Specifies the filter mode (e.g., ab, as, fb, fs, blast-a, blast-f, blast-l,
      blast-c, thin-b, thin-s).
    inputBinding:
      position: 101
      prefix: --mode
  - id: ref_blast_db
    type:
      - 'null'
      - string
    doc: Base name to a blast data base file (fasta file of reference genome).
    inputBinding:
      position: 101
      prefix: --ref-blast-db
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Compute bait file characteristics for the input file and report these.
    inputBinding:
      position: 101
      prefix: --stats
  - id: thinning_step_width
    type:
      - 'null'
      - int
    doc: Step width N for thinning out the bait file (required for thin modes).
    inputBinding:
      position: 101
      prefix: --thinning-step-width
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Controls the amount of information written to the console (0-10000).
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output_bait_file
    type:
      - 'null'
      - File
    doc: Name of the output bait file.
    outputBinding:
      glob: $(inputs.output_bait_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/baitfisher:v1.2.7git20180107.e92dbf2dfsg-1-deb_cv1
