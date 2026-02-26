cwlVersion: v1.2
class: CommandLineTool
baseCommand: hamronize
label: hamronization_hamronize
doc: "Convert AMR gene detection tool output(s) to hAMRonization specification format\n\
  \nTool homepage: https://github.com/pha4ge/hAMRonization"
inputs:
  - id: tool
    type: string
    doc: 'The AMR gene detection tool whose output needs to be harmonized. Available
      tools: abricate, amrfinderplus, amrplusplus, ariba, csstar, deeparg, fargene,
      groot, kmerresistance, resfams, resfinder, mykrobe, rgi, srax, srst2, staramr,
      tbprofiler, summarize.'
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options specific to the chosen tool. For example, for 'abricate', it's 
      the path to the OUTPUT.tsv file.
    inputBinding:
      position: 2
  - id: abricate_output
    type:
      - 'null'
      - File
    doc: hAMRonize abricate's output report i.e., OUTPUT.tsv
    inputBinding:
      position: 103
      prefix: --abricate
  - id: amrfinderplus_output
    type:
      - 'null'
      - File
    doc: hAMRonize amrfinderplus's output report i.e., OUTPUT.tsv
    inputBinding:
      position: 103
      prefix: --amrfinderplus
  - id: amrplusplus_output
    type:
      - 'null'
      - File
    doc: hAMRonize amrplusplus's output report i.e., gene.tsv
    inputBinding:
      position: 103
      prefix: --amrplusplus
  - id: ariba_output
    type:
      - 'null'
      - File
    doc: hAMRonize ariba's output report i.e., OUTDIR/OUTPUT.tsv
    inputBinding:
      position: 103
      prefix: --ariba
  - id: csstar_output
    type:
      - 'null'
      - File
    doc: hAMRonize csstar's output report i.e., OUTPUT.tsv
    inputBinding:
      position: 103
      prefix: --csstar
  - id: deeparg_output
    type:
      - 'null'
      - File
    doc: hAMRonize deeparg's output report i.e., OUTDIR/OUTPUT.mapping.ARG
    inputBinding:
      position: 103
      prefix: --deeparg
  - id: fargene_output
    type:
      - 'null'
      - File
    doc: hAMRonize fargene's output report i.e., 
      retrieved-genes-*-hmmsearched.out
    inputBinding:
      position: 103
      prefix: --fargene
  - id: groot_output
    type:
      - 'null'
      - File
    doc: hAMRonize groot's output report i.e., OUTPUT.tsv (from `groot report`)
    inputBinding:
      position: 103
      prefix: --groot
  - id: kmerresistance_output
    type:
      - 'null'
      - File
    doc: hAMRonize kmerresistance's output report i.e., OUTPUT.res
    inputBinding:
      position: 103
      prefix: --kmerresistance
  - id: mykrobe_output
    type:
      - 'null'
      - File
    doc: hAMRonize mykrobe's output report i.e., OUTPUT.json
    inputBinding:
      position: 103
      prefix: --mykrobe
  - id: resfams_output
    type:
      - 'null'
      - File
    doc: hAMRonize resfams's output report i.e., resfams.tblout
    inputBinding:
      position: 103
      prefix: --resfams
  - id: resfinder_output
    type:
      - 'null'
      - File
    doc: hAMRonize resfinder's output report i.e., data_resfinder.json
    inputBinding:
      position: 103
      prefix: --resfinder
  - id: rgi_output
    type:
      - 'null'
      - File
    doc: hAMRonize rgi's output report i.e., OUTPUT.txt or 
      OUTPUT_bwtoutput.gene_mapping_data.txt
    inputBinding:
      position: 103
      prefix: --rgi
  - id: srax_output
    type:
      - 'null'
      - File
    doc: hAMRonize srax's output report i.e., sraX_detected_ARGs.tsv
    inputBinding:
      position: 103
      prefix: --srax
  - id: srst2_output
    type:
      - 'null'
      - File
    doc: hAMRonize srst2's output report i.e., OUTPUT_srst2_report.tsv
    inputBinding:
      position: 103
      prefix: --srst2
  - id: staramr_output
    type:
      - 'null'
      - File
    doc: hAMRonize staramr's output report i.e., resfinder.tsv
    inputBinding:
      position: 103
      prefix: --staramr
  - id: summarize_reports
    type:
      - 'null'
      - type: array
        items: File
    doc: Provide a list of paths to the reports you wish to summarize
    inputBinding:
      position: 103
      prefix: --summarize
  - id: tbprofiler_output
    type:
      - 'null'
      - File
    doc: hAMRonize tbprofiler's output report i.e., OUTPUT.results.json
    inputBinding:
      position: 103
      prefix: --tbprofiler
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
stdout: hamronization_hamronize.out
