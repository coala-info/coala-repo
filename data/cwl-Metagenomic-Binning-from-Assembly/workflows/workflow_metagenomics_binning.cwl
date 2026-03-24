#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: Metagenomic Binning from Assembly
doc: |
  Workflow for Metagenomics binning from assembly.<br>

  Minimal inputs are: Identifier, assembly (fasta) and a associated sorted BAM file

  Summary
    - MetaBAT2 (binning)
    - MaxBin2 (binning)
    - SemiBin2 (binning)
    - BinSPreader (bin refinement)
    - DAS Tool (bin merging)
    - binette (bin merging) In Development
    - EukRep (eukaryotic classification)
    - CheckM (bin completeness and contamination)
    - BUSCO (bin completeness)
    - GTDB-Tk (bin taxonomic classification)

  Other UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>
  
  **All tool CWL files and other workflows can be found here:**<br>
    Tools: https://gitlab.com/m-unlock/cwl<br>
    Workflows: https://gitlab.com/m-unlock/cwl/workflows<br>

  **How to setup and use an UNLOCK workflow:**<br>
  https://docs.m-unlock.nl/docs/workflows/setup.html<br>

outputs:
  # proteins:
  #   type: File[]
  #   outputSource: extract_proteins/out_file
  bins:
    label: Bin files
    doc: Bins files in fasta format. To be be used in other workflows.
    type: File[]?
    outputSource: binette_bins/files
  metabat2_output:
    label: MetaBAT2
    doc: MetaBAT2 output directory
    type: Directory
    outputSource: metabat2_files_to_folder/results
  maxbin2_output:
    label: MaxBin2
    doc: MaxBin2 output directoryß
    type: Directory
    outputSource: maxbin2_files_to_folder/results
  semibin_output:
    label: SemiBin
    doc: MaxBin2 output directory
    type: Directory?
    outputSource: semibin_files_to_folder/results
  binette_output:
    label: DAS Tool
    doc: DAS Tool output directory
    type: Directory
    outputSource: binette_files_to_folder/results
  busco_output:
    label: BUSCO
    doc: BUSCO output directory
    type: Directory
    outputSource: busco_files_to_folder/results
  gtdbtk_output:
    label: GTDB-Tk
    doc: GTDB-Tk output directory
    type: Directory?
    outputSource: gtdbtk_files_to_folder/results
  annotation_output:
    label: Annotation
    doc: Bin annotation
    type: Directory?
    outputSource: annotation_files_to_folder_bins/results
  bins_summary_table:
    label: Bins summary
    doc: Summary of info about the bins
    type: File
    outputSource: bins_summary/bins_summary_table
  bins_read_stats:
    label: Assembly/Bin read stats
    doc: General assembly and bin coverage
    type: File
    outputSource: bin_readstats/binReadStats    
  binned_contigs:
    label: Binned contigs
    doc: File with contig to bin assignment
    type: File
    outputSource: bins_summary/bin_contigs
  eukrep_fasta:
    label: EukRep fasta
    doc: EukRep eukaryotic classified contigs
    type: File
    outputSource: eukrep/euk_fasta_out
  eukrep_stats_file:
    label: EukRep stats
    doc: EukRep fasta statistics
    type: File
    outputSource: eukrep_stats/output

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: Identifier used
  assembly:
    type: File
    doc: Assembly in fasta format
    label: Assembly fasta
    loadListing: no_listing
  bam_file:
    type: File
    doc: Mapping file in sorted bam format containing reads mapped to the assembly
    label: Bam file
    loadListing: no_listing
  threads:
    type: int
    doc: Number of threads to use for computational processes
    label: Threads
    default: 2

  min_completeness:
    type: int
    doc: Minimum completeness for Binette bin refinement. Default 40
    label: Minimum completeness
    default: 40
  contamination_weight:
    type: float
    doc: Score metric used in Binette bin refinement. Bin are scored as follow; completeness - weight * contamination. A low contamination_weight favor complete bins over low contaminated bins. Default 2.0
    label: Contamination weight
    default: 2.0

  gtdbtk_data:
    type: Directory?
    doc: Directory containing the GTDB database. When none is given GTDB-Tk will be skipped.
    label: gtdbtk data directory
    loadListing: no_listing
  busco_data:
    type: Directory?
    label: BUSCO dataset
    doc: Directory containing the BUSCO dataset location.
    loadListing: no_listing

  bakta_db:
    type: Directory?
    label: Bakta DB
    doc: Bakta Database directory (required when annotating bins)
  skip_bakta_crispr:
    type: boolean
    label: Skip CRISPR
    doc: Skip CRISPR array prediction using PILER-CR
    default: false

  interproscan_directory:
    type: Directory?
    label: InterProScan 5 directory
    doc: Directory of the (full) InterProScan 5 program. Used for annotating bins. (required when running with interproscan)
    loadListing: no_listing
  eggnog_dbs:
    type:
      - 'null'
      - type: record
        name: eggnog_dbs
        fields:
          data_dir:
            type: Directory?
            doc: Directory containing all data files for the eggNOG database.
            loadListing: no_listing
          db:
            type: File?
            doc: eggNOG database file
            loadListing: no_listing
          diamond_db:
            type: File?
            doc: eggNOG database file for diamond blast search
            loadListing: no_listing
  run_kofamscan:
    type: boolean
    label: Run kofamscan
    doc: Run with KEGG KO KoFamKOALA annotation. Default false
    default: false
  kofamscan_limit_sapp:
    type: int?
    label: SAPP kofamscan limit
    doc: Limit max number of entries of kofamscan hits per locus in SAPP. Default 5
    default: 5
  run_eggnog:
    type: boolean
    label: Run eggNOG-mapper
    doc: Run with eggNOG-mapper annotation. Requires eggnog database files. Default false
    default: false
  run_interproscan:
    type: boolean
    label: Run InterProScan
    doc: Run with eggNOG-mapper annotation. Requires InterProScan v5 program files. Default false
    default: false
  interproscan_applications:
    type: string
    label: InterProScan applications
    doc: |
          Comma separated list of analyses:
          FunFam,SFLD,PANTHER,Gene3D,Hamap,PRINTS,ProSiteProfiles,Coils,SUPERFAMILY,SMART,CDD,PIRSR,ProSitePatterns,AntiFam,Pfam,MobiDBLite,PIRSF,NCBIfam
          default Pfam,SFLD,SMART,AntiFam,NCBIfam
    default: 'Pfam'
  
  run_maxbin2:
    type: boolean
    doc: Run with MaxBin2 binner. Default true
    label: Run Maxbin2
    default: true

  run_semibin2:
    type: boolean
    doc: Run with SemiBin2 binner. Default true
    label: Run SemiBin
    default: true
  semibin2_environment:
    doc: |
          Semibin2 Built-in models (none/global/human_gut/dog_gut/ocean/soil/cat_gut/human_oral/mouse_gut/pig_gut/built_environment/wastewater/chicken_caecum). 
          Choosing a built-in model is generally faster. Otherwise it will do (single-sample) training on the data.
          Default global
    label: SemiBin Environment
    type:
      - type: enum
        symbols:
        - none
        - global
        - human_gut
        - dog_gut
        - ocean
        - soil
        - cat_gut
        - human_oral
        - mouse_gut
        - pig_gut
        - built_environment
        - wastewater
        - chicken_caecum
    default: global

  # bin refiner
  # run_binspreader:
  #   type: boolean?
  #   doc: Whether to use BinSPreader for bin refinement
  #   default: false
  assembly_graph:
    type: File?
    doc: Assembly graph file from asssembler for BinSPreader
    label: BinSPreader graph file

  run_busco:
    type: boolean
    doc: Run with BUSCO bin completeness assessment. Default false
    label: Run BUSCO
    default: false

  annotate_bins:
    type: boolean
    label: Annotate bins
    doc: Annotate bins. Default false
    default: false
  annotate_unbinned:
    type: boolean
    label: Annotate unbinned
    doc: Annotate unbinned contigs. Will be treated as metagenome. Default false
    default: false
  
  destination:
    type: string?
    label: Output destination
    doc: Optional output destination path for cwl-prov reporting. (not used in the workflow itself)

