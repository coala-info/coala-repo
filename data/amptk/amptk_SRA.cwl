cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amptk
  - SRA
label: amptk_SRA
doc: "Script that takes De-mulitplexed Illumina data from a folder and processes it
  for amptk (merge PE reads, strip primers, trim/pad to set length.\n\nTool homepage:
  https://github.com/nextgenusfs/amptk"
inputs:
  - id: barcode_mismatch
    type:
      - 'null'
      - int
    doc: Number of mis-matches allowed in index
    inputBinding:
      position: 101
      prefix: --barcode_mismatch
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Delete all intermediate files
    inputBinding:
      position: 101
      prefix: --cleanup
  - id: cpus
    type:
      - 'null'
      - int
    doc: 'Number of CPUs. Default: auto'
    inputBinding:
      position: 101
      prefix: --cpus
  - id: full_length
    type:
      - 'null'
      - boolean
    doc: Keep only full length reads (no trimming/padding)
    inputBinding:
      position: 101
      prefix: --full_length
  - id: fwd_primer
    type:
      - 'null'
      - string
    doc: Forward Primer (fITS7)
    inputBinding:
      position: 101
      prefix: --fwd_primer
  - id: input_folder
    type: Directory
    doc: Folder of Illumina Data
    inputBinding:
      position: 101
      prefix: --input
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: 'Mapping file: QIIME format can have extra meta data columns'
    inputBinding:
      position: 101
      prefix: --mapping_file
  - id: merge_method
    type:
      - 'null'
      - string
    doc: Software to use for PE read merging
    inputBinding:
      position: 101
      prefix: --merge_method
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum read length to keep
    inputBinding:
      position: 101
      prefix: --min_len
  - id: output_folder
    type:
      - 'null'
      - string
    doc: Name for output folder
    inputBinding:
      position: 101
      prefix: --out
  - id: pad
    type:
      - 'null'
      - string
    doc: Pad with Ns to a set length
    inputBinding:
      position: 101
      prefix: --pad
  - id: primer_mismatch
    type:
      - 'null'
      - int
    doc: Number of mis-matches in primer
    inputBinding:
      position: 101
      prefix: --primer_mismatch
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length, i.e. 2 x 300 bp = 300
    inputBinding:
      position: 101
      prefix: --read_length
  - id: reads
    type:
      - 'null'
      - string
    doc: PE or forward reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: require_primer
    type:
      - 'null'
      - string
    doc: Require Fwd primer to be present
    inputBinding:
      position: 101
      prefix: --require_primer
  - id: rescue_forward
    type:
      - 'null'
      - string
    doc: Rescue Not-merged forward reads
    inputBinding:
      position: 101
      prefix: --rescue_forward
  - id: rev_primer
    type:
      - 'null'
      - string
    doc: Reverse Primer (ITS4)
    inputBinding:
      position: 101
      prefix: --rev_primer
  - id: sra
    type:
      - 'null'
      - boolean
    doc: Input files are from NCBI SRA not direct from illumina
    inputBinding:
      position: 101
      prefix: --sra
  - id: trim_len
    type:
      - 'null'
      - int
    doc: Trim length for reads
    inputBinding:
      position: 101
      prefix: --trim_len
  - id: usearch_executable
    type:
      - 'null'
      - string
    doc: USEARCH executable
    inputBinding:
      position: 101
      prefix: --usearch
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_folder_dir
    type:
      - 'null'
      - Directory
    doc: Name for output folder
    outputBinding:
      glob: $(inputs.output_folder)
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written beside the output folder (demux.fq.gz, log, mapping file)
    outputBinding:
      glob: $(inputs.output_folder).*
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_folder)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_SRA.out
