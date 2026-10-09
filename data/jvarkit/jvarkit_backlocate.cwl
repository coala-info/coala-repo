cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - backlocate
label: jvarkit_backlocate
doc: "Map a mutation on a protein back to the genomic coordinates.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: mutation_files
    type:
      type: array
      items: File
    doc: Text files with one mutation per line (gene name and protein mutation)
    inputBinding:
      position: 100
  - id: gtf
    type: File
    doc: "A GTF (General Transfer Format) file. See https://www.ensembl.org/info/website/upload/gff.html . Please note that CDS are only detected if a start and stop codons are defined."
    inputBinding:
      position: 1
      prefix: --gtf
  - id: out
    type:
      - 'null'
      - string
    doc: "Output file. Optional. Default: stdout"
    inputBinding:
      position: 2
      prefix: --out
  - id: print_seq
    type:
      - 'null'
      - boolean
    doc: "print mRNA & protein sequences"
    inputBinding:
      position: 3
      prefix: --printSeq
  - id: reference
    type: File
    doc: Indexed fasta Reference file. This file must be indexed with samtools faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    secondaryFiles:
      - .fai
      - "^.dict"
    inputBinding:
      position: 4
      prefix: --reference
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, when the output option is given
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output (the result, when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_backlocate.out
