cwlVersion: v1.2
class: CommandLineTool
baseCommand: MappingQC
label: ngs-bits_MappingQC
doc: "Calculates QC metrics based on mapped NGS reads.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: build
    type:
      - 'null'
      - string
    doc: Genome build used to generate the input (needed for WGS and 
      contamination only).
    inputBinding:
      position: 101
      prefix: -build
  - id: cfdna
    type:
      - 'null'
      - boolean
    doc: Add additional QC parameters for cfDNA samples. Only supported mit 
      '-roi'.
    inputBinding:
      position: 101
      prefix: -cfdna
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enables verbose debug outout.
    inputBinding:
      position: 101
      prefix: -debug
  - id: input_file
    type: File
    doc: Input BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: -in
  - id: long_read
    type:
      - 'null'
      - boolean
    doc: Support long reads (> 1kb).
    inputBinding:
      position: 101
      prefix: -long_read
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minmum mapping quality to consider a read mapped.
    inputBinding:
      position: 101
      prefix: -min_mapq
  - id: no_cont
    type:
      - 'null'
      - boolean
    doc: Disables sample contamination calculation, e.g. for tumor or non-human 
      samples.
    inputBinding:
      position: 101
      prefix: -no_cont
  - id: read_qc
    type:
      - 'null'
      - File
    doc: If set, a read QC file in qcML format is created (just like 
      ReadQC/SeqPurge).
    inputBinding:
      position: 101
      prefix: -read_qc
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file. If unset 'reference_genome' from the 
      'settings.ini' file is used.
    inputBinding:
      position: 101
      prefix: -ref
  - id: rna
    type:
      - 'null'
      - boolean
    doc: RNA mode without target region. Genome information is taken from the 
      BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: -rna
  - id: roi
    type:
      - 'null'
      - File
    doc: Input target region BED file (for panel, WES, etc.).
    inputBinding:
      position: 101
      prefix: -roi
  - id: settings
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: somatic_custom_bed
    type:
      - 'null'
      - File
    doc: Somatic custom region of interest (subpanel of actual roi). If 
      specified, additional depth metrics will be calculated.
    inputBinding:
      position: 101
      prefix: -somatic_custom_bed
  - id: tdx
    type:
      - 'null'
      - boolean
    doc: Writes a Tool Definition Xml file. The file name is the application 
      name with the suffix '.tdx'.
    inputBinding:
      position: 101
      prefix: --tdx
  - id: txt
    type:
      - 'null'
      - boolean
    doc: Writes TXT format instead of qcML.
    inputBinding:
      position: 101
      prefix: -txt
  - id: wgs
    type:
      - 'null'
      - boolean
    doc: WGS mode without target region. Genome information is taken from the 
      BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: -wgs
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output qcML file. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
