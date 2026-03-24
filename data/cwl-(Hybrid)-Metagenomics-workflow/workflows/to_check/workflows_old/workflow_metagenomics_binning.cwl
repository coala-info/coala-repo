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
    - SemiBin (binning)
    - DAS Tool (bin merging)
    - EukRep (eukaryotic classification)
    - CheckM (bin completeness and contamination)
    - BUSCO (bin completeness)
    - GTDB-Tk (bin taxonomic classification)

  Other UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>
  
  **All tool CWL files and other workflows can be found here:**<br>
    Tools: https://gitlab.com/m-unlock/cwl<br>
    Workflows: https://gitlab.com/m-unlock/cwl/workflows<br>

  **How to setup and use an UNLOCK workflow:**<br>
  https://m-unlock.gitlab.io/docs/setup/setup.html<br>

outputs:
  bins:
    label: Bin files
    doc: Bins files in fasta format. To be be used in other workflows.
    type: File[]?
    outputSource: output_bin_files/bins_out
  metabat2_output:
    label: MetaBAT2
    doc: MetaBAT2 output directory
    type: Directory
    outputSource: metabat2_files_to_folder/results
  maxbin2_output:
    label: MaxBin2
    doc: MaxBin2 output directory
    type: Directory
    outputSource: maxbin2_files_to_folder/results
  semibin_output:
    label: SemiBin
    doc: MaxBin2 output directory
    type: Directory?
    outputSource: semibin_files_to_folder/results
  das_tool_output:
    label: DAS Tool
    doc: DAS Tool output directory
    type: Directory
    outputSource: das_tool_files_to_folder/results
  checkm_output:
    label: CheckM
    doc: CheckM output directory
    type: Directory
    outputSource: checkm_files_to_folder/results
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
    type: int?
    doc: Number of threads to use for computational processes
    label: Threads
    default: 2
  memory:
    type: int?
    doc: Maximum memory usage in megabytes
    label: memory usage (MB)
    default: 4000

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

  run_semibin:
    type: boolean?
    doc: Run with SemiBin binner
    label: Run SemiBin
    default: true
  # semibin_reference_database:
  #   type: Directory?
  #   doc: Reference database data directory (MMseqs2 GTDB)
  #   label: SemiBin reference database
  #   loadListing: no_listing
  semibin_environment:
    type: string?
    doc: Semibin Built-in models (human_gut/dog_gut/ocean/soil/cat_gut/human_oral/mouse_gut/pig_gut/built_environment/wastewater/global/chicken_caecum)
    label: SemiBin Environment
    default: global
  sub_workflow:
    type: boolean
    label: Sub workflow Run
    doc: Use this when you need the output bins as File[] for subsequent analysis workflow steps in another workflow.
    default: false
  step:
    type: int?
    label: CWL base step number
    doc: Step number for order of steps
    default: 1
  destination:
    type: string?
    label: Output destination (not used in the workflow itself)
    doc: Optional output destination path for cwl-prov reporting.

steps:
#############################################
#### Contig depths file retrieval
  metabat2_contig_depths:
    label: contig depths 
    doc: MetabatContigDepths to obtain the depth file used in the MetaBat2 and SemiBin binning process
    run: ../metabat2/metabatContigDepths.cwl
    in:
      identifier: identifier
      bamFile: bam_file
    out: [depths]
#############################################
#### EukRep, eukaryotic sequence classification
  eukrep:
    doc: EukRep, eukaryotic sequence classification
    label: EukRep
    run: ../eukrep/eukrep.cwl
    in:
      identifier: identifier
      assembly: assembly
    out: [euk_fasta_out]

  eukrep_stats:
    doc: EukRep fasta statistics
    label: EukRep stats
    run: ../stats/raw_n50.cwl
    in:
      tmp_id: identifier
      identifier:
        valueFrom: $(inputs.tmp_id)_EukRep
      input_fasta: eukrep/euk_fasta_out
    out: [output]
