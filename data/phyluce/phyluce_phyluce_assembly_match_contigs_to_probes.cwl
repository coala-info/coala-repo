cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_match_contigs_to_probes
label: phyluce_phyluce_assembly_match_contigs_to_probes
doc: "Match UCE probes/baits to assembled contigs and store the data in a relational database. The matching process is dependent on the probe names in the file. If the probe names are not like 'uce-1001_p1' where 'uce-' indicates we're searching for uce loci, '1001' indicates locus 1001, '_p1' indicates this is probe 1 for locus 1001, you will need to set the optional --regex parameter.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: contigs
    type: Directory
    doc: "The directory containing the assembled contigs in which you are searching for UCE loci."
    inputBinding:
      position: 1
      prefix: --contigs
  - id: probes
    type: File
    doc: "The bait/probe file in FASTA format."
    inputBinding:
      position: 1
      prefix: --probes
  - id: output
    type: string
    doc: "The directory in which to store the resulting SQL database and LASTZ files. It must not exist yet."
    inputBinding:
      position: 1
      prefix: --output
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use (INFO, WARN or CRITICAL)."
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory must already exist."
    inputBinding:
      position: 1
      prefix: --log-path
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: "The minimum percent coverage required for a match [default=80]."
    inputBinding:
      position: 1
      prefix: --min-coverage
  - id: min_identity
    type:
      - 'null'
      - int
    doc: "The minimum percent identity required for a match [default=80]."
    inputBinding:
      position: 1
      prefix: --min-identity
  - id: dupefile
    type:
      - 'null'
      - File
    doc: "Path to self-to-self lastz results for baits to remove potential duplicate probes."
    inputBinding:
      position: 1
      prefix: --dupefile
  - id: regex
    type:
      - 'null'
      - string
    doc: "A regular expression to apply to the probe names for replacement [default='^(uce-\\d+)(?:_p\\d+.*)']."
    inputBinding:
      position: 1
      prefix: --regex
  - id: keep_duplicates
    type:
      - 'null'
      - string
    doc: "A optional output file in which to store those loci that appear to be duplicates."
    inputBinding:
      position: 1
      prefix: --keep-duplicates
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_dir
    type: Directory
    doc: "The directory holding probe.matches.sqlite and the lastz files"
    outputBinding:
      glob: $(inputs.output)
  - id: duplicates_file
    type:
      - 'null'
      - File
    doc: "The file of duplicate loci"
    outputBinding:
      glob: $(inputs.keep_duplicates)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_assembly_match_contigs_to_probes.out
