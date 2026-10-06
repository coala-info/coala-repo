cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - gapInfo
label: bamutil_gapInfo
doc: "Print information on the gap between read pairs in a SAM/BAM File.\n\nTool homepage:\
  \ http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: the SAM/BAM file to print read pair gap info for
    inputBinding:
      position: 1
      prefix: --in
  - id: out
    type: string
    doc: the output file to be written
    inputBinding:
      position: 1
      prefix: --out
  - id: ref_file
    type:
      - 'null'
      - File
    doc: reference file, used to skip gaps that include reference base 'N' (for runs
      without --detailed)
    inputBinding:
      position: 1
      prefix: --refFile
  - id: detailed
    type:
      - 'null'
      - boolean
    doc: Print the details for each read pair
    inputBinding:
      position: 1
      prefix: --detailed
  - id: check_first
    type:
      - 'null'
      - boolean
    doc: Check the first in pair flag and print "NotFirst" if it isn't first
    inputBinding:
      position: 1
      prefix: --checkFirst
  - id: check_strand
    type:
      - 'null'
      - boolean
    doc: Check the strand flag and print "Reverse" if it is reverse complimented
    inputBinding:
      position: 1
      prefix: --checkStrand
  - id: noeof
    type:
      - 'null'
      - boolean
    doc: Do not expect an EOF block on a bam file.
    inputBinding:
      position: 1
      prefix: --noeof
  - id: params
    type:
      - 'null'
      - boolean
    doc: Print the parameter settings
    inputBinding:
      position: 1
      prefix: --params
  - id: no_phone_home
    type:
      - 'null'
      - boolean
    doc: Do not send usage information (phone home)
    inputBinding:
      position: 1
      prefix: --noPhoneHome
  - id: phone_home_thinning
    type:
      - 'null'
      - int
    doc: Phone home thinning percentage [50]
    inputBinding:
      position: 1
      prefix: --phoneHomeThinning
outputs:
  - id: output_file
    type: File
    doc: Read pair gap information
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
