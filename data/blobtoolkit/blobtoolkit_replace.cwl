cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtools
  - replace
label: blobtoolkit_replace
doc: "Call blobtools add with --replace flag: add data to a BlobDir, replacing existing fields with matching ids.\n\nTool homepage: https://github.com/blobtoolkit/blobtoolkit"
inputs:
  - id: blobdir
    type: Directory
    doc: Existing Blob directory (updated in place; the updated copy is returned).
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: bed
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bed
    doc: BED format file.
    inputBinding:
      position: 1
  - id: beddir
    type: ['null', Directory]
    doc: Directory containing one or more BED format files.
    inputBinding:
      position: 1
      prefix: --beddir
  - id: bedtsv
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bedtsv
    doc: TSV file with header row and bed-format columns 1-3.
    inputBinding:
      position: 1
  - id: bedtsvdir
    type: ['null', Directory]
    doc: Directory containing one or more BED-like tsv files.
    inputBinding:
      position: 1
      prefix: --bedtsvdir
  - id: busco
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --busco
    doc: BUSCO full_table.tsv output file.
    inputBinding:
      position: 1
  - id: cov
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --cov
    doc: BAM/SAM/CRAM read alignment file. The index (.bai/.csi) is used when given; otherwise the tool writes one beside the staged file.
    inputBinding:
      position: 1
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .csi
        required: false
      - pattern: .crai
        required: false
  - id: fasta
    type: ['null', File]
    doc: FASTA sequence file.
    inputBinding:
      position: 1
      prefix: --fasta
  - id: hits
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --hits
    doc: Tabular BLAST/Diamond output file.
    inputBinding:
      position: 1
  - id: hits_cols
    type: ['null', string]
    doc: 'Comma separated list of <column number>=<field name>. [Default: 1=qseqid,2=staxids,3=bitscore,5=sseqid,10=qstart,11=qend,14=evalue]'
    inputBinding:
      position: 1
      prefix: --hits-cols
  - id: taxid
    type: ['null', int]
    doc: Add ranks to metadata for a taxid.
    inputBinding:
      position: 1
      prefix: --taxid
  - id: key
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --key
    doc: Set a metadata key to value (path=value).
    inputBinding:
      position: 1
  - id: link
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --link
    doc: Link to an external resource (path=URL).
    inputBinding:
      position: 1
  - id: skip_link_test
    type: ['null', boolean]
    doc: Skip test to see if link URL can be resolved.
    inputBinding:
      position: 1
      prefix: --skip-link-test
  - id: meta
    type: ['null', File]
    doc: Dataset metadata (YAML).
    inputBinding:
      position: 1
      prefix: --meta
  - id: blobdb
    type: ['null', File]
    doc: Blobtools v1 blobDB (JSON).
    inputBinding:
      position: 1
      prefix: --blobdb
  - id: synonyms
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --synonyms
    doc: TSV file containing current identifiers and synonyms.
    inputBinding:
      position: 1
  - id: taxdump
    type: ['null', Directory]
    doc: Location of NCBI new_taxdump directory.
    inputBinding:
      position: 1
      prefix: --taxdump
  - id: taxrule
    type: ['null', string]
    doc: 'Rule to use when assigning BLAST hits to taxa (bestsum, bestsumorder, bestdistsum, bestdistsumorder, blastp). An alternate prefix may be specified as rulename=prefix. [Default: bestsumorder]'
    inputBinding:
      position: 1
      prefix: --taxrule
  - id: threads
    type: ['null', int]
    doc: 'Number of threads to use for multithreaded tasks. [Default: 1]'
    inputBinding:
      position: 1
      prefix: --threads
  - id: evalue
    type: ['null', float]
    doc: 'Set evalue cutoff when parsing hits file. [Default: 1]'
    inputBinding:
      position: 1
      prefix: --evalue
  - id: bitscore
    type: ['null', float]
    doc: 'Set bitscore cutoff when parsing hits file. [Default: 1]'
    inputBinding:
      position: 1
      prefix: --bitscore
  - id: hit_count
    type: ['null', int]
    doc: 'Number of hits to parse when inferring taxonomy. [Default: 10]'
    inputBinding:
      position: 1
      prefix: --hit-count
  - id: update_plot
    type: ['null', boolean]
    doc: Flag to use new taxrule as default category.
    inputBinding:
      position: 1
      prefix: --update-plot
  - id: text
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --text
    doc: Generic text file.
    inputBinding:
      position: 1
  - id: text_delimiter
    type: ['null', string]
    doc: 'Text file delimiter. [Default: whitespace]'
    inputBinding:
      position: 1
      prefix: --text-delimiter
  - id: text_cols
    type: ['null', string]
    doc: Comma separated list of <column number>[=<field name>].
    inputBinding:
      position: 1
      prefix: --text-cols
  - id: text_header
    type: ['null', boolean]
    doc: Flag to indicate first row of text file contains field names.
    inputBinding:
      position: 1
      prefix: --text-header
  - id: text_no_array
    type: ['null', boolean]
    doc: Flag to prevent fields in files with duplicate identifiers being loaded as array fields.
    inputBinding:
      position: 1
      prefix: --text-no-array
  - id: trnascan
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --trnascan
    doc: tRNAscan2-SE output
    inputBinding:
      position: 1
  - id: pileup_args
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --pileup-args
    doc: Key/value pairs to pass to samtools pileup (key=val).
    inputBinding:
      position: 1
  - id: create
    type: ['null', boolean]
    doc: Create a new BlobDir.
    inputBinding:
      position: 1
      prefix: --create
outputs:
  - id: output_blobdir
    type: Directory
    doc: The updated BlobDir
    outputBinding:
      glob: $(inputs.blobdir.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.blobdir)
        writable: true
      - entry: $(inputs.cov)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
