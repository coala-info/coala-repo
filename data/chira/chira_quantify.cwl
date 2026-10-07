cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chira_quantify.py
label: chira_quantify
doc: "Chimeric Read Annotator: quantify mapped loci\n\nTool homepage: https://github.com/pavanvidem/chira/"
inputs:
  - id: bed
    type: File
    doc: "Input BED file (segments.bed from chira_merge.py)"
    inputBinding:
      position: 1
      prefix: --bed
  - id: merged_bed
    type: File
    doc: "Input merged BED file (merged.bed from chira_merge.py)"
    inputBinding:
      position: 1
      prefix: --merged_bed
  - id: outdir
    type: string
    doc: "Output directory for the quantified loci (loci.counts)"
    default: "chira_quantify_out"
    inputBinding:
      position: 1
      prefix: --outdir
  - id: crl_share
    type:
      - 'null'
      - float
    doc: "Minimum fraction of reads of a locus that must overlap with all CRL loci in order to merge it into that CRL. (default: 0.7)"
    inputBinding:
      position: 1
      prefix: --crl_share
  - id: min_locus_size
    type:
      - 'null'
      - int
    doc: "Minimum number of reads a locus should have in order to participate in CRL creation. (default: 10)"
    inputBinding:
      position: 1
      prefix: --min_locus_size
  - id: em_threshold
    type:
      - 'null'
      - float
    doc: "The maximum difference of transcripts expression between two consecutive iterations of EM algorithm to converge. (default: 1e-05)"
    inputBinding:
      position: 1
      prefix: --em_threshold
  - id: build_crls_too
    type:
      - 'null'
      - boolean
    doc: "Create CRLs too"
    inputBinding:
      position: 1
      prefix: --build_crls_too
outputs:
  - id: loci_counts
    type: File
    doc: "Quantified loci (loci.counts)"
    outputBinding:
      glob: $(inputs.outdir)/loci.counts
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "${ return {class: 'Directory', basename: inputs.outdir, listing: [], writable: true}; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
