cwlVersion: v1.2
class: CommandLineTool
baseCommand: lohhla
label: lohhla
doc: "LOHHLA detects loss of heterozygosity (LOH) at the HLA locus in tumour sequencing data, using the patient HLA type and optional copy-number results.\n\nTool homepage: https://bitbucket.org/mcgranahanlab/lohhla"
inputs:
  - id: patient_id
    type: string
    doc: Patient ID.
    inputBinding:
      position: 1
      prefix: --patientId
  - id: output_dir
    type: string
    doc: Location of the output directory (created by the tool).
    inputBinding:
      position: 1
      prefix: --outputDir
  - id: normal_bam
    type:
      - 'null'
      - File
    doc: Normal BAM file.
    inputBinding:
      position: 1
      prefix: --normalBAMfile
  - id: bam_dir
    type: Directory
    doc: Location of all BAMs to test.
    inputBinding:
      position: 1
      prefix: --BAMDir
  - id: hla_path
    type: File
    doc: Location of the patient HLA calls.
    inputBinding:
      position: 1
      prefix: --hlaPath
  - id: hla_fasta
    type:
      - 'null'
      - File
    doc: Location of the HLA FASTA [default - ~/lohhla/data/hla_all.fasta].
    inputBinding:
      position: 1
      prefix: --HLAfastaLoc
  - id: copy_num
    type:
      - 'null'
      - File
    doc: Location of the patient purity and ploidy output. Can be FALSE to only estimate allelic imbalance.
    inputBinding:
      position: 1
      prefix: --CopyNumLoc
  - id: override_dir
    type:
      - 'null'
      - Directory
    doc: Location of flagstat information if already run [default - FALSE].
    inputBinding:
      position: 1
      prefix: --overrideDir
  - id: min_coverage_filter
    type:
      - 'null'
      - int
    doc: Minimum coverage at mismatch site [default - 30].
    inputBinding:
      position: 1
      prefix: --minCoverageFilter
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of kmers to fish with [default - 50].
    inputBinding:
      position: 1
      prefix: --kmerSize
  - id: num_mismatch
    type:
      - 'null'
      - int
    doc: Number of mismatches allowed in a read to map to an HLA allele [default - 1].
    inputBinding:
      position: 1
      prefix: --numMisMatch
  - id: mapping_step
    type:
      - 'null'
      - string
    doc: Does mapping to HLA alleles need to be done, TRUE or FALSE [default - TRUE].
    inputBinding:
      position: 1
      prefix: --mappingStep
  - id: fishing_step
    type:
      - 'null'
      - string
    doc: If mapping is performed, also look for fished reads matching kmers of size kmerSize, TRUE or FALSE [default - TRUE].
    inputBinding:
      position: 1
      prefix: --fishingStep
  - id: plotting_step
    type:
      - 'null'
      - string
    doc: Are plots made, TRUE or FALSE [default - TRUE].
    inputBinding:
      position: 1
      prefix: --plottingStep
  - id: coverage_step
    type:
      - 'null'
      - string
    doc: Are coverage differences analyzed, TRUE or FALSE [default - TRUE].
    inputBinding:
      position: 1
      prefix: --coverageStep
  - id: clean_up
    type:
      - 'null'
      - string
    doc: Remove temporary files, TRUE or FALSE [default - TRUE].
    inputBinding:
      position: 1
      prefix: --cleanUp
  - id: novo_dir
    type:
      - 'null'
      - string
    doc: Path to the novoalign executable (directory containing it).
    inputBinding:
      position: 1
      prefix: --novoDir
  - id: gatk_dir
    type:
      - 'null'
      - string
    doc: Path to the GATK executable.
    inputBinding:
      position: 1
      prefix: --gatkDir
  - id: hla_exon_loc
    type:
      - 'null'
      - File
    doc: HLA exon boundaries for plotting [default - ~/lohhla/data/hla.dat].
    inputBinding:
      position: 1
      prefix: --HLAexonLoc
  - id: ignore_warnings
    type:
      - 'null'
      - string
    doc: Continue running with warnings, TRUE or FALSE [default - TRUE].
    inputBinding:
      position: 1
      prefix: --ignoreWarnings
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory with the LOHHLA results.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lohhla:20171108--hdfd78af_3
