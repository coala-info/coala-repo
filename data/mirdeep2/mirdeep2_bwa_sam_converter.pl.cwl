cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa_sam_converter.pl
label: mirdeep2_bwa_sam_converter.pl
doc: "Convert read mappings in SAM format (bwa or bowtie) to the miRDeep2 arf format, optionally collapsing the reads first\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: sam
    type: File
    doc: File with read mappings in sam format (staged in the working directory; the script reads it from there)
    inputBinding:
      position: 101
      prefix: -i
      valueFrom: "$(self.basename)"
  - id: arf_output_file
    type: string
    doc: Name of the mapping file in arf format to write
    inputBinding:
      position: 102
      prefix: -a
  - id: reads_output_file
    type:
      - 'null'
      - string
    doc: Name of the collapsed read output file (only written together with collapse)
    inputBinding:
      position: 103
      prefix: -o
  - id: collapse
    type:
      - 'null'
      - boolean
    doc: Collapse the sam file first and create correct miRDeep2 ids
    inputBinding:
      position: 104
      prefix: -c
  - id: tmp_dir_tag
    type:
      - 'null'
      - string
    doc: Tag for the temporary directory
    inputBinding:
      position: 105
      prefix: -t
  - id: keep_tmp_dir
    type:
      - 'null'
      - boolean
    doc: Do not delete the temporary directory
    inputBinding:
      position: 106
      prefix: -n
outputs:
  - id: arf
    type: File
    doc: Read mappings in arf format
    outputBinding:
      glob: $(inputs.arf_output_file)
  - id: collapsed_reads
    type:
      - 'null'
      - File
    doc: Collapsed reads in fasta format (with collapse and reads_output_file)
    outputBinding:
      glob: $(inputs.reads_output_file)
  - id: tmp_directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Temporary directories kept with keep_tmp_dir
    outputBinding:
      glob: bwasamconv_*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
