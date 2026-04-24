cwlVersion: v1.2
class: CommandLineTool
baseCommand: inspector.py
label: inspector_inspector.py
doc: "de novo assembly evaluator\n\nTool homepage: https://github.com/ChongLab/Inspector"
inputs:
  - id: contig_file
    type: File
    doc: assembly contigs in FASTA format
    inputBinding:
      position: 101
      prefix: --contig
  - id: data_type
    type:
      - 'null'
      - string
    doc: Input read type. (clr, hifi, nanopore)
    inputBinding:
      position: 101
      prefix: --datatype
  - id: max_assembly_error_size
    type:
      - 'null'
      - int
    doc: maximal size for assembly errors.
    inputBinding:
      position: 101
      prefix: --max_assembly_error_size
  - id: min_assembly_error_size
    type:
      - 'null'
      - int
    doc: minimal size for assembly errors.
    inputBinding:
      position: 101
      prefix: --min_assembly_error_size
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: minimal length for a contig to be evaluated.
    inputBinding:
      position: 101
      prefix: --min_contig_length
  - id: min_contig_length_assemblyerror
    type:
      - 'null'
      - int
    doc: minimal contig length for assembly error detection.
    inputBinding:
      position: 101
      prefix: --min_contig_length_assemblyerror
  - id: min_depth
    type:
      - 'null'
      - string
    doc: minimal read-alignment depth for a contig base to be considered in QV 
      calculation.
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: noplot
    type:
      - 'null'
      - boolean
    doc: do not make plots
    inputBinding:
      position: 101
      prefix: --noplot
  - id: raw_reads
    type:
      type: array
      items: File
    doc: sequencing reads in FASTA/FASTQ format
    inputBinding:
      position: 101
      prefix: --read
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: OPTIONAL reference genome in FASTA format
    inputBinding:
      position: 101
      prefix: --ref
  - id: skip_base_error
    type:
      - 'null'
      - boolean
    doc: skip the step of identifying small-scale errors.
    inputBinding:
      position: 101
      prefix: --skip_base_error
  - id: skip_base_error_detect
    type:
      - 'null'
      - boolean
    doc: skip the step of detecting small-scale errors from pileup.
    inputBinding:
      position: 101
      prefix: --skip_base_error_detect
  - id: skip_read_mapping
    type:
      - 'null'
      - boolean
    doc: skip the step of mapping reads to contig.
    inputBinding:
      position: 101
      prefix: --skip_read_mapping
  - id: skip_structural_error
    type:
      - 'null'
      - boolean
    doc: skip the step of identifying large structural errors.
    inputBinding:
      position: 101
      prefix: --skip_structural_error
  - id: skip_structural_error_detect
    type:
      - 'null'
      - boolean
    doc: skip the step of detecting large structural errors.
    inputBinding:
      position: 101
      prefix: --skip_structural_error_detect
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: output_dict
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dict)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/inspector:1.3.1--hdfd78af_1
