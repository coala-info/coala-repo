cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unitigger
label: ra_unitigger
doc: "Builds a string graph from the overlaps in a depot, simplifies it and writes\
  \ unitigs and contigs (FASTA and AFG).\n\nTool homepage: https://github.com/mariokostelac/ra"
inputs:
  - id: depot
    type: Directory
    doc: Depot directory (created by depot import_reads); it is updated in place
    inputBinding:
      position: 102
      prefix: --depot
      valueFrom: $(self.basename)
  - id: spec_file
    type:
      - 'null'
      - File
    doc: spec file
    inputBinding:
      position: 102
      prefix: --spec_file
  - id: working_directory
    type:
      - 'null'
      - string
    doc: working directory (default .); the output files are written there
    inputBinding:
      position: 102
      prefix: --working_directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: unitigs_fasta
    type: File
    doc: Unitig sequences
    outputBinding:
      glob: unitigs_fast.fasta
  - id: unitigs_afg
    type: File
    doc: Unitigs in AFG format
    outputBinding:
      glob: unitigs.afg
  - id: contigs_fasta
    type: File
    doc: Contig sequences
    outputBinding:
      glob: contigs_fast.fasta
  - id: contigs_afg
    type: File
    doc: Contigs in AFG format
    outputBinding:
      glob: contigs.afg
  - id: final_overlaps
    type: File
    doc: Remaining overlaps in MHAP format
    outputBinding:
      glob: final.mhap
  - id: run_args
    type: File
    doc: Run arguments and settings
    outputBinding:
      glob: run_args.txt
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.depot)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra:0.9--h503566f_8
stdout: ra_unitigger.out