steps:
#############################################
#### Contig depths file retrieval
  metabat2_contig_depths:
    label: contig depths 
    doc: MetabatContigDepths to obtain the depth file used in the MetaBat2 and SemiBin2 binning process
    run: ../tools/metabat2/metabatContigDepths.cwl
    in:
      identifier: identifier
      bamFile: bam_file
    out: [depths]
#############################################
#### EukRep, eukaryotic sequence classification
  eukrep:
    doc: EukRep, eukaryotic sequence classification
    label: EukRep
    run: ../tools/eukrep/eukrep.cwl
    in:
      identifier: identifier
      assembly: assembly
    out: [euk_fasta_out]

  eukrep_stats:
    doc: EukRep fasta statistics
    label: EukRep stats
    run: ../tools/stats/raw_n50.cwl
    in:
      identifier:
        source: identifier
        valueFrom: $(self)_eukrep
      input_fasta: eukrep/euk_fasta_out
    out: [output]
#############################################
#### Assembly binning using metabat2
  metabat2:
    doc: Binning procedure using MetaBAT2
    label: MetaBAT2 binning
    run: ../tools/metabat2/metabat2.cwl
    in:
      identifier: identifier
      threads: threads

      assembly: assembly
      depths: metabat2_contig_depths/depths
    out: [bin_dir, log]

  metabat2_filter_bins:
    doc: Only keep genome bin fasta files (exlude e.g TooShort.fa)
    label: Keep MetaBAT2 genome bins
    run: ../tools/expressions/folder_file_regex.cwl
    in:
      folder: metabat2/bin_dir
      output_as_folder:
        default: true
      regex:
        valueFrom: "bin\\.[0-9]+\\.fa"
      output_folder_name:
        valueFrom: "metabat2_bins"  
    out: [output_folder]

