cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-synthesis-reference-transcripts
label: rsem_rsem-synthesis-reference-transcripts
doc: "Build the RSEM transcript reference files (.transcripts.fa, .ti and .grp)
  from FASTA files that already hold transcript sequences. 
  rsem-prepare-reference runs it when no GTF/GFF3 file is given.\n\nTool 
  homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: reference_name
    type: string
    doc: Name (prefix) of the reference files to write.
    inputBinding:
      position: 1
  - id: quiet
    type: int
    doc: 1 to run quietly, 0 to print progress.
    inputBinding:
      position: 2
  - id: has_mapping_file
    type: int
    doc: '0 no mapping file; 1 a transcript to gene mapping file is given; 2 an
      allele-specific mapping file is given.'
    inputBinding:
      position: 3
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: The mapping file (needed when has_mapping_file is 1 or 2).
    inputBinding:
      position: 4
  - id: reference_files
    type:
      type: array
      items: File
    doc: One or more FASTA files with the transcript sequences 
      (reference_file_1 [reference_file_2 ...]).
    inputBinding:
      position: 5
outputs:
  - id: reference_output_files
    type:
      type: array
      items: File
    outputBinding:
      glob: $(inputs.reference_name).*
    doc: The reference files written with the reference_name prefix.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