#############################################
#### Assembly binning using metabat2
  metabat2:
    doc: Binning procedure using MetaBAT2
    label: MetaBAT2 binning
    run: ../metabat2/metabat2.cwl
    in:
      identifier: identifier
      threads: threads
      assembly: assembly
      depths: metabat2_contig_depths/depths
    out: [bin_dir, log]

  metabat2_filter_bins:
    doc: Only keep genome bin fasta files (exlude e.g TooShort.fa)
    label: Keep MetaBAT2 genome bins
    run: ../expressions/folder_file_regex.cwl
    in:
      folder: metabat2/bin_dir
      regex:
        valueFrom: "bin\\.[0-9]+\\.fa"
      output_folder_name:
        valueFrom: "MetaBAT2_bins"      
    out: [output_folder]

  metabat2_contig2bin:
    label: MetaBAT2 to contig to bins
    doc: List the contigs and their corresponding bin.
    run: ../das_tool/fasta_to_contig2bin.cwl
    in:
      bin_folder: metabat2_filter_bins/output_folder
      binner_name:
        valueFrom: "MetaBAT2"
      extension:
        valueFrom: "fa"
    out: [table]
#############################################
#### Assembly binning using MaxBin2
  maxbin2:
    doc: Binning procedure using MaxBin2
    label: MaxBin2 binning
    run: ../maxbin2/maxbin2.cwl
    in:
      identifier: identifier
      threads: threads
      contigs: assembly
      abundances: metabat2_contig_depths/depths
    out: [bins, summary, log]

  maxbin2_to_folder:
    doc: Create folder with MaxBin2 bins
    label: MaxBin2 bins to folder
    run: ../expressions/files_to_folder.cwl
    in:
      files: maxbin2/bins
      destination: 
        valueFrom: "MaxBin2_bins"
    out: [results]

  maxbin2_contig2bin:
    label: MaxBin2 to contig to bins
    doc: List the contigs and their corresponding bin.
    run: ../das_tool/fasta_to_contig2bin.cwl
    in:
      bin_folder: maxbin2_to_folder/results
      binner_name:
        valueFrom: "MaxBin2"
    out: [table]
#############################################
#### Assembly binning using Semibin
  semibin:
    doc: Binning procedure using SemiBin
    label: Semibin binning
    run: ../semibin/semibin_single_easy_bin.cwl
    when: $(inputs.run_semibin)
    in:
      run_semibin: run_semibin
      identifier: identifier
      threads: threads
      assembly: assembly
      # bam_file: bam_file
      metabat2_depth_file: metabat2_contig_depths/depths
      environment: semibin_environment
      # reference_database: semibin_reference_database
      # abundances: metabat2_contig_depths/depths
    out: [recluster_bins, data, data_split, model, coverage]

  semibin_contig2bin:
    label: SemiBin to contig to bins
    doc: List the contigs and their corresponding bin.
    run: ../das_tool/fasta_to_contig2bin.cwl
    when: $(inputs.run_semibin)
    in:
      run_semibin: run_semibin
      bin_folder: semibin/recluster_bins
      binner_name:
        valueFrom: "SemiBin"
      extension:
        valueFrom: "fa"
    out: [table]
#############################################
#### DAStool 
  das_tool:
    doc: DAS Tool
    label: DAS Tool integrate predictions from multiple binning tools
    run: ../das_tool/das_tool.cwl
    in:
      run_semibin: run_semibin
      identifier: identifier
      threads: threads
      assembly: assembly
      bin_tables:
        source: [metabat2_contig2bin/table, maxbin2_contig2bin/table, semibin_contig2bin/table]
        linkMerge: merge_flattened
        pickValue: all_non_null
      binner_labels:
        valueFrom: |
          ${
            if (inputs.run_semibin) {
              return "MetaBAT2,MaxBin2,SemiBin";
            } else {
              return "MetaBAT2,MaxBin2";
            }
          }
    out: [bin_dir, summary, contig2bin, log]

  das_tool_bins:
    doc: DAS Tool bins folder to File array for further analysis
    label: Bin dir to files[]
    run: ../expressions/folder_to_files.cwl
    in:
      folder: das_tool/bin_dir
    out: [files]

  remove_unbinned:
    doc: Remove unbinned fasta from bin directory. So analysed by subsequent tools. 
    label: Remove unbinned
    run:
      class: ExpressionTool
      requirements:
        InlineJavascriptRequirement: {}
      hints:
        LoadListingRequirement:
          loadListing: shallow_listing
      inputs:
        bins: Directory
      outputs:
        bins_dir: Directory
      expression: |
        ${  
          var regex = new RegExp('.*unbinned.*');
          var array = [];
          for (var i = 0; i < inputs.bins.listing.length; i++) {
            if (!regex.test(inputs.bins.listing[i].location)){
              array = array.concat(inputs.bins.listing[i]);
            }
          }
          var r = {
            'bins_dir':
              { "class": "Directory",
                "basename": "DAS_Tool_genome_bins",
                "listing": array
              }
            };
          return r;
        }
    in:
      bins:
        source: das_tool/bin_dir
    out: 
      [bins_dir]

