cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circtools
  - detect
label: circtools_detect
doc: "circular RNA detection from STAR Chimeric.out.junction files\n\nTool homepage: https://github.com/dieterich-lab/circtools"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        l = l.concat(inputs.junction_files);
        l.push({"entryname": "samplesheet", "entry": inputs.junction_files.map(function(f) { return f.basename; }).join("\n") + "\n"});
        if (inputs.mate1) { l = l.concat(inputs.mate1); l.push({"entryname": "mate1_list", "entry": inputs.mate1.map(function(f) { return f.basename; }).join("\n") + "\n"}); }
        if (inputs.mate2) { l = l.concat(inputs.mate2); l.push({"entryname": "mate2_list", "entry": inputs.mate2.map(function(f) { return f.basename; }).join("\n") + "\n"}); }
        if (inputs.bam) { l.push({"entryname": "bam_list", "entry": inputs.bam.map(function(f) { return f.path; }).join("\n") + "\n"}); }
        return l;
      }
arguments:
  - position: 0
    valueFrom: '@samplesheet'
inputs:
  - id: junction_files
    type:
      type: array
      items: File
    doc: 'Chimeric.out.junction files from STAR, one per sample. They are staged in the working directory and listed in a sample sheet passed as @samplesheet (output files such as <file>.circRNA are written beside them).'
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: 'Temporary files will not be deleted [default: False]'
    inputBinding:
      position: 101
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads used for computation [default: 2]'
    inputBinding:
      position: 101
      prefix: -T
  - id: output_dir
    type:
      - 'null'
      - string
    doc: 'Output directory [default: .]'
    inputBinding:
      position: 101
      prefix: -O
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: 'Temporary directory [default: _tmp_circtools/]'
    inputBinding:
      position: 101
      prefix: -t
  - id: detect
    type:
      - 'null'
      - boolean
    doc: 'Enable circRNA detection from Chimeric.out.junction files [default: False]'
    inputBinding:
      position: 101
      prefix: -D
  - id: secondstrand
    type:
      - 'null'
      - boolean
    doc: 'Must be enabled for stranded libraries, aka ''fr-secondstrand'' [default: False]'
    inputBinding:
      position: 101
      prefix: -ss
  - id: nonstrand
    type:
      - 'null'
      - boolean
    doc: 'The library is non-stranded [default stranded]'
    inputBinding:
      position: 101
      prefix: -N
  - id: end_tol
    type:
      - 'null'
      - int
    doc: 'Maximum base pair tolerance of reads extending over junction sites (0-9) [default: 5]'
    inputBinding:
      position: 101
      prefix: -E
  - id: maximum
    type:
      - 'null'
      - int
    doc: 'The maximum length of candidate circRNAs (including introns) [default: 1000000]'
    inputBinding:
      position: 101
      prefix: -m
  - id: minimum
    type:
      - 'null'
      - int
    doc: 'The minimum length of candidate circRNAs (including introns) [default 30]'
    inputBinding:
      position: 101
      prefix: -n
  - id: annotation
    type:
      - 'null'
      - File
    doc: 'Gene annotation file in GTF/GFF3 format, to annotate circRNAs by their host gene name/identifier'
    inputBinding:
      position: 101
      prefix: -an
  - id: pe_independent
    type:
      - 'null'
      - boolean
    doc: 'Has to be specified if the paired end mates have also been mapped separately. If specified, -mt1 and -mt2 must also be provided [default: False]'
    inputBinding:
      position: 101
      prefix: -Pi
  - id: mate1
    type:
      - 'null'
      - type: array
        items: File
    doc: 'For paired end data, Chimeric.out.junction files from mate1 independent mapping result (staged and passed as a @list file)'
    inputBinding:
      position: 101
      prefix: -mt1
      valueFrom: '@mate1_list'
  - id: mate2
    type:
      - 'null'
      - type: array
        items: File
    doc: 'For paired end data, Chimeric.out.junction files from mate2 independent mapping result (staged and passed as a @list file)'
    inputBinding:
      position: 101
      prefix: -mt2
      valueFrom: '@mate2_list'
  - id: filter
    type:
      - 'null'
      - boolean
    doc: 'If specified, the program will perform a recommended filter step on the detection results'
    inputBinding:
      position: 101
      prefix: -F
  - id: filter_only
    type:
      - 'null'
      - type: array
        items: File
    doc: 'If specified, the program will only filter based on two files provided: 1) a coordinates file [BED6 format] and 2) a count file'
    inputBinding:
      position: 101
      prefix: -f
  - id: chrM
    type:
      - 'null'
      - boolean
    doc: 'If specified, circRNA candidates located on the mitochondrial chromosome will be removed'
    inputBinding:
      position: 101
      prefix: -M
  - id: rep_file
    type:
      - 'null'
      - File
    doc: 'Custom repetitive region file in GTF format to filter out circRNA candidates in repetitive regions'
    inputBinding:
      position: 101
      prefix: -R
  - id: repeat_length
    type:
      - 'null'
      - int
    doc: 'Minimum length in base pairs to check for repetitive regions [default 50]'
    inputBinding:
      position: 101
      prefix: -L
  - id: nr
    type:
      - 'null'
      - type: array
        items: int
    doc: 'countthreshold replicatethreshold [default: 2 5]'
    inputBinding:
      position: 101
      prefix: -Nr
  - id: filterbygene
    type:
      - 'null'
      - boolean
    doc: 'If specified, filter also by gene annotation (candidates are not allowed to span more than one gene) default: False'
    inputBinding:
      position: 101
      prefix: -fg
  - id: gene
    type:
      - 'null'
      - boolean
    doc: 'If specified, the program will count host gene expression given circRNA coordinates [default: False]'
    inputBinding:
      position: 101
      prefix: -G
  - id: circ
    type:
      - 'null'
      - File
    doc: 'User specified circRNA coordinates, any tab delimited file with first three columns as circRNA coordinates: chr, start, end, which circtools will use to count host gene expression'
    inputBinding:
      position: 101
      prefix: -C
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: 'Mapped BAM files from which host gene expression is computed; must have the same order as input chimeric junction files (passed as a @list file)'
    inputBinding:
      position: 101
      prefix: -B
      valueFrom: '@bam_list'
  - id: refseq
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: 'Reference sequence FASTA file'
    inputBinding:
      position: 101
      prefix: -A
  - id: flag_ciriquant
    type:
      - 'null'
      - boolean
    doc: 'If specified, -cql must also be provided. [default: False]'
    inputBinding:
      position: 101
      prefix: -cq
  - id: list_ciriquant
    type:
      - 'null'
      - File
    doc: 'Two-column tab-separated text file with list of CIRIquant output files. First column is sample ID and second column is full path to .ciri output file'
    inputBinding:
      position: 101
      prefix: -cql
  - id: cleanup
    type:
      - 'null'
      - string
    doc: 'String to be removed from each sample name so that the names of Circtools and CIRIquant are the same [Default: "_STARmapping.*Chimeric.out.junction"]'
    inputBinding:
      position: 101
      prefix: -S
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: circ_rna_count
    type:
      - 'null'
      - File
    doc: circRNA read counts per sample
    outputBinding:
      glob: $((inputs.output_dir || '.') + '/CircRNACount')
  - id: circ_coordinates
    type:
      - 'null'
      - File
    doc: circRNA coordinates and annotation
    outputBinding:
      glob: $((inputs.output_dir || '.') + '/CircCoordinates')
  - id: linear_count
    type:
      - 'null'
      - File
    doc: Host gene linear read counts (with -G)
    outputBinding:
      glob: $((inputs.output_dir || '.') + '/LinearCount')
  - id: circ_skip_junctions
    type:
      - 'null'
      - File
    doc: CircSkip junction counts
    outputBinding:
      glob: $((inputs.output_dir || '.') + '/CircSkipJunctions')
  - id: filtered_files
    type:
      type: array
      items: File
    doc: Filtered results (with -F)
    outputBinding:
      glob: $((inputs.output_dir || '.') + '/*.filtered')
  - id: logs
    type:
      type: array
      items: File
    doc: circtools log files
    outputBinding:
      glob: $((inputs.output_dir || '.') + '/circtools-*.log')
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
stdout: circtools_detect.out
