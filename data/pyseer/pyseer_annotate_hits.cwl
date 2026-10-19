cwlVersion: v1.2
class: CommandLineTool
baseCommand: annotate_hits_pyseer
label: pyseer_annotate_hits
doc: "Iteratively annotate significant kmers from SEER.\n\nTool homepage: https://github.com/mgalardini/pyseer"
inputs:
  - id: kmers
    type: File
    doc: Kmers file, filtered output from SEER.
    inputBinding:
      position: 1
  - id: references
    type: File
    doc: File of reference annotations. First column fasta sequence, second column gff annotation, third column ref or draft.
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: output_path
    type: string
    doc: Output file.
    inputBinding:
      position: 3
  - id: reference_files
    type:
      type: array
      items: File
    doc: The fasta and gff files named in the references file (staged next to it so the names resolve).
  - id: feature_type
    type:
      - 'null'
      - string
    doc: Which feature types to consider (default CDSs only).
    inputBinding:
      position: 4
      prefix: --feature-type
  - id: bwa
    type:
      - 'null'
      - string
    doc: Location of bwa executable.
    inputBinding:
      position: 4
      prefix: --bwa
  - id: tmp_prefix
    type:
      - 'null'
      - string
    doc: Directory to store temporary files.
    inputBinding:
      position: 4
      prefix: --tmp-prefix
outputs:
  - id: annotated_hits
    type: File
    doc: Annotated kmers table
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${ return inputs.reference_files.concat([inputs.references]); }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
