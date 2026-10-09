cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mbgc
  - a
label: mbgc_a
doc: "Append FASTA file(s) to an MBGC archive (writes a new archive)\n\nTool homepage: https://github.com/kowallus/mbgc"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta_files || [])
inputs:
  - id: fasta_list
    type:
      - 'null'
      - File
    doc: "name of text file with a list of FASTA files (raw or gz), given in separate lines"
    inputBinding:
      position: 1
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The FASTA files named in fasta_list, staged in the working directory so the names in the list resolve.
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: "name of a single FASTA file (raw or gz); used instead of fasta_list"
    inputBinding:
      position: 102
      prefix: -i
  - id: archive_file
    type: File
    doc: "mbgc archive filename to be appended"
    inputBinding:
      position: 2
  - id: output_archive_path
    type: string
    doc: "new archive to create; the input archive remains unchanged"
    inputBinding:
      position: 3
  - id: threads
    type:
      - 'null'
      - int
    doc: "set limit of used threads"
    inputBinding:
      position: 102
      prefix: -t
  - id: ignore_fasta_paths
    type:
      - 'null'
      - boolean
    doc: "ignore FASTA file paths (use only filenames)"
    inputBinding:
      position: 102
      prefix: -I
  - id: redirect_stderr
    type:
      - 'null'
      - boolean
    doc: "redirect app output to stderr"
    inputBinding:
      position: 102
      prefix: '-2'
outputs:
  - id: archive
    type: File
    doc: 'The new archive'
    outputBinding:
      glob: $(inputs.output_archive_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mbgc:2.1.1--hd63eeec_0
