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
  Workflow for Metagenomics from raw reads to annotated bins.<br>
  Summary
    - MetaBAT2 (binning)
    - CheckM (bin completeness and contamination)
    - GTDB-Tk (bin taxonomic classification)
    - BUSCO (bin completeness)

  **All tool CWL files and other workflows can be found here:**<br>
    Tools: https://git.wur.nl/unlock/cwl/-/tree/master/cwl<br>
    Workflows: https://git.wur.nl/unlock/cwl/-/tree/master/cwl/workflows<br>

  The dependencies are either accessible from https://unlock-icat.irods.surfsara.nl (anonymous,anonymous)<br>
  and/or<br>
  By using the conda / pip environments as shown in https://git.wur.nl/unlock/docker/-/blob/master/kubernetes/scripts/setup.sh<br>

outputs:
  metabat2_output:
    label: MetaBAT2
    doc: MetaBAT2 output directory
    type: Directory
    outputSource: metabat_files_to_folder/results
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
  bins_summary:
    label: Bins summary
    doc: Summary of info about the bins
    type: File
    outputSource: bins_summary/bins_summary

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: Identifier used
  assembly:
    type: File
    doc: Assembly in fasta format
    label: Assembly fasta
  bam_file:
    type: File
    doc: Mapping file in sorted bam format containing reads mapped to the assembly
    label: Bam file
  threads:
    type: int?
    doc: Number of threads to use for computational processes
    label: number of threads
  memory:
    type: int?
    doc: Maximum memory usage in megabytes
    label: memory usage (mb)
  
  # TODO: There seem to be some issues with the --tmpdir-prefix option in cwltool and the gtdbtk tool.
  run_gtdbtk:
    type: boolean
    label: Run GTDB-Tk
    doc: Run GTDB-Tk taxonomic bin classification when true
  busco_dataset:
      type: string
      label: BUSCO dataset
      doc: Path to the BUSCO dataset download location
  step:
    type: int?
    label: CWL base step number
    doc: Step number for order of steps
  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

steps:
#############################################
#### Contig depths file retrieval for MetaBat2
  metabat2_contig_depths:
    label: contig depths 
    doc: MetabatContigDepths to obtain the depth file used in the MetaBat2 binning process
    run: ../metagenomics/metabat2/metabatContigDepths.cwl
    in:
      identifier: identifier
      bamFile: bam_file
    out: [depths]
#############################################
#### reports per contig alignment statistics
  contig_read_counts:
    label: samtools idxstats
    doc: Reports alignment summary statistics
    run: ../samtools/samtools_idxstats.cwl
    in:
      identifier: identifier
      bam_file: bam_file
      threads: threads
    out: [contigReadCounts]
#############################################
#### reports general alignment summary statistics
  assembly_read_counts:
    label: samtools flagstat
    doc: Reports alignment summary statistics
    run: ../samtools/samtools_flagstat.cwl
    in:
      identifier: identifier
      bam_file: bam_file
      threads: threads
    out: [flagstat]
#############################################
#### Assembly binning using metabat2
  metabat2:
    doc: Binning procedure using MetaBAT2
    label: MetaBAT2 binning
    run: ../metagenomics/metabat2/metabat2.cwl
    in:
      identifier: identifier
      threads: threads
      assembly: assembly
      depths: metabat2_contig_depths/depths
    out: [bin_dir, bins, log]
#############################################
#### Aggregate bin depths
  aggregate_bin_depths:
    doc: Depths per bin
    label: Depths per bin
    run: ../metagenomics/metabat2/aggregateBinDepths.cwl
    in:
      identifier: identifier
      metabatdepthsFile: metabat2_contig_depths/depths
      bins: metabat2/bins
    out: [binDepths]
#############################################
#### Bin assembly statistics
  bins_summary:
    doc: Table of all bins and their statistics like size, contigs, completeness etc
    label: Bins summary
    run: ../metagenomics/bins_summary.cwl
    in:
      identifier: identifier
      bin_dir: metabat2/bin_dir
      busco_dir: busco_files_to_folder/results 
      bin_depths: aggregate_bin_depths/binDepths
      checkm: checkm/checkm_out_table
    out: [bins_summary, bin_contigs]
#############################################
#### Get unbinned contigs fasta
  # workflow_getunbinned:
  #   doc: Get unbinned contigs fasta
  #   label: unbinned_contigs
  #   run: ../metagenomics/get_unbinned_contigs.cwl
  #   in:
  #     identifier: identifier
  #     threads: threads
  #     assembly_fasta: assembly
  #     bin_dir: workflow_metabat2/bin_dir
  #   out: [unbinned_fasta]
############################################
### General bin and assembly read mapping stats
  bin_readstats:
    doc: Table general bin and assembly read mapping stats
    label: Bin and assembly read stats
    run: ../metagenomics/assembly_bins_readstats.cwl
    in:
      identifier: identifier
      binContigs: bins_summary/bin_contigs
      idxstats: contig_read_counts/contigReadCounts
      flagstat: assembly_read_counts/flagstat
    out: [binReadStats]
