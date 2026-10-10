cwlVersion: v1.2
class: CommandLineTool
baseCommand: mGEMS
label: mgems_mGEMS
doc: "mGEMS is a tool for extracting sequencing reads belonging to specific taxonomic
  groups from metagenomic datasets using pseudoalignments and posterior probabilities.
  Runs both the binning (mGEMS bin) and the extraction (mGEMS extract) steps.\n\
  \nTool homepage: https://github.com/PROBIC/mGEMS"
inputs:
  - id: input_reads
    type:
      type: array
      items: File
    doc: Comma-separated list of input read(s).
    inputBinding:
      position: 101
      prefix: -r
      itemSeparator: ','
  - id: group_indicators
    type: File
    doc: Group identifiers file used with the mSWEEP call.
    inputBinding:
      position: 101
      prefix: -i
  - id: themisto_alns
    type:
      type: array
      items: File
    doc: Comma-separated list of pseudoalignment file(s) for the reads from 
      themisto.
    inputBinding:
      position: 101
      prefix: --themisto-alns
      itemSeparator: ','
  - id: probs
    type: File
    doc: Posterior probability matrix (output from mSWEEP with the --write-probs
      flag).
    inputBinding:
      position: 101
      prefix: --probs
  - id: abundance_estimates
    type: File
    doc: Relative abundance estimates from mSWEEP (tab-separated, 1st column has
      the group names and 2nd column the estimates).
    inputBinding:
      position: 101
      prefix: -a
  - id: index
    type: Directory
    doc: Themisto pseudoalignment index directory.
    inputBinding:
      position: 101
      prefix: --index
  - id: groups
    type:
      - 'null'
      - type: array
        items: string
    doc: Which groups to extract from the input reads (optional).
    inputBinding:
      position: 101
      prefix: --groups
      itemSeparator: ','
  - id: min_abundance
    type:
      - 'null'
      - float
    doc: Extract only groups that have a relative abundance higher than this 
      value.
    inputBinding:
      position: 101
      prefix: --min-abundance
  - id: write_unassigned
    type:
      - 'null'
      - boolean
    doc: Extract reads that pseudoaligned to a reference sequence but were not 
      assigned to any group.
    inputBinding:
      position: 101
      prefix: --write-unassigned
  - id: write_assignment_table
    type:
      - 'null'
      - boolean
    doc: Write the read to group assignments table to `reads_to_groups.tsv` in 
      the output directory.
    inputBinding:
      position: 101
      prefix: --write-assignment-table
  - id: unique_only
    type:
      - 'null'
      - boolean
    doc: Write only the reads that are assigned to a single group.
    inputBinding:
      position: 101
      prefix: --unique-only
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default 1).
    inputBinding:
      position: 101
      prefix: -t
  - id: q_threshold
    type:
      - 'null'
      - float
    doc: Tuning parameter for the binning thresholds (default 1.0).
    inputBinding:
      position: 101
      prefix: -q
  - id: merge_mode
    type:
      - 'null'
      - string
    doc: How to merge paired-end alignments from Themisto (default 
      intersection).
    inputBinding:
      position: 101
      prefix: --merge-mode
  - id: compress
    type:
      - 'null'
      - boolean
    doc: 'Toggle compression of the output files. Compression is on by default; giving this flag turns it off (writes plain text).'
    inputBinding:
      position: 101
      prefix: --compress
  - id: output_directory_path
    type: string
    doc: Output directory (created before the run).
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_directory_path)
        entry: '$({"class": "Directory", "basename": inputs.output_directory_path, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgems:1.3.3--h13024bc_2