#############################################
#### CheckM bin quality assessment
  checkm:
    doc: CheckM bin quality assessment
    label: CheckM
    run: ../checkm/checkm_lineagewf.cwl
    in:
      identifier: identifier
      threads: threads
      bin_dir: remove_unbinned/bins_dir
    out: [checkm_out_table, checkm_out_folder]

#############################################
#### BUSCO bin quality assessment
  busco:
    doc: BUSCO assembly completeness workflow
    label: BUSCO
    run: ../busco/busco.cwl
    when: $(inputs.bins.length !== 0)
    in:
      bins: das_tool_bins/files
      identifier: identifier
      sequence_folder: remove_unbinned/bins_dir
      mode:
        valueFrom: "geno"
      threads: threads
      busco_data: busco_data
      auto-lineage-prok:
        valueFrom: $(true)
    out: [batch_summary]

#############################################
#### GTDB-Tk Taxomic assigment of bins with
  gtdbtk:
    doc: Taxomic assigment of bins with GTDB-Tk
    label: GTDBTK
    when: $(inputs.gtdbtk_data !== null && inputs.bins.length !== 0)
    run: ../gtdbtk/gtdbtk_classify_wf.cwl
    in:
      bins: das_tool_bins/files
      gtdbtk_data: gtdbtk_data
      identifier: identifier
      threads: threads
      bin_dir: remove_unbinned/bins_dir
    out: [gtdbtk_summary, gtdbtk_out_folder]
  compress_gtdbtk:
    doc: Compress GTDB-Tk output folder
    label: Compress GTDB-Tk
    when: $(inputs.gtdbtk_data !== null)
    run: ../bash/compress_directory.cwl
    in:
      gtdbtk_data: gtdbtk_data
      indir: gtdbtk/gtdbtk_out_folder
    out: [outfile]

#############################################
#### Aggregate bin depths
  aggregate_bin_depths:
    doc: Depths per bin
    label: Depths per bin
    run: ../metabat2/aggregateBinDepths.cwl
    in:
      identifier: identifier
      metabatdepthsFile: metabat2_contig_depths/depths
      bins: das_tool_bins/files
    out: [binDepths]
#############################################
#### Bin assembly statistics
  bins_summary:
    doc: Table of all bins and their statistics like size, contigs, completeness etc
    label: Bins summary
    run: ../metagenomics/bins_summary.cwl
    in:
      identifier: identifier
      bin_dir: das_tool/bin_dir
      bin_depths: aggregate_bin_depths/binDepths
      checkm: checkm/checkm_out_table
      gtdbtk: gtdbtk/gtdbtk_summary
      busco_batch: busco/batch_summary
    out: [bins_summary_table]
############################################
### General bin and assembly read mapping stats
  bin_readstats:
    doc: Table general bin and assembly read mapping stats
    label: Bin and assembly read stats
    run: ../metagenomics/assembly_bins_readstats.cwl
    in:
      identifier: identifier
      binContigs: das_tool/contig2bin
      bam_file: bam_file
      assembly: assembly
    out: [binReadStats]

#############################################

