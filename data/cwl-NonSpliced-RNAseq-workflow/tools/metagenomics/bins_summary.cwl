#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "Bin summary"

doc: |
    Creates a summary table of the bins and their quality and taxonomy.

    Columns are:
    Bin
    Contigs
    Size
    Largest_contig
    N50
    GC
    Relative abundance
    GTDB-Tk_taxonomy
    BUSCO_Taxonomy
    BUSCO_score
    CheckM_Completeness
    CheckM_Contamination
    CheckM_Strain-heterogeneity    

requirements:
  - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      python3:
        version: ["3.12.0"]
        specs: ["https://anaconda.org/conda-forge/python"]
      pandas:
        version: ["2.2.2"]
        specs: ["https://anaconda.org/conda-forge/pandas", "doi.org/10.5281/zenodo.3509134"]
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/scripts:e197a628

baseCommand: ["python3", "/scripts/metagenomics/bins_summary.py"]

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used  
  bin_dir:
    type: Directory?
    doc: Directory containing bins in fasta format from metagenomic binning
    label: Bins directory
    inputBinding:
      prefix: "--bin_dir"
  bin_files:
    type: File[]?
    doc: Array of bin files in fasta format
    label: Bin files
    inputBinding:
      prefix: "--bin_files"
  busco_batch:
    type: File?
    doc: BUSCO batch report file
    label: BUSCO batch
    inputBinding:
      prefix: "--busco_batch"
  binette_report:
    type: File?
    doc: Binette report file
    label: Binette report
    inputBinding:
      prefix: "--binette"
  coverm:
    type: File?
    doc: CoverM tsv with bins coverages/abundances
    label: CoverM tsv
    inputBinding:
      prefix: "--coverm"
  gtdbtk_summary:
    type: File?
    doc: GTDB-Tk summary file
    label: GTDB-Tk summary
    inputBinding:
      prefix: "--gtdbtk"

arguments:
  - prefix: "--output"
    valueFrom: $(inputs.identifier)

outputs:
  bins_summary_table:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_bin-summary.tsv
  bin_contigs:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_bin-contigs.tsv

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke


s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2021-00-00"
s:dateModified: "2025-09-03"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
