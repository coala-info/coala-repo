cwlVersion: v1.2
class: CommandLineTool
baseCommand: transcriptm
label: transcriptm
doc: "Process metatranscriptomic data and complete metagenomics analysis\n\nTool homepage:
  https://github.com/elfrouin/transcriptM"
inputs:
  - id: paired_end
    type:
      type: array
      items: File
    doc: 'Input files: paired sequences files of raw metatranscriptomics reads (.fq.gz
      format)'
    inputBinding:
      position: 1
      prefix: --paired_end
  - id: metaG_contigs
    type: File
    doc: All contigs from the reference metagenome in a fasta file
    inputBinding:
      position: 2
      prefix: --metaG_contigs
  - id: dir_bins
    type: Directory
    doc: Directory which contains several annotated population genomes (bins)
    inputBinding:
      position: 3
      prefix: --dir_bins
  - id: adapters
    type:
      - 'null'
      - string
    doc: Type of adapters to clip
    inputBinding:
      position: 104
      prefix: --adapters
  - id: crop
    type:
      - 'null'
      - int
    doc: Cut read to a specific length
    inputBinding:
      position: 104
      prefix: --crop
  - id: db_path
    type:
      - 'null'
      - Directory
    doc: Directory which contains the TranscriptM databases
    inputBinding:
      position: 104
      prefix: --db_path
  - id: headcrop
    type:
      - 'null'
      - int
    doc: Cut specified number of bases from start of read
    inputBinding:
      position: 104
      prefix: --headcrop
  - id: log_file
    type:
      - 'null'
      - File
    doc: Name and path of log file
    inputBinding:
      position: 104
      prefix: --log_file
  - id: min_avg_qc
    type:
      - 'null'
      - int
    doc: Minimum average quality score for 4 bp windows
    inputBinding:
      position: 104
      prefix: --min_avg_qc
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum required length of read
    inputBinding:
      position: 104
      prefix: --min_len
  - id: min_qc
    type:
      - 'null'
      - int
    doc: Minimum quality score for leading and trailing bases
    inputBinding:
      position: 104
      prefix: --min_qc
  - id: no_mapping_filter
    type:
      - 'null'
      - boolean
    doc: Do not adjust the mapping stringency by filtering alignments
    inputBinding:
      position: 104
      prefix: --no_mapping_filter
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Output directory
    inputBinding:
      position: 104
      prefix: --output_dir
  - id: path_db_smr
    type:
      - 'null'
      - string
    doc: Path to databases and index
    inputBinding:
      position: 104
      prefix: --path_db_smr
  - id: percentage_aln
    type:
      - 'null'
      - float
    doc: Minimum allowable percentage read bases mapped
    inputBinding:
      position: 104
      prefix: --percentage_aln
  - id: percentage_id
    type:
      - 'null'
      - float
    doc: Minimum allowable percentage base identity of a mapped read
    inputBinding:
      position: 104
      prefix: --percentage_id
  - id: phred
    type:
      - 'null'
      - string
    doc: Quality encoding
    inputBinding:
      position: 104
      prefix: --phred
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more verbose messages for each additional verbose level.
    inputBinding:
      position: 104
      prefix: --verbose
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Working directory
    inputBinding:
      position: 104
      prefix: --working_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcriptm:0.2--pyhdfd78af_0
stdout: transcriptm.out
