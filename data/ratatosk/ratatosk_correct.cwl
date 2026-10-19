cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Ratatosk
  - correct
label: ratatosk_correct
doc: "Correct long reads with short reads (hybrid error correction using colored de Bruijn graphs)\n\nTool homepage: https://github.com/DecodeGenetics/Ratatosk"
inputs:
  - id: in_short
    type:
      type: array
      items: File
      inputBinding:
        prefix: "-s"
    doc: "Input short read file(s) in fasta/fastq(.gz); reads of a pair must have the same name without /1 or /2"
    inputBinding:
      position: 1
  - id: in_long
    type:
      type: array
      items: File
      inputBinding:
        prefix: "-l"
    doc: "Input long read file(s) to correct in fasta/fastq(.gz)"
    inputBinding:
      position: 1
  - id: out_long
    type: string
    doc: "Output prefix (the corrected long reads are written to a file starting with this name)"
    inputBinding:
      position: 1
      prefix: "-o"
  - id: cores
    type:
      - 'null'
      - int
    doc: "Number of cores (default: 1)"
    inputBinding:
      position: 1
      prefix: "-c"
  - id: subsampling
    type:
      - 'null'
      - float
    doc: "Rate of short reads subsampling"
    inputBinding:
      position: 1
      prefix: "-S"
  - id: in_unmapped_short
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: "-u"
    doc: "Input unmapped short read file(s) in fasta/fastq(.gz)"
    inputBinding:
      position: 1
  - id: in_accurate_long
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: "-a"
    doc: "Input high quality long read file(s); these reads are NOT corrected but assist the correction"
    inputBinding:
      position: 1
  - id: in_graph
    type:
      - 'null'
      - File
    doc: "Load graph file prepared with the index command"
    inputBinding:
      position: 1
      prefix: "-g"
  - id: max_base_qual
    type:
      - 'null'
      - int
    doc: "Maximum base quality of input long reads (default: 40)"
    inputBinding:
      position: 1
      prefix: "-Q"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print information"
    inputBinding:
      position: 1
      prefix: "-v"
  - id: min_conf_color2
    type:
      - 'null'
      - float
    doc: "Minimum confidence threshold to color vertices for 2nd pass (default: 0)"
    inputBinding:
      position: 1
      prefix: "-M"
  - id: min_len_color2
    type:
      - 'null'
      - int
    doc: "Minimum length of a long read to color vertices for 2nd pass (default: 3000)"
    inputBinding:
      position: 1
      prefix: "-C"
  - id: insert_sz
    type:
      - 'null'
      - int
    doc: "Insert size of the input paired-end short reads (default: 500)"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: k1
    type:
      - 'null'
      - int
    doc: "Length of short k-mers for 1st pass (default: 31)"
    inputBinding:
      position: 1
      prefix: "-k"
  - id: k2
    type:
      - 'null'
      - int
    doc: "Length of long k-mers for 2nd pass (default: 63)"
    inputBinding:
      position: 1
      prefix: "-K"
  - id: no_snp_correction
    type:
      - 'null'
      - boolean
    doc: "Disable SNP detection and correction"
    inputBinding:
      position: 1
      prefix: "-F"
  - id: no_graph_index
    type:
      - 'null'
      - boolean
    doc: "Disable graph index output"
    inputBinding:
      position: 1
      prefix: "-I"
  - id: first_pass_only
    type:
      - 'null'
      - boolean
    doc: "Perform only the 1st correction pass (default: false)"
    inputBinding:
      position: 1
      prefix: "-1"
  - id: second_pass_only
    type:
      - 'null'
      - boolean
    doc: "Perform only the 2nd correction pass (default: false)"
    inputBinding:
      position: 1
      prefix: "-2"
  - id: in_unitig_data
    type:
      - 'null'
      - File
    doc: "Load unitig data file prepared with the index command"
    inputBinding:
      position: 1
      prefix: "-d"
  - id: trim_split
    type:
      - 'null'
      - int
    doc: "Trim and split bases with quality score < t (default: no trim/split); only sub-reads with length >= 63 are output"
    inputBinding:
      position: 1
      prefix: "-t"
  - id: gzip_out
    type:
      - 'null'
      - boolean
    doc: "Output file is compressed with gzip"
    inputBinding:
      position: 1
      prefix: "-G"
  - id: force_io_order
    type:
      - 'null'
      - boolean
    doc: "Force same long read input/output order"
    inputBinding:
      position: 1
      prefix: "-O"
  - id: min_conf_snp_corr
    type:
      - 'null'
      - float
    doc: "Minimum confidence threshold to correct a SNP (default: 0.9)"
    inputBinding:
      position: 1
      prefix: "-m"
  - id: max_len_weak1
    type:
      - 'null'
      - int
    doc: "Do not correct non-solid regions >= w bases during 1st pass (default: 1000)"
    inputBinding:
      position: 1
      prefix: "-w"
  - id: max_len_weak2
    type:
      - 'null'
      - int
    doc: "Do not correct non-solid regions >= w bases during 2nd pass (default: 5000)"
    inputBinding:
      position: 1
      prefix: "-W"
  - id: in_long_raw
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: "-L"
    doc: "Input long read file(s) from 1st pass (experimental)"
    inputBinding:
      position: 1
  - id: in_short_phase
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: "-p"
    doc: "Input short read phasing file(s) (diploid only, experimental)"
    inputBinding:
      position: 1
  - id: in_long_phase
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: "-P"
    doc: "Input long read phasing file(s) (diploid only, experimental)"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Corrected long reads and the graph index files written with the output prefix
    outputBinding:
      glob: $(inputs.out_long)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ratatosk:0.9.0--h077b44d_2
stdout: ratatosk_correct_stdout.txt
