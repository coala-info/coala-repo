cwlVersion: v1.2
class: CommandLineTool
baseCommand: var-agg
label: var-agg
doc: "Aggregatation of multi-sample VCF files into site VCF files.\n\nTool homepage:
  https://github.com/bihealth/var-agg"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Path to VCF/BCF file(s) to read.
    inputBinding:
      position: 1
  - id: input_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: FAI-indexed reference FASTA file, only index will be accessed.
    inputBinding:
      position: 102
      prefix: --input-fasta
  - id: input_panel
    type:
      - 'null'
      - type: array
        items: File
    doc: "Path to panel file, format is \"SAMPLE<tab>SUB-\nPOPULATION<tab>POPULATION<ignored>\""
    inputBinding:
      position: 102
      prefix: --input-panel
  - id: input_ped
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to input PED file for FOUND_* INFO entries.
    inputBinding:
      position: 102
      prefix: --input-ped
  - id: io_threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use for (de)compression in I/O.
    inputBinding:
      position: 102
      prefix: --io-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease verbosity
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Path to output VCF/BCF file to create. Will also write out a CSI/TBI 
      index.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/var-agg:0.1.1--h2c42bab_0
