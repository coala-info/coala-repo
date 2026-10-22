cwlVersion: v1.2
class: CommandLineTool
baseCommand: tgsgapcloser
label: tgsgapcloser
doc: "Fill gaps in scaffolds with long reads (gap-filling step of TGS-GapCloser).\n\nTool homepage: https://github.com/BGI-Qingdao/TGS-GapCloser"
inputs:
  - id: prefix
    type: string
    doc: the file prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: contig
    type: File
    doc: xxx.contig from tgsseqsplit (staged as prefix.contig)
  - id: orignial_scaff_infos
    type: File
    doc: xxx.orignial_scaff_infos from tgsseqsplit (staged as prefix.orignial_scaff_infos)
  - id: contig2ont_paf
    type: File
    doc: the paf file that map contig into ont reads.
    inputBinding:
      position: 101
      prefix: --contig2ont_paf
  - id: ont_reads_q
    type:
      - 'null'
      - File
    doc: the ont reads in fastq format.
    inputBinding:
      position: 101
      prefix: --ont_reads_q
  - id: ont_reads_a
    type:
      - 'null'
      - File
    doc: the ont reads in fasta format.
    inputBinding:
      position: 101
      prefix: --ont_reads_a
  - id: max_hang
    type:
      - 'null'
      - int
    doc: max hang for ont
    inputBinding:
      position: 101
      prefix: --max_hang
  - id: min_match
    type:
      - 'null'
      - int
    doc: min match for ont
    inputBinding:
      position: 101
      prefix: --min_match
  - id: min_idy
    type:
      - 'null'
      - float
    doc: min idy for ont
    inputBinding:
      position: 101
      prefix: --min_idy
  - id: factor_a
    type:
      - 'null'
      - float
    doc: factor_a for ont aligned factor
    inputBinding:
      position: 101
      prefix: --factor_a
  - id: factor_b
    type:
      - 'null'
      - float
    doc: factor_b for ont idy factor
    inputBinding:
      position: 101
      prefix: --factor_b
  - id: max_ignored_overlap
    type:
      - 'null'
      - int
    doc: max overlap size that can be ignored by overlap check
    inputBinding:
      position: 101
      prefix: --max_ignored_overlap
  - id: min_contigtail_cut
    type:
      - 'null'
      - int
    doc: min sequence length for contig aligned check
    inputBinding:
      position: 101
      prefix: --min_contigtail_cut
  - id: min_idy_oc
    type:
      - 'null'
      - float
    doc: min idy for overlap check
    inputBinding:
      position: 101
      prefix: --min_idy_oc
  - id: min_af_oc
    type:
      - 'null'
      - float
    doc: min aligned factor for overlap check
    inputBinding:
      position: 101
      prefix: --min_af_oc
  - id: use_gapsize_check
    type:
      - 'null'
      - boolean
    doc: use original gap size to filter candidate fragments
    inputBinding:
      position: 101
      prefix: --use_gapsize_check
  - id: min_gapsize_ignore
    type:
      - 'null'
      - int
    doc: min gap size that can ignore gap size check
    inputBinding:
      position: 101
      prefix: --min_gapsize_ignore
  - id: min_gap_diff
    type:
      - 'null'
      - int
    doc: reject fragment if (new_gapsize-old_gapsize)*100/old_gapsize < min_gap_diff
    inputBinding:
      position: 101
      prefix: --min_gap_diff
  - id: max_gap_diff
    type:
      - 'null'
      - int
    doc: reject fragment if (new_gapsize-old_gapsize)*100/old_gapsize > max_gap_diff
    inputBinding:
      position: 101
      prefix: --max_gap_diff
outputs:
  - id: updated_scaff_infos
    type: File
    doc: scaffold infos with the gaps that could be filled
    outputBinding:
      glob: $(inputs.prefix).updated_scaff_infos
  - id: log
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.prefix).contig
        entry: $(inputs.contig)
      - entryname: $(inputs.prefix).orignial_scaff_infos
        entry: $(inputs.orignial_scaff_infos)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgsgapcloser:1.2.1--h6f25541_3
stdout: tgsgapcloser.log
