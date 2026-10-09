cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hymet
  - truth
  - build-zymo
label: hymet_truth_build-zymo
doc: "Build Zymo mock community truth tables: a per-contig truth table and a CAMI
  profile from contigs and their PAF alignment against curated references.\n\nTool
  homepage: https://github.com/ieeta-pt/HYMET"
inputs:
  - id: contigs
    type: File
    doc: Input contigs FASTA
    inputBinding:
      position: 1
      prefix: --contigs
  - id: paf
    type: File
    doc: PAF alignment against curated references
    inputBinding:
      position: 1
      prefix: --paf
  - id: seqmap
    type:
      - 'null'
      - File
    doc: SeqID to TaxID map (default case/truth/zymo_refs/seqid2taxid.tsv)
    inputBinding:
      position: 1
      prefix: --seqmap
  - id: out_contigs
    type: string
    doc: Output contig truth TSV
    inputBinding:
      position: 1
      prefix: --out-contigs
  - id: out_profile
    type: string
    doc: Output CAMI profile TSV
    inputBinding:
      position: 1
      prefix: --out-profile
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Show command without executing it
    inputBinding:
      position: 1
      prefix: --dry-run
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: contig_truth
    type: File
    doc: Per-contig truth table
    outputBinding:
      glob: $(inputs.out_contigs)
  - id: profile
    type: File
    doc: CAMI-style truth profile
    outputBinding:
      glob: $(inputs.out_profile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
stdout: hymet_truth_build-zymo.out
