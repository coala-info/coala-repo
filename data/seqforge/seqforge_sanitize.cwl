cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqforge
  - sanitize
label: seqforge_sanitize
doc: "Remove special characters from input file names (content unchanged; needed for
  BLAST+).\n\nTool homepage: https://github.com/ERBringHorvath/SeqForge"
inputs:
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Preview changes without renaming any files
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: extension
    type:
      - 'null'
      - type: array
        items: string
    doc: File extensions to process. Not needed if submitting a single file. For
      FASTA files, run '-e fasta' to allow for all standard FASTA extensions
    inputBinding:
      position: 101
      prefix: --extension
  - id: in_place
    type:
      - 'null'
      - boolean
    doc: Rename files in place (recommended)
    inputBinding:
      position: 101
      prefix: --in-place
  - id: input
    type: File
    doc: File(s) to sanitize. Can be a single file or a directory of files
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: sanitize_outdir
    type:
      - 'null'
      - Directory
    doc: Leave original filenames unchanged, but copy them to a new directory 
      with santitized filenames
    outputBinding:
      glob: $(inputs.sanitize_outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