#############################################
#### Assembly binning using MaxBin2
  maxbin2:
    doc: Binning procedure using MaxBin2
    label: MaxBin2 binning
    when: $(inputs.run_maxbin2)
    run: ../tools/maxbin2/maxbin2.cwl
    in:
      run_maxbin2: run_maxbin2
      identifier: identifier
      threads: threads
      contigs: assembly
      abundances: metabat2_contig_depths/depths
    out: [bins, summary, log]

  maxbin2_to_folder:
    doc: Create folder with MaxBin2 bins
    label: MaxBin2 bins to folder
    when: $(inputs.run_maxbin2)
    run: ../tools/expressions/files_to_folder.cwl
    in:
      run_maxbin2: run_maxbin2
      files: maxbin2/bins
      destination: 
        valueFrom: "maxbin2_bins"
    out: [results]

#############################################
#### Semibin2
  semibin2:
    doc: Binning procedure using SemiBin2
    label: Semibin2 binning
    run: ../tools/semibin/semibin2_single_easy_bin.cwl
    when: $(inputs.run_semibin2)
    in:
      run_semibin2: run_semibin2
      identifier:
        source: identifier
        valueFrom: $(self)_SemiBin2
      threads: threads
      assembly: assembly

      # When environment is none, do self-training and do not use the metabat2 depth file and use bam file
      environment:
        source: semibin2_environment
        valueFrom: | 
          ${ return self !== "none" ? self : null; }
      metabat2_depth_file:
        source: metabat2_contig_depths/depths
        valueFrom: |
          ${ return inputs.environment !== "none" ? self : null; }
      bam_file:
        source: bam_file
        valueFrom: |
          ${ return inputs.environment === "none" ? self : null; }

    out: [output_bins, data, data_split, model, coverage]

