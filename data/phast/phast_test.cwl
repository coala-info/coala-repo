cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast_test
label: phast_test
doc: "The PHAST package contains the following programs: all_dists, hmm_view, phastBias,
  base_evolve, indelFit, phastCons, chooseLines, indelHistory, phastMotif, clean_genes,
  maf_parse, phastOdds, consEntropy, makeHKY, phyloBoot, convert_coords, modFreqs,
  phyloFit, display_rate_matrix, msa_diff, phyloP, dless, msa_split, prequel, dlessP,
  msa_view, refeature, draw_tree, pbsDecode, stringiphy, eval_predictions, pbsEncode,
  test, exoniphy, pbsScoreMatrix, tree_doctor, hmm_train, pbsTrain, treeGen, hmm_tweak,
  phast. For help, type the program's name followed by -h in your command line window.\n\
  \nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: program_name
    type: string
    doc: The name of the PHAST program to get help for.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: phast_test.out
