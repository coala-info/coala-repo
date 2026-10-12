cwlVersion: v1.2
class: CommandLineTool
baseCommand: panaroo-generate-gffs
label: panaroo_generate_gffs
doc: "Generate GFF annotation files for each isolate from the Panaroo pangenome graph. The Panaroo output directory is updated in place.

Tool homepage: https://gtonkinhill.github.io/panaroo"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.out_dir)
        writable: true
inputs:
  - id: out_dir
    type: Directory
    doc: "Location of the Panaroo output directory (updated in place)."
    inputBinding:
      prefix: --out_dir
  - id: input_files
    type:
      type: array
      items: File
    doc: "Input GFF3 files used to run Panaroo, or a file listing each gff file line by line."
    inputBinding:
      prefix: --input
  - id: format
    type:
      - 'null'
      - string
    doc: "Output format for the GFF files: 'prokka' (with FASTA, default) or strict 'gff3'."
    inputBinding:
      prefix: --f
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default 1)."
    inputBinding:
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print additional output."
    inputBinding:
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "The Panaroo output directory with the new GFF files."
    outputBinding:
      glob: $(inputs.out_dir.basename)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
stdout: panaroo_generate_gffs.out
