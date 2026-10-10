cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bowtie-align-reads.py
label: mir-prefer_bowtie-align-reads.py
doc: "Align collapsed small RNA read FASTA files (output of process-reads-fasta.py) to a genome with bowtie and write SAM files for miR-PREFeR\n\nTool homepage: https://github.com/hangelwen/miR-PREFeR"
arguments:
  - position: 102
    valueFrom: $(inputs.read_fasta_files.map(function(f) { return f.basename; }))
inputs:
  - id: allowed_mismatch
    type:
      - 'null'
      - int
    doc: "-v option in bowtie. Number of mismatches allowed. Default is 0."
    inputBinding:
      position: 101
      prefix: -v
  - id: filter_unmapped
    type:
      - 'null'
      - boolean
    doc: Filter out unmapped alignments in the output (uses samtools)
    inputBinding:
      position: 101
      prefix: -f
  - id: index_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Bowtie index files (.ebwt) to use with the index prefix; they are staged in the working directory
  - id: index_prefix
    type:
      - 'null'
      - string
    doc: Use the supplied bowtie index instead of indexing the genome in the script. Give the index name without the .1.ebwt suffix, as it appears in the working directory
    inputBinding:
      position: 101
      prefix: -i
  - id: multi_alignment
    type:
      - 'null'
      - int
    doc: "-k option in bowtie. Report up to this many valid alignments. Default is 20."
    inputBinding:
      position: 101
      prefix: -k
  - id: processors
    type:
      - 'null'
      - int
    doc: Use multiple threads to do alignment
    inputBinding:
      position: 101
      prefix: -p
  - id: reference
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -r
    doc: Reference genome in FASTA format. Use several files for multiple reference files. Not used when an index is given.
    inputBinding:
      position: 101
  - id: temp_folder
    type:
      - 'null'
      - string
    doc: Temporary folder to hold the bowtie index files. If not supplied, the current directory is used. Only used with -r.
    inputBinding:
      position: 101
      prefix: -t
  - id: read_fasta_files
    type:
      type: array
      items: File
    doc: Collapsed read FASTA files in the format written by process-reads-fasta.py (ids like samplename_rA_xN)
outputs:
  - id: sam_files
    type:
      type: array
      items: File
    doc: SAM alignment files, named like the inputs with the suffix .sam
    outputBinding:
      glob: '*.sam'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.read_fasta_files)
      - '$(inputs.index_files ? inputs.index_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mir-prefer:0.24--py27_0
