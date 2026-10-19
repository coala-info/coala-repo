cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribotish
  - predict
label: ribotish_predict
doc: "Predict translated ORFs and translation initiation sites (TIS) from ribosome profiling data.\n\nTool homepage: https://github.com/zhpn1024/ribotish"
inputs:
  - id: tis_bam_paths
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
      - .bai
    doc: "TIS enriched riboseq bam files (comma seperated on the command line)"
    inputBinding:
      position: 101
      prefix: '-t'
      itemSeparator: ','
  - id: ribo_bam_paths
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
      - .bai
    doc: "Ordinary riboseq bam files (comma seperated on the command line)"
    inputBinding:
      position: 101
      prefix: '-b'
      itemSeparator: ','
  - id: gene_path
    type: File
    doc: "Gene annotation file for ORF prediction"
    inputBinding:
      position: 101
      prefix: '-g'
  - id: genome_fasta_path
    type: File
    secondaryFiles:
      - .fai
    doc: "Genome fasta file"
    inputBinding:
      position: 101
      prefix: '-f'
  - id: input
    type:
      - 'null'
      - File
    doc: "Only test input candidate ORFs, format: transID start stop (0 based, half open)"
    inputBinding:
      position: 101
      prefix: '-i'
  - id: igenomepos
    type:
      - 'null'
      - boolean
    doc: "The start and end in -i input file are genome positions"
    inputBinding:
      position: 101
      prefix: '--igenomepos'
  - id: gene_format
    type:
      - 'null'
      - string
    doc: "Gene annotation file format (gtf, bed, gpd, gff, default: auto)"
    inputBinding:
      position: 101
      prefix: '--geneformat'
  - id: tis_para
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input offset parameter files for -t bam files (comma seperated)"
    inputBinding:
      position: 101
      prefix: '--tispara'
      itemSeparator: ','
  - id: ribo_para
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input offset parameter files for -b bam files (comma seperated)"
    inputBinding:
      position: 101
      prefix: '--ribopara'
      itemSeparator: ','
  - id: nparts
    type:
      - 'null'
      - int
    doc: "Group transcript according to TIS reads density quantile (default: 10)"
    inputBinding:
      position: 101
      prefix: '--nparts'
  - id: alternative_gene_path
    type:
      - 'null'
      - File
    doc: "Gene file for known protein coding gene annotation and TIS background estimation instead of -g gene file"
    inputBinding:
      position: 101
      prefix: '-a'
  - id: est_path
    type:
      - 'null'
      - string
    doc: "Output TIS background estimation result (default: tisBackground.txt)"
    inputBinding:
      position: 101
      prefix: '-e'
  - id: in_est_path
    type:
      - 'null'
      - File
    doc: "Input background estimation result file instead of instant estimation"
    inputBinding:
      position: 101
      prefix: '-s'
  - id: trans_profile
    type:
      - 'null'
      - string
    doc: "Output RPF P-site profile for each transcript"
    inputBinding:
      position: 101
      prefix: '--transprofile'
  - id: in_profile
    type:
      - 'null'
      - File
    doc: "Input RPF P-site profile for each transcript, instead of reading bam reads, save time for re-running"
    inputBinding:
      position: 101
      prefix: '--inprofile'
  - id: chr_map
    type:
      - 'null'
      - File
    doc: "Input chromosome id mapping table file if annotation chr ids are not same as chr ids in bam/fasta files"
    inputBinding:
      position: 101
      prefix: '--chrmap'
  - id: all_result
    type:
      - 'null'
      - string
    doc: "All result output without FDR q-value threshold (default: output + '_all.txt', 'off' to turn off)"
    inputBinding:
      position: 101
      prefix: '--allresult'
  - id: alt
    type:
      - 'null'
      - boolean
    doc: "Use alternative start codons (all codons with 1 base different from ATG)"
    inputBinding:
      position: 101
      prefix: '--alt'
  - id: altcodons
    type:
      - 'null'
      - string
    doc: "Use provided alternative start codons, comma seperated, eg. CTG,GTG,ACG"
    inputBinding:
      position: 101
      prefix: '--altcodons'
  - id: tis_to_ribo
    type:
      - 'null'
      - boolean
    doc: "Add TIS bam counts to ribo, if specified or -b not provided"
    inputBinding:
      position: 101
      prefix: '--tis2ribo'
  - id: harr
    type:
      - 'null'
      - boolean
    doc: "The data is treated with harringtonine (instead of LTM)"
    inputBinding:
      position: 101
      prefix: '--harr'
  - id: harr_width
    type:
      - 'null'
      - int
    doc: "Flanking region for harr data, in codons (default: 15)"
    inputBinding:
      position: 101
      prefix: '--harrwidth'
  - id: enrich_test
    type:
      - 'null'
      - boolean
    doc: "Use enrich test instead of frame test"
    inputBinding:
      position: 101
      prefix: '--enrichtest'
  - id: min_aa_length
    type:
      - 'null'
      - int
    doc: "Min amino acid length of candidate ORF (default: 6)"
    inputBinding:
      position: 101
      prefix: '--minaalen'
  - id: gene_filter
    type:
      - 'null'
      - string
    doc: "Only process given genes"
    inputBinding:
      position: 101
      prefix: '--genefilter'
  - id: tis_p_value_threshold
    type:
      - 'null'
      - float
    doc: "TIS p value threshold (default: 0.05)"
    inputBinding:
      position: 101
      prefix: '--tpth'
  - id: frame_p_value_threshold
    type:
      - 'null'
      - float
    doc: "Frame p value threshold (default: 0.05)"
    inputBinding:
      position: 101
      prefix: '--fpth'
  - id: min_p_value_threshold
    type:
      - 'null'
      - float
    doc: "At least one of TIS or frame p value should be lower than this threshold (default: 0.05)"
    inputBinding:
      position: 101
      prefix: '--minpth'
  - id: fisher_p_value_threshold
    type:
      - 'null'
      - float
    doc: "Fisher's p value threshold"
    inputBinding:
      position: 101
      prefix: '--fspth'
  - id: fisher_q_value_threshold
    type:
      - 'null'
      - float
    doc: "Fisher's FDR q value threshold"
    inputBinding:
      position: 101
      prefix: '--fsqth'
  - id: frame_local_best
    type:
      - 'null'
      - boolean
    doc: "Only report local best frame test results"
    inputBinding:
      position: 101
      prefix: '--framelocalbest'
  - id: frame_best
    type:
      - 'null'
      - boolean
    doc: "Only report best frame test results"
    inputBinding:
      position: 101
      prefix: '--framebest'
  - id: longest
    type:
      - 'null'
      - boolean
    doc: "Only report longest possible ORF results"
    inputBinding:
      position: 101
      prefix: '--longest'
  - id: sequence
    type:
      - 'null'
      - boolean
    doc: "Report ORF sequences"
    inputBinding:
      position: 101
      prefix: '--seq'
  - id: aa_sequence
    type:
      - 'null'
      - boolean
    doc: "Report amino acid sequences"
    inputBinding:
      position: 101
      prefix: '--aaseq'
  - id: blocks
    type:
      - 'null'
      - boolean
    doc: "Report all exon block positions for predicted ORFs"
    inputBinding:
      position: 101
      prefix: '--blocks'
  - id: in_frame_count
    type:
      - 'null'
      - boolean
    doc: "Report the sum of all counts at the in-frame positions in the ORF"
    inputBinding:
      position: 101
      prefix: '--inframecount'
  - id: max_nh
    type:
      - 'null'
      - int
    doc: "Max NH value allowed for bam alignments (default: 5)"
    inputBinding:
      position: 101
      prefix: '--maxNH'
  - id: min_map_q
    type:
      - 'null'
      - int
    doc: "Min MapQ value required for bam alignments (default: 1)"
    inputBinding:
      position: 101
      prefix: '--minMapQ'
  - id: secondary_alignments
    type:
      - 'null'
      - boolean
    doc: "Use bam secondary alignments"
    inputBinding:
      position: 101
      prefix: '--secondary'
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: "Reads are paired end"
    inputBinding:
      position: 101
      prefix: '--paired'
  - id: no_compatible_junctions
    type:
      - 'null'
      - boolean
    doc: "Do not require reads compatible with transcript splice junctions"
    inputBinding:
      position: 101
      prefix: '--nocompatible'
  - id: compatible_mis
    type:
      - 'null'
      - int
    doc: "Missed bases allowed in reads compatibility check (default: 2)"
    inputBinding:
      position: 101
      prefix: '--compatiblemis'
  - id: num_processes
    type:
      - 'null'
      - int
    doc: "Number of processes"
    inputBinding:
      position: 101
      prefix: '-p'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase output verbosity"
    inputBinding:
      position: 101
      prefix: '-v'
  - id: output_path
    type: string
    doc: "Output result file"
    inputBinding:
      position: 102
      prefix: '-o'
outputs:
  - id: output
    type: File
    doc: "Predicted ORF result file"
    outputBinding:
      glob: $(inputs.output_path)
  - id: all_output
    type:
      - 'null'
      - File
    doc: "All results without FDR q-value threshold (default name: output name with _all.txt)"
    outputBinding:
      glob: "$(inputs.all_result ? inputs.all_result : (inputs.output_path.endsWith(\".txt\") ? inputs.output_path.slice(0, -4) + \"_all.txt\" : inputs.output_path + \"_all.txt\"))"
  - id: background
    type:
      - 'null'
      - File
    doc: "TIS background estimation result (tisBackground.txt or the -e name)"
    outputBinding:
      glob: "$(inputs.est_path ? inputs.est_path : \"tisBackground.txt\")"
  - id: profile
    type:
      - 'null'
      - File
    doc: "RPF P-site profile for each transcript (--transprofile)"
    outputBinding:
      glob: $(inputs.trans_profile)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotish:0.2.8--pyhdfd78af_0
stdout: ribotish_predict.out
