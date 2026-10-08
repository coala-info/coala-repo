cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_FilterSomaticVcf
doc: "Applies one or more filters to a VCF of somatic variants. The VCF must contain\
  \ genotype information for the tumor sample. If the VCF also contains genotypes\
  \ for one or more other samples, the '--sample' option must be provided to specify\
  \ the sample whose genotypes to examine and whose reads are present in the BAM file.\n\
  \nVarious options are available for filtering the reads coming from the BAM file,\
  \ including '--min-mapping-quality', '--min-base-quality' and '--paired-reads-only'.\
  \ The latter filters to only paired end reads where both reads are mapped. Reads\
  \ marked as duplicates, secondary alignments and supplemental alignments are all\
  \ filtered out.\n\nEach available filter may generate annotations in the 'INFO'\
  \ field of the output VCF and optionally, if a threshold is specified, may apply\
  \ one or more 'FILTER's to applicable variants.\n\nIn previous versions of this\
  \ tool, the only available filter was specific to A-base addition artifacts and\
  \ was referred to as the 'End Repair Artifact Filter.' This filter has been renamed\
  \ to 'A-tailing Artifact Filter', but its functionality is unchanged. The filter's\
  \ associated command-line parameters, 'INFO' field key, and 'FILTER' tag have also\
  \ been renamed accordingly, as described below.\n\nAvailable Filters -----------------\n\
  \nA-tailing Artifact Filter (previously 'End Repair Artifact Filter') -------------------------------------------------------------------\n\
  \nThe A-tailing artifact filter attempts to measure the probability that a single-nucleotide\
  \ mismatch is the product of errors in the template generated during the A-base\
  \ addition steps that are common to many Illumina library preparation protocols.\
  \ The artifacts occur if/when a recessed 3' end is incorrectly filled in with one\\\
  \ or more adenines during A-base addition. Incorrect adenine incorporation presents\
  \ specifically as errors to T at the beginning of reads (and in very short templates,\
  \ as matching errors to A at the ends of reads).\n\nThe filter adds the 'INFO' field\
  \ 'ATAP' (previously 'ERAP') to SNVs with an A or T alternate allele. This field\
  \ records the p-value representing the probability of the null hypothesis that the\
  \ variant is a true mutation, so lower p-values indicate that the variant is more\
  \ likely an A-tailing artifact. If a threshold p-value is specified, the 'FILTER'\
  \ tag 'ATailingArtifact' (previously 'EndRepairArtifact') will be applied to variants\
  \ with p-values less than or equal to the threshold.\n\nTwo options are available:\n\
  \n  * '--a-tailing-distance' (previously '--end-repair-distance') allows control\
  \ over how close to the ends of\n    reads/templates errors can be considered to\
  \ be candidates for the A-tailing artifact. Higher values decrease the\n    power\
  \ of the test, so this should be set as low as possible given observed errors.\n\
  \  * '--a-tailing-p-value' (previously '--end-repair-p-value') the p-value at or\
  \ below which a filter should be applied.\n    If no value is supplied only the\
  \ 'INFO' annotation is produced and no 'FILTER' is applied.\n\nEnd Repair Fill-in\
  \ Artifact Filter ----------------------------------\n\nThe end repair fill-in artifact\
  \ filter attempts to measure the probability that a single-nucleotide mismatch is\
  \ the product of an error in the template generated during the end repair fill-in\
  \ step that is common to many Illumina library preparation protocols, in which single-stranded\
  \ 3' overhangs are filled in to create a blunt end. These artifacts originate from\
  \ single-stranded templates containing damaged bases, often as a consequence of\
  \ oxidative damage. These DNA lesions, for example 8-oxoguanine, undergo mismatched\
  \ pairing, which after PCR appear as mutations at the ends of reads.\n\nThe filter\
  \ adds the 'INFO' field 'ERFAP' to records SNVs. This field records the p-value\
  \ representing the probability of the null hypothesis (e.g. that the variant is\
  \ a true mutation), so lower p-values indicate that the variant is more likely an\
  \ end repair fill-in artifact. If a threshold p-value is specified, then the 'FILTER'\
  \ tag 'EndRepairFillInArtifact' will be applied to variants with p-values less than\
  \ or equal to the threshold.\n\nTwo options are available:\n\n  * '--end-repair-fill-in-distance'\
  \ allows control over how close to the ends of reads/templates errors can be\n \
  \   considered to be candidates for the artifact. Higher values decrease the power\
  \ of the test, so this should be set as\n    low as possible given observed errors.\n\
  \  * '--end-repair-fill-in-p-value' the p-value below which a filter should be applied.\
  \ If no value is supplied only the\n    annotation is produced and no filtering\
  \ is performed.\n\nPerformance Expectations ------------------------\n\nBy default\
  \ '--access-pattern' will be set to 'RandomAccess' and the input BAM will be queried\
  \ using index-based random access. Random access is mandatory if the input VCF is\
  \ not coordinate sorted. If random access is not requested and the input VCF is\
  \ not coordinate sorted, then an exception will be raised on the first non-coordinate\
  \ increasing VCF record found. The BAM must be coordinate sorted in all cases and\
  \ additionally be indexed if random access is requested.\n\nOften, a VCF file will\
  \ contain a sparse set of records that are scattered across a given territory within\
  \ a genome (or the records will be sparsely scattered genome-wide). If the territory\
  \ of the VCF records is markedly smaller than the territory of all aligned SAM records\
  \ in the BAM file, then random access may be the most efficient BAM access pattern.\
  \ However, there are cases where random access will be less efficient such as when\
  \ the VCF is coordinate sorted and the variant call records are very densely packed\
  \ across a similar territory as compared to all aligned SAM records. Such a case\
  \ is common in deeply sequenced hybrid selection NGS experiments and setting '--access-pattern'\
  \ to 'Streaming' will often be the most efficient BAM access pattern.\n\nTool homepage:\
  \ https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: a_tailing_distance
    type:
      - 'null'
      - string
    doc: 'Distance from 5-prime end of read to implicate A-base addition artifacts.
      Set to :none: to deactivate the filter.'
    inputBinding:
      position: 101
      prefix: --a-tailing-distance
  - id: a_tailing_p_value
    type:
      - 'null'
      - float
    doc: Minimum acceptable p-value for the A-base addition artifact test.
    inputBinding:
      position: 101
      prefix: --a-tailing-p-value
  - id: access_pattern
    type:
      - 'null'
      - string
    doc: 'The type of BAM access pattern to use. Options: RandomAccess, Streaming.'
    inputBinding:
      position: 101
      prefix: --access-pattern
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: bam
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    type: File
    doc: BAM file for the tumor sample.
    inputBinding:
      position: 101
      prefix: --bam
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 1
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 1
      prefix: --cram-ref-fasta
  - id: end_repair_fill_in_distance
    type:
      - 'null'
      - string
    doc: 'Distance from 5-prime end of read to implicate end repair fill-in artifacts.
      Set to :none: to deactivate the filter.'
    inputBinding:
      position: 101
      prefix: --end-repair-fill-in-distance
  - id: end_repair_fill_in_p_value
    type:
      - 'null'
      - float
    doc: Minimum acceptable p-value for the end repair fill-in artifact test.
    inputBinding:
      position: 101
      prefix: --end-repair-fill-in-p-value
  - id: input_vcf
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
    type: File
    doc: Input VCF of somatic variant calls.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality.
    inputBinding:
      position: 101
      prefix: --min-base-quality
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for reads.
    inputBinding:
      position: 101
      prefix: --min-mapping-quality
  - id: output_vcf
    type: string
    doc: Output VCF of filtered somatic variants.
    inputBinding:
      position: 101
      prefix: --output
  - id: paired_reads_only
    type:
      - 'null'
      - boolean
    doc: Use only paired reads mapped in pairs.
    inputBinding:
      position: 101
      prefix: --paired-reads-only
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name in VCF if '> 1' sample present.
    inputBinding:
      position: 101
      prefix: --sample
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
arguments:
  - position: 50
    valueFrom: FilterSomaticVcf
outputs:
  - id: output_vcf_out
    type: File
    doc: Output VCF of filtered somatic variants.
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
