cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - format
label: rtg-tools_rtg_format
doc: 'Converts the contents of sequence data files (FASTA/FASTQ/SAM/BAM) into the RTG Sequence Data File (SDF) format. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: 'format of input. Allowed values are [fasta, fastq, fastq-interleaved, sam-se, sam-pe] (Default is fasta)'
    inputBinding:
      position: 101
      prefix: --format
  - id: input_list_file
    type:
      - 'null'
      - File
    doc: 'file containing a list of input read files (1 per line)'
    inputBinding:
      position: 101
      prefix: --input-list-file
  - id: left
    type:
      - 'null'
      - File
    doc: 'left input file for FASTA/FASTQ paired end data'
    inputBinding:
      position: 101
      prefix: --left
  - id: output
    type: string
    doc: 'name of output SDF'
    inputBinding:
      position: 101
      prefix: --output
  - id: protein
    type:
      - 'null'
      - boolean
    doc: 'input is protein. If this option is not specified, then the input is assumed to consist of nucleotides'
    inputBinding:
      position: 101
      prefix: --protein
  - id: quality_format
    type:
      - 'null'
      - string
    doc: 'quality data encoding method used in FASTQ input files (Illumina 1.8+ uses sanger). Allowed values are [sanger, solexa, illumina] (Default is sanger)'
    inputBinding:
      position: 101
      prefix: --quality-format
  - id: right
    type:
      - 'null'
      - File
    doc: 'right input file for FASTA/FASTQ paired end data'
    inputBinding:
      position: 101
      prefix: --right
  - id: duster
    type:
      - 'null'
      - boolean
    doc: 'treat lower case residues as unknowns'
    inputBinding:
      position: 101
      prefix: --duster
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude
    doc: 'exclude input sequences based on their name. If the input sequence contains the specified string then that sequence is excluded from the SDF. May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: select_read_group
    type:
      - 'null'
      - string
    doc: 'when formatting from SAM/BAM input, only include reads with this read group ID'
    inputBinding:
      position: 101
      prefix: --select-read-group
  - id: trim_threshold
    type:
      - 'null'
      - int
    doc: 'trim read ends to maximise base quality above the given threshold'
    inputBinding:
      position: 101
      prefix: --trim-threshold
  - id: allow_duplicate_names
    type:
      - 'null'
      - boolean
    doc: 'disable checking for duplicate sequence names'
    inputBinding:
      position: 101
      prefix: --allow-duplicate-names
  - id: no_names
    type:
      - 'null'
      - boolean
    doc: 'do not include name data in the SDF output'
    inputBinding:
      position: 101
      prefix: --no-names
  - id: no_quality
    type:
      - 'null'
      - boolean
    doc: 'do not include quality data in the SDF output'
    inputBinding:
      position: 101
      prefix: --no-quality
  - id: sam_rg
    type:
      - 'null'
      - string
    doc: 'file containing a single valid read group SAM header line or a string in the form "@RG\tID:READGROUP1\tSM:BACT_SAMPLE\tPL:ILLUMINA"'
    inputBinding:
      position: 101
      prefix: --sam-rg
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'input sequence files. May be specified 0 or more times'
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: sdf
    type: Directory
    doc: Output SDF directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_format.out
