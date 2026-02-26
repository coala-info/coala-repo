cwlVersion: v1.2
class: CommandLineTool
baseCommand: transit
label: transit_gi
doc: "Transit1 is a tool for analyzing high-throughput sequencing data. This specific
  invocation seems to be related to selecting a method for analysis.\n\nTool homepage:
  http://github.com/mad-lab/transit"
inputs:
  - id: method
    type: string
    doc: 'The analysis method to use. Known methods include: example, gumbel, binomial,
      griffin, hmm, resampling, tn5gaps, rankproduct, utest, GI, anova, zinb, normalize,
      pathway_enrichment, tnseq_stats, corrplot, heatmap, ttnfitness, CGI.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
stdout: transit_gi.out
