cwlVersion: v1.2
class: CommandLineTool
baseCommand: rscape
label: rscape_R-scape
doc: "RNA Structural Covariation Above Phylogenetic Expectation\n\nTool homepage:
  http://eddylab.org/R-scape/"
inputs:
  - id: msafile
    type: File
    doc: Multiple sequence alignment file
    inputBinding:
      position: 1
  - id: allbranch
    type:
      - 'null'
      - boolean
    doc: output msa with all branges
    inputBinding:
      position: 102
      prefix: --allbranch
  - id: allownegatives
    type:
      - 'null'
      - boolean
    doc: no pairs are forbidden for having power but no covariation
    inputBinding:
      position: 102
      prefix: --allownegatives
  - id: amino
    type:
      - 'null'
      - boolean
    doc: use protein alphabet
    inputBinding:
      position: 102
      prefix: --amino
  - id: aplm
    type:
      - 'null'
      - boolean
    doc: potts option for training
    inputBinding:
      position: 102
      prefix: --APLM
  - id: c16
    type:
      - 'null'
      - boolean
    doc: use 16 covariation classes
    inputBinding:
      position: 102
      prefix: --C16
  - id: c2
    type:
      - 'null'
      - boolean
    doc: use 2 covariation classes
    inputBinding:
      position: 102
      prefix: --C2
  - id: cacofold
    type:
      - 'null'
      - boolean
    doc: The CaCoFold structure including all covariation
    inputBinding:
      position: 102
      prefix: --cacofold
  - id: ccf
    type:
      - 'null'
      - boolean
    doc: Correlation Coefficient with Frobenious norm statistic
    inputBinding:
      position: 102
      prefix: --CCF
  - id: ccfapc
    type:
      - 'null'
      - boolean
    doc: Correlation Coefficient with Frobenious norm APC corrected statistic
    inputBinding:
      position: 102
      prefix: --CCFp
  - id: ccfase
    type:
      - 'null'
      - boolean
    doc: Correlation Coefficient with Frobenius norm ASC corrected statistic
    inputBinding:
      position: 102
      prefix: --CCFa
  - id: chi
    type:
      - 'null'
      - boolean
    doc: CHI statistic
    inputBinding:
      position: 102
      prefix: --CHI
  - id: chiapc
    type:
      - 'null'
      - boolean
    doc: CHI APC corrected statistic
    inputBinding:
      position: 102
      prefix: --CHIp
  - id: chiasc
    type:
      - 'null'
      - boolean
    doc: CHI ASC corrected statistic
    inputBinding:
      position: 102
      prefix: --CHIa
  - id: cntmaxD
    type:
      - 'null'
      - float
    doc: max distance for contact definition
    inputBinding:
      position: 102
      prefix: --cntmaxD
  - id: cntmind
    type:
      - 'null'
      - int
    doc: min (j-i+1) for contact definition
    inputBinding:
      position: 102
      prefix: --cntmind
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: analyze only consensus (seq_cons) positions
    inputBinding:
      position: 102
      prefix: --consensus
  - id: covmin
    type:
      - 'null'
      - int
    doc: min distance between covarying pairs to report the pair. Default 1 
      (contiguous)
    inputBinding:
      position: 102
      prefix: --covmin
  - id: cselect
    type:
      - 'null'
      - boolean
    doc: use C2 if nseq <= nseqthresh otherwise use C16
    inputBinding:
      position: 102
      prefix: --CSELECT
  - id: cshuffle
    type:
      - 'null'
      - boolean
    doc: shuffle the columns of the alignment
    inputBinding:
      position: 102
      prefix: --cshuffle
  - id: cyk
    type:
      - 'null'
      - boolean
    doc: folding algorithm is cyk (default). Options are [cyk,decoding]
    inputBinding:
      position: 102
      prefix: --cyk
  - id: decoding
    type:
      - 'null'
      - boolean
    doc: folding algorithm is decoding. Options are [cyk,decoding] (default is 
      cyk)
    inputBinding:
      position: 102
      prefix: --decoding
  - id: dna
    type:
      - 'null'
      - boolean
    doc: use DNA alphabet
    inputBinding:
      position: 102
      prefix: --dna
  - id: doublesubs
    type:
      - 'null'
      - boolean
    doc: calculate power using double substitutions, default is single 
      substitutions
    inputBinding:
      position: 102
      prefix: --doublesubs
  - id: draw_nonWC
    type:
      - 'null'
      - boolean
    doc: TRUE to draw annotated non WC basepairs
    inputBinding:
      position: 102
      prefix: --draw_nonWC
  - id: e_helix
    type:
      - 'null'
      - float
    doc: E-value target for Helix significance
    inputBinding:
      position: 102
      prefix: --E_hlx
  - id: e_neg
    type:
      - 'null'
      - float
    doc: Evalue thresholds for negative pairs. Negative pairs require eval > <x>
    inputBinding:
      position: 102
      prefix: --E_neg
  - id: e_value_target
    type:
      - 'null'
      - float
    doc: E-value target for base pair significance. E > 1000 means report all 
      E-values
    inputBinding:
      position: 102
      prefix: -E
  - id: filter_seqs_residues
    type:
      - 'null'
      - float
    doc: filter out seqs <x*seq_cons residues
    inputBinding:
      position: 102
      prefix: -F
  - id: fisher
    type:
      - 'null'
      - boolean
    doc: 'aggregation method: fisher'
    inputBinding:
      position: 102
      prefix: --fisher
  - id: gapthresh
    type:
      - 'null'
      - float
    doc: keep columns with < <x> fraction of gaps
    inputBinding:
      position: 102
      prefix: --gapthresh
  - id: givennull
    type:
      - 'null'
      - File
    doc: use a given null distriburtion
    inputBinding:
      position: 102
      prefix: --givennull
  - id: gremlin
    type:
      - 'null'
      - boolean
    doc: reproduce gremlin
    inputBinding:
      position: 102
      prefix: --gremlin
  - id: gt
    type:
      - 'null'
      - boolean
    doc: GT statistic
    inputBinding:
      position: 102
      prefix: --GT
  - id: gtapc
    type:
      - 'null'
      - boolean
    doc: GT APC corrected statistic
    inputBinding:
      position: 102
      prefix: --GTp
  - id: gtasc
    type:
      - 'null'
      - boolean
    doc: GT ASC corrected statistic
    inputBinding:
      position: 102
      prefix: --GTa
  - id: informat
    type:
      - 'null'
      - string
    doc: specify format
    inputBinding:
      position: 102
      prefix: --informat
  - id: joinsubs
    type:
      - 'null'
      - boolean
    doc: calculate power using join substitutions, default is single 
      substitutions
    inputBinding:
      position: 102
      prefix: --joinsubs
  - id: lancaster
    type:
      - 'null'
      - boolean
    doc: 'aggregation method: lancaster'
    inputBinding:
      position: 102
      prefix: --lancaster
  - id: lancaster_double
    type:
      - 'null'
      - boolean
    doc: 'aggregation method: lancaster'
    inputBinding:
      position: 102
      prefix: --lancaster_double
  - id: lancaster_join
    type:
      - 'null'
      - boolean
    doc: 'aggregation method: lancaster'
    inputBinding:
      position: 102
      prefix: --lancaster_join
  - id: maxid
    type:
      - 'null'
      - float
    doc: maximum avgid of the given alignment
    inputBinding:
      position: 102
      prefix: --maxid
  - id: mi
    type:
      - 'null'
      - boolean
    doc: MI statistic
    inputBinding:
      position: 102
      prefix: --MI
  - id: miapc
    type:
      - 'null'
      - boolean
    doc: MI APC corrected statistic
    inputBinding:
      position: 102
      prefix: --MIp
  - id: mias
    type:
      - 'null'
      - boolean
    doc: MI ASC corrected statistic
    inputBinding:
      position: 102
      prefix: --MIa
  - id: mig
    type:
      - 'null'
      - boolean
    doc: MIg statistic
    inputBinding:
      position: 102
      prefix: --MIg
  - id: migapc
    type:
      - 'null'
      - boolean
    doc: MIg APC corrected statistic
    inputBinding:
      position: 102
      prefix: --MIgp
  - id: migasc
    type:
      - 'null'
      - boolean
    doc: MIg ASC corrected statistic
    inputBinding:
      position: 102
      prefix: --MIga
  - id: minhloop
    type:
      - 'null'
      - int
    doc: 'minimum hairpin loop length. If i-j is the closing pair: minhloop = j-1-1.'
    inputBinding:
      position: 102
      prefix: --minhloop
  - id: minid
    type:
      - 'null'
      - float
    doc: minimum avgid of the given alignment
    inputBinding:
      position: 102
      prefix: --minid
  - id: mir
    type:
      - 'null'
      - boolean
    doc: MIr statistic
    inputBinding:
      position: 102
      prefix: --MIr
  - id: mirapc
    type:
      - 'null'
      - boolean
    doc: MIr APC corrected statistic
    inputBinding:
      position: 102
      prefix: --MIrp
  - id: mirasc
    type:
      - 'null'
      - boolean
    doc: MIr ASC corrected statistic
    inputBinding:
      position: 102
      prefix: --MIra
  - id: naive
    type:
      - 'null'
      - boolean
    doc: sort results by cov score, no null model involved
    inputBinding:
      position: 102
      prefix: --naive
  - id: nofigures
    type:
      - 'null'
      - boolean
    doc: do not produce R2R and dotplot outputs
    inputBinding:
      position: 102
      prefix: --nofigures
  - id: nonparam
    type:
      - 'null'
      - boolean
    doc: non parameteric correlate
    inputBinding:
      position: 102
      prefix: --nonparam
  - id: nseqmin
    type:
      - 'null'
      - int
    doc: minimum number of sequences in the alignment
    inputBinding:
      position: 102
      prefix: --nseqmin
  - id: nshuffle
    type:
      - 'null'
      - int
    doc: number of shuffled alignments
    inputBinding:
      position: 102
      prefix: --nshuffle
  - id: ntree
    type:
      - 'null'
      - int
    doc: number of trees obtained by sequence rearrangements. Default is one 
      from msa as is
    inputBinding:
      position: 102
      prefix: --ntree
  - id: nullphylo
    type:
      - 'null'
      - boolean
    doc: nullphylo statistics
    inputBinding:
      position: 102
      prefix: --nullphylo
  - id: omes
    type:
      - 'null'
      - boolean
    doc: OMES statistic
    inputBinding:
      position: 102
      prefix: --OMES
  - id: omesapc
    type:
      - 'null'
      - boolean
    doc: OMES APC corrected statistic
    inputBinding:
      position: 102
      prefix: --OMESp
  - id: omesasc
    type:
      - 'null'
      - boolean
    doc: OMES ASC corrected statistic
    inputBinding:
      position: 102
      prefix: --OMESa
  - id: onemsa
    type:
      - 'null'
      - boolean
    doc: if file has more than one msa, analyze only the first one
    inputBinding:
      position: 102
      prefix: --onemsa
  - id: onlypdb
    type:
      - 'null'
      - boolean
    doc: use only structural info in pdbfile, ignore msa annotation if any
    inputBinding:
      position: 102
      prefix: --onlypdb
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: specify a directory for all output files
    inputBinding:
      position: 102
      prefix: --outdir
  - id: outmsa
    type:
      - 'null'
      - boolean
    doc: write actual msa used
    inputBinding:
      position: 102
      prefix: --outmsa
  - id: outname
    type:
      - 'null'
      - string
    doc: specify a filename for all outputs
    inputBinding:
      position: 102
      prefix: --outname
  - id: outnull
    type:
      - 'null'
      - boolean
    doc: write null alignments
    inputBinding:
      position: 102
      prefix: --outnull
  - id: outpotts
    type:
      - 'null'
      - boolean
    doc: write inferred potts parameters
    inputBinding:
      position: 102
      prefix: --outpotts
  - id: outprep
    type:
      - 'null'
      - boolean
    doc: write pair representations
    inputBinding:
      position: 102
      prefix: --outprep
  - id: outsubs
    type:
      - 'null'
      - boolean
    doc: 'write # of substitutions per alignment position'
    inputBinding:
      position: 102
      prefix: --outsubs
  - id: outtree
    type:
      - 'null'
      - boolean
    doc: write phylogenetic tree used
    inputBinding:
      position: 102
      prefix: --outtree
  - id: pdb
    type:
      - 'null'
      - File
    doc: read pdb structure from file <f>
    inputBinding:
      position: 102
      prefix: --pdb
  - id: pdbchain
    type:
      - 'null'
      - string
    doc: read a particular chain form pdbfile
    inputBinding:
      position: 102
      prefix: --pdbchain
  - id: plm
    type:
      - 'null'
      - boolean
    doc: potts option for training
    inputBinding:
      position: 102
      prefix: --PLM
  - id: pmass
    type:
      - 'null'
      - float
    doc: pmass for censored histogram of cov scores
    inputBinding:
      position: 102
      prefix: --pmass
  - id: potts
    type:
      - 'null'
      - boolean
    doc: potts couplings
    inputBinding:
      position: 102
      prefix: --potts
  - id: power
    type:
      - 'null'
      - File
    doc: calculate empirical power curve
    inputBinding:
      position: 102
      prefix: --power
  - id: powergaps
    type:
      - 'null'
      - boolean
    doc: calculate power including res->gap changes (default is not)
    inputBinding:
      position: 102
      prefix: --powergaps
  - id: prep_nohot
    type:
      - 'null'
      - boolean
    doc: write pair representations is don't want to use default onehot 
      representation
    inputBinding:
      position: 102
      prefix: --prep_nohot
  - id: profmark
    type:
      - 'null'
      - boolean
    doc: write null alignments with the ss_cons of the original alignment, 
      usefuls for a profmark
    inputBinding:
      position: 102
      prefix: --profmark
  - id: ptapc
    type:
      - 'null'
      - boolean
    doc: POTTS Averages ASC corrected statistic
    inputBinding:
      position: 102
      prefix: --PTAp
  - id: ptdpc
    type:
      - 'null'
      - boolean
    doc: POTTS DI ASC corrected statistic
    inputBinding:
      position: 102
      prefix: --PTDp
  - id: ptf
    type:
      - 'null'
      - boolean
    doc: POTTS Frobenious ASC corrected statistic
    inputBinding:
      position: 102
      prefix: --PTFp
  - id: ptmue
    type:
      - 'null'
      - float
    doc: potts regularization parameters for training eij's
    inputBinding:
      position: 102
      prefix: --ptmue
  - id: ptmuh
    type:
      - 'null'
      - float
    doc: potts regularization parameters for training hi's
    inputBinding:
      position: 102
      prefix: --ptmuh
  - id: r2rall
    type:
      - 'null'
      - boolean
    doc: make R2R plot all position in the alignment
    inputBinding:
      position: 102
      prefix: --r2rall
  - id: r3d
    type:
      - 'null'
      - boolean
    doc: 'TRUE: use grammar RBG_R3D'
    inputBinding:
      position: 102
      prefix: --r3d
  - id: r3dfile
    type:
      - 'null'
      - File
    doc: read r3d grammar from file <f>
    inputBinding:
      position: 102
      prefix: --r3dfile
  - id: raf
    type:
      - 'null'
      - boolean
    doc: RNAalifold statistic
    inputBinding:
      position: 102
      prefix: --RAF
  - id: rafapc
    type:
      - 'null'
      - boolean
    doc: RNAalifold APC corrected statistic
    inputBinding:
      position: 102
      prefix: --RAFp
  - id: rafasc
    type:
      - 'null'
      - boolean
    doc: RNAalifold ASC corrected statistic
    inputBinding:
      position: 102
      prefix: --RAFa
  - id: rafs
    type:
      - 'null'
      - boolean
    doc: RNAalifold-stacking statistic
    inputBinding:
      position: 102
      prefix: --RAFS
  - id: rafsapc
    type:
      - 'null'
      - boolean
    doc: RNAalifold-stacking APC corrected statistic
    inputBinding:
      position: 102
      prefix: --RAFSp
  - id: rafsasc
    type:
      - 'null'
      - boolean
    doc: RNAalifold-stacking ASC corrected statistic
    inputBinding:
      position: 102
      prefix: --RAFSa
  - id: rbg
    type:
      - 'null'
      - boolean
    doc: 'TRUE: use grammar RBG, default is RBGJ3J4'
    inputBinding:
      position: 102
      prefix: --RBG
  - id: refseq
    type:
      - 'null'
      - boolean
    doc: 'TRUE: CaCoFold uses a RF sequence. Default creates a profileseq from the
      alignment'
    inputBinding:
      position: 102
      prefix: --refseq
  - id: require_seqs_max_id
    type:
      - 'null'
      - float
    doc: require seqs to have < <x> id
    inputBinding:
      position: 102
      prefix: -I
  - id: require_seqs_min_id
    type:
      - 'null'
      - float
    doc: require seqs to have >= <x> id
    inputBinding:
      position: 102
      prefix: -i
  - id: rfam
    type:
      - 'null'
      - boolean
    doc: The CaCoFold structure w/o triplets/side/cross modules, overlaping or 
      contiguou pairs
    inputBinding:
      position: 102
      prefix: --Rfam
  - id: rna
    type:
      - 'null'
      - boolean
    doc: use RNA alphabet
    inputBinding:
      position: 102
      prefix: --rna
  - id: roc
    type:
      - 'null'
      - boolean
    doc: write .roc file
    inputBinding:
      position: 102
      prefix: --roc
  - id: sample_bp
    type:
      - 'null'
      - boolean
    doc: basepair-set sample size is all 12-type basepairs (default for RNA/DNA)
    inputBinding:
      position: 102
      prefix: --samplebp
  - id: sample_contacts
    type:
      - 'null'
      - boolean
    doc: basepair-set sample size is all contacts (default for amino acids)
    inputBinding:
      position: 102
      prefix: --samplecontacts
  - id: sample_wc
    type:
      - 'null'
      - boolean
    doc: basepair-set sample size is WWc basepairs only
    inputBinding:
      position: 102
      prefix: --samplewc
  - id: savenull
    type:
      - 'null'
      - boolean
    doc: write null histogram
    inputBinding:
      position: 102
      prefix: --savenull
  - id: seed
    type:
      - 'null'
      - int
    doc: set RNG seed to <n>. Use 0 for a random seed.
    inputBinding:
      position: 102
      prefix: --seed
  - id: show_hoverlap
    type:
      - 'null'
      - boolean
    doc: TRUE to leave the overlap of alt helices with other helices
    inputBinding:
      position: 102
      prefix: --show_hoverlap
  - id: sidak
    type:
      - 'null'
      - boolean
    doc: 'aggregation method: sidak'
    inputBinding:
      position: 102
      prefix: --sidak
  - id: singlesubs
    type:
      - 'null'
      - boolean
    doc: calculate power using double substitutions, default is single 
      substitutions
    inputBinding:
      position: 102
      prefix: --singlesubs
  - id: slide
    type:
      - 'null'
      - int
    doc: window slide
    inputBinding:
      position: 102
      prefix: --slide
  - id: submsa
    type:
      - 'null'
      - int
    doc: take n random sequences from the alignment, all if NULL
    inputBinding:
      position: 102
      prefix: --submsa
  - id: tend
    type:
      - 'null'
      - int
    doc: max alignment position to analyze
    inputBinding:
      position: 102
      prefix: --tend
  - id: tol
    type:
      - 'null'
      - float
    doc: tolerance
    inputBinding:
      position: 102
      prefix: --tol
  - id: treefile
    type:
      - 'null'
      - File
    doc: provide external tree to use
    inputBinding:
      position: 102
      prefix: --treefile
  - id: tstart
    type:
      - 'null'
      - int
    doc: min alignment position to analyze
    inputBinding:
      position: 102
      prefix: --tstart
  - id: two_set_test
    type:
      - 'null'
      - boolean
    doc: 'two-set test: basepairs / all other pairs. Requires a given structure'
    inputBinding:
      position: 102
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose
    inputBinding:
      position: 102
      prefix: --verbose
  - id: voutput
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: --voutput
  - id: vshuffle
    type:
      - 'null'
      - boolean
    doc: shuffle the residues in a column
    inputBinding:
      position: 102
      prefix: --vshuffle
  - id: wfisher
    type:
      - 'null'
      - boolean
    doc: 'aggregation method: weighted fisher'
    inputBinding:
      position: 102
      prefix: --wfisher
  - id: wfisher_double
    type:
      - 'null'
      - boolean
    doc: 'aggregation method: weighted fisher'
    inputBinding:
      position: 102
      prefix: --wfisher_double
  - id: wfisher_join
    type:
      - 'null'
      - boolean
    doc: 'aggregation method: weighted fisher'
    inputBinding:
      position: 102
      prefix: --wfisher_join
  - id: window
    type:
      - 'null'
      - int
    doc: window size
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rscape:2.0.4.a--h503566f_1
stdout: rscape_R-scape.out
