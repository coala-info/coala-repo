cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MethylDackel
  - mbias
label: methyldackel_mbias
doc: "Determine the position-dependent methylation bias in a dataset, producing diagnostic SVG images.\n\nTool homepage: https://github.com/dpryan79/MethylDackel"
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
  - id: max_depth
    type:
      - 'null'
      - int
    doc: "Maximum per-base depth (default 2000)"
    inputBinding:
      position: 10
      prefix: -D
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
  - id: no_cpg
    type:
      - 'null'
      - boolean
    doc: "Do not output CpG methylation metrics"
    inputBinding:
      position: 10
      prefix: --noCpG
  - id: txt
    type:
      - 'null'
      - boolean
    doc: "Output tab separated metrics to the screen (1-based coordinates)."
    inputBinding:
      position: 10
      prefix: --txt
  - id: no_svg
    type:
      - 'null'
      - boolean
    doc: "Do not produce the SVG files. This implies txt and no output prefix is required."
    inputBinding:
      position: 10
      prefix: --noSVG
  - id: n_ot
    type:
      - 'null'
      - string
    doc: "Inclusion bound for methylation calls from the original top strand: INT,INT,INT,INT, each a 1-based position from the end of a read; 0 means start/end of the alignment."
    inputBinding:
      position: 10
      prefix: --nOT
  - id: n_ob
    type:
      - 'null'
      - string
    doc: "Inclusion bound for methylation calls from the original bottom strand: INT,INT,INT,INT, each a 1-based position from the end of a read; 0 means start/end of the alignment."
    inputBinding:
      position: 10
      prefix: --nOB
  - id: n_ctot
    type:
      - 'null'
      - string
    doc: "Inclusion bound for methylation calls from the original complementary to the original top strand: INT,INT,INT,INT, each a 1-based position from the end of a read; 0 means start/end of the alignment."
    inputBinding:
      position: 10
      prefix: --nCTOT
  - id: n_ctob
    type:
      - 'null'
      - string
    doc: "Inclusion bound for methylation calls from the original complementary to the original bottom strand: INT,INT,INT,INT, each a 1-based position from the end of a read; 0 means start/end of the alignment."
    inputBinding:
      position: 10
      prefix: --nCTOB
  - id: output_prefix
    type: string
    doc: "Output prefix for the SVG diagnostic images."
    inputBinding:
      position: 102
outputs:
  - id: svg_files
    type:
      type: array
      items: File
    doc: "Diagnostic SVG images written for the output prefix."
    outputBinding:
      glob: $(inputs.output_prefix)*
  - id: stdout
    type: stdout
    doc: Standard output (tab separated metrics with txt)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methyldackel:0.6.1--h577a1d6_9
stdout: methyldackel_mbias.out
