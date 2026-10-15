cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_slice_sequence_from_genomes
label: phyluce_phyluce_probe_slice_sequence_from_genomes
doc: "Given a LASTZ input directory, find matches, add flank, and return a FASTA file\
  \ of sequences\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: conf
    type: File
    doc: Path to the configuration file (sections [chromos] / [scaffolds] with name:2bit-file
      entries; use bare 2bit file names)
    inputBinding:
      prefix: --conf
  - id: genomes
    type:
      type: array
      items: File
    doc: The 2bit genome files named in the config file; they are staged in the working
      directory.
  - id: lastz
    type: Directory
    doc: Path to the directory containing LASTZ results
    inputBinding:
      prefix: --lastz
  - id: output_dir
    type: string
    doc: Path to the output directory for storing FASTA files
    inputBinding:
      prefix: --output
  - id: name_pattern
    type:
      - 'null'
      - string
    doc: An alternate name pattern to transform the conf entry into
    inputBinding:
      prefix: --name-pattern
  - id: probe_prefix
    type:
      - 'null'
      - string
    doc: The prefix (e.g. "uce-") added to all probes designed
    inputBinding:
      prefix: --probe-prefix
  - id: probe_regex
    type:
      - 'null'
      - string
    doc: The regular expression to use for matching probes
    inputBinding:
      prefix: --probe-regex
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Species to exclude from genome slicing
    inputBinding:
      prefix: --exclude
  - id: verbosity
    type:
      - 'null'
      - type: enum
        symbols:
          - INFO
          - WARN
          - CRITICAL
    doc: The logging level to use
    inputBinding:
      prefix: --verbosity
  - id: contig_orient
    type:
      - 'null'
      - boolean
    doc: Check orientation by contigs versus probes - useful for multi-species probe
      sets
    inputBinding:
      prefix: --contig_orient
  - id: flank
    type:
      - 'null'
      - int
    doc: The amount of flanking sequence to add to each match
    inputBinding:
      prefix: --flank
  - id: probes
    type:
      - 'null'
      - int
    doc: The probe length to use
    inputBinding:
      prefix: --probes
outputs:
  - id: output
    type: Directory
    doc: The directory of FASTA files, one per genome.
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genomes)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
