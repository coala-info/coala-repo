cwlVersion: v1.2
class: CommandLineTool
baseCommand: correct.py
label: dunovo_correct.py
doc: "Correct barcodes using an alignment of all barcodes to themselves. Reads the
  alignment in SAM format and corrects the barcodes in an input \"families\" file
  (the output of make-barcodes.awk). It will print the \"families\" file to stdout
  with barcodes (and orders) corrected.\n\nTool homepage: https://github.com/galaxyproject/dunovo"
inputs:
  - id: families
    type: File
    doc: "The sorted output of make-barcodes.awk. The important part is that it's
      a tab-delimited file with at least 2 columns: the barcode sequence and order,
      and it must be sorted in the same order as the \"reads\" in the SAM file."
    inputBinding:
      position: 1
  - id: reads
    type: File
    doc: The fasta/q file given to the aligner. Used to get barcode sequences 
      from read names.
    inputBinding:
      position: 2
  - id: sam
    type:
      - 'null'
      - File
    doc: Barcode alignment, in SAM format. Omit to read from stdin. The read 
      names must be integers, representing the (1-based) order they appear in 
      the families file.
    inputBinding:
      position: 3
  - id: allow_no_nm_if_ns
    type:
      - 'null'
      - boolean
    doc: Allow alignments with missing NM tags if the barcode has at least one 
      N. Otherwise this will fail if it encounters an alignment missing an NM 
      tag.
    inputBinding:
      position: 104
      prefix: --allow-no-nm-if-ns
  - id: choose_by
    type:
      - 'null'
      - string
    doc: Choose the "correct" barcode in a network of related barcodes by either
      the count of how many times the barcode was observed ('count') or how 
      connected the barcode is to the others in the network ('connect').
    inputBinding:
      position: 104
      prefix: --choose-by
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug messages (very verbose).
    inputBinding:
      position: 104
      prefix: --debug
  - id: dist
    type:
      - 'null'
      - int
    doc: NM edit distance threshold.
    inputBinding:
      position: 104
      prefix: --dist
  - id: galaxy
    type:
      - 'null'
      - boolean
    doc: Tell the script it's running on Galaxy. Currently this only affects 
      data reported when phoning home.
    inputBinding:
      position: 104
      prefix: --galaxy
  - id: info
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 104
      prefix: --info
  - id: limit
    type:
      - 'null'
      - int
    doc: Limit the number of entries that will be read from each input file, for
      testing purposes.
    inputBinding:
      position: 104
      prefix: --limit
  - id: mapq
    type:
      - 'null'
      - int
    doc: MAPQ threshold.
    inputBinding:
      position: 104
      prefix: --mapq
  - id: no_check_ids
    type:
      - 'null'
      - boolean
    doc: Don't check to make sure read pairs have identical ids. By default, if 
      this encounters a pair of reads in families.tsv with ids that aren't 
      identical (minus an ending /1 or /2), it will throw an error.
    inputBinding:
      position: 104
      prefix: --no-check-ids
  - id: no_output
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 104
      prefix: --no-output
  - id: phone_home
    type:
      - 'null'
      - boolean
    doc: Report helpful usage data to the developer, to better understand the 
      use cases and performance of the tool. The only data which will be 
      recorded is the name and version of the tool, the size of the input data, 
      the time and memory taken to process it, and the IP address of the machine
      running it. Also, if the script fails, it will report the name of the 
      exception thrown and the line of code it occurred in. No parameters or 
      filenames are sent. All the reporting and recording code is available at 
      https://github.com/NickSto/ET.
    inputBinding:
      position: 104
      prefix: --phone-home
  - id: pos
    type:
      - 'null'
      - int
    doc: POS tolerance. Alignments will be ignored if abs(POS - 1) is greater 
      than this value. Set to greater than the barcode length for no threshold.
    inputBinding:
      position: 104
      prefix: --pos
  - id: prepend
    type:
      - 'null'
      - boolean
    doc: Prepend the corrected barcodes and orders to the original columns.
    inputBinding:
      position: 104
      prefix: --prepend
  - id: quiet
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 104
      prefix: --quiet
  - id: struct_human
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 104
      prefix: --struct-human
  - id: structures
    type:
      - 'null'
      - boolean
    doc: Print a list of the unique isoforms
    inputBinding:
      position: 104
      prefix: --structures
  - id: test
    type:
      - 'null'
      - boolean
    doc: If reporting usage data, mark this as a test run.
    inputBinding:
      position: 104
      prefix: --test
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 104
      prefix: --verbose
  - id: viz_format
    type:
      - 'null'
      - string
    doc: Format for visualization output.
    inputBinding:
      position: 104
      prefix: --viz-format
outputs:
  - id: visualize
    type:
      - 'null'
      - File
    doc: Produce a visualization of the unique structures and write the image to
      this file. If you omit a filename, it will be displayed in a window.
    outputBinding:
      glob: $(inputs.visualize)
  - id: log
    type:
      - 'null'
      - File
    doc: 'Print log messages to this file instead of to stderr. Warning: Will overwrite
      the file.'
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
