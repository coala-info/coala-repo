cwlVersion: v1.2
class: CommandLineTool
baseCommand: create_hybrid_samplesheet.sh
label: milonga_create_hybrid_samplesheet.sh
doc: "Create a sample sheet (samples.tsv) for MiLongA from a MinION run folder: concatenates the FASTQ\
  \ files of each barcode directory into rundir/raw.\n\nTool homepage: https://gitlab.com/bfr_bioinformatics/milonga"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force also when samples.tsv already exists.
    inputBinding:
      position: 101
      prefix: --force
  - id: rundir
    type: Directory
    doc: Run folder holding fastq_pass or workspace/pass with the barcode directories; it is staged writable
      because the script writes samples.tsv and raw/ into it.
    inputBinding:
      position: 1
  - id: subdir
    type:
      - 'null'
      - string
    doc: Subdirectory of the rundir where the pass reads are located, for example guppy6_sup.
    inputBinding:
      position: 2
outputs:
  - id: run_dir
    type: Directory
    doc: Run folder with samples.tsv and the concatenated reads in raw/.
    outputBinding:
      glob: $(inputs.rundir.basename)
  - id: log
    type: stdout
    doc: Standard output.
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.rundir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/milonga:1.0.3--hdfd78af_0
stdout: milonga_create_hybrid_samplesheet.sh.out
