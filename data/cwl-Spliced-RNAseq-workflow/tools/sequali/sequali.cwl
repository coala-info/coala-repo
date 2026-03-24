#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: Sequali, fast sequencing data quality metrics 

doc: |
  Sequence quality metrics for FASTQ and uBAM files.
  Documentation on how to install and run Sequali can be found here:
  https://sequali.readthedocs.io/en/latest/

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/sequali:0.12.0--py311haab0aaa_1
  SoftwareRequirement:
    packages:
      sequali:
        version: ["0.12.0"]
        specs: ["identifiers.org/RRID:SCR_026466"]
  
baseCommand: [ sequali ]

arguments:
  - valueFrom: "sequali_output"  # hardcoded to create output folder
    prefix: --outdir
    position: 3

inputs:
  input_file:
    type: File
    label: input file
    doc: Input file in FASTQ or uBAM format, compressed formats are supported.
    inputBinding:
      position: 1
  paired_input:
    type: File?
    label: second input file
    doc: Second input file for paired-end data.
    inputBinding:
      position: 2
  json_output:
    type: string?
    label: output json filename
    doc: File path for .json out put file, defaults to "<outdir>/($input_file).json".
    inputBinding:
      prefix: --json
  html_output:
    type: string?
    label: output HTML filename
    doc: File path for .json out put file, defaults to "<outdir>/($input_file).html".
    inputBinding:
      prefix: --html
  threads:
    type: int?
    label: CPU usage
    doc: The number of threads used, defaults to 2.
    inputBinding:
      prefix: --threads
  adapter_file:
    type: File?
    label: adapter file
    doc: |
      File with adapters to search for. See default file for formatting.
      Defaults to /home/docs/checkouts/readthedocs.org/user_builds/sequali/envs/latest/lib/python3.13/site-packages/sequali/adapters/adapter_list.tsv
      Default adapter file also present in the container: /usr/local/lib/python3.11/site-packages/sequali/adapters/adapter_list.tsv
    inputBinding:
      prefix: --adapter-file
  overrep_threshold_fraction:
    type: float?
    label: overrepresentation fraction
    doc: |
      At what fraction a sequence is determined to be overrepresented.
      Default: 0.001 (1 in 1000)
    inputBinding:
      prefix: --overrepresentation-threshold-fraction
  overrep_min_threshold:
    type: int?
    label: overrepresentation minimum
    doc: "Minimum occurrences for a sequence to be considered overrepresented regardless of the fraction. Default: 100"
    inputBinding:
      prefix: --overrepresentation-min-threshold
  overrep_max_threshold:
    type: int?
    label: overrepresentation maximum
    doc: "Maximum occurrences for a sequence to be considered overrepresented regardless of the fraction. Default: 9223372036854775807"
    inputBinding:
      prefix: --overrepresentation-max-threshold
  overrep_max_unique_fragments:
    type: int?
    label: maximum unique fragments
    doc: |
      Maximum amount of unique fragments to store.
      Larger amounts increase the sensitivity of finding overrepresented sequences at the cost of increasing memory usage. Default: 5000000
    inputBinding:
      prefix: --overrepresentation-max-unique-fragments
  overrep_fragment_length:
    type: int?
    label: fragment length
    doc: "Length of fragments to sample. Maximum is 31. Default: 21"
    inputBinding:
      prefix: --overrepresentation-fragment-length
  overrep_sample_every:
    type: int?
    label: sample frequency
    doc: |
      How often a read should be sampled.
      More samples improve precision at the cost of speed as well as more bias towards the beginning of the file as the fragment store gets filled up with more sequences from the beginning.
      Value is set ax 1 in X, defaults to 8
    inputBinding:
      prefix: --overrepresentation-sample-every
  #overrep_bases_from_start:  ## These two flags are present in sequali's documentation, but are not implemented in the current version
  #  type: int?
  #  label: minimum bases start
  #  doc: "Minimum bases sampled from the start of the read. Use a negative value to sample the entire read. Default: 100"
  #  inputBinding:
  #    prefix: --overrepresentation-bases-from-start
  #overrep_bases_from_end:
  #  type: int?
  #  label: minumum bases end
  #  doc: "Minimum bases sampled from the end of the read. Use a negative value to sample the entire read. Default: 100"
  #  inputBinding:
  #    prefix: --overrepresentation-bases-from-end
  duplication_max_stored_fingerprints:
    type: int?
    label: maximum number of fingerprints for duplication estimation
    doc: |
      Max number of fingerprints to store for estimation of duplication rate.
      More fingerprints leads to a more accurate estimate, but also more memory usage. Default: 1000000
    inputBinding:
      prefix: --duplication-max-stored-fingerprints
  fingerprint_front_length:
    type: int?
    label: amount of deduplication bases front
    doc: "Number of bases taken for the deduplication fingerprint from the front. Default: 8"
    inputBinding:
      prefix: --fingerprint-front-length
  fingerprint_back_length:
    type: int?
    label: amount of deduplication bases back
    doc: "Number of bases taken for the deduplication fingerprint from the back. Default: 8"
    inputBinding:
      prefix: --fingerprint-back-length
  fingerprint_front_offset:
    type: int?
    label: offset deduplication front
    doc: |
      Offset for the front part of the deduplication fingerprint. Useful for avoiding adapter sequences.
      Default: 64 for single end (0 for paired sequences).
    inputBinding:
      prefix: --fingerprint-front-offset
  fingerprint_back_offset:
    type: int?
    label: offset deduplication back
    doc: |
      Offset for the back part of the deduplication fingerprint. Useful for avoiding adapter sequences.
      Default: 64 for single end (0 for paired sequences).
    inputBinding:
      prefix: --fingerprint-back-offset

outputs:
  output_directory:
    type: Directory
    label: output directory
    outputBinding:
      glob: "sequali_output"
  report_html:
    type: File
    label: output HTML file
    format: edam:format_2331
    streamable: true  
    outputBinding:
      glob: "sequali_output/*.html"
  report_json: 
    type: File
    label: output JSON file
    format: edam:format_3464
    streamable: true
    outputBinding:
      glob: "sequali_output/*.json"

$namespaces:
  s: https://schema.org/   
  edam: http://edamontology.org/ 
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2025-02-24"
s:dateModified: "2025-02-24"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"