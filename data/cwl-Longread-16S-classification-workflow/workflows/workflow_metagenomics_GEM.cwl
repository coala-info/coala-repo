#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

label: Metagenomic GEM construction from assembly
doc: |
  Workflow for Metagenomics from bins to metabolic model.<br>
  Summary
    - Prodigal gene prediction
    - CarveMe genome scale metabolic model reconstruction
    - MEMOTE for metabolic model testing
    - SMETANA Species METabolic interaction ANAlysis

  Other UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>
  
  **All tool CWL files and other workflows can be found here:**<br>
    Tools: https://gitlab.com/m-unlock/cwl<br>
    Workflows: https://gitlab.com/m-unlock/cwl/workflows<br>

  **How to setup and use an UNLOCK workflow:**<br>
  https://docs.m-unlock.nl/docs/workflows/setup.html<br>

  Note: This workflow uses private containers due to IBM CPLEX requirement.

  Docker files can be found here: https://gitlab.com/m-unlock/docker/-/tree/main/cwl/builder/docker

requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

outputs:
  carveme_gems_folder:
    label: CarveMe GEMs folder
    doc: CarveMe metabolic models folder
    type: Directory
    outputSource: carveme_files_to_folder/results
  protein_fasta_folder:
    label: Protein files folder
    doc: Prodigal predicted proteins (compressed) fasta files
    type: Directory
    outputSource: prodigal_files_to_folder/results
  memote_folder:
    label: MEMOTE outputs folder
    doc: MEMOTE outputs folder
    type: Directory
    outputSource: memote_files_to_folder/results

  smetana_output:
    label: SMETANA output
    doc: SMETANA detailed output table
    type: File?
    outputSource: smetana/detailed_output_tsv

  gemstats_out:
    label: GEMstats
    doc: CarveMe GEM statistics
    type: File
    outputSource: gemstats/carveme_GEMstats

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: Identifier used
  bins:
    type: File[] # ?
    doc: Bin/genome fasta files
    label: Genome/bin
  # bin_folder:
    # type: Directory?
    # doc: Directory with bins in fasta format
    # label: Bin Folder
  smetana_solver:
    type: string
    doc: Solver to be used in SMETANA (now only run with cplex)
    default: "cplex"
  run_smetana:
    type: boolean?
    label: Run SMETANA
    doc: Run SMETANA (Species METabolic interaction ANAlysis) (default false)
    default: false
  memote_solver:
    type: string?
    label: MEMOTE solver
    doc: MEMOTE solver Choice (cplex, glpk, gurobi, glpk_exact); by default glpk
    default: "glpk"
  
  gapfill:
    type: string?
    label: Gap fill
    doc: Gap fill model for given media
    # default: "M8"
  mediadb:
    type: File?
    label: Media database
    doc: Media database file
  carveme_solver:
    type: string?
    label: CarveMe solver
    doc: CarveMe solver (default scip), possible to use cplex in private container (not provided in public container)
    default: "scip"

  # Prodigal mode, single or meta
  mode:
    type: 
      - 'null'
      - type: enum
        symbols: 
        - single
        - meta
    label: Prodigal mode
    doc: Prodigal mode, single or meta
    default: single

  threads:
    type: int?
    doc: Number of threads to use for computational processes
    label: number of threads
    default: 2

  destination:
    type: string?
    label: Output Destination (prov only)
    doc: Not used in this workflow. Output destination used for cwl-prov reporting only.

steps:
#############################################
#### Prodigal
  prodigal:
    label: prodigal
    doc: prodigal gene/protein prediction
    run: ../tools/prodigal/prodigal.cwl
    scatter: [input_fasta]
    in:
      identifier: identifier
      input_fasta: bins
      mode: mode
    out: [predicted_proteins_faa]

  compress_prodigal:
    label: Compress proteins
    doc: Compress prodigal protein files
    run: ../tools/bash/pigz.cwl
    scatter: inputfile
    in:
      inputfile: 
        source: [prodigal/predicted_proteins_faa]
        linkMerge: merge_flattened
      threads: threads
    out: [outfile]
#############################################
#### CarveMe
  carveme:
    label: CarveMe proprietary solver
    doc: Genome-scale metabolic models reconstruction with CarveMe using proprietary solver (cplex)
    run: ../tools/carveme/carveme.cwl
    when: $(inputs.carveme_solver == "cplex")
    scatter: [protein_file]
    in:
      protein_file: prodigal/predicted_proteins_faa
      mediadb: mediadb
      gapfill: gapfill
      # solver by defalt is cplex, but user can override it here:
      carveme_solver: carveme_solver
    out: [carveme_gem]
    # Users can override the DockerRequirement here if they have a proprietary solver:
    # Otherwise, set the solver to scip
    requirements:
      DockerRequirement:
        dockerPull: "docker-registry.wur.nl/m-unlock/docker-private/carveme:1.6.1" 
        # Image with the proprietary CPLEX solver

  carveme_base:
    label: CarveMe opensource solver
    doc: Genome-scale metabolic models reconstruction with CarveMe using opensource solver (scip)
    run: ../tools/carveme/carveme.cwl
    when: $(inputs.carveme_solver == "scip")
    scatter: [protein_file]
    in:
      protein_file: prodigal/predicted_proteins_faa
      mediadb: mediadb
      gapfill: gapfill
      # solver by defalt is cplex, but user can override it here:
      carveme_solver: carveme_solver
    out: [carveme_gem]

  compress_carveme:
    label: Compress GEM from CarveMe
    doc: Compress CarveMe GEM
    run: ../tools/bash/pigz.cwl
    scatter: inputfile
    in:
      inputfile: 
        source: [carveme/carveme_gem, carveme_base/carveme_gem]
        linkMerge: merge_flattened
        pickValue: all_non_null
      threads: threads
    out: [outfile]
#############################################
#### GEM statistics
  gemstats:
    label: GEM stats
    doc: CarveMe GEM statistics
    run: ../tools/carveme/GEMstats.cwl
    in:
      identifier: identifier
      carveme_gems: 
        source: [carveme/carveme_gem, carveme_base/carveme_gem]
        linkMerge: merge_flattened
        pickValue: all_non_null
    out: [carveme_GEMstats]
#############################################
#### SMETANA
  smetana:
    label: SMETANA
    doc: Species METabolic interaction ANAlysis
    # when run_smetana is true, and smetana_solver is cplex
    when: $(inputs.run_smetana && inputs.solver == "cplex")
    run: ../tools/smetana/smetana.cwl
    in:
      run_smetana: run_smetana
      identifier: identifier
      GEM: 
        source: [carveme/carveme_gem, carveme_base/carveme_gem]
        linkMerge: merge_flattened
        pickValue: all_non_null
      solver: smetana_solver
    out: [detailed_output_tsv]

#############################################
#### MEMOTE REPORT AND RUN
# when memote solver is glpk
  memote_report_snapshot_base:
    label: MEMOTE report snapshot opensource
    doc: Take a snapshot of a model's state and generate a report. 
    run: ../tools/memote/memote.cwl
    when: $(inputs.solver == "glpk")
    scatter: [GEM]
    in:
      GEM: 
        source: [carveme/carveme_gem, carveme_base/carveme_gem]
        linkMerge: merge_flattened
        pickValue: all_non_null
      solver: memote_solver
      report_snapshot:
        default: true
      skip_test_find_metabolites_produced_with_closed_bounds:
        default: true
      skip_test_find_metabolites_consumed_with_closed_bounds:
        default: true
      skip_test_find_metabolites_not_produced_with_open_bounds:
        default: true
      skip_test_find_metabolites_not_consumed_with_open_bounds:
        default: true
    out: [report_html]

  memote_run_base:
    label: MEMOTE opensource solver
    doc: MEMOTE run analsis 
    run: ../tools/memote/memote.cwl
    when: $(inputs.solver == "glpk")
    scatter: [GEM]
    in:
      GEM: 
        source: [carveme/carveme_gem, carveme_base/carveme_gem]
        linkMerge: merge_flattened
        pickValue: all_non_null
      solver: memote_solver
      run:
        default: true
      skip_test_find_metabolites_produced_with_closed_bounds:
        default: true
      skip_test_find_metabolites_consumed_with_closed_bounds:
        default: true
      skip_test_find_metabolites_not_produced_with_open_bounds:
        default: true
      skip_test_find_metabolites_not_consumed_with_open_bounds:
        default: true
    out: [run_json]