#############################################
#### Binette bin refinement
  binette:
    doc: Binning refinement using Binette
    label: Binette
    run: ../tools/binette/binette.cwl
    in:
      # identifier: identifier
      threads: threads
      contigs: assembly
      min_completeness: min_completeness
      contamination_weight: contamination_weight
      bins_dirs: 
        source: [metabat2_filter_bins/output_folder, maxbin2_to_folder/results, semibin2/output_bins]
        linkMerge: merge_flattened
        pickValue: all_non_null
      verbose:
        default: true
    out: [final_bins, final_bins_quality_report, input_bins_quality_reports]
  binette_bins:
    doc: Binette bins folder to File array for further analysis
    label: Bin folder to files[]
    run: ../tools/expressions/folder_to_files.cwl
    in:
      folder: binette/final_bins
    out: [files]

#############################################
#### BUSCO bin quality assessment
  busco:
    doc: BUSCO assembly completeness workflow
    label: BUSCO
    run: ../tools/busco/busco.cwl
    when: $(inputs.bins.length !== 0 && inputs.run_busco)
    in:
      run_busco: run_busco
      bins: binette_bins/files
      identifier: identifier
      sequence_folder: binette/final_bins
      mode:
        valueFrom: "geno"
      threads: threads
      busco_data: busco_data
      auto-lineage-prok:
        valueFrom: $(true)
    out: [batch_summary]

#############################################
#### GTDB-Tk Taxonomic assigment of bins
  gtdbtk:
    doc: Taxonomic assigment of bins with GTDB-Tk
    label: GTDBTK
    when: $(inputs.gtdbtk_data !== null && inputs.bins.length !== 0)
    run: ../tools/gtdbtk/gtdbtk_classify_wf.cwl
    in:
      bins: binette_bins/files
      gtdbtk_data: gtdbtk_data
      identifier: identifier
      threads: threads
      bin_dir: binette/final_bins
    out: [gtdbtk_summary, gtdbtk_out_folder]
  compress_gtdbtk:
    doc: Compress GTDB-Tk output folder
    label: Compress GTDB-Tk
    when: $(inputs.gtdbtk_data !== null)
    run: ../tools/bash/compress_directory.cwl
    in:
      gtdbtk_data: gtdbtk_data
      indir: gtdbtk/gtdbtk_out_folder
    out: [outfile]
  
##############################################
#### Extract unbinned contigs and move to bin folder
  get_unbinned_contigs:
    doc: Extract unbinned contigs
    label: Extract unbinned contigs from assembly and bins
    when: $(inputs.bins.length !== 0)
    run: ../tools/metagenomics/get_unbinned_contigs.cwl
    in:
      bins: binette_bins/files

      identifier: 
        source: identifier
        valueFrom: $(self)_binette
      bin_dir: binette/final_bins
      assembly_fasta: assembly
      bin_extension:
        valueFrom: "fa"
    out: [unbinned_fasta]

#############################################
#### Get bin abundances with CoverM
  coverm:
    doc: CoverM to obtain bin coverages/abundances
    label: CoverM
    run: ../tools/coverm/coverm_genome.cwl
    when: $(inputs.genome_fasta_files.length !== 0)
    in:
      identifier: identifier
      genome_fasta_files: 
        source: [binette_bins/files, get_unbinned_contigs/unbinned_fasta]
        linkMerge: merge_flattened
        pickValue: all_non_null
      bam_files:
        source: [bam_file]
        linkMerge: merge_nested
    out: [coverm_tsv]
#############################################
#### Bin assembly statistics
  bins_summary:
    doc: Table of final bins and their statistics like size, contigs, completeness etc
    label: Bins summary
    run: ../tools/metagenomics/bins_summary.cwl
    in:
      identifier: identifier
      bin_files: 
        source: [binette_bins/files, get_unbinned_contigs/unbinned_fasta]
        linkMerge: merge_flattened
        pickValue: all_non_null
      binette_report: binette/final_bins_quality_report
      coverm: coverm/coverm_tsv
      gtdbtk_summary: gtdbtk/gtdbtk_summary
      busco_batch: busco/batch_summary
    out: [bins_summary_table, bin_contigs]
