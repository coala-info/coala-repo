cwlVersion: v1.2
class: CommandLineTool
baseCommand: [chmod, '600', .hg.conf]
arguments:
  - position: 0
    shellQuote: false
    valueFrom: '&&'
  - position: 1
    valueFrom: bedCoverage
label: ucsc-bedcoverage
doc: "Analyse coverage by bed files - chromosome by chromosome and genome-wide. The\
  \ chromosome sizes are read from a UCSC MySQL database (the public UCSC server\
  \ is set in a .hg.conf file in the working directory), so the tool needs network\
  \ access. The bed file must be sorted by chromosome.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
stdout: $(inputs.output_name)
inputs:
  - id: database
    type: string
    doc: UCSC database (genome assembly) name, e.g. hg18, hg19, mm10
    inputBinding:
      position: 11
  - id: bed_file
    type: File
    doc: Input BED file, sorted by chromosome
    inputBinding:
      position: 12
  - id: restrict
    type:
      - 'null'
      - File
    doc: Restrict to parts in this BED file
    inputBinding:
      position: 2
      prefix: -restrict=
      separate: false
  - id: output_name
    type: ['null', string]
    default: bedCoverage.txt
    doc: Name of the output file (standard output of the tool)
outputs:
  - id: output_coverage
    type: File
    doc: Coverage report, chromosome by chromosome and genome-wide
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .hg.conf
        entry: |
          db.host=genome-mysql.soe.ucsc.edu
          db.user=genome
          db.password=
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedcoverage:482--h0b57e2e_0