# when memote solver is cplex
  memote_report_snapshot:
    label: MEMOTE report snapshot proprietary
    doc: Take a snapshot of a model's state and generate a report. 
    run: ../tools/memote/memote.cwl
    when: $(inputs.solver == "cplex")
    requirements:
      DockerRequirement:
        dockerPull: "docker-registry.wur.nl/m-unlock/docker-private/memote:0.13.0"
    scatter: [GEM]
    in:
      GEM: 
        source: [carveme/carveme_gem, carveme_base/carveme_gem]
        linkMerge: merge_flattened
        pickValue: all_non_null
      solver: memote_solver
      report_snapshot:
        default: true
      skip_test_find_metabolites_produced_with_closed_bounds:
        default: true
      skip_test_find_metabolites_consumed_with_closed_bounds:
        default: true
      skip_test_find_metabolites_not_produced_with_open_bounds:
        default: true
      skip_test_find_metabolites_not_consumed_with_open_bounds:
        default: true
    out: [report_html]

  memote_run:
    label: MEMOTE proprietary solver
    doc: MEMOTE run analsis 
    run: ../tools/memote/memote.cwl
    when: $(inputs.solver == "cplex")
    requirements:
      DockerRequirement:
        dockerPull: "docker-registry.wur.nl/m-unlock/docker-private/memote:0.13.0"
    scatter: [GEM]
    in:
      GEM: 
        source: [carveme/carveme_gem, carveme_base/carveme_gem]
        linkMerge: merge_flattened
        pickValue: all_non_null
      solver: memote_solver
      run:
        default: true
      skip_test_find_metabolites_produced_with_closed_bounds:
        default: true
      skip_test_find_metabolites_consumed_with_closed_bounds:
        default: true
      skip_test_find_metabolites_not_produced_with_open_bounds:
        default: true
      skip_test_find_metabolites_not_consumed_with_open_bounds:
        default: true
    out: [run_json]

#############################################
#### Move to folder if not part of a workflow
  carveme_files_to_folder:
    doc: Preparation of workflow output files to a specific output folder
    label: CarveMe GEMs to folder
    run: ../tools/expressions/files_to_folder.cwl
    in:
      files: 
        source: [compress_carveme/outfile]
        linkMerge: merge_flattened
      destination: 
        valueFrom: "CarveMe_GEMs"
    out:
      [results]
#############################################
#### Move to folder if not part of a workflow
  prodigal_files_to_folder:
    doc: Preparation of workflow output files to a specific output folder
    label: Prodigal proteins to folder
    run: ../tools/expressions/files_to_folder.cwl
    in:
      files: 
        source: [compress_prodigal/outfile]
        linkMerge: merge_flattened
      destination: 
        valueFrom: "Prodigal_proteins"
    out:
      [results]
#############################################
#### Move to folder if not part of a workflow
  memote_files_to_folder:
    doc: Preparation of workflow output files to a specific output folder
    label: MEMOTE output
    run: ../tools/expressions/files_to_folder.cwl
    in:
      files: 
        source: [memote_report_snapshot/report_html, memote_run/run_json, memote_report_snapshot_base/report_html, memote_run_base/run_json]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
        valueFrom: "MEMOTE"
    out:
      [results]

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:Changlin.ke@wur.nl
    s:name: Changlin Ke

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2020-00-00"
s:dateModified: "2023-03-03"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/