############################################
### General bin and assembly read mapping stats
  bin_readstats:
    doc: Table general bin and assembly read mapping stats
    label: Bin and assembly read stats
    run: ../tools/metagenomics/assembly_bins_readstats.cwl
    in:
      identifier: identifier
      bin_dir: binette/final_bins
      bam_file: bam_file
    out: [binReadStats]

############################################
### Bin annotation workflow
  workflow_microbial_annotation_bins:
    doc: Microbial annotation workflow of the predicted bins
    label: Annotate bins
    when: $(inputs.annotate_bins) # && inputs.bakta_db !== null)
    run: workflow_microbial_annotation.cwl
    scatter: [genome_fasta]
    scatterMethod: dotproduct
    in:
      annotate_bins: annotate_bins
      genome_fasta: 
        source: binette_bins/files
        default: []
      bakta_db: bakta_db
      skip_bakta_crispr: skip_bakta_crispr
      interproscan_directory: interproscan_directory
      interproscan_applications: interproscan_applications
      eggnog_dbs: eggnog_dbs
      run_interproscan: run_interproscan
      run_eggnog: run_eggnog
      run_kofamscan: run_kofamscan
      kofamscan_limit_sapp: kofamscan_limit_sapp
     
      sapp_conversion:
        default: true
      threads: threads
      compress_output:
        default: true
    out: [bakta_folder_compressed, compressed_other_files, sapp_hdt_file]

  workflow_microbial_annotation_unbinned:
    doc: Microbial annotation workflow of the predicted bins
    label: Annotate bins
    when: $(inputs.annotate_unbinned && inputs.genome_fasta !== null)
    run: workflow_microbial_annotation.cwl
    in:
      annotate_unbinned: annotate_unbinned
      genome_fasta: get_unbinned_contigs/unbinned_fasta
      bakta_db: bakta_db
      skip_bakta_crispr: skip_bakta_crispr
      interproscan_directory: interproscan_directory
      interproscan_applications: interproscan_applications
      eggnog_dbs: eggnog_dbs
      run_interproscan: run_interproscan
      run_eggnog: run_eggnog
      run_kofamscan: run_kofamscan
      kofamscan_limit_sapp: kofamscan_limit_sapp
      metagenome:
        default: true
      skip_bakta_plot:
        default: true
      sapp_conversion:
        default: true
      threads: threads
      compress_output:
        default: true
    out: [bakta_folder_compressed, compressed_other_files, sapp_hdt_file]

  # extract_proteins:
  #   doc: Extract protein fasta from bakta directories. For analyis by subsequent tools. 
  #   label: Extract proteins
  #   when: $(inputs.annotate_bins || inputs.annotate_unbinned)
  #   run: ../tools/expressions/file_from_folder_regex.cwl
  #   scatter: [folder]
  #   scatterMethod: dotproduct
  #   in:
  #     folder: workflow_microbial_annotation_bins/bakta_folder
  #     regex:
  #       valueFrom: ".*.faa"
  #     output_file_name:
  #       source: identifier
  #       valueFrom: $(self)_unbinned.fasta
  #   out: [out_file]

#############################################

# OUTPUT FOLDER PREPARATION #

#############################################
#### MetaBAT2 output folder
  metabat2_files_to_folder:
    doc: Preparation of MetaBAT2 output files + unbinned contigs to a specific output folder
    label: MetaBAT2 output folder
    run: ../tools/expressions/files_to_folder.cwl
    in:
      files:
        source: [metabat2/log, metabat2_contig_depths/depths]
        linkMerge: merge_flattened
      folders:
        source: [metabat2/bin_dir]
        linkMerge: merge_flattened
      destination:
        valueFrom: "binner_metabat2"
    out:
      [results]

