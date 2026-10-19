cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-alignment
  - compare-error-type
label: rdp-alignment_compare-error-type
doc: "Detect insertion, deletion and substitution errors in query sequences by global alignment to reference sequences (CompareErrorType).

Tool homepage: https://github.com/rdpstaff/Alignment"
inputs:
  - id: ref_nucl
    type: File
    doc: "Reference nucleotide sequences"
    inputBinding:
      position: 2
  - id: query_nucl
    type: File
    doc: "Query nucleotide sequences (fasta, or fastq with its qualities)"
    inputBinding:
      position: 3
  - id: query_nucl_qual
    type:
      - 'null'
      - File
    doc: "Query quality file, used with a fasta query"
    inputBinding:
      position: 4
  - id: stem
    type:
      - 'null'
      - string
    doc: "Output stem (default is the query fasta file name)"
    inputBinding:
      position: 1
      prefix: --stem
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_files
    type:
      type: array
      items: File
    doc: "Alignment, mismatch, indel and quality files written with the output stem"
    outputBinding:
      glob: |
        ${ var s = inputs.stem ? inputs.stem : inputs.query_nucl.basename; return s + "_*"; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
stdout: rdp-alignment_compare-error-type.out
