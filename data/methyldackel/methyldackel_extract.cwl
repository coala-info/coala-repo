cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MethylDackel
  - extract
label: methyldackel_extract
doc: "Extract methylation metrics from an alignment file in BAM/CRAM format.\n\nTool homepage: https://github.com/dpryan79/MethylDackel"
inputs:
  - id: ref
    type: File
    secondaryFiles:
      - .fai
    doc: "Reference genome in fasta format, indexed with samtools faidx."
    inputBinding:
      position: 100
  - id: alignments
    type: File
    secondaryFiles:
      - .bai
    doc: "Sorted alignment file in BAM/CRAM format."
    inputBinding:
      position: 101
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "Minimum MAPQ threshold to include an alignment (default 10)"
    inputBinding:
      position: 10
      prefix: -q
  - id: min_phred
    type:
      - 'null'
      - int
    doc: "Minimum Phred threshold to include a base (default 5). This must be >0."
    inputBinding:
      position: 10
      prefix: -p
  - id: min_depth
    type:
      - 'null'
      - int
    doc: "Minimum per-base depth for reporting output. With mergeContext this applies to the merged CpG/CHG. (default 1)"
    inputBinding:
      position: 10
      prefix: -d
  - id: region
    type:
      - 'null'
      - string
    doc: "Region string in which to extract methylation"
    inputBinding:
      position: 10
      prefix: -r
  - id: bed
    type:
      - 'null'
      - File
    doc: "A BED file listing regions for inclusion."
    inputBinding:
      position: 10
      prefix: -l
  - id: keep_strand
    type:
      - 'null'
      - boolean
    doc: "If a BED file is specified, use the strand column (column 6) so that only metrics from the given strand are output."
    inputBinding:
      position: 10
      prefix: --keepStrand
  - id: mappability
    type:
      - 'null'
      - File
    doc: "A bigWig file containing mappability data for filtering reads."
    inputBinding:
      position: 10
      prefix: --mappability
  - id: mappability_threshold
    type:
      - 'null'
      - float
    doc: "If a bigWig file is provided, the threshold mappability value above which a base is considered mappable (default 0.01)."
    inputBinding:
      position: 10
      prefix: --mappabilityThreshold
  - id: min_mappable_bases
    type:
      - 'null'
      - int
    doc: "If a bigWig file is provided, the number of mappable bases needed for a read to be considered mappable (default 15)."
    inputBinding:
      position: 10
      prefix: --minMappableBases
  - id: output_bbm_file
    type:
      - 'null'
      - boolean
    doc: "Write a Binary Bismap (.bbm) file with the same base name as the bigWig file but with the .bbm extension."
    inputBinding:
      position: 10
      prefix: --outputBBMFile
  - id: output_bbm_file_name
    type:
      - 'null'
      - string
    doc: "Write a Binary Bismap (.bbm) file at the provided file name."
    inputBinding:
      position: 10
      prefix: --outputBBMFileName
  - id: mappability_bb
    type:
      - 'null'
      - File
    doc: "A .bbm file containing mappability data for filtering reads."
    inputBinding:
      position: 10
      prefix: --mappabilityBB
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads to use, the default 1"
    inputBinding:
      position: 10
      prefix: -@
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "The size of the genome processed by a single thread at a time. The default is 1000000 bases. This value MUST be at least 1."
    inputBinding:
      position: 10
      prefix: --chunkSize
  - id: merge_context
    type:
      - 'null'
      - boolean
    doc: "Merge per-Cytosine metrics from CpG and CHG contexts into per-CpG or per-CHG metrics."
    inputBinding:
      position: 10
      prefix: --mergeContext
  - id: keep_dupes
    type:
      - 'null'
      - boolean
    doc: "By default, any alignment marked as a duplicate is ignored. This option causes them to be incorporated."
    inputBinding:
      position: 10
      prefix: --keepDupes
  - id: keep_singleton
    type:
      - 'null'
      - boolean
    doc: "By default, if only one read in a pair aligns (a singleton) then it is ignored."
    inputBinding:
      position: 10
      prefix: --keepSingleton
  - id: keep_discordant
    type:
      - 'null'
      - boolean
    doc: "By default, paired-end alignments with the properly-paired bit unset in the FLAG field are ignored."
    inputBinding:
      position: 10
      prefix: --keepDiscordant
  - id: ignore_flags
    type:
      - 'null'
      - int
    doc: "Alignment flag bits to ignore. The default is 0xF00 (3840): secondary, failing QC, duplicate and supplemental alignments."
    inputBinding:
      position: 10
      prefix: --ignoreFlags
  - id: require_flags
    type:
      - 'null'
      - int
    doc: "Require each alignment to have all bits in this value present, or else the alignment is ignored (like samtools -f). The default is 0."
    inputBinding:
      position: 10
      prefix: --requireFlags
  - id: ignore_nh
    type:
      - 'null'
      - boolean
    doc: "Ignore NH auxiliary tags. By default, if an NH tag is present and its value is >1 then an entry is ignored as a multimapper."
    inputBinding:
      position: 10
      prefix: --ignoreNH
  - id: min_conversion_efficiency
    type:
      - 'null'
      - float
    doc: "The minimum non-CpG conversion efficiency observed in a read to include it in the output (0.0 to 1.0, default 0.0)."
    inputBinding:
      position: 10
      prefix: --minConversionEfficiency
  - id: no_cpg
    type:
      - 'null'
      - boolean
    doc: "Do not output CpG methylation metrics"
    inputBinding:
      position: 10
      prefix: --noCpG
  - id: chg
    type:
      - 'null'
      - boolean
    doc: "Output CHG methylation metrics"
    inputBinding:
      position: 10
      prefix: --CHG
  - id: chh
    type:
      - 'null'
      - boolean
    doc: "Output CHH methylation metrics"
    inputBinding:
      position: 10
      prefix: --CHH
  - id: fraction
    type:
      - 'null'
      - boolean
    doc: "Extract fractional methylation (only) at each position. Produces a file with a .meth.bedGraph extension."
    inputBinding:
      position: 10
      prefix: --fraction
  - id: counts
    type:
      - 'null'
      - boolean
    doc: "Extract base counts (only) at each position. Produces a file with a .counts.bedGraph extension."
    inputBinding:
      position: 10
      prefix: --counts
  - id: logit
    type:
      - 'null'
      - boolean
    doc: "Extract logit(M/(M+U)) (only) at each position. Produces a file with a .logit.bedGraph extension."
    inputBinding:
      position: 10
      prefix: --logit
  - id: min_opposite_depth
    type:
      - 'null'
      - int
    doc: "Minimum depth required on the strand opposite of a C to look for A/T/C bases, to exclude likely SNP sites (default 0, no exclusion)."
    inputBinding:
      position: 10
      prefix: --minOppositeDepth
  - id: max_variant_frac
    type:
      - 'null'
      - float
    doc: "The maximum fraction of A/T/C base calls on the strand opposite of a C to allow before a position is declared a variant and excluded (default 0.0)."
    inputBinding:
      position: 10
      prefix: --maxVariantFrac
  - id: methyl_kit
    type:
      - 'null'
      - boolean
    doc: "Output in the format required by methylKit. Incompatible with mergeContext, fraction and counts."
    inputBinding:
      position: 10
      prefix: --methylKit
  - id: cytosine_report
    type:
      - 'null'
      - boolean
    doc: "A per-base exhaustive report comparable to the Bismark methylation extractor cytosine report; writes a .cytosine_report.txt file."
    inputBinding:
      position: 10
      prefix: --cytosine_report
  - id: ot
    type:
      - 'null'
      - string
    doc: "Inclusion bounds A,B,C,D for methylation calls from the original top strand. Each integer is a 1-based position on read 1 (A,B) and read 2 (C,D); 0 means start/end of the alignment."
    inputBinding:
      position: 10
      prefix: --OT
  - id: ob
    type:
      - 'null'
      - string
    doc: "Inclusion bounds A,B,C,D for methylation calls from the original bottom strand. Each integer is a 1-based position on read 1 (A,B) and read 2 (C,D); 0 means start/end of the alignment."
    inputBinding:
      position: 10
      prefix: --OB
  - id: ctot
    type:
      - 'null'
      - string
    doc: "Inclusion bounds A,B,C,D for methylation calls from the original complementary to the original top strand. Each integer is a 1-based position on read 1 (A,B) and read 2 (C,D); 0 means start/end of the alignment."
    inputBinding:
      position: 10
      prefix: --CTOT
  - id: ctob
    type:
      - 'null'
      - string
    doc: "Inclusion bounds A,B,C,D for methylation calls from the original complementary to the original bottom strand. Each integer is a 1-based position on read 1 (A,B) and read 2 (C,D); 0 means start/end of the alignment."
    inputBinding:
      position: 10
      prefix: --CTOB
  - id: n_ot
    type:
      - 'null'
      - string
    doc: "Inclusion bounds A,B,C,D for methylation calls from the original top strand; always exclude the given number of bases from each end."
    inputBinding:
      position: 10
      prefix: --nOT
  - id: n_ob
    type:
      - 'null'
      - string
    doc: "Inclusion bounds A,B,C,D for methylation calls from the original bottom strand; always exclude the given number of bases from each end."
    inputBinding:
      position: 10
      prefix: --nOB
  - id: n_ctot
    type:
      - 'null'
      - string
    doc: "Inclusion bounds A,B,C,D for methylation calls from the original complementary to the original top strand; always exclude the given number of bases from each end."
    inputBinding:
      position: 10
      prefix: --nCTOT
  - id: n_ctob
    type:
      - 'null'
      - string
    doc: "Inclusion bounds A,B,C,D for methylation calls from the original complementary to the original bottom strand; always exclude the given number of bases from each end."
    inputBinding:
      position: 10
      prefix: --nCTOB
  - id: opref
    type: string
    doc: "Output filename prefix. CpG/CHG/CHH context metrics are written to <prefix>_CpG.bedGraph and so on."
    inputBinding:
      position: 50
      prefix: --opref
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Per-context bedGraph files, or the report, written for the output prefix."
    outputBinding:
      glob: $(inputs.opref)*
  - id: bbm_file
    type:
      - 'null'
      - File
    doc: "Binary Bismap file written when output_bbm_file_name is set."
    outputBinding:
      glob: $(inputs.output_bbm_file_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methyldackel:0.6.1--h577a1d6_9
