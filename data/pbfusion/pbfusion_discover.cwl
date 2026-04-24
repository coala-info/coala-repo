cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pbfusion
  - discover
label: pbfusion_discover
doc: "Identify fusion genes in aligned PacBio Iso-Seq data\n\nTool homepage: https://github.com/PacificBiosciences/pbfusion"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Aligned Iso-Seq data in BAM format
    inputBinding:
      position: 1
  - id: additional_bams
    type:
      - 'null'
      - type: array
        items: File
    doc: Aligned Iso-Seq data in BAM format. Accepts a path to a bam, a url, or a
      fofn file
    inputBinding:
      position: 102
      prefix: -b
  - id: allow_immune
    type:
      - 'null'
      - boolean
    doc: Permit fusion events identified involving primarily immunological genes and
      their pseudogenes
    inputBinding:
      position: 102
      prefix: --allow-immune
  - id: allow_mito
    type:
      - 'null'
      - boolean
    doc: Permit fusion events identified involving mitochondrial genes
    inputBinding:
      position: 102
      prefix: --allow-mito
  - id: gtf
    type: File
    doc: Reference gene annotations in GTF format (or gtf.bin)
    inputBinding:
      position: 102
      prefix: --gtf
  - id: gtf_transcript_allow_lncrna
    type:
      - 'null'
      - boolean
    doc: Allow fusion partners to contain lncRNA annotations
    inputBinding:
      position: 102
      prefix: --gtf-transcript-allow-lncRNA
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Alternative to repeated -v/--verbose: set log level via key (error, warn,
      info, debug, trace)'
    inputBinding:
      position: 102
      prefix: --log-level
  - id: max_genes_in_event
    type:
      - 'null'
      - int
    doc: Mark fusion groups involving > [arg] genes as low quality
    inputBinding:
      position: 102
      prefix: --max-genes-in-event
  - id: max_readthrough
    type:
      - 'null'
      - int
    doc: Assigns 'low confidence' to fusion calls spanning two genes below the readthrough
      threshold
    inputBinding:
      position: 102
      prefix: --max-readthrough
  - id: max_variability
    type:
      - 'null'
      - int
    doc: Assigns 'low confidence' to fusion calls with the mean breakpoint distance
      is above the threshold
    inputBinding:
      position: 102
      prefix: --max-variability
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Real-cell filtering for single-cell data. Assigns 'low confidence' to fusion
      calls with read coverage below the minimum coverage threshold
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: min_fusion_fraction
    type:
      - 'null'
      - float
    doc: Minimum fusion fraction relative to transcript count
    inputBinding:
      position: 102
      prefix: --min-fusion-fraction
  - id: min_fusion_quality
    type:
      - 'null'
      - string
    doc: 'Determine the minimum fusion quality to emit. Choices: LOW or MEDIUM'
    inputBinding:
      position: 102
      prefix: --min-fusion-quality
  - id: min_fusion_read_fraction
    type:
      - 'null'
      - float
    doc: Remove breakpoint pairs from groups if they have gene alignments which fewer
      than [arg] reads in group have
    inputBinding:
      position: 102
      prefix: --min-fusion-read-fraction
  - id: min_mean_identity
    type:
      - 'null'
      - float
    doc: Assigns 'low confidence' to fusion calls where the mean alignment identity
      is below the threshold
    inputBinding:
      position: 102
      prefix: --min-mean-identity
  - id: min_mean_mapq
    type:
      - 'null'
      - int
    doc: Assigns 'low confidence' to fusion calls where the mean mapq is below the
      threshold
    inputBinding:
      position: 102
      prefix: --min-mean-mapq
  - id: prom_filter
    type:
      - 'null'
      - int
    doc: Filter rarer events involving genes with high numbers of fusion partners
    inputBinding:
      position: 102
      prefix: --prom-filter
  - id: real_cell_filtering
    type:
      - 'null'
      - boolean
    doc: Enable real-cell filtering
    inputBinding:
      position: 102
      prefix: --real-cell-filtering
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Defaults to available parallelism
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_prefix
    type: File
    doc: Output prefix
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbfusion:0.5.1--hdfd78af_0
