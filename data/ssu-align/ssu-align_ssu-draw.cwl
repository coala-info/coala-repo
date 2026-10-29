cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu-draw
label: ssu-align_ssu-draw
doc: "Draw SSU rRNA secondary structure diagrams of alignments made by ssu-align (alignment summary diagrams, consensus and per-sequence diagrams).

Tool homepage: http://eddylab.org/software/ssu-align/"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: "force; w/--indi, draw all seqs, even if predicted output >100 Mb"
    inputBinding:
      position: 101
      prefix: -f
  - id: default_masks
    type:
      - 'null'
      - boolean
    doc: "display default ssu-align-0.1 masks on drawings"
    inputBinding:
      position: 101
      prefix: -d
  - id: mask_file
    type:
      - 'null'
      - File
    doc: "display single mask in file <f> for single alignment (requires -a)"
    inputBinding:
      position: 101
      prefix: -s
  - id: mask_key
    type:
      - 'null'
      - string
    doc: "display masks from files named <modelname>.<s>.mask on drawings"
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
    doc: "use template file <f>, not the default template file"
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
    doc: "only save postscript secondary structure diagrams, no pdfs"
    inputBinding:
      position: 101
      prefix: --ps-only
  - id: ifile
    type:
      - 'null'
      - File
    doc: "insert info for alignment is in <s> (requires -a)"
    inputBinding:
      position: 101
      prefix: --ifile
  - id: key_out
    type:
      - 'null'
      - string
    doc: "add <s> to all output file names, before the suffix"
    inputBinding:
      position: 101
      prefix: --key-out
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: "do not use ssu-mask created '.mask' files in the aln dir"
    inputBinding:
      position: 101
      prefix: --no-mask
  - id: mask_key_dir
    type:
      - 'null'
      - boolean
    doc: "display masks from files named <dir>.<modelname>.<s>.mask on drawings"
    inputBinding:
      position: 101
      prefix: --mask-key
  - id: info
    type:
      - 'null'
      - boolean
    doc: "draw sequence information content per position"
    inputBinding:
      position: 101
      prefix: --info
  - id: mutinfo
    type:
      - 'null'
      - boolean
    doc: "draw mutual information per position"
    inputBinding:
      position: 101
      prefix: --mutinfo
  - id: ifreq
    type:
      - 'null'
      - boolean
    doc: "draw frequency of insertions per position"
    inputBinding:
      position: 101
      prefix: --ifreq
  - id: iavglen
    type:
      - 'null'
      - boolean
    doc: "draw average length of insertions per position"
    inputBinding:
      position: 101
      prefix: --iavglen
  - id: dall
    type:
      - 'null'
      - boolean
    doc: "draw frequency of deletions per position"
    inputBinding:
      position: 101
      prefix: --dall
  - id: dint
    type:
      - 'null'
      - boolean
    doc: "draw frequency of internal deletions per position"
    inputBinding:
      position: 101
      prefix: --dint
  - id: prob
    type:
      - 'null'
      - boolean
    doc: "draw average posterior probability per position"
    inputBinding:
      position: 101
      prefix: --prob
  - id: span
    type:
      - 'null'
      - boolean
    doc: "draw fraction of seqs that span each position"
    inputBinding:
      position: 101
      prefix: --span
  - id: cnt
    type:
      - 'null'
      - boolean
    doc: "draw consensus nucleotides on alignment summary diagrams"
    inputBinding:
      position: 101
      prefix: --cnt
  - id: no_aln
    type:
      - 'null'
      - boolean
    doc: "do not create multi-page pdf with all alignment stats"
    inputBinding:
      position: 101
      prefix: --no-aln
  - id: indi
    type:
      - 'null'
      - boolean
    doc: "draw sequence and probability diagrams for all aligned sequences"
    inputBinding:
      position: 101
      prefix: --indi
  - id: cons
    type:
      - 'null'
      - boolean
    doc: "draw alignment consensus sequence"
    inputBinding:
      position: 101
      prefix: --cons
  - id: rf
    type:
      - 'null'
      - boolean
    doc: "draw model reference (#=GC RF) sequence"
    inputBinding:
      position: 101
      prefix: --rf
  - id: no_pp
    type:
      - 'null'
      - boolean
    doc: "with --indi, omit probability diagrams"
    inputBinding:
      position: 101
      prefix: --no-pp
  - id: no_bp
    type:
      - 'null'
      - boolean
    doc: "w/--indi,--rf or --cons, do not color nts based on basepair type"
    inputBinding:
      position: 101
      prefix: --no-bp
  - id: no_ol
    type:
      - 'null'
      - boolean
    doc: "w/--indi, do not outline nts that are not most common nt"
    inputBinding:
      position: 101
      prefix: --no-ol
  - id: no_leg
    type:
      - 'null'
      - boolean
    doc: "do not draw legends"
    inputBinding:
      position: 101
      prefix: --no-leg
  - id: no_head
    type:
      - 'null'
      - boolean
    doc: "do not draw headers"
    inputBinding:
      position: 101
      prefix: --no-head
  - id: no_foot
    type:
      - 'null'
      - boolean
    doc: "do not draw footers"
    inputBinding:
      position: 101
      prefix: --no-foot
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
      glob: '${ return inputs.alignment ? ["*.ps","*.pdf","*.drawtab","*.sum","*.log"] : []; }'
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
stdout: ssu-draw.out
