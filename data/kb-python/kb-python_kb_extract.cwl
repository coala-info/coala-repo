cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kb
  - extract
label: kb-python_kb_extract
doc: "Extract sequencing reads that were pseudoaligned to specific genes/transcripts (or extract all reads that were / were not pseudoaligned).\n\nTool homepage: https://github.com/pachterlab/kb_python"
inputs:
  - id: fastq
    type: File
    doc: "Single fastq file containing the sequencing reads (e.g. in case of 10x data, provide the R2 file)."
    inputBinding:
      position: 1
  - id: tmp
    type:
      - 'null'
      - string
    doc: "Override default temporary directory"
    inputBinding:
      position: 102
      prefix: --tmp
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: "Do not delete the tmp directory"
    inputBinding:
      position: 102
      prefix: --keep-tmp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print debugging information"
    inputBinding:
      position: 102
      prefix: --verbose
  - id: index
    type: File
    doc: "Path to kallisto index"
    inputBinding:
      position: 102
      prefix: -i
  - id: targets
    type:
      - 'null'
      - type: array
        items: string
    doc: "Gene or transcript names for which to extract the raw reads that align to the index"
    inputBinding:
      position: 102
      prefix: -ts
  - id: target_type
    type:
      - 'null'
      - string
    doc: "'gene' (default) or 'transcript' -> Defines whether targets are gene or transcript names"
    inputBinding:
      position: 102
      prefix: -ttype
  - id: extract_all
    type:
      - 'null'
      - boolean
    doc: "Extracts all reads that pseudo-aligned to any gene or transcript (breaks down output by gene/transcript)."
    inputBinding:
      position: 102
      prefix: --extract_all
  - id: extract_all_fast
    type:
      - 'null'
      - boolean
    doc: "Extracts all reads that pseudo-aligned (does not break down output by gene/transcript; output saved in the \"all\" folder)."
    inputBinding:
      position: 102
      prefix: --extract_all_fast
  - id: extract_all_unmapped
    type:
      - 'null'
      - boolean
    doc: "Extracts all unmapped reads (output saved in the \"all_unmapped\" folder)."
    inputBinding:
      position: 102
      prefix: --extract_all_unmapped
  - id: mm
    type:
      - 'null'
      - boolean
    doc: "Also extract reads that multi-mapped to more than one gene."
    inputBinding:
      position: 102
      prefix: --mm
  - id: t2g
    type:
      - 'null'
      - File
    doc: "Path to transcript-to-gene mapping file (required when mm = False, target_type = \"gene\" (and extract_all_fast and extract_all_unmapped = False), OR extract_all = True)."
    inputBinding:
      position: 102
      prefix: -g
  - id: out
    type: string
    default: kb_extract_out
    doc: "Path to output directory (default: current directory)"
    inputBinding:
      position: 102
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default: 8)"
    inputBinding:
      position: 102
      prefix: -t
  - id: strand
    type:
      - 'null'
      - string
    doc: "Strandedness: unstranded, forward or reverse (default: unstranded)"
    inputBinding:
      position: 102
      prefix: --strand
  - id: aa
    type:
      - 'null'
      - boolean
    doc: "Map to index generated from FASTA-file containing amino acid sequences"
    inputBinding:
      position: 102
      prefix: --aa
  - id: num_reads
    type:
      - 'null'
      - int
    doc: "Maximum number of reads to process from supplied fastq"
    inputBinding:
      position: 102
      prefix: -N
  - id: kallisto
    type:
      - 'null'
      - string
    doc: "Path to kallisto binary to use (inside the container)"
    inputBinding:
      position: 102
      prefix: --kallisto
  - id: bustools
    type:
      - 'null'
      - string
    doc: "Path to bustools binary to use (inside the container)"
    inputBinding:
      position: 102
      prefix: --bustools
  - id: opt_off
    type:
      - 'null'
      - boolean
    doc: "Disable performance optimizations"
    inputBinding:
      position: 102
      prefix: --opt-off
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory with the extracted reads"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
stdout: kb-python_kb_extract.out
