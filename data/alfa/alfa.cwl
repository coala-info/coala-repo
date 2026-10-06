cwlVersion: v1.2
class: CommandLineTool
baseCommand: alfa
label: alfa
doc: "ALFA (Automated Labelling of Feature Annotations) is a tool for genome-wide
  annotation of sequencing data, providing a global overview of the distribution of
  reads across genomic features.\n\nTool homepage: https://github.com/biocompibens/ALFA"
inputs:
  - id: annotation
    type:
      - 'null'
      - File
    doc: Genomic annotations file (GTF format).
    inputBinding:
      position: 101
      prefix: --annotation
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BAM file(s), sorted by position. Each BAM is paired with the label
      at the same index in bam_labels (rendered as --bam BAM1 LABEL1 BAM2 LABEL2).
  - id: bam_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: One sample label per BAM file in bam.
  - id: bedgraph
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BedGraph file(s). If stranded, give the plus and minus BedGraph
      files of each sample in order; the files are split evenly among bedgraph_labels.
  - id: bedgraph_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: One sample label per sample in bedgraph.
  - id: categories_depth
    type:
      - 'null'
      - int
    doc: "Hierarchical level that will be considered in the GTF file: (1) gene,intergenic;
      (2) intron,exon,intergenic; (3) 5'UTR,CDS,3'UTR,intron,intergenic; (4) start_codon,5'UTR,CDS,3'UTR,stop_codon,intron,intergenic."
    inputBinding:
      position: 101
      prefix: --categories_depth
  - id: chr_len
    type:
      - 'null'
      - File
    doc: Tabulated file containing chromosome names and lengths.
    inputBinding:
      position: 101
      prefix: --chr_len
  - id: counts
    type:
      - 'null'
      - type: array
        items: File
    doc: Use this options instead of '--bam/--bedgraph' to provide ALFA counts 
      files as input instead of bam/bedgraph files.
    inputBinding:
      position: 101
      prefix: --counts
  - id: genome_index
    type:
      - 'null'
      - string
    doc: Genome index files path and basename for existing index, or path and 
      basename for new index creation.
    inputBinding:
      position: 101
      prefix: --genome_index
  - id: genome_index_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Existing ALFA index files (<basename>.stranded.ALFA_index and 
      <basename>.unstranded.ALFA_index). They are staged in the working directory,
      so set genome_index to their basename.
  - id: keep_ambiguous
    type:
      - 'null'
      - boolean
    doc: Keep reads mapping to different features (discarded by default).
    inputBinding:
      position: 101
      prefix: --keep_ambiguous
  - id: no_display
    type:
      - 'null'
      - boolean
    doc: Do not display plots.
    inputBinding:
      position: 101
      prefix: --no_display
  - id: processors
    type:
      - 'null'
      - int
    doc: Set the number of processors used for multi-processing operations.
    inputBinding:
      position: 101
      prefix: --processors
  - id: strandness
    type:
      - 'null'
      - string
    doc: "Library orientation. Choose within: 'unstranded', 'forward'/'fr-firststrand'
      or 'reverse'/'fr-secondstrand'."
    inputBinding:
      position: 101
      prefix: --strandness
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: Temp directory to store pybedtools files.
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: threshold
    type:
      - 'null'
      - type: array
        items: float
    doc: Set ordinate axis limits for enrichment plots (YMIN YMAX).
    inputBinding:
      position: 101
      prefix: --threshold
  - id: output_dir_path
    type:
      - 'null'
      - string
    doc: Output directory for all files created by ALFA (current dir by 
      default).
    inputBinding:
      position: 102
      prefix: -o
  - id: pdf_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 103
      prefix: --pdf
  - id: png_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: --png
  - id: svg_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 105
      prefix: --svg
outputs:
  - id: pdf
    type:
      - 'null'
      - type: array
        items: File
    doc: PDF plots (<pdf_path basename>.Categories.pdf and .Biotypes.pdf)
    outputBinding:
      glob: |-
        ${
          if (!inputs.pdf_path) return [];
          var d = inputs.output_dir_path ? inputs.output_dir_path.replace(/\/$/, '') + '/' : '';
          return d + inputs.pdf_path.replace(/\.pdf$/, '') + '.*.pdf';
        }
  - id: png
    type:
      - 'null'
      - type: array
        items: File
    doc: PNG plots (<png_path basename>.Categories.png and .Biotypes.png)
    outputBinding:
      glob: |-
        ${
          if (!inputs.png_path) return [];
          var d = inputs.output_dir_path ? inputs.output_dir_path.replace(/\/$/, '') + '/' : '';
          return d + inputs.png_path.replace(/\.png$/, '') + '.*.png';
        }
  - id: svg
    type:
      - 'null'
      - type: array
        items: File
    doc: SVG plots (<svg_path basename>.Categories.svg and .Biotypes.svg)
    outputBinding:
      glob: |-
        ${
          if (!inputs.svg_path) return [];
          var d = inputs.output_dir_path ? inputs.output_dir_path.replace(/\/$/, '') + '/' : '';
          return d + inputs.svg_path.replace(/\.svg$/, '') + '.*.svg';
        }
  - id: counts_files
    type:
      type: array
      items: File
    doc: ALFA counts files (<label>.ALFA_feature_counts.tsv)
    outputBinding:
      glob: "$(inputs.output_dir_path ? inputs.output_dir_path.replace(/\\/$/, '') + '/' : '')*.ALFA_feature_counts.tsv"
  - id: index_files
    type:
      type: array
      items: File
    doc: ALFA genome index files created from the annotation (*.ALFA_index)
    outputBinding:
      glob: "$(inputs.annotation ? (inputs.output_dir_path ? inputs.output_dir_path.replace(/\\/$/, '') + '/' : '') + '*.ALFA_index' : [])"
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for all files created by ALFA (current dir by 
      default).
    outputBinding:
      glob: $(inputs.output_dir_path)
arguments:
  - position: 101
    valueFrom: |-
      ${
        if (!inputs.bam) return null;
        var a = ["--bam"];
        for (var i = 0; i < inputs.bam.length; i++) {
          a.push(inputs.bam[i].path);
          a.push(inputs.bam_labels[i]);
        }
        return a;
      }
  - position: 101
    valueFrom: |-
      ${
        if (!inputs.bedgraph) return null;
        var a = ["--bedgraph"];
        var n = inputs.bedgraph.length / inputs.bedgraph_labels.length;
        for (var i = 0; i < inputs.bedgraph_labels.length; i++) {
          for (var j = 0; j < n; j++) a.push(inputs.bedgraph[i * n + j].path);
          a.push(inputs.bedgraph_labels[i]);
        }
        return a;
      }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.genome_index_files ? inputs.genome_index_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfa:1.1.1--pyh5e36f6f_0
