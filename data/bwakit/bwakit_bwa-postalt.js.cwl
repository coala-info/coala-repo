cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa-postalt.js
label: bwakit_bwa-postalt.js
doc: "Post-process BWA-MEM alignments to a reference with ALT contigs: extract the XA tag,
  lift ALT hits to the primary assembly, group them and re-estimate mapQ.\n\nTool homepage: https://github.com/lh3/bwa/tree/master/bwakit"
inputs:
  - id: hla_prefix
    type:
      - 'null'
      - string
    doc: prefix of output files containting sequences matching HLA genes
    inputBinding:
      position: 1
      prefix: -p
  - id: min_pa_ratio
    type:
      - 'null'
      - float
    doc: reduce mapQ to 0 if not overlapping lifted best and pa<FLOAT
    inputBinding:
      position: 1
      prefix: -r
  - id: alt_sam
    type: File
    doc: ALT-to-REF alignment of the ALT contigs (the <idxbase>.alt file)
    inputBinding:
      position: 2
  - id: aln_sam
    type: File
    doc: BWA-MEM alignment in SAM format (the tool reads stdin when it is not given)
    inputBinding:
      position: 3
  - id: output_sam_name
    type: string
    doc: name of the post-processed SAM file written from stdout
    default: postalt.sam
outputs:
  - id: output_sam
    type: stdout
    doc: Post-processed SAM
  - id: hla_fastq
    type: File[]
    doc: reads matching each HLA gene ({-p}.HLA-*.fq)
    outputBinding:
      glob: "${ return inputs.hla_prefix ? inputs.hla_prefix + '.HLA-*.fq' : []; }"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwakit:0.7.18.dev1--hdfd78af_0
stdout: $(inputs.output_sam_name)
