cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mirtrace
  - trace
label: mirtrace_trace
doc: "miRNA trace mode. Produces a clade report. --species is ignored.\n\nTool homepage:
  https://github.com/friedlanderlab/mirtrace"
inputs:
  - id: fastq_filenames
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ filenames
    inputBinding:
      position: 200
  - id: adapter
    type:
      - 'null'
      - string
    doc: <DNA sequence>
    inputBinding:
      position: 103
      prefix: --adapter
  - id: comment
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --comment
    doc: Add a comment to the generated report. Multiple arguments can be given.
    inputBinding:
      position: 103
  - id: config
    type:
      - 'null'
      - File
    doc: 'List of FASTQ files to process. This is a CSV (comma separated value) file,
      i.e. with one entry per row. Each row consists of the following columns (only
      the first is required): filename,name-displayed-in-report,adapter,PHRED-ASCII-offset.
      NOTE: the PHRED ASCII offset can typically be reliably auto-detected and is
      not necessary to specify.'
    inputBinding:
      position: 103
      prefix: --config
  - id: custom_db_folder
    type:
      - 'null'
      - Directory
    doc: Folder containing user-generated reference databases.
    inputBinding:
      position: 103
      prefix: --custom-db-folder
  - id: enable_pipes
    type:
      - 'null'
      - boolean
    doc: 'Enable support for named pipes (fifos) as input. NOTE: Requires a config
      file with PHRED and adapter given for each entry. Input must not be compressed.'
    inputBinding:
      position: 103
      prefix: --enable-pipes
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory if it exists.
    inputBinding:
      position: 103
      prefix: --force
  - id: global_mem_reserve
    type:
      - 'null'
      - int
    doc: Amount of Java memory reserved for "housekeeping" tasks (in MB). 
      Increase only if OutOfMemoryErrors are occurring. Decrease only if 
      available system memory is very low.
    inputBinding:
      position: 103
      prefix: --global-mem-reserve
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Maximum number of processing threads to use.
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Directory for output files.
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: protocol
    type:
      - 'null'
      - string
    doc: "One of the following (read structure schematic in parens): illumina (miRNA--3'-adapter--index)
      [DEFAULT], qiaseq (miRNA--3'-adapter--UMI--3'-adapter--index), cats (NNN--miRNA--poly-A--3'-adapter--index),
      nextflex (NNNN--miRNA--NNNN--3'-adapter--index)"
    inputBinding:
      position: 103
      prefix: --protocol
  - id: title
    type:
      - 'null'
      - string
    doc: Set the report title.
    inputBinding:
      position: 103
      prefix: --title
  - id: uncollapse_fasta
    type:
      - 'null'
      - boolean
    doc: Write one FASTA entry per original FASTQ entry.
    inputBinding:
      position: 103
      prefix: --uncollapse-fasta
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: Level of detail for debug messages.
    inputBinding:
      position: 103
      prefix: --verbosity-level
  - id: write_fasta
    type:
      - 'null'
      - boolean
    doc: Write QC-passed reads and unknown reads (as defined in the RNA type 
      plot) to the output folder. Identical reads are collapsed. Entries are 
      sorted by abundance.
    inputBinding:
      position: 103
      prefix: --write-fasta
outputs:
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Directory for output files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirtrace:1.0.1--0
