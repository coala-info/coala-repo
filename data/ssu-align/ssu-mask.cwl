cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu-mask
label: ssu-mask
doc: "Mask SSU rRNA alignments made by ssu-align (the default ssu-align-0.1 masks or masks computed from posterior probabilities), convert alignments, or list/remove sequences.

Tool homepage: http://eddylab.org/software/ssu-align/"
inputs:
  - id: default_masks
    type:
      - 'null'
      - boolean
    doc: "use default ssu-align-0.1 masks"
    inputBinding:
      position: 101
      prefix: -d
  - id: mask_file
    type:
      - 'null'
      - File
    doc: "use single mask in existing file <f> to mask single alignment"
    inputBinding:
      position: 101
      prefix: -s
  - id: mask_key
    type:
      - 'null'
      - string
    doc: "use mask file named <modelname>.<s>.mask for masking"
    inputBinding:
      position: 101
      prefix: -k
  - id: cm_file
    type:
      - 'null'
      - File
    doc: "CM file <f> created the alignment(s) (with ssu-align -m <f>)"
    inputBinding:
      position: 101
      prefix: -m
  - id: template_file
    type:
      - 'null'
      - File
    doc: "for structure diagrams, use template file <f>, not the default"
    inputBinding:
      position: 101
      prefix: -t
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: "-i used with ssu-align, alignments are interleaved"
    inputBinding:
      position: 101
      prefix: -i
  - id: pf
    type:
      - 'null'
      - float
    doc: "include columns w/<x> fraction of seqs w/prob >= --pt <y> [df: 0.95]"
    inputBinding:
      position: 101
      prefix: --pf
  - id: pt
    type:
      - 'null'
      - float
    doc: "set probability threshold as <y> [default=0.95]"
    inputBinding:
      position: 101
      prefix: --pt
  - id: rfonly
    type:
      - 'null'
      - boolean
    doc: "exclude insert (gap in RF) columns only"
    inputBinding:
      position: 101
      prefix: --rfonly
  - id: gapthresh
    type:
      - 'null'
      - float
    doc: "only consider columns with <= <x> fraction gaps"
    inputBinding:
      position: 101
      prefix: --gapthresh
  - id: gaponly
    type:
      - 'null'
      - boolean
    doc: "do not consider posterior probabilities, only gap frequencies"
    inputBinding:
      position: 101
      prefix: --gaponly
  - id: afa
    type:
      - 'null'
      - boolean
    doc: "output aligned FASTA (.afa) alignments, not Stockholm ones"
    inputBinding:
      position: 101
      prefix: --afa
  - id: dna
    type:
      - 'null'
      - boolean
    doc: "output alignments as DNA, default is RNA (even if input is DNA)"
    inputBinding:
      position: 101
      prefix: --dna
  - id: key_out
    type:
      - 'null'
      - string
    doc: "add <s> to all output file names, before the suffix"
    inputBinding:
      position: 101
      prefix: --key-out
  - id: ps2pdf
    type:
      - 'null'
      - string
    doc: "<s> (!= \"ps2pdf\") is the command for converting ps to pdf"
    inputBinding:
      position: 101
      prefix: --ps2pdf
  - id: ps_only
    type:
      - 'null'
      - boolean
    doc: "save postscript secondary structure diagrams, don't convert to pdf"
    inputBinding:
      position: 101
      prefix: --ps-only
  - id: no_draw
    type:
      - 'null'
      - boolean
    doc: "do not draw mask diagrams"
    inputBinding:
      position: 101
      prefix: --no-draw
  - id: list
    type:
      - 'null'
      - boolean
    doc: "output list file(s) of sequence names in alignment(s) (no masking will be done)"
    inputBinding:
      position: 101
      prefix: --list
  - id: stk2afa
    type:
      - 'null'
      - boolean
    doc: "convert Stockholm alignment(s) to aligned FASTA (no masking will be done)"
    inputBinding:
      position: 101
      prefix: --stk2afa
  - id: seq_keep
    type:
      - 'null'
      - File
    doc: "with -a, remove all sequences *except* those listed in file <f>"
    inputBinding:
      position: 101
      prefix: --seq-k
  - id: seq_remove
    type:
      - 'null'
      - File
    doc: "with -a, remove sequences with names listed in file <f>"
    inputBinding:
      position: 101
      prefix: --seq-r
  - id: ssu_align_dir
    type:
      - 'null'
      - Directory
    doc: "Directory created by ssu-align (includes >= 1 alignment file(s)); results are written into a copy of it"
    inputBinding:
      position: 201
      valueFrom: '$(self.basename)'
  - id: alignment
    type:
      - 'null'
      - File
    doc: "Stockholm alignment file (use instead of the directory; with the -a option)"
    inputBinding:
      position: 202
      prefix: -a
      valueFrom: '$(self.basename)'
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: ssu-align output directory with the new files
    outputBinding:
      glob: '${ return inputs.ssu_align_dir ? inputs.ssu_align_dir.basename : []; }'
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written next to the input alignment (with -a)
    outputBinding:
      glob: '${ return inputs.alignment ? ["*.mask.stk","*.mask","*.afa","*.list","*.ps","*.pdf","*.sum","*.log"] : []; }'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        if (inputs.ssu_align_dir) { l.push({"entry": inputs.ssu_align_dir, "writable": true}); }
        if (inputs.alignment) { l.push({"entry": inputs.alignment, "writable": true}); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
stdout: ssu-mask.out
