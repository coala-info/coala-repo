cwlVersion: v1.2
class: CommandLineTool
baseCommand: transit
label: transit_cgi
doc: "Transit1 v3.3.20\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: method
    type: string
    doc: 'The method to use. Known methods: example, gumbel, binomial, griffin, hmm,
      resampling, tn5gaps, rankproduct, utest, GI, anova, zinb, normalize, pathway_enrichment,
      tnseq_stats, corrplot, heatmap, ttnfitness, CGI'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
stdout: transit_cgi.out
