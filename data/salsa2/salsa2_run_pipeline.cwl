cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_pipeline.py
label: salsa2_run_pipeline
doc: "SALSA Iterative Pipeline: scaffold a genome assembly with Hi-C alignments.\n\nTool homepage: https://github.com/marbl/SALSA"
inputs:
  - id: assembly
    type: File
    doc: Path to initial assembly
    inputBinding:
      position: 1
      prefix: --assembly
  - id: length
    type: File
    doc: Length of contigs at start (FASTA index .fai file)
    inputBinding:
      position: 2
      prefix: --length
  - id: bed
    type: File
    doc: Bed file of alignments sorted by read names
    inputBinding:
      position: 3
      prefix: --bed
  - id: output
    type:
      - 'null'
      - string
    default: out
    doc: Output directory to put results
    inputBinding:
      position: 4
      prefix: --output
  - id: cutoff
    type:
      - 'null'
      - int
    doc: Minimum contig length to scaffold, default=1000
    inputBinding:
      position: 5
      prefix: --cutoff
  - id: gfa
    type:
      - 'null'
      - File
    doc: GFA file for assembly
    inputBinding:
      position: 6
      prefix: --gfa
  - id: enzyme
    type:
      - 'null'
      - string
    doc: Restriction Enzyme used for experiment
    inputBinding:
      position: 7
      prefix: --enzyme
  - id: iter
    type:
      - 'null'
      - int
    doc: Number of iterations to run, default = 3
    inputBinding:
      position: 8
      prefix: --iter
  - id: dup
    type:
      - 'null'
      - File
    doc: File containing duplicated contig information
    inputBinding:
      position: 9
      prefix: --dup
  - id: exp
    type:
      - 'null'
      - long
    doc: Expected Genome size of the assembled genome
    inputBinding:
      position: 10
      prefix: --exp
  - id: clean
    type:
      - 'null'
      - string
    doc: Set this option to "yes" if you want to find misassemblies in input assembly
    inputBinding:
      position: 11
      prefix: --clean
  - id: filter
    type:
      - 'null'
      - string
    doc: Filter bed file for contigs present in the assembly
    inputBinding:
      position: 12
      prefix: --filter
  - id: prnt
    type:
      - 'null'
      - string
    doc: Set this option to "yes" if you want to output the scaffolds sequence and agp file for each iteration
    inputBinding:
      position: 13
      prefix: --prnt
outputs:
  - id: scaffolds_fasta
    type: File
    doc: Final scaffold sequences
    outputBinding:
      glob: $(inputs.output)/scaffolds_FINAL.fasta
  - id: scaffolds_agp
    type: File
    doc: Final scaffold layout in AGP format
    outputBinding:
      glob: $(inputs.output)/scaffolds_FINAL.agp
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/salsa2:2.3--py27h16ec135_1
