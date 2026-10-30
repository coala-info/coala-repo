cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - contigs
label: mccortex_contigs
doc: "Assemble contigs from the graph and print statistics.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence status output normally printed to STDERR.
    inputBinding:
      position: 1
      prefix: --quiet
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output files if they already exist.
    inputBinding:
      position: 1
      prefix: --force
  - id: memory
    type:
      - 'null'
      - string
    doc: Memory to use (for example 1GB, 500M, 20GB). Default 1GB.
    inputBinding:
      position: 1
      prefix: --memory
  - id: nkmers
    type:
      - 'null'
      - string
    doc: Number of hash table entries (for example 4M, 1G). Default 4M.
    inputBinding:
      position: 1
      prefix: --nkmers
  - id: threads
    type:
      - 'null'
      - int
    doc: Limit on processing threads (default 2).
    inputBinding:
      position: 1
      prefix: --threads
  - id: out
    type:
      - 'null'
      - string
    default: contigs.fa
    doc: Output FASTA file of contigs.
    inputBinding:
      position: 1
      prefix: --out
  - id: colour
    type:
      - 'null'
      - int
    doc: Pull out contigs from the given colour (default 0).
    inputBinding:
      position: 1
      prefix: --colour
  - id: paths
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --paths
    doc: Link file (.ctp or .ctp.gz) to load. Can be given multiple times; use offset:file.ctp to choose the colour.
    inputBinding:
      position: 1
  - id: ncontigs
    type:
      - 'null'
      - int
    doc: Pull out this many contigs from random k-mers (default 0, no limit).
    inputBinding:
      position: 1
      prefix: --ncontigs
  - id: seed
    type:
      - 'null'
      - File
    doc: Use seed k-mers from a FASTA file; reads must be of k-mer length.
    inputBinding:
      position: 1
      prefix: --seed
  - id: reseed
    type:
      - 'null'
      - boolean
    doc: Sample seed k-mers with replacement.
    inputBinding:
      position: 1
      prefix: --reseed
  - id: no_reseed
    type:
      - 'null'
      - boolean
    doc: Do not use a seed k-mer if it is used in a contig (default).
    inputBinding:
      position: 1
      prefix: --no-reseed
  - id: use_seed_paths
    type:
      - 'null'
      - boolean
    doc: Use unused paths to seed contigs.
    inputBinding:
      position: 1
      prefix: --use-seed-paths
  - id: genome
    type:
      - 'null'
      - long
    doc: Genome size in bases.
    inputBinding:
      position: 1
      prefix: --genome
  - id: confid_cumul
    type:
      - 'null'
      - float
    doc: Halt if cumulative confidence is below this value (0 to 1; default off).
    inputBinding:
      position: 1
      prefix: --confid-cumul
  - id: confid_step
    type:
      - 'null'
      - float
    doc: Halt if single step confidence is below this value (0 to 1; default off).
    inputBinding:
      position: 1
      prefix: --confid-step
  - id: confid_csv
    type:
      - 'null'
      - string
    doc: Save the confidence table to this CSV file.
    inputBinding:
      position: 1
      prefix: --confid-csv
  - id: no_missing_check
    type:
      - 'null'
      - boolean
    doc: Do not use the missing information check.
    inputBinding:
      position: 1
      prefix: --no-missing-check
  - id: graph
    type:
      type: array
      items: File
    doc: Input cortex graph file(s) (.ctx).
    inputBinding:
      position: 100
outputs:
  - id: contigs_fa
    type:
      - 'null'
      - File
    doc: Assembled contigs in FASTA format.
    outputBinding:
      glob: $(inputs.out)
  - id: confid_csv_file
    type:
      - 'null'
      - File
    doc: Confidence table.
    outputBinding:
      glob: $(inputs.confid_csv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
