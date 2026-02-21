cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - trgt
  - merge
label: trgt_merge
doc: "Tandem Repeat VCF Merger\n\nTool homepage: https://github.com/PacificBiosciences/trgt"
inputs:
  - id: color
    type:
      - 'null'
      - string
    doc: 'Enable or disable color output in logging [possible values: always, auto,
      never]'
    default: auto
    inputBinding:
      position: 101
      prefix: --color
  - id: contig
    type:
      - 'null'
      - string
    doc: Process only the specified contigs (comma-separated list)
    inputBinding:
      position: 101
      prefix: --contig
  - id: force_single
    type:
      - 'null'
      - boolean
    doc: Run even if there is only one file on input
    inputBinding:
      position: 101
      prefix: --force-single
  - id: genome
    type:
      - 'null'
      - File
    doc: Path to reference genome FASTA
    inputBinding:
      position: 101
      prefix: --genome
  - id: no_index
    type:
      - 'null'
      - boolean
    doc: Stream VCFs without loading their indexes (contig order must match across
      inputs)
    inputBinding:
      position: 101
      prefix: --no-index
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 101
      prefix: --no-version
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'Output type: u|b|v|z, u/b: un/compressed BCF, v/z: un/compressed VCF'
    inputBinding:
      position: 101
      prefix: --output-type
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: Print only the merged header and exit
    inputBinding:
      position: 101
      prefix: --print-header
  - id: process_n
    type:
      - 'null'
      - int
    doc: Only process N records
    inputBinding:
      position: 101
      prefix: --process-n
  - id: quit_on_errors
    type:
      - 'null'
      - boolean
    doc: Quit immediately on errors during merging
    inputBinding:
      position: 101
      prefix: --quit-on-errors
  - id: skip_n
    type:
      - 'null'
      - int
    doc: Skip the first N records
    inputBinding:
      position: 101
      prefix: --skip-n
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for (de)compressing input/output VCF files
    default: 2
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: VCF files to merge
    inputBinding:
      position: 101
      prefix: --vcf
  - id: vcf_list
    type:
      - 'null'
      - File
    doc: File containing paths of VCF files to merge (one per line)
    inputBinding:
      position: 101
      prefix: --vcf-list
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Specify multiple times to increase verbosity level (e.g., -vv for more verbosity)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: write_index
    type:
      - 'null'
      - boolean
    doc: Write index for the output compressed VCF/BCF file
    inputBinding:
      position: 101
      prefix: --write-index
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to a file [standard output]
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trgt:5.0.0--h9ee0642_0
