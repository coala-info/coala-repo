cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfAnnotateMaxEntScan
label: ngs-bits_VcfAnnotateMaxEntScan
doc: "Annotates a VCF file with MaxEntScan scores. This is essentially a multithreaded C++ reimplementation of the MaxEntScan plugin for VEP (https://github.com/Ensembl/VEP_plugins/blob/release/109/MaxEntScan.pm). MaxEntScan was first introduced by Shamsani et al. (https://doi.org/10.1093/bioinformatics/bty960). Benchmarking of this tool showed that it is up to 10x faster than the VEP plugin when using one thread. The standard MES scores are only computed for variants which are close to known splice sites (which are computed from the provided GFF file). De-novo splice sites can be found by using the MES scores from the sliding window approach (SWA). Intergenic variants never get a MES scores.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: "If set, all transcripts are used for annotation (the default is to skip transcripts not labeled with the 'GENCODE basic' tag)."
    inputBinding:
      position: 1
      prefix: -all
  - id: block_size
    type:
      - 'null'
      - int
    doc: "Number of VCF lines processed in one chunk."
    inputBinding:
      position: 2
      prefix: -block_size
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Enables debug output (use only with one thread)."
    inputBinding:
      position: 3
      prefix: -debug
  - id: decimals
    type:
      - 'null'
      - int
    doc: "Number of decimals of output scores."
    inputBinding:
      position: 4
      prefix: -decimals
  - id: gff
    type: File
    doc: "Ensembl-style GFF file with transcripts, e.g. from https://ftp.ensembl.org/pub/release-115/gff3/homo_sapiens/Homo_sapiens.GRCh38.115.gff3.gz."
    inputBinding:
      position: 5
      prefix: -gff
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input VCF file. If unset, reads from STDIN."
    inputBinding:
      position: 6
      prefix: -in
  - id: min_score
    type:
      - 'null'
      - float
    doc: "Minimum score to report."
    inputBinding:
      position: 7
      prefix: -min_score
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output VCF file containing the MaxEntScan scores in the INFO column. If unset, writes to STDOUT."
    inputBinding:
      position: 8
      prefix: -out
  - id: prefetch
    type:
      - 'null'
      - int
    doc: "Maximum number of chunks that may be pre-fetched into memory."
    inputBinding:
      position: 9
      prefix: -prefetch
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 10
      prefix: -ref
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 11
      prefix: --settings
  - id: swa
    type:
      - 'null'
      - boolean
    doc: "Enables sliding window approach, i.e. predictions of de-novo acceptor/donor sites."
    inputBinding:
      position: 12
      prefix: -swa
  - id: tag
    type:
      - 'null'
      - string
    doc: "Info entry name used for native splice site scores."
    inputBinding:
      position: 13
      prefix: -tag
  - id: tag_swa
    type:
      - 'null'
      - string
    doc: "Info entry name used for SWA scores."
    inputBinding:
      position: 14
      prefix: -tag_swa
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads used to process VCF line chunk."
    inputBinding:
      position: 15
      prefix: -threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output VCF file containing the MaxEntScan scores in the INFO column. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
