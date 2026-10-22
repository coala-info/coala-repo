cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sortgrcd
label: spaln_sortgrcd
doc: "Read binary .grd results written by spaln -O12 and sort them in the order of chromosomal location in each direction.\n\nTool homepage: https://github.com/ogotoh/spaln"
inputs:
  - id: grd_files
    type:
      type: array
      items: File
    doc: "Binary *.grd result files from spaln -O12 (the .erd and .qrd files with the same base name must exist beside them)"
    secondaryFiles:
      - pattern: ^.erd
        required: false
      - pattern: ^.qrd
        required: false
    inputBinding:
      position: 200
  - id: db_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files of the spaln genome database named by genome_db, staged into the working directory"
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: "Minimum % of coverage (0-100)"
    inputBinding:
      position: 10
      prefix: -C
      separate: false
  - id: report_mode
    type:
      - 'null'
      - int
    doc: "Report only the best (N=1) or all (N=2) results per gene locus (1)"
    inputBinding:
      position: 10
      prefix: -E
      separate: false
  - id: filter_level
    type:
      - 'null'
      - int
    doc: "Filter Level (0 -> 3: no -> stringent)"
    inputBinding:
      position: 10
      prefix: -F
      separate: false
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: "Genetic code (0: universal)"
    inputBinding:
      position: 10
      prefix: -G
      separate: false
  - id: min_score
    type:
      - 'null'
      - int
    doc: "Minimum spaln score"
    inputBinding:
      position: 10
      prefix: -H
      separate: false
  - id: min_orf_length
    type:
      - 'null'
      - int
    doc: "Minimum ORF length (300)"
    inputBinding:
      position: 10
      prefix: -J
      separate: false
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: "Maximum total number of missmatches"
    inputBinding:
      position: 10
      prefix: -M
      separate: false
  - id: max_noncanonical
    type:
      - 'null'
      - int
    doc: "Maximum total number of non-canonical boundaries"
    inputBinding:
      position: 10
      prefix: -N
      separate: false
  - id: output_format
    type:
      - 'null'
      - int
    doc: "Output format. 0:Gff3, 3:BED, 4:Native, 5:Intron, 6:cDNA, 7:translate, 8:CDS, 15:unique intron"
    inputBinding:
      position: 10
      prefix: -O
      separate: false
  - id: min_identity
    type:
      - 'null'
      - int
    doc: "Minimum Overall % identity (0-100)"
    inputBinding:
      position: 10
      prefix: -P
      separate: false
  - id: sort_chromosomes
    type:
      - 'null'
      - string
    doc: "Sort chromosomes: a: alphabetical order of identifier (default), b: order of abundance mapped on them, c: order of apparence in the genome db, r: sort records mapped on minus strand in the reverse order of genomic positions"
    inputBinding:
      position: 10
      prefix: -S
      separate: false
  - id: max_unpaired
    type:
      - 'null'
      - int
    doc: "Maximum total number of unpaired bases in gaps"
    inputBinding:
      position: 10
      prefix: -U
      separate: false
  - id: sort_memory
    type:
      - 'null'
      - string
    doc: "Maximum memory size used for core sort (16M)"
    inputBinding:
      position: 10
      prefix: -V
      separate: false
  - id: genome_db
    type:
      - 'null'
      - string
    doc: "Specify the directory/genome_id (inferred from input)"
    inputBinding:
      position: 10
      prefix: -d
      separate: false
  - id: residues_per_line
    type:
      - 'null'
      - int
    doc: "Number of residues per line for -O6 or -O7 (60)"
    inputBinding:
      position: 10
      prefix: -l
      separate: false
  - id: max_boundary_mismatches
    type:
      - 'null'
      - int
    doc: "Maximum allowed missmatches at both exon boundaries"
    inputBinding:
      position: 10
      prefix: -m
      separate: false
  - id: noncanonical_boundary
    type:
      - 'null'
      - int
    doc: "Allow non-canonical boundary? [0: no; 1: AT-AN; 2: 1bp mismatch; 3: any]"
    inputBinding:
      position: 10
      prefix: -n
      separate: false
  - id: max_boundary_unpaired
    type:
      - 'null'
      - int
    doc: "Maximum allowed unpaired bases in gaps at both exon boundaries"
    inputBinding:
      position: 10
      prefix: -u
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Sorted results (stdout)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.db_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
stdout: spaln_sortgrcd.out