#############################################
#### CheckM bin quality assessment
  checkm:
    doc: CheckM bin quality assessment
    label: CheckM
    run: ../metagenomics/checkm/checkm_lineagewf.cwl
    in:
      identifier: identifier
      threads: threads
      bin_dir: metabat2/bin_dir
    out: [checkm_out_table, checkm_out_folder]

#############################################
#### BUSCO bin quality assessment
  busco:
    doc: BUSCO assembly completeness workflow
    label: BUSCO
    run: ../busco/busco.cwl
    scatter: [sequence_file]
    # scatterMethod: dotproduct
    in:
      identifier:
        valueFrom: $(inputs.sequence_file.basename)
      sequence_file:
        source: metabat2/bins
        linkMerge: merge_flattened
        pickValue: all_non_null
      mode:
        valueFrom: "geno"
      threads: threads
      dataset: busco_dataset
      offline:
        valueFrom: $(true)
    out: [short_summaries]

  merge_busco_summaries:
    run: ../expressions/merge_file_arrays.cwl
    label: Merge BUSCO summaries
    in:
      input: 
        source: busco/short_summaries
        linkMerge: merge_flattened
        pickValue: all_non_null
    out: [output]

#############################################
#### Taxomic assigment of bins with GTDB-Tk
  gtdbtk:
    doc: Taxomic assigment of bins with GTDB-Tk
    label: GTDBTK
    when: $(inputs.run_gtdbtk)
    run: ../gtdbtk/gtdbtk_classify_wf.cwl
    in:
      run_gtdbtk: run_gtdbtk
      identifier: identifier
      threads: threads
      bin_dir: metabat2/bin_dir
    out: [gtdbtk_summary, gtdbtk_out_folder]
#############################################
#### Compress GTDB-Tk output folder
  compress_gtdbtk:
    doc: Compress GTDB-Tk output folder
    label: Compress GTDB-Tk
    when: $(inputs.run_gtdbtk)
    run: ../bash/compress_directory.cwl
    in:
      run_gtdbtk: run_gtdbtk
      indir: gtdbtk/gtdbtk_out_folder
    out: [outfile]
#############################################
  # bin annotation using SAPP
  # workflow_sapp:
  #   doc: Semantic Annotation Platform with Provenance to annotate each bin obtained from metabat2
  #   label: Semantic Annotation Platform with Provenance
  #   run: workflow_sapp.cwl
  #   scatter: [fasta]
  #   in:
  #     fasta: workflow_metabat/bins
  #     codon:
  #       valueFrom: ${ return 11; }
  #     identifier:
  #       valueFrom: ${ return inputs.fasta.nameroot; }
  #     single:
  #       default: true
  #     threads: threads
  #   out: [conversion, prodigal, interproscan]
#############################################
#### Move to folder if not part of a workflow
  metabat_files_to_folder:
    doc: Preparation of MetaBat2 output files + unbinned contigs to a specific output folder
    label: MetaBat2 output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [metabat2/log, bins_summary/bin_contigs ,bin_readstats/binReadStats, metabat2_contig_depths/depths, aggregate_bin_depths/binDepths]
        linkMerge: merge_flattened
      folders:
        source: [metabat2/bin_dir]
        linkMerge: merge_flattened
      step: step
      destination: 
        valueFrom: $(inputs.step)_MetaBAT2_Binning
    out:
      [results]
#############################################
#### Move to folder if not part of a workflow
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
      step: step
      destination: 
        valueFrom: |
          ${
            var step = inputs.step+1;
            return step+"_CheckM_binQuality";
          }
    out:
      [results]
############################################
### Move to folder if not part of a workflow
  busco_files_to_folder:
    doc: Preparation of BUSCO output files to a specific output folder
    label: BUSCO output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: merge_busco_summaries/output
        linkMerge: merge_flattened
        pickValue: all_non_null
      step: step
      destination: 
        valueFrom: |
          ${
            var step = inputs.step+2;
            return step+"_BUSCO";
          }
    out:
      [results]
#############################################
#### Move to folder if not part of a workflow
  gtdbtk_files_to_folder:
    doc: Preparation of GTDB-Tk output files to a specific output folder
    label: GTBD-Tk output folder
    when: $(inputs.run_gtdbtk)
    run: ../expressions/files_to_folder.cwl
    in:
      run_gtdbtk: run_gtdbtk
      files:
        source: [gtdbtk/gtdbtk_summary, compress_gtdbtk/outfile]
        linkMerge: merge_flattened
        pickValue: all_non_null
      step: step
      destination: 
        valueFrom: |
          ${
            var step = inputs.step+3;
            return step+"_GTDB-Tk_binTaxonomy";
          }
    out:
      [results]
#################################################
  #### Move to folder if not part of a workflow
  # sapp_files_to_folder:
  #   doc: Preparation of sapp output files to a specific output folder
  #   label: SAPP output
  #   run: ../expressions/files_to_folder.cwl
  #   in:
  #     files: 
  #       source: [workflow_sapp/conversion, workflow_sapp/prodigal , workflow_sapp/interproscan]
  #       linkMerge: merge_flattened
  #     destination: 
  #       valueFrom: $("8_SAPP")
  #   out:
  #     [results]
#############################################

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
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
