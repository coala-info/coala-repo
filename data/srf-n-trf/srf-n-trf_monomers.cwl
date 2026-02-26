cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - srf-n-trf
  - monomers
label: srf-n-trf_monomers
doc: "Parses TRF output to identify tandem repeats within SRF-elongated motifs.\n\n\
  Tool homepage: https://github.com/koisland/srf-n-trf"
inputs:
  - id: cov
    type:
      - 'null'
      - float
    doc: Percent coverage of srf motif required for a given trf monomer.
    default: 0.8
    inputBinding:
      position: 101
      prefix: --cov
  - id: diff
    type:
      - 'null'
      - float
    doc: 'Percent difference in monomer period length allowed. ex. `0.02` results
      in valid periods for `170`: `167 < 170 < 173`'
    default: 0.02
    inputBinding:
      position: 101
      prefix: --diff
  - id: max_seq_div
    type:
      - 'null'
      - float
    doc: Maximum gap-compressed sequence divergence between aligned motif and 
      region
    default: 0.2
    inputBinding:
      position: 101
      prefix: --max-seq-div
  - id: monomers
    type: File
    doc: '`trf` monomers TSV file on `srf` monomers with columns: `chrom (query),
      motif (target), st, end, period, copyNum, fracMatch, fracGap, score, entropy,
      pattern`'
    inputBinding:
      position: 101
      prefix: --monomers
  - id: paf
    type: File
    doc: PAF file of alignment of assembly as query and `srf` enlonged motifs as
      target. Requires `cg` extended cigar string. With `minimap2`, use `--eqx`
    inputBinding:
      position: 101
      prefix: --paf
  - id: sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: Monomer size in base pairs to search for
    default:
      - 170
      - 340
      - 510
      - 680
      - 850
      - 1020
      - 42
    inputBinding:
      position: 101
      prefix: --sizes
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: "Output BED9 file with columns: `chrom, st, end, comma-delimited_monomers,
      0, strand, st, end, '0,0,0'`"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srf-n-trf:0.1.2--h4349ce8_0
