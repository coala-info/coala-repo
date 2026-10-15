cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_get_bed_for_genome_enabled_taxon
label: phyluce_phyluce_assembly_get_bed_for_genome_enabled_taxon
doc: "Get a BED file for the given taxon using the probe.matches.sqlite database, the lastz file, and a taxon name\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: locus_db
    type: File
    doc: "The probe.matches.sqlite database"
    inputBinding:
      position: 1
      prefix: --locus-db
  - id: lastz_file
    type: File
    doc: "The lastz file to use"
    inputBinding:
      position: 1
      prefix: --lastz-file
  - id: taxon_name
    type: string
    doc: "The taxon name to search for in probe.matches.sqlite"
    inputBinding:
      position: 1
      prefix: --taxon-name
  - id: output
    type: string
    doc: "The output BED file to create"
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
  - id: regex
    type:
      - 'null'
      - string
    doc: "A regular expression to apply to the probe names for replacement [default='^(uce-\\d+)(?:_p\\d+.*)']."
    inputBinding:
      position: 1
      prefix: --regex
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_bed
    type: File
    doc: "The output BED file"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_assembly_get_bed_for_genome_enabled_taxon.out