#############################################
#### MaxBin2 output folder
  maxbin2_files_to_folder:
    doc: Preparation of maxbin2 output files to a specific output folder.
    label: MaxBin2 output folder
    when: $(inputs.run_maxbin2)
    run: ../tools/expressions/files_to_folder.cwl
    in:
      run_maxbin2: run_maxbin2
      files:
        source: [maxbin2/summary, maxbin2/log]
        linkMerge: merge_flattened
      folders:
        source: [maxbin2_to_folder/results]
        linkMerge: merge_flattened
      destination:
        valueFrom: "binner_maxbin2"
    out:
      [results]
#############################################
#### SemiBin2 output folder
  semibin_files_to_folder:
    doc: Preparation of SemiBin output files to a specific output folder.
    label: SemiBin output folder
    run: ../tools/expressions/files_to_folder.cwl
    when: $(inputs.run_semibin2)
    in:
      run_semibin2: run_semibin2
      files:
        source: [semibin2/data, semibin2/data_split, semibin2/model, semibin2/coverage]
        linkMerge: merge_flattened
        pickValue: all_non_null
      folders:
        source: [semibin2/output_bins]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        valueFrom: "binner_semibin2"
    out:
      [results]
#############################################
#### Binette output folder
  binette_files_to_folder:
    doc: Preparation of DAS Tool output files to a specific output folder.
    label: DAS Tool output folder
    run: ../tools/expressions/files_to_folder.cwl
    in:
      files:
        source: [binette/final_bins_quality_report, get_unbinned_contigs/unbinned_fasta]
        linkMerge: merge_flattened
      folders:
        source: [binette/final_bins, binette/input_bins_quality_reports]
        linkMerge: merge_flattened
      destination:
        valueFrom: "bin_refinement_binette"
    out:
      [results]
############################################
### BUSCO output folder
  busco_files_to_folder:
    doc: Preparation of BUSCO output files to a specific output folder
    label: BUSCO output folder
    when: $(inputs.run_busco)
    run: ../tools/expressions/files_to_folder.cwl
    in:
      run_busco: run_busco
      files:
        source: [busco/batch_summary]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
        valueFrom: "busco_bin_completeness"
    out:
      [results]
#############################################
#### GTDB-Tk output folder
  gtdbtk_files_to_folder:
    doc: Preparation of GTDB-Tk output files to a specific output folder
    label: GTBD-Tk output folder
    when: $(inputs.gtdbtk_data !== null)
    run: ../tools/expressions/files_to_folder.cwl
    in:
      gtdbtk_data: gtdbtk_data
      files:
        source: [gtdbtk/gtdbtk_summary, compress_gtdbtk/outfile]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
        valueFrom: "gtdb-tk_bin_classification"
    out:
      [results]
#############################################
#### Annotation output folder
  annotation_output_to_array_bins:
    when: $(inputs.annotate_bins)
    run: ../tools/expressions/merge_file_arrays.cwl
    in:
      annotate_bins: annotate_bins
      input: 
        source: [workflow_microbial_annotation_bins/compressed_other_files]
    out: 
      [output]
  annotation_files_to_folder_bins:
    doc: Preparation of annotation output files to a specific output folder
    label: Annotation output folder
    when: $((inputs.annotate_bins || inputs.annotate_unbinned))
    run: ../tools/expressions/files_to_folder.cwl
    in:
      annotate_bins: annotate_bins
      annotate_unbinned: annotate_unbinned
      folders: 
        source: [workflow_microbial_annotation_bins/bakta_folder_compressed, workflow_microbial_annotation_unbinned/bakta_folder_compressed]
        linkMerge: merge_flattened
        pickValue: all_non_null
      files:
        source: [workflow_microbial_annotation_unbinned/compressed_other_files, workflow_microbial_annotation_unbinned/sapp_hdt_file, workflow_microbial_annotation_bins/sapp_hdt_file, annotation_output_to_array_bins/output]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
        valueFrom: "bin_annotation"
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
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2025-05-02"
s:dateModified: "2025-09-05"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/