# OUTPUT FOLDER PREPARATION #

#############################################
#### MetaBAT2 output folder
  metabat2_files_to_folder:
    doc: Preparation of MetaBAT2 output files + unbinned contigs to a specific output folder
    label: MetaBAT2 output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [metabat2/log, metabat2_contig_depths/depths, metabat2_contig2bin/table]
        linkMerge: merge_flattened
      folders:
        source: [metabat2/bin_dir]
        linkMerge: merge_flattened
      destination:
        valueFrom: "Binner_MetaBAT2"
    out:
      [results]
#############################################
#### MaxBin2 output folder
  maxbin2_files_to_folder:
    doc: Preparation of maxbin2 output files to a specific output folder.
    label: MaxBin2 output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [maxbin2/summary, maxbin2/log, maxbin2_contig2bin/table]
        linkMerge: merge_flattened
      folders:
        source: [maxbin2_to_folder/results]
        linkMerge: merge_flattened
      destination:
        valueFrom: "Binner_MaxBin2"
    out:
      [results]
#############################################
#### SemiBin output folder
  semibin_files_to_folder:
    doc: Preparation of SemiBin output files to a specific output folder.
    label: SemiBin output folder
    run: ../expressions/files_to_folder.cwl
    when: $(inputs.run_semibin)
    in:
      run_semibin: run_semibin
      files:
        source: [semibin_contig2bin/table, semibin/data, semibin/data_split, semibin/model, semibin/coverage]
        linkMerge: merge_flattened
        pickValue: all_non_null
      folders:
        source: [semibin/recluster_bins]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        valueFrom: "Binner_SemiBin"
    out:
      [results]
#############################################
#### DAS Tool output folder
  das_tool_files_to_folder:
    doc: Preparation of DAS Tool output files to a specific output folder.
    label: DAS Tool output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [das_tool/log, das_tool/summary, das_tool/contig2bin, aggregate_bin_depths/binDepths]
        linkMerge: merge_flattened
      folders:
        source: [das_tool/bin_dir]
        linkMerge: merge_flattened
      destination:
        valueFrom: "Bin_Refinement_DAS_Tool"
    out:
      [results]
#############################################
#### CheckM output folder
  checkm_files_to_folder:
    doc: Preparation of CheckM output files to a specific output folder
    label: CheckM output
    run: ../expressions/files_to_folder.cwl
    in:
      files: 
        source: [checkm/checkm_out_table]
        linkMerge: merge_flattened
      folders:
        source: [checkm/checkm_out_folder]
        linkMerge: merge_flattened
      destination: 
        valueFrom: "CheckM_Bin_Quality"
    out:
      [results]
############################################
### BUSCO output folder
  busco_files_to_folder:
    doc: Preparation of BUSCO output files to a specific output folder
    label: BUSCO output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [busco/batch_summary]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
        valueFrom: "BUSCO_Bin_Completeness"
    out:
      [results]
#############################################
#### GTDB-Tk output folder
  gtdbtk_files_to_folder:
    doc: Preparation of GTDB-Tk output files to a specific output folder
    label: GTBD-Tk output folder
    when: $(inputs.gtdbtk_data !== null)
    run: ../expressions/files_to_folder.cwl
    in:
      gtdbtk_data: gtdbtk_data
      files:
        source: [gtdbtk/gtdbtk_summary, compress_gtdbtk/outfile]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
        valueFrom: "GTDB-Tk_Bin_Taxonomy"
    out:
      [results]
#############################################
#### Bins File[] preparation for final output
  output_bin_files:
    doc: Bin files for subsequent workflow runs when sub_worflow = true
    label: Bin files
    when: $(inputs.sub_workflow)
    run:
      class: ExpressionTool
      requirements:
        InlineJavascriptRequirement: {}
      inputs:
        bins: File[]
      outputs:
        bins_out: File[]
      expression: ${ return inputs.bins; }
    in:
      sub_workflow: sub_workflow
      bins:
        source: das_tool_bins/files
    out: 
      [bins_out]

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2022-00-00"
s:dateModified: "2023-01-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
