cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prepare_signature.pl
label: mirdeep2_prepare_signature.pl
doc: "Prepare the signature file for miRDeep: map reads to potential precursors with bowtie and sort the mappings by precursor\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: file_reads
    type: File
    doc: Deep sequencing reads in fasta format
    inputBinding:
      position: 1
  - id: file_precursors
    type: File
    doc: Potential precursor sequences in fasta format
    inputBinding:
      position: 2
  - id: read_align_edit_distance
    type: int
    doc: Maximum edit distance (bowtie -v) for aligning reads to the precursors
    inputBinding:
      position: 3
  - id: mature_ref
    type:
      - 'null'
      - File
    doc: Fasta file with known mature miRNAs of the species; added to the signature to estimate sensitivity (does not change the scoring)
    inputBinding:
      position: 101
      prefix: -a
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Output progress to standard error
    inputBinding:
      position: 101
      prefix: -b
  - id: output_file
    type: string
    default: signature.arf
    doc: Name of the signature output file (required by the script)
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: signature
    type: File
    doc: Signature file in arf format
    outputBinding:
      glob: $(inputs.output_file)
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory with the bowtie index and intermediate mappings
    outputBinding:
      glob: dir_prepare_signature*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
