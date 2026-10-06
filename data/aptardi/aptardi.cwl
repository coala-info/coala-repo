cwlVersion: v1.2
class: CommandLineTool
baseCommand: aptardi
label: aptardi
doc: "Alternative polyadenylation transcriptome analysis from RNA-seq and DNA-seq 
  information. aptardi adds 3' ends (polyA sites) found by machine learning to an
  input transcriptome (GTF/GFF).\n\nTool homepage: https://github.com/luskry/aptardi"
inputs:
  - id: output_dir
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --o
  - id: transcripts
    type: File
    doc: Transcriptome reconstruction in GTF/GFF format (for example from 
      StringTie)
    inputBinding:
      position: 101
      prefix: --r
  - id: fasta
    type: File
    doc: FASTA file where headers are chromosomes
    inputBinding:
      position: 101
      prefix: --f
  - id: bam
    type: File
    doc: Sorted BAM file of aligned RNA-Seq reads
    inputBinding:
      position: 101
      prefix: --b
  - id: orientation
    type:
      - 'null'
      - string
    doc: Upstream/downstream mate orientations for paired-end alignment against 
      the forward reference strand (fr or rf, default fr)
    inputBinding:
      position: 101
      prefix: --a
  - id: output_gtf
    type:
      - 'null'
      - string
    doc: Name of the output GTF file, saved in the output directory (default 
      standard output)
    inputBinding:
      position: 101
      prefix: --g
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn debugging mode on (keep intermediate files)
    inputBinding:
      position: 101
      prefix: --d
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn verbose mode on
    inputBinding:
      position: 101
      prefix: --verbose
  - id: machine_learning
    type:
      - 'null'
      - boolean
    doc: Turn machine learning mode on (build your own model)
    inputBinding:
      position: 101
      prefix: --m
  - id: polya_sites
    type:
      - 'null'
      - File
    doc: Tab separated polyA sites file (if building model)
    inputBinding:
      position: 101
      prefix: --s
  - id: output_model
    type:
      - 'null'
      - string
    doc: Name to save model, with .hdf5 extension (if building model)
    inputBinding:
      position: 101
      prefix: --e
  - id: output_scale
    type:
      - 'null'
      - string
    doc: Name to save scale, with .pk extension (if building model)
    inputBinding:
      position: 101
      prefix: --k
  - id: polya_columns
    type:
      - 'null'
      - string
    doc: 0-based coordinates of chromosome, strand, and polyA site columns in 
      the polyA sites file, comma separated (if building model)
    inputBinding:
      position: 101
      prefix: --l
  - id: probability
    type:
      - 'null'
      - float
    doc: Probability threshold, predictions >= value are classified as polyA 
      sites (otherwise default used)
    inputBinding:
      position: 101
      prefix: --p
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed state for the train test split if building model
    inputBinding:
      position: 101
      prefix: --c
  - id: input_model
    type:
      - 'null'
      - File
    doc: Pre-built model, model.hdf5 (if not building model)
    inputBinding:
      position: 101
      prefix: --n
  - id: input_scale
    type:
      - 'null'
      - File
    doc: Scale from the pre-built model, scale.pk (if not building model)
    inputBinding:
      position: 101
      prefix: --t
  - id: max_bins
    type:
      - 'null'
      - int
    doc: Maximum number of bins analyzed per transcript (default 300)
    inputBinding:
      position: 101
      prefix: --i
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Size of bins for making predictions, 25-200 in 25 base increments 
      (default 100)
    inputBinding:
      position: 101
      prefix: --w
outputs:
  - id: gtf_stdout
    type: stdout
    doc: Output GTF written to standard output when --g is not given
  - id: out_dir
    type: Directory
    doc: Output directory (output GTF given with --g, models, debug files)
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aptardi:1.4--pyh5e36f6f_0
stdout: aptardi_output.gtf
