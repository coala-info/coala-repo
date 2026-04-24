cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsumugi run
label: tsumugi_run
doc: "TSUMUGI pipeline for analyzing IMPC statistical results and generating phenotype-disease
  associations.\n\nTool homepage: https://github.com/akikuno/TSUMUGI-dev"
inputs:
  - id: impc_phenodigm
    type:
      - 'null'
      - File
    doc: 'Path to IMPC Phenodigm annotation file (impc_phenodigm.csv). This file links
      mouse phenotypes to human diseases based on Phenodigm similarity. If not available,
      download manually from: https://diseasemodels.research.its.qmul.ac.uk/'
    inputBinding:
      position: 101
      prefix: --impc_phenodigm
  - id: mp_obo
    type:
      - 'null'
      - File
    doc: "Path to Mammalian Phenotype ontology file (mp.obo). Used to map and infer
      hierarchical relationships among MP terms. If not available, download 'mp.obo'
      manually from: https://obofoundry.org/ontology/mp.html"
    inputBinding:
      position: 101
      prefix: --mp_obo
  - id: output_dir
    type: Directory
    doc: Output directory for TSUMUGI results. All generated files (intermediate
      and final results) will be saved here.
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: statistical_results
    type: File
    doc: "Path to IMPC statistical_results_ALL.csv file. This file contains statistical
      test results (effect sizes, p-values, etc.) for all IMPC phenotyping experiments.
      If not available, download 'statistical-results-ALL.csv.gz' manually from: https://ftp.ebi.ac.uk/pub/databases/impc/all-data-releases/latest/TSUMUGI-results/"
    inputBinding:
      position: 101
      prefix: --statistical_results
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for TSUMUGI pipeline. If not specified, 
      defaults to 1.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
stdout: tsumugi_run.out
