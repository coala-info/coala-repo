cwlVersion: v1.2
class: CommandLineTool
baseCommand: alimask
label: alimask
doc: "append modelmask line to a multiple sequence alignment\n\nTool homepage: http://hmmer.org/"
inputs:
  - id: msafile
    type: File
    doc: Input multiple sequence alignment file
    inputBinding:
      position: 1
  - id: ali2model
    type:
      - 'null'
      - string
    doc: print model range for each input msa column range; no postmsa
    inputBinding:
      position: 102
      prefix: --ali2model
  - id: alirange
    type:
      - 'null'
      - string
    doc: range(s) for mask(s) in alignment coordinates
    inputBinding:
      position: 102
      prefix: --alirange
  - id: amino
    type:
      - 'null'
      - boolean
    doc: input alignment is protein sequence data
    inputBinding:
      position: 102
      prefix: --amino
  - id: appendmask
    type:
      - 'null'
      - boolean
    doc: add to existing mask (default ignores the existing mask)
    inputBinding:
      position: 102
      prefix: --appendmask
  - id: dna
    type:
      - 'null'
      - boolean
    doc: input alignment is DNA sequence data
    inputBinding:
      position: 102
      prefix: --dna
  - id: fast
    type:
      - 'null'
      - boolean
    doc: assign cols w/ >= symfrac residues as consensus
    inputBinding:
      position: 102
      prefix: --fast
  - id: fragthresh
    type:
      - 'null'
      - float
    doc: if L <= x*alen, tag sequence as a fragment
    inputBinding:
      position: 102
      prefix: --fragthresh
  - id: hand
    type:
      - 'null'
      - boolean
    doc: manual construction (requires reference annotation)
    inputBinding:
      position: 102
      prefix: --hand
  - id: informat
    type:
      - 'null'
      - string
    doc: assert input alifile is in format <s> (no autodetect)
    inputBinding:
      position: 102
      prefix: --informat
  - id: model2ali
    type:
      - 'null'
      - string
    doc: print msa column range for each input model range; no postmsa
    inputBinding:
      position: 102
      prefix: --model2ali
  - id: modelrange
    type:
      - 'null'
      - string
    doc: range(s) for mask(s) in model coordinates
    inputBinding:
      position: 102
      prefix: --modelrange
  - id: outformat
    type:
      - 'null'
      - string
    doc: output alignment in format <s>
    inputBinding:
      position: 102
      prefix: --outformat
  - id: rna
    type:
      - 'null'
      - boolean
    doc: input alignment is RNA sequence data
    inputBinding:
      position: 102
      prefix: --rna
  - id: seed
    type:
      - 'null'
      - int
    doc: 'set RNG seed to <n> (if 0: one-time arbitrary seed)'
    inputBinding:
      position: 102
      prefix: --seed
  - id: symfrac
    type:
      - 'null'
      - float
    doc: sets sym fraction controlling --fast construction
    inputBinding:
      position: 102
      prefix: --symfrac
  - id: wblosum
    type:
      - 'null'
      - boolean
    doc: Henikoff simple filter weights
    inputBinding:
      position: 102
      prefix: --wblosum
  - id: wgiven
    type:
      - 'null'
      - boolean
    doc: use weights as given in MSA file
    inputBinding:
      position: 102
      prefix: --wgiven
  - id: wgsc
    type:
      - 'null'
      - boolean
    doc: Gerstein/Sonnhammer/Chothia tree weights
    inputBinding:
      position: 102
      prefix: --wgsc
  - id: wid
    type:
      - 'null'
      - float
    doc: 'for --wblosum: set identity cutoff (0<=x<=1)'
    inputBinding:
      position: 102
      prefix: --wid
  - id: wnone
    type:
      - 'null'
      - boolean
    doc: don't do any relative weighting; set all to 1
    inputBinding:
      position: 102
      prefix: --wnone
  - id: wpb
    type:
      - 'null'
      - boolean
    doc: Henikoff position-based weights
    inputBinding:
      position: 102
      prefix: --wpb
outputs:
  - id: postmsafile
    type: File
    doc: Output multiple sequence alignment file with mask
    outputBinding:
      glob: '*.out'
  - id: summary_output
    type:
      - 'null'
      - File
    doc: direct summary output to file <f>, not stdout
    outputBinding:
      glob: $(inputs.summary_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
