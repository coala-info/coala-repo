cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmbuild
label: infernal_cmbuild
doc: covariance model construction from multiple sequence alignments
inputs:
  - id: cmfile_out
    type: string
    doc: Output covariance model file
    inputBinding:
      position: 1
  - id: msafile
    type:
      - 'null'
      - File
    doc: Input multiple sequence alignment file
    inputBinding:
      position: 2
  - id: name
    type:
      - 'null'
      - string
    doc: name the CM(s) <s>, (only if single aln in file)
    inputBinding:
      position: 103
      prefix: -n
  - id: force
    type:
      - 'null'
      - boolean
    doc: force; allow overwriting of <cmfile_out>
    inputBinding:
      position: 103
      prefix: -F
  - id: summary_output
    type:
      - 'null'
      - string
    doc: direct summary output to file <f>, not stdout
    inputBinding:
      position: 103
      prefix: -o
  - id: resave_msa
    type:
      - 'null'
      - string
    doc: resave consensus/insert column annotated MSA to file <f>
    inputBinding:
      position: 103
      prefix: -O
  - id: devhelp
    type:
      - 'null'
      - boolean
    doc: show list of otherwise hidden developer/expert options
    inputBinding:
      position: 103
      prefix: --devhelp
  - id: fast
    type:
      - 'null'
      - boolean
    doc: assign cols w/ >= symfrac residues as consensus
    inputBinding:
      position: 103
      prefix: --fast
  - id: hand
    type:
      - 'null'
      - boolean
    doc: use reference coordinate annotation to specify consensus
    inputBinding:
      position: 103
      prefix: --hand
  - id: symfrac
    type:
      - 'null'
      - float
    doc: fraction of non-gaps to require in a consensus column [0..1]
    inputBinding:
      position: 103
      prefix: --symfrac
  - id: fragthresh
    type:
      - 'null'
      - float
    doc: if aligned seq spans <= x*alen, tag seq as a fragment
    inputBinding:
      position: 103
      prefix: --fragthresh
  - id: fragnrfpos
    type:
      - 'null'
      - int
    doc: w/--hand, seqs w/ > <n> 5' or 3' consensus gaps are fragments
    inputBinding:
      position: 103
      prefix: --fragnrfpos
  - id: fraggiven
    type:
      - 'null'
      - boolean
    doc: use fragment info, if any, in input MSA, don't infer frags
    inputBinding:
      position: 103
      prefix: --fraggiven
  - id: noss
    type:
      - 'null'
      - boolean
    doc: ignore secondary structure annotation in input alignment
    inputBinding:
      position: 103
      prefix: --noss
  - id: rsearch
    type:
      - 'null'
      - File
    doc: use RSEARCH parameterization with RIBOSUM matrix file <f>
    inputBinding:
      position: 103
      prefix: --rsearch
  - id: consrf
    type:
      - 'null'
      - boolean
    doc: with --hand, rewrite RF line with consensus sequence
    inputBinding:
      position: 103
      prefix: --consrf
  - id: 'null'
    type:
      - 'null'
      - File
    doc: read null (random sequence) model from file <f>
    inputBinding:
      position: 103
      prefix: --null
  - id: prior
    type:
      - 'null'
      - File
    doc: read priors from file <f>
    inputBinding:
      position: 103
      prefix: --prior
  - id: wpb
    type:
      - 'null'
      - boolean
    doc: Henikoff position-based weights [default]
    inputBinding:
      position: 103
      prefix: --wpb
  - id: wgsc
    type:
      - 'null'
      - boolean
    doc: Gerstein/Sonnhammer/Chothia tree weights
    inputBinding:
      position: 103
      prefix: --wgsc
  - id: wnone
    type:
      - 'null'
      - boolean
    doc: don't do any relative weighting; set all to 1
    inputBinding:
      position: 103
      prefix: --wnone
  - id: wgiven
    type:
      - 'null'
      - boolean
    doc: use weights as given in MSA file
    inputBinding:
      position: 103
      prefix: --wgiven
  - id: wblosum
    type:
      - 'null'
      - boolean
    doc: Henikoff simple filter weights
    inputBinding:
      position: 103
      prefix: --wblosum
  - id: wid
    type:
      - 'null'
      - float
    doc: 'for --wblosum: set identity cutoff [0.62] (0<=x<=1)'
    inputBinding:
      position: 103
      prefix: --wid
  - id: eent
    type:
      - 'null'
      - boolean
    doc: 'adjust eff seq # to achieve relative entropy target [default]'
    inputBinding:
      position: 103
      prefix: --eent
  - id: enone
    type:
      - 'null'
      - boolean
    doc: 'no effective seq # weighting: just use nseq'
    inputBinding:
      position: 103
      prefix: --enone
  - id: ere
    type:
      - 'null'
      - float
    doc: 'for --eent: set CM target relative entropy to <x>'
    inputBinding:
      position: 103
      prefix: --ere
  - id: eset
    type:
      - 'null'
      - float
    doc: 'set eff seq # for all models to <x>'
    inputBinding:
      position: 103
      prefix: --eset
  - id: eminseq
    type:
      - 'null'
      - float
    doc: 'for --eent: set minimum effective sequence number to <x> [0.1]'
    inputBinding:
      position: 103
      prefix: --eminseq
  - id: emaxseq
    type:
      - 'null'
      - float
    doc: 'for --eent: set maximum effective sequence number to <x>'
    inputBinding:
      position: 103
      prefix: --emaxseq
  - id: ehmmre
    type:
      - 'null'
      - float
    doc: 'for --eent: set minimum HMM relative entropy to <x>'
    inputBinding:
      position: 103
      prefix: --ehmmre
  - id: esigma
    type:
      - 'null'
      - float
    doc: 'for --eent: set sigma param to <x> [45.0]'
    inputBinding:
      position: 103
      prefix: --esigma
  - id: p7ere
    type:
      - 'null'
      - float
    doc: for the filter p7 HMM, set minimum rel entropy/posn to <x>
    inputBinding:
      position: 103
      prefix: --p7ere
  - id: p7ml
    type:
      - 'null'
      - boolean
    doc: define the filter p7 HMM as the ML p7 HMM
    inputBinding:
      position: 103
      prefix: --p7ml
  - id: emn
    type:
      - 'null'
      - int
    doc: number of sampled seqs to use for p7 local MSV calibration [200]
    inputBinding:
      position: 103
      prefix: --EmN
  - id: evn
    type:
      - 'null'
      - int
    doc: number of sampled seqs to use for p7 local Vit calibration [200]
    inputBinding:
      position: 103
      prefix: --EvN
  - id: elfn
    type:
      - 'null'
      - int
    doc: number of sampled seqs to use for p7 local Fwd calibration [200]
    inputBinding:
      position: 103
      prefix: --ElfN
  - id: egfn
    type:
      - 'null'
      - int
    doc: number of sampled seqs to use for p7 glocal Fwd calibration [200]
    inputBinding:
      position: 103
      prefix: --EgfN
  - id: refine
    type:
      - 'null'
      - string
    doc: refine input aln w/Expectation-Maximization, save to <f>
    inputBinding:
      position: 103
      prefix: --refine
  - id: local
    type:
      - 'null'
      - boolean
    doc: 'w/--refine, configure model for local alignment [default: global]'
    inputBinding:
      position: 103
      prefix: -l
  - id: gibbs
    type:
      - 'null'
      - boolean
    doc: w/--refine, use Gibbs sampling instead of EM
    inputBinding:
      position: 103
      prefix: --gibbs
  - id: seed
    type:
      - 'null'
      - int
    doc: 'w/--gibbs, set RNG seed to <n> (if 0: one-time arbitrary seed)'
    inputBinding:
      position: 103
      prefix: --seed
  - id: cyk
    type:
      - 'null'
      - boolean
    doc: w/--refine, use CYK instead of optimal accuracy
    inputBinding:
      position: 103
      prefix: --cyk
  - id: notrunc
    type:
      - 'null'
      - boolean
    doc: w/--refine, do not use truncated alignment algorithm
    inputBinding:
      position: 103
      prefix: --notrunc
  - id: miss
    type:
      - 'null'
      - boolean
    doc: w/--refine, mark seqs w/terminal gaps as fragments
    inputBinding:
      position: 103
      prefix: --miss
outputs:
  - id: out_cmfile_out
    type: File
    doc: Output covariance model file
    outputBinding:
      glob: $(inputs.cmfile_out)
  - id: output_summary_output
    type:
      - 'null'
      - File
    doc: direct summary output to file <f>, not stdout
    outputBinding:
      glob: $(inputs.summary_output)
  - id: output_resave_msa
    type:
      - 'null'
      - File
    doc: resave consensus/insert column annotated MSA to file <f>
    outputBinding:
      glob: $(inputs.resave_msa)
  - id: output_refine
    type:
      - 'null'
      - File
    doc: refine input aln w/Expectation-Maximization, save to <f>
    outputBinding:
      glob: $(inputs.refine)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
s:url: http://eddylab.org/infernal
$namespaces:
  s: https://schema.org/
