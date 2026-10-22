cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sider
  - process-sample
label: sideretro_process-sample
doc: "Extract alignments related to an event of retrocopy. Output is a SQLite3
  database that can be processed at the merge-call step.\n\nTool homepage:
  https://github.com/galantelab/sideRETRO"
inputs:
  - id: annotation_file
    type: File
    doc: Gene annotation on the reference genome in GTF/GFF3 format. sider looks
      for 'exon' with the attribute 'transcript_type=protein_coding'. The
      attributes 'gene_name', 'gene_id' and 'exon_id' are also required.
    inputBinding:
      position: 1
      prefix: --annotation-file
  - id: input_list_file
    type:
      - 'null'
      - File
    doc: File containing a newline separated list of alignment files in
      SAM/BAM/CRAM format. Not mandatory if alignment files are passed as
      arguments.
    inputBinding:
      position: 1
      prefix: --input-file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease verbosity to error messages only or suppress terminal outputs
      at all if 'log-file' is passed
    inputBinding:
      position: 1
      prefix: --quiet
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Same as quiet
    inputBinding:
      position: 1
      prefix: --silent
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Increase verbosity to debug level
    inputBinding:
      position: 1
      prefix: --debug
  - id: log_file
    type:
      - 'null'
      - string
    doc: Print log messages to a file
    inputBinding:
      position: 1
      prefix: --log-file
  - id: output_dir
    type: string
    doc: Output directory. Create the directory if it does not exist.
    inputBinding:
      position: 1
      prefix: --output-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix output files [default:"out"]
    inputBinding:
      position: 1
      prefix: --prefix
  - id: cache_size
    type:
      - 'null'
      - int
    doc: Set SQLite3 cache size in KiB [default:"200000"]
    inputBinding:
      position: 1
      prefix: --cache-size
  - id: phred_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality of the reads required [default:"8"]
    inputBinding:
      position: 1
      prefix: --phred-quality
  - id: max_base_freq
    type:
      - 'null'
      - double
    doc: Maximum base frequency fraction allowed [default:"0.75"]
    inputBinding:
      position: 1
      prefix: --max-base-freq
  - id: deduplicate
    type:
      - 'null'
      - boolean
    doc: Remove duplicated reads. Reads are duplicates when they share the 5
      prime positions of both reads and read-pairs.
    inputBinding:
      position: 1
      prefix: --deduplicate
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Assume all reads are grouped by queryname, even if there is no
      SAM/BAM/CRAM header tag 'SO:queryname'
    inputBinding:
      position: 1
      prefix: --sorted
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [default:"1"]
    inputBinding:
      position: 1
      prefix: --threads
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum distance allowed between paired-end reads [default:"10000"]
    inputBinding:
      position: 1
      prefix: --max-distance
  - id: exon_frac
    type:
      - 'null'
      - double
    doc: Minimum overlap required as a fraction of exon [default:"1e-09"; 1 base]
    inputBinding:
      position: 1
      prefix: --exon-frac
  - id: alignment_frac
    type:
      - 'null'
      - double
    doc: Minimum overlap required as a fraction of alignment [default:"1e-09"; 1
      base]
    inputBinding:
      position: 1
      prefix: --alignment-frac
  - id: either
    type:
      - 'null'
      - boolean
    doc: The minimum fraction must be satisfied for at least exon OR alignment.
    inputBinding:
      position: 1
      prefix: --either
  - id: reciprocal
    type:
      - 'null'
      - boolean
    doc: The fraction overlap must be reciprocal for exon and alignment.
    inputBinding:
      position: 1
      prefix: --reciprocal
  - id: alignment_files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more alignment files in SAM/BAM/CRAM format
    inputBinding:
      position: 2
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory with the SQLite3 database
    outputBinding:
      glob: $(inputs.output_dir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sideretro:1.1.6--hb728cf0_0
stdout: sideretro_process-sample.out
