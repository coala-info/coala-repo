cwlVersion: v1.2
class: CommandLineTool
baseCommand: generate_ska_alignment.py
label: gubbins_generate_ska_alignment
doc: "Generate a ska2 alignment from a list of assemblies\n\nTool homepage: https://github.com/nickjcroucher/gubbins"
inputs:
  - id: reference
    type: File
    doc: "Reference sequence (fasta file) to use for alignment"
    inputBinding:
      position: 101
      prefix: --reference
  - id: input_list
    type:
      - 'null'
      - File
    doc: "List of sequence data; one row per isolate, with first column being the isolate name"
    inputBinding:
      position: 102
      prefix: --input
  - id: out
    type: string
    doc: "Name of output alignment"
    inputBinding:
      position: 103
      prefix: --out
  - id: k
    type:
      - 'null'
      - int
    doc: "Split kmer size"
    inputBinding:
      position: 104
      prefix: --k
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 105
      prefix: --threads
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: "Do not remove intermediate files"
    inputBinding:
      position: 106
      prefix: --no-cleanup
  - id: assembly_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Assembly files named in the input list; they are staged in the working directory so the names in the list resolve"
outputs:
  - id: alignment
    type: File
    doc: "ska2 alignment"
    outputBinding:
      glob: $(inputs.out)
  - id: alignment_report
    type: File
    doc: "CSV report of the alignment check"
    outputBinding:
      glob: $(inputs.out).csv
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.assembly_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
