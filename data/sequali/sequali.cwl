cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequali
label: sequali
doc: "Create a quality metrics report for sequencing data.\n\nTool homepage: https://github.com/rhpvorderman/sequali"
inputs:
  - id: input
    type: File
    doc: Input FASTQ or uBAM file. The format is autodetected and compressed 
      formats are supported.
    inputBinding:
      position: 1
  - id: input_reverse
    type:
      - 'null'
      - File
    doc: Second FASTQ file for Illumina paired-end reads.
    inputBinding:
      position: 2
  - id: adapter_file
    type:
      - 'null'
      - File
    doc: File with adapters to search for. See default file for formatting.
    inputBinding:
      position: 103
      prefix: --adapter-file
  - id: duplication_max_stored_fingerprints
    type:
      - 'null'
      - int
    doc: Determines how many fingerprints are maximally stored to estimate the 
      duplication rate. More fingerprints leads to a more accurate estimate, but
      also more memory usage.
    inputBinding:
      position: 103
      prefix: --duplication-max-stored-fingerprints
  - id: fingerprint_back_length
    type:
      - 'null'
      - int
    doc: Set the number of bases to be taken for the deduplication fingerprint 
      from the back of the sequence.
    inputBinding:
      position: 103
      prefix: --fingerprint-back-length
  - id: fingerprint_back_offset
    type:
      - 'null'
      - int
    doc: Set the offset for the back part of the deduplication fingerprint. 
      Useful for avoiding adapter sequences.
    inputBinding:
      position: 103
      prefix: --fingerprint-back-offset
  - id: fingerprint_front_length
    type:
      - 'null'
      - int
    doc: Set the number of bases to be taken for the deduplication fingerprint 
      from the front of the sequence.
    inputBinding:
      position: 103
      prefix: --fingerprint-front-length
  - id: fingerprint_front_offset
    type:
      - 'null'
      - int
    doc: Set the offset for the front part of the deduplication fingerprint. 
      Useful for avoiding adapter sequences.
    inputBinding:
      position: 103
      prefix: --fingerprint-front-offset
  - id: overrepresentation_bases_from_end
    type:
      - 'null'
      - int
    doc: The minimum amount of bases sampled from the end of the read. There 
      might be slight overshoot depending on the fragment length. Set to a 
      negative value to sample the entire read.
    inputBinding:
      position: 103
      prefix: --overrepresentation-bases-from-end
  - id: overrepresentation_bases_from_start
    type:
      - 'null'
      - int
    doc: The minimum amount of bases sampled from the start of the read. There 
      might be slight overshoot depending on the fragment length. Set to a 
      negative value to sample the entire read.
    inputBinding:
      position: 103
      prefix: --overrepresentation-bases-from-start
  - id: overrepresentation_fragment_length
    type:
      - 'null'
      - int
    doc: The length of the fragments to sample. The maximum is 31.
    inputBinding:
      position: 103
      prefix: --overrepresentation-fragment-length
  - id: overrepresentation_max_threshold
    type:
      - 'null'
      - int
    doc: The amount of occurrences for a sequence to be considered 
      overrepresented, regardless of the bound set by the threshold fraction. 
      Useful for very large files.
    inputBinding:
      position: 103
      prefix: --overrepresentation-max-threshold
  - id: overrepresentation_max_unique_fragments
    type:
      - 'null'
      - int
    doc: The maximum amount of unique fragments to store. Larger amounts 
      increase the sensitivity of finding overrepresented sequences at the cost 
      of increasing memory usage.
    inputBinding:
      position: 103
      prefix: --overrepresentation-max-unique-fragments
  - id: overrepresentation_min_threshold
    type:
      - 'null'
      - int
    doc: The minimum amount of occurrences for a sequence to be considered 
      overrepresented, regardless of the bound set by the threshold fraction. 
      Useful for smaller files.
    inputBinding:
      position: 103
      prefix: --overrepresentation-min-threshold
  - id: overrepresentation_sample_every
    type:
      - 'null'
      - int
    doc: How often a read should be sampled. More samples leads to better 
      precision, lower speed, and also towards more bias towards the beginning 
      of the file as the fragment store gets filled up with more sequences from 
      the beginning.
    inputBinding:
      position: 103
      prefix: --overrepresentation-sample-every
  - id: overrepresentation_threshold_fraction
    type:
      - 'null'
      - float
    doc: At what fraction a sequence is determined to be overrepresented. The 
      threshold is calculated as fraction times the number of sampled sequences.
    inputBinding:
      position: 103
      prefix: --overrepresentation-threshold-fraction
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. If greater than one an additional thread for 
      gzip decompression will be used.
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: json
    type:
      - 'null'
      - File
    doc: JSON output file.
    outputBinding:
      glob: $(inputs.json)
  - id: html
    type:
      - 'null'
      - File
    doc: HTML output file.
    outputBinding:
      glob: $(inputs.html)
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory for the report files.
    outputBinding:
      glob: $(inputs.outdir)
  - id: images_zip
    type:
      - 'null'
      - File
    doc: If supplied, will create a zip file with the images at the supplied 
      location.
    outputBinding:
      glob: $(inputs.images_zip)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequali:1.0.2--py310h1fe012e_0
