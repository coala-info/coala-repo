cwlVersion: v1.2
class: CommandLineTool
baseCommand: vase
label: vase
doc: "Variant annotation, segregation and exclusion.\n\nTool homepage: https://github.com/david-a-parry/vase"
inputs:
  - id: ac
    type:
      - 'null'
      - int
    doc: "Maximum AC value in input VCF. Any allele with an\n                    \
      \    AC > than this value will be filtered."
    inputBinding:
      position: 101
      prefix: --ac
  - id: af
    type:
      - 'null'
      - float
    doc: "Maximum AF value in input VCF. Any allele with an\n                    \
      \    AF > than this value will be filtered."
    inputBinding:
      position: 101
      prefix: --af
  - id: bed
    type:
      - 'null'
      - File
    doc: "Only include variants overlapping the intervals in\n                   \
      \     the provided BED file."
    inputBinding:
      position: 101
      prefix: --bed
  - id: biallelic
    type:
      - 'null'
      - boolean
    doc: "Identify variants matching a recessive inheritance\n                   \
      \     pattern in cases present in the PED file specified\n                 \
      \       by the --ped argument. Input must be VEP\n                        annotated.
      If the --csq argument is given, only\n                        variants/alleles
      resulting in the given functional\n                        consequences will
      be used to identify qualifying\n                        variants/alleles, otherwise
      the default set of\n                        VEP consequences (see --csq argument
      for details)\n                        will be used."
    inputBinding:
      position: 101
      prefix: --biallelic
  - id: biallelic
    type:
      - 'null'
      - boolean
    doc: "Identify variants matching a recessive inheritance\n                   \
      \     pattern in cases present in the PED file specified\n                 \
      \       by the --ped argument. Input must be VEP\n                        annotated.
      If the --csq argument is given, only\n                        variants/alleles
      resulting in the given functional\n                        consequences will
      be used to identify qualifying\n                        variants/alleles, otherwise
      the default set of\n                        VEP consequences (see --csq argument
      for details)\n                        will be used."
    inputBinding:
      position: 101
      prefix: -biallelic
  - id: biotypes
    type:
      - 'null'
      - type: array
        items: string
    doc: "When used in conjunction with --csq argument,\n                        ignore
      consequences in biotypes other than those\n                        specified
      here. By default only consequences in\n                        features with
      the following biotypes are\n                        considered:\n\n        \
      \                            3prime_overlapping_ncrna\n                    \
      \                antisense\n                                    CTCF_binding_site\n\
      \                                    enhancer\n                            \
      \        IG_C_gene\n                                    IG_D_gene\n        \
      \                            IG_J_gene\n                                   \
      \ IG_V_gene\n                                    lincRNA\n                 \
      \                   miRNA\n                                    misc_RNA\n  \
      \                                  Mt_rRNA\n                               \
      \     Mt_tRNA\n                                    open_chromatin_region\n \
      \                                   polymorphic_pseudogene\n               \
      \                     processed_transcript\n                               \
      \     promoter\n                                    promoter_flanking_region\n\
      \                                    protein_coding\n                      \
      \              rRNA\n                                    sense_intronic\n  \
      \                                  sense_overlapping\n                     \
      \               snoRNA\n                                    snRNA\n        \
      \                            TF_binding_site\n                             \
      \       translated_processed_pseudogene\n                                  \
      \  TR_C_gene\n                                    TR_D_gene\n              \
      \                      TR_J_gene\n                                    TR_V_gene\n\
      \n                        Use this argument to specify one or more biotypes\n\
      \                        to consider instead of those listed above. You may\n\
      \                        also include the value 'default' in your list to\n\
      \                        include the default values listed above in\n      \
      \                  addition to others provided to this argument. Alternatively
      you may use the value 'all' to\n                        disable filtering on
      biotypes."
    inputBinding:
      position: 101
      prefix: --biotypes
  - id: build
    type:
      - 'null'
      - string
    doc: "dbSNP build version cutoff. For use with --dbsnp\n                     \
      \   files. Alleles/variants present in this dbSNP\n                        build
      or earlier will be filtered from input.\n                        from your input."
    inputBinding:
      position: 101
      prefix: --build
  - id: build
    type:
      - 'null'
      - string
    doc: "dbSNP build version cutoff. For use with --dbsnp\n                     \
      \   files. Alleles/variants present in this dbSNP\n                        build
      or earlier will be filtered from input.\n                        from your input."
    inputBinding:
      position: 101
      prefix: --build
  - id: burden_counts
    type:
      - 'null'
      - File
    doc: "File for outputting 'burden counts' per\n                        transcript.
      If specified, the number of alleles\n                        passing specified
      filters will be counted for\n                        each transcript identified.
      Requires your VCF\n                        input to be annotated with Ensembl's
      VEP. Note,\n                        that if --cases or --controls are specified
      when\n                        using this argument, variants will not be filtered\n\
      \                        on presence in cases/controls; instead counts will\n\
      \                        be written for cases and controls to this file."
    inputBinding:
      position: 101
      prefix: --burden_counts
  - id: cadd_dir
    type:
      - 'null'
      - Directory
    doc: "Directory containing one or more tabix indexed\n                       \
      \ CADD annotation files to be used as above. Only\n                        files
      with '.gz' or '.bgz' extensions will be\n                        included."
    inputBinding:
      position: 101
      prefix: -cadd_dir
  - id: cadd_directory
    type:
      - 'null'
      - Directory
    doc: "Directory containing one or more tabix indexed\n                       \
      \ CADD annotation files to be used as above. Only\n                        files
      with '.gz' or '.bgz' extensions will be\n                        included."
    inputBinding:
      position: 101
      prefix: --cadd_directory
  - id: cadd_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more tabix indexed CADD annotation files\n                      \
      \  (such as those found at\n                        http://cadd.gs.washington.edu/download).
      Variants\n                        in your input that match any scored variant
      in\n                        these files will have the CADD RawScore and PHRED\n\
      \                        values added to the INFO field, one per ALT\n     \
      \                   allele. Alleles/variants can be filtered on these\n    \
      \                    scores using the --cadd_phred or --cadd_raw\n         \
      \               options."
    inputBinding:
      position: 101
      prefix: --cadd_files
  - id: cadd_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more tabix indexed CADD annotation files\n                      \
      \  (such as those found at\n                        http://cadd.gs.washington.edu/download).
      Variants\n                        in your input that match any scored variant
      in\n                        these files will have the CADD RawScore and PHRED\n\
      \                        values added to the INFO field, one per ALT\n     \
      \                   allele. Alleles/variants can be filtered on these\n    \
      \                    scores using the --cadd_phred or --cadd_raw\n         \
      \               options."
    inputBinding:
      position: 101
      prefix: -cadd_files
  - id: cadd_phred
    type:
      - 'null'
      - float
    doc: "CADD PHRED score cutoff. Variants with a CADD\n                        PHRED
      score below this value will be filtered. Only\n                        used
      with annotations from files supplied to\n                        --cadd_files
      or --cadd_dir arguments or a\n                        pre-annotated CADD_PHRED_score
      INFO field. To\n                        filter on CADD scores annotated using
      the VEP\n                        dbNSFP plugin use the --missense_filters option."
    inputBinding:
      position: 101
      prefix: --cadd_phred
  - id: cadd_raw
    type:
      - 'null'
      - float
    doc: "CADD RawScore cutoff. Variants with a CADD\n                        RawScore
      below this value will be filtered. Only\n                        used with annotations
      from files supplied to\n                        --cadd_files or --cadd_dir arguments
      or a\n                        pre-annotated CADD_raw_score INFO field. To filter\n\
      \                        on CADD scores annotated using the VEP dbNSFP\n   \
      \                     plugin use the --missense_filters option."
    inputBinding:
      position: 101
      prefix: --cadd_raw
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: "When used in conjunction with --csq argument,\n                        ignore
      consequences for non-canonical transcripts."
    inputBinding:
      position: 101
      prefix: --canonical
  - id: cases
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more sample IDs to treat as cases. Default\n                    \
      \    behaviour is to retain variants/alleles present in\n                  \
      \      all of these samples as long as they are not\n                      \
      \  present in any sample specified using the\n                        '--controls'
      option. This behaviour can be\n                        adjusted using other
      options detailed below."
    inputBinding:
      position: 101
      prefix: --cases
  - id: cases
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more sample IDs to treat as cases. Default\n                    \
      \    behaviour is to retain variants/alleles present in\n                  \
      \      all of these samples as long as they are not\n                      \
      \  present in any sample specified using the\n                        '--controls'
      option. This behaviour can be\n                        adjusted using other
      options detailed below."
    inputBinding:
      position: 101
      prefix: --cases
  - id: check_g2p_consequence
    type:
      - 'null'
      - boolean
    doc: "If using --g2p option, use this flag to require\n                      \
      \  that the observed consequence matches the\n                        'mutation
      consequence' in the specified G2P file."
    inputBinding:
      position: 101
      prefix: --check_g2p_consequence
  - id: check_g2p_inheritance
    type:
      - 'null'
      - boolean
    doc: "If using --g2p option, use this flag to require\n                      \
      \  that the observed inheritance or\n                        hetero/hemi/homozygosity
      of alleles match the\n                        requirement specified in the specified
      G2P file.\n                        Requires at least one of --recessive/--de_novo/\n\
      \                        --dominant/singleton_recessive/singleton_dominant\n\
      \                        arguments."
    inputBinding:
      position: 101
      prefix: --check_g2p_inheritance
  - id: clinvar
    type:
      - 'null'
      - type: array
        items: File
    doc: "dbSNP or ClinVar VCF file for variant\n                        annotating/filtering."
    inputBinding:
      position: 101
      prefix: --clinvar
  - id: clinvar_path
    type:
      - 'null'
      - boolean
    doc: "Retain variants with ClinVar 'likely pathogenic'\n                     \
      \   or 'pathogenic' flags regardless of frequency or\n                     \
      \   other settings provided to other Annotation File\n                     \
      \   Arguments. This requires one of the files\n                        provided
      to --dbsnp to have CLNSIG annotations\n                        from ClinVar."
    inputBinding:
      position: 101
      prefix: --clinvar_path
  - id: clinvar_path
    type:
      - 'null'
      - boolean
    doc: "Retain variants with ClinVar 'likely pathogenic'\n                     \
      \   or 'pathogenic' flags regardless of frequency or\n                     \
      \   other settings provided to other Annotation File\n                     \
      \   Arguments. This requires one of the files\n                        provided
      to --dbsnp to have CLNSIG annotations\n                        from ClinVar."
    inputBinding:
      position: 101
      prefix: --clinvar_path
  - id: confirm_control_gts
    type:
      - 'null'
      - boolean
    doc: "If using the --controls argument, also filter\n                        variants
      if any control sample is either a no-call\n                        or fails
      specified genotype quality, depth or\n                        allele balance
      thresholds. If used in conjunction\n                        with the --n_controls
      option, control samples with\n                        no-call genotypes or genotypes
      failing the above\n                        thresholds will be counted towards
      the number of\n                        controls with an allele/variant."
    inputBinding:
      position: 101
      prefix: --confirm_control_gts
  - id: confirm_control_gts
    type:
      - 'null'
      - boolean
    doc: "If using the --controls argument, also filter\n                        variants
      if any control sample is either a no-call\n                        or fails
      specified genotype quality, depth or\n                        allele balance
      thresholds. If used in conjunction\n                        with the --n_controls
      option, control samples with\n                        no-call genotypes or genotypes
      failing the above\n                        thresholds will be counted towards
      the number of\n                        controls with an allele/variant."
    inputBinding:
      position: 101
      prefix: --confirm_control_gts
  - id: control_dp
    type:
      - 'null'
      - int
    doc: "Minimum depth threshold for\n                        parents/unaffecteds/controls
      when filtering\n                        variants. Defaults to the same value
      as --dp but\n                        you may wish to set this to a lower value
      if, for\n                        example, you require less evidence from\n \
      \                       controls/unaffected in order to filter a variant\n \
      \                       or from parental genotype calls when confirming\n  \
      \                      a potential de novo variant."
    inputBinding:
      position: 101
      prefix: --control_dp
  - id: control_dp
    type:
      - 'null'
      - int
    doc: "Minimum depth threshold for\n                        parents/unaffecteds/controls
      when filtering\n                        variants. Defaults to the same value
      as --dp but\n                        you may wish to set this to a lower value
      if, for\n                        example, you require less evidence from\n \
      \                       controls/unaffected in order to filter a variant\n \
      \                       or from parental genotype calls when confirming\n  \
      \                      a potential de novo variant."
    inputBinding:
      position: 101
      prefix: -con_dp
  - id: control_duphold_del_dhffc
    type:
      - 'null'
      - float
    doc: "Maximum fold-change for deletion calls relative to\n                   \
      \     flanking regions as annotated by duphold for\n                       \
      \ parent/unaffected/control sample het/homozygous\n                        alternative
      calls. Defaults to the same value as\n                        --duphold_del_dhffc
      but you may wish to set this\n                        to a higher value if,
      for example, you require\n                        less evidence from controls/unaffected
      in order to\n                        filter a variant or from parental genotype
      calls\n                        when confirming a potential de novo variant."
    inputBinding:
      position: 101
      prefix: --control_duphold_del_dhffc
  - id: control_duphold_del_dhffc
    type:
      - 'null'
      - float
    doc: "Maximum fold-change for deletion calls relative to\n                   \
      \     flanking regions as annotated by duphold for\n                       \
      \ parent/unaffected/control sample het/homozygous\n                        alternative
      calls. Defaults to the same value as\n                        --duphold_del_dhffc
      but you may wish to set this\n                        to a higher value if,
      for example, you require\n                        less evidence from controls/unaffected
      in order to\n                        filter a variant or from parental genotype
      calls\n                        when confirming a potential de novo variant."
    inputBinding:
      position: 101
      prefix: --control_duphold_del_dhffc
  - id: control_duphold_dup_dhbfc
    type:
      - 'null'
      - float
    doc: "Minimum fold-change for duplication calls relative\n                   \
      \     to flanking regions as annotated by duphold for\n                    \
      \    parent/unaffected/control sample het/homozygous\n                     \
      \   alternative calls. Defaults to the same value as\n                     \
      \   --duphold_dup_dhbfc but you may wish to set this\n                     \
      \   to a lower value if, for example, you require\n                        less
      evidence from controls/unaffected in order to\n                        filter
      a variant or from parental genotype calls\n                        when confirming
      a potential de novo variant."
    inputBinding:
      position: 101
      prefix: --control_duphold_dup_dhbfc
  - id: control_duphold_dup_dhbfc
    type:
      - 'null'
      - float
    doc: "Minimum fold-change for duplication calls relative\n                   \
      \     to flanking regions as annotated by duphold for\n                    \
      \    parent/unaffected/control sample het/homozygous\n                     \
      \   alternative calls. Defaults to the same value as\n                     \
      \   --duphold_dup_dhbfc but you may wish to set this\n                     \
      \   to a lower value if, for example, you require\n                        less
      evidence from controls/unaffected in order to\n                        filter
      a variant or from parental genotype calls\n                        when confirming
      a potential de novo variant."
    inputBinding:
      position: 101
      prefix: --control_duphold_dup_dhbfc
  - id: control_gq
    type:
      - 'null'
      - int
    doc: "Minimum genotype quality score threshold for\n                        parents/unaffecteds/controls
      when filtering\n                        variants. Defaults to the same value
      as --gq but\n                        you may wish to set this to a lower value
      if, for\n                        example, you require less evidence from\n \
      \                       controls/unaffected in order to filter a variant\n \
      \                       or from parental genotype calls when confirming\n  \
      \                      a potential de novo variant."
    inputBinding:
      position: 101
      prefix: --control_gq
  - id: control_gq
    type:
      - 'null'
      - int
    doc: "Minimum genotype quality score threshold for\n                        parents/unaffecteds/controls
      when filtering\n                        variants. Defaults to the same value
      as --gq but\n                        you may wish to set this to a lower value
      if, for\n                        example, you require less evidence from\n \
      \                       controls/unaffected in order to filter a variant\n \
      \                       or from parental genotype calls when confirming\n  \
      \                      a potential de novo variant."
    inputBinding:
      position: 101
      prefix: -con_gq
  - id: control_het_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for heterozygous\n                     \
      \   genotypes. Heterozygous sample genotype calls\n                        with
      a ratio of the alternate allele vs total\n                        depth lower
      than this threshold will be treated as\n                        no-calls. Defaults
      to the same as --het_ab but\n                        you may wish to set this
      to a lower value if, for\n                        example, you require less
      evidence from\n                        controls/unaffected in order to filter
      a variant."
    inputBinding:
      position: 101
      prefix: --control_het_ab
  - id: control_het_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for heterozygous\n                     \
      \   genotypes. Heterozygous sample genotype calls\n                        with
      a ratio of the alternate allele vs total\n                        depth lower
      than this threshold will be treated as\n                        no-calls. Defaults
      to the same as --het_ab but\n                        you may wish to set this
      to a lower value if, for\n                        example, you require less
      evidence from\n                        controls/unaffected in order to filter
      a variant."
    inputBinding:
      position: 101
      prefix: -con_het_ab
  - id: control_hom_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for homozygous\n                       \
      \ genotypes. Homozygous sample genotype calls\n                        with
      a ratio of the alternate allele vs total\n                        depth lower
      than this threshold will be treated as\n                        no-calls. Defaults
      to the same as --hom_ab but\n                        you may wish to set this
      to a lower value if, for\n                        example, you require less
      evidence from\n                        controls/unaffected in order to filter
      a variant."
    inputBinding:
      position: 101
      prefix: --control_hom_ab
  - id: control_hom_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for homozygous\n                       \
      \ genotypes. Homozygous sample genotype calls\n                        with
      a ratio of the alternate allele vs total\n                        depth lower
      than this threshold will be treated as\n                        no-calls. Defaults
      to the same as --hom_ab but\n                        you may wish to set this
      to a lower value if, for\n                        example, you require less
      evidence from\n                        controls/unaffected in order to filter
      a variant."
    inputBinding:
      position: 101
      prefix: -con_hom_ab
  - id: control_max_dp
    type:
      - 'null'
      - int
    doc: "Maximum depth threshold for\n                        parents/unaffecteds/controls
      when filtering\n                        variants. Defaults to the same value
      as --max_dp."
    inputBinding:
      position: 101
      prefix: --control_max_dp
  - id: control_max_dp
    type:
      - 'null'
      - int
    doc: "Maximum depth threshold for\n                        parents/unaffecteds/controls
      when filtering\n                        variants. Defaults to the same value
      as --max_dp."
    inputBinding:
      position: 101
      prefix: -con_max_dp
  - id: control_max_ref_ab
    type:
      - 'null'
      - float
    doc: "Maximum genotype allele balance for\n                        parents/unaffecteds/controls
      with reference (0/0)\n                        genotypes when filtering variants.
      If you wish to\n                        count/exclude variants where controls/unaffecteds\n\
      \                        are called as homozygous reference but still have a\n\
      \                        low proportion of ALT alleles specify a suitable\n\
      \                        cutoff here."
    inputBinding:
      position: 101
      prefix: --control_max_ref_ab
  - id: control_max_ref_ab
    type:
      - 'null'
      - float
    doc: "Maximum genotype allele balance for\n                        parents/unaffecteds/controls
      with reference (0/0)\n                        genotypes when filtering variants.
      If you wish to\n                        count/exclude variants where controls/unaffecteds\n\
      \                        are called as homozygous reference but still have a\n\
      \                        low proportion of ALT alleles specify a suitable\n\
      \                        cutoff here."
    inputBinding:
      position: 101
      prefix: -con_max_ref_ab
  - id: controls
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more sample IDs to treat as controls.\n                        Default
      behaviour is to filter variants/alleles\n                        present in
      any of these samples. This behaviour\n                        can be adjusted
      using other options detailed\n                        below."
    inputBinding:
      position: 101
      prefix: --controls
  - id: controls
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more sample IDs to treat as controls.\n                        Default
      behaviour is to filter variants/alleles\n                        present in
      any of these samples. This behaviour\n                        can be adjusted
      using other options detailed\n                        below."
    inputBinding:
      position: 101
      prefix: --controls
  - id: csq
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more VEP consequence classes to retain.\n                       \
      \ Variants which do not result in one of these VEP\n                       \
      \ consequence classes will be filtered. If this\n                        option
      is used with no values then the following\n                        default classes
      will be used:\n\n                                          TFBS_ablation\n \
      \                                         TFBS_amplification\n             \
      \                             inframe_deletion\n                           \
      \               inframe_insertion\n                                        \
      \  frameshift_variant\n                                          initiator_codon_variant\n\
      \                                          missense_variant\n              \
      \                            protein_altering_variant\n                    \
      \                      regulatory_region_ablation\n                        \
      \                  regulatory_region_amplification\n                       \
      \                   splice_acceptor_variant\n                              \
      \            splice_donor_variant\n                                        \
      \  start_lost\n                                          stop_gained\n     \
      \                                     stop_lost\n                          \
      \                transcript_ablation\n                                     \
      \     transcript_amplification\n\n                        You may also pass
      the value \"default\" in order to\n                        include these default
      classes in addition to other\n                        specified classes. Alternatively,
      you may specify\n                        'all' to include all consequence types
      if, for\n                        example, you want to filter on other VEP\n\
      \                        annotations (e.g. allele frequency or biotype)\n  \
      \                      irrespective of consequence.\n\n                    \
      \    Note, that using the --csq option automatically\n                     \
      \   turns on biotype filtering (see the --biotypes\n                       \
      \ option below)."
    inputBinding:
      position: 101
      prefix: --csq
  - id: dbsnp
    type:
      - 'null'
      - type: array
        items: File
    doc: "dbSNP or ClinVar VCF file for variant\n                        annotating/filtering."
    inputBinding:
      position: 101
      prefix: --dbsnp
  - id: dbsnp
    type:
      - 'null'
      - type: array
        items: File
    doc: "dbSNP or ClinVar VCF file for variant\n                        annotating/filtering."
    inputBinding:
      position: 101
      prefix: --dbsnp
  - id: de_novo
    type:
      - 'null'
      - boolean
    doc: "Idenfify apparent de novo variants in cases\n                        present
      in the PED file specified by the --ped\n                        argument. This
      requires that at least one\n                        parent-child trio exists
      in the given PED file."
    inputBinding:
      position: 101
      prefix: --de_novo
  - id: de_novo
    type:
      - 'null'
      - boolean
    doc: "Idenfify apparent de novo variants in cases\n                        present
      in the PED file specified by the --ped\n                        argument. This
      requires that at least one\n                        parent-child trio exists
      in the given PED file."
    inputBinding:
      position: 101
      prefix: -de_novo
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output debugging level information to STDERR.
    inputBinding:
      position: 101
      prefix: --debug
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output debugging level information to STDERR.
    inputBinding:
      position: 101
      prefix: --debug
  - id: dng_vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more VCFs created by DeNovoGear for adding\n                    \
      \    PP_DNM and PP_NULL fields to sample calls."
    inputBinding:
      position: 101
      prefix: --dng_vcf
  - id: dng_vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more VCFs created by DeNovoGear for adding\n                    \
      \    PP_DNM and PP_NULL fields to sample calls."
    inputBinding:
      position: 101
      prefix: --dng_vcf
  - id: dominant
    type:
      - 'null'
      - boolean
    doc: "Idenfify variants segregating in manner matching\n                     \
      \   dominant inheritance in cases present in the PED\n                     \
      \   file specified by the --ped argument."
    inputBinding:
      position: 101
      prefix: --dominant
  - id: dominant
    type:
      - 'null'
      - boolean
    doc: "Idenfify variants segregating in manner matching\n                     \
      \   dominant inheritance in cases present in the PED\n                     \
      \   file specified by the --ped argument."
    inputBinding:
      position: 101
      prefix: -dominant
  - id: dp
    type:
      - 'null'
      - int
    doc: "Minimum genotype depth threshold. Sample genotype\n                    \
      \    calls with a read depth lower than this threshold\n                   \
      \     will be treated as no-calls. Default = 0."
    default: 0
    inputBinding:
      position: 101
      prefix: --dp
  - id: dp
    type:
      - 'null'
      - int
    doc: "Minimum genotype depth threshold. Sample genotype\n                    \
      \    calls with a read depth lower than this threshold\n                   \
      \     will be treated as no-calls. Default = 0."
    default: 0
    inputBinding:
      position: 101
      prefix: -dp
  - id: duphold_del_dhffc
    type:
      - 'null'
      - float
    doc: "Maximum fold-change for deletion calls relative to\n                   \
      \     flanking regions as annotated by duphold\n                        (https://github.com/brentp/duphold).
      Deletion\n                        calls will be filtered if the DHFFC annotation\n\
      \                        from duphold is greater than this value."
    inputBinding:
      position: 101
      prefix: --duphold_del_dhffc
  - id: duphold_del_dhffc
    type:
      - 'null'
      - float
    doc: "Maximum fold-change for deletion calls relative to\n                   \
      \     flanking regions as annotated by duphold\n                        (https://github.com/brentp/duphold).
      Deletion\n                        calls will be filtered if the DHFFC annotation\n\
      \                        from duphold is greater than this value."
    inputBinding:
      position: 101
      prefix: --duphold_del_dhffc
  - id: duphold_dup_dhbfc
    type:
      - 'null'
      - float
    doc: "Minimum fold-change for duplication calls relative\n                   \
      \     to flanking regions as annotated by duphold\n                        (https://github.com/brentp/duphold).
      Duplication\n                        calls will be filtered if the DHBFC annotation\n\
      \                        from duphold is less than this value."
    inputBinding:
      position: 101
      prefix: --duphold_dup_dhbfc
  - id: duphold_dup_dhbfc
    type:
      - 'null'
      - float
    doc: "Minimum fold-change for duplication calls relative\n                   \
      \     to flanking regions as annotated by duphold\n                        (https://github.com/brentp/duphold).
      Duplication\n                        calls will be filtered if the DHBFC annotation\n\
      \                        from duphold is less than this value."
    inputBinding:
      position: 101
      prefix: --duphold_dup_dhbfc
  - id: exac
    type:
      - 'null'
      - type: array
        items: File
    doc: "gnomAD/ExAC file for variant annotating/filtering\n                    \
      \    using population allele frequencies. By default\n                     \
      \   allele frequencies from AFR, AMR, EAS, FIN, NFE\n                      \
      \  and SAS populations are used. Populations to use\n                      \
      \  can be chosen with the --gnomad_pops argument."
    inputBinding:
      position: 101
      prefix: --exac
  - id: exac
    type:
      - 'null'
      - type: array
        items: File
    doc: "gnomAD/ExAC file for variant annotating/filtering\n                    \
      \    using population allele frequencies. By default\n                     \
      \   allele frequencies from AFR, AMR, EAS, FIN, NFE\n                      \
      \  and SAS populations are used. Populations to use\n                      \
      \  can be chosen with the --gnomad_pops argument."
    inputBinding:
      position: 101
      prefix: --exac
  - id: exclude_filters
    type:
      - 'null'
      - type: array
        items: string
    doc: "Filter variants that have these FILTER Fields.\n                       \
      \ If multiple filter annotations are given for a\n                        variant
      it will be excluded if any match one of\n                        the given fields."
    inputBinding:
      position: 101
      prefix: --exclude_filters
  - id: exclude_regions
    type:
      - 'null'
      - boolean
    doc: "When using region filtering arguments, output\n                        variants
      that do NOT overlap regions instead of\n                        those that do.
      This forces streaming rather than\n                        index-jumping retrieval."
    inputBinding:
      position: 101
      prefix: --exclude_regions
  - id: feature_blacklist
    type:
      - 'null'
      - File
    doc: "A file containing a list of Features (e.g. Ensembl\n                   \
      \     transcript IDs) to ignore. These must correspond\n                   \
      \     to the IDs in the 'Feature' field annotated by\n                     \
      \   VEP."
    inputBinding:
      position: 101
      prefix: --feature_blacklist
  - id: filter_asterisk_only_calls
    type:
      - 'null'
      - boolean
    doc: Filter variants where the only ALT allele is '*'.
    inputBinding:
      position: 101
      prefix: --filter_asterisk_only_calls
  - id: filter_known
    type:
      - 'null'
      - boolean
    doc: "Filter any allele/variant present in any of the\n                      \
      \  files supplied to --gnomad, --dbsnp or\n                        --vcf_filter
      arguments, or if using '--csq' if any\n                        allele frequency
      is recorded for any of VEP's AF\n                        annotations. This will
      also filter\n                        alleles/variants if an annotation from
      --gnomad or\n                        --dbsnp is present from a previous run
      unless the\n                        --ignore_existing_annotations option is
      given."
    inputBinding:
      position: 101
      prefix: --filter_known
  - id: filter_known
    type:
      - 'null'
      - boolean
    doc: "Filter any allele/variant present in any of the\n                      \
      \  files supplied to --gnomad, --dbsnp or\n                        --vcf_filter
      arguments, or if using '--csq' if any\n                        allele frequency
      is recorded for any of VEP's AF\n                        annotations. This will
      also filter\n                        alleles/variants if an annotation from
      --gnomad or\n                        --dbsnp is present from a previous run
      unless the\n                        --ignore_existing_annotations option is
      given."
    inputBinding:
      position: 101
      prefix: --filter_known
  - id: filter_novel
    type:
      - 'null'
      - boolean
    doc: "Filter any allele/variant NOT present in\n                        any of
      the files supplied to --gnomad or --dbsnp or\n                        --vcf_filter
      arguments, or if using '--csq' if no\n                        allele frequency
      is recorded for any of VEP's AF\n                        annotations."
    inputBinding:
      position: 101
      prefix: --filter_novel
  - id: filter_novel
    type:
      - 'null'
      - boolean
    doc: "Filter any allele/variant NOT present in\n                        any of
      the files supplied to --gnomad or --dbsnp or\n                        --vcf_filter
      arguments, or if using '--csq' if no\n                        allele frequency
      is recorded for any of VEP's AF\n                        annotations."
    inputBinding:
      position: 101
      prefix: --filter_novel
  - id: filter_unpredicted
    type:
      - 'null'
      - boolean
    doc: "For use in conjunction with --missense_filters. The default behaviour when
      using\n                        --missense_filters is to ignore a program if\n\
      \                        there is no prediction given (i.e. the score/pred\n\
      \                        is empty). That is, if there are no predictions\n \
      \                       for any of the programs annotating a missense\n    \
      \                    consequence, it will not be filtered, while if\n      \
      \                  predictions are missing for only some, filtering\n      \
      \                  will proceed as normal with the other programs. If\n    \
      \                    this option is given, missense variants will be\n     \
      \                   filtered if any program does not have a\n              \
      \          prediction/score."
    inputBinding:
      position: 101
      prefix: --filter_unpredicted
  - id: filtering_an
    type:
      - 'null'
      - int
    doc: "Require at least this number of allele calls\n                        before
      filtering with --af or --min_af options.\n                        Useful to
      avoid filtering at sites with many\n                        uncalled genotpyes.
      If AN field is missing from a\n                        record and this value
      is > 0, --af/--min_af\n                        filtering will not occur for
      that record.\n                        Default=0."
    default: 0
    inputBinding:
      position: 101
      prefix: --filtering_an
  - id: flagged_features
    type:
      - 'null'
      - boolean
    doc: "When used in conjunction with --csq argument,\n                        ignore
      consequences for flagged\n                        transcripts/features (i.e.
      with a non-empty\n                        'FLAGS' CSQ field)."
    inputBinding:
      position: 101
      prefix: --flagged_features
  - id: freq
    type:
      - 'null'
      - float
    doc: "Allele frequency cutoff (between 0 and 1). Used\n                      \
      \  for extenal allele frequency sources such as\n                        --dbsnp
      or --gnomad files. Alleles/variants with\n                        an allele
      frequency equal to or greater than\n                        this value in these
      sources will be filtered\n                        from your input. VEP annotated
      allele frequencies\n                        will also be used for filtering
      if '--csq' or\n                        '--impact' options are used (annotations
      from VEP\n                        v90 or higher required). This can be disabled
      with\n                        the --no_vep_freq option."
    inputBinding:
      position: 101
      prefix: --freq
  - id: freq
    type:
      - 'null'
      - float
    doc: "Allele frequency cutoff (between 0 and 1). Used\n                      \
      \  for extenal allele frequency sources such as\n                        --dbsnp
      or --gnomad files. Alleles/variants with\n                        an allele
      frequency equal to or greater than\n                        this value in these
      sources will be filtered\n                        from your input. VEP annotated
      allele frequencies\n                        will also be used for filtering
      if '--csq' or\n                        '--impact' options are used (annotations
      from VEP\n                        v90 or higher required). This can be disabled
      with\n                        the --no_vep_freq option."
    inputBinding:
      position: 101
      prefix: --freq
  - id: g2p
    type:
      - 'null'
      - File
    doc: "A G2P CSV file for filtering variants based on G2P\n                   \
      \     annotations. Requires your VCF to be annotated\n                     \
      \   with VEP. Only variants with consequences\n                        affecting
      genes in this file will be retained."
    inputBinding:
      position: 101
      prefix: --g2p
  - id: gene_bed
    type:
      - 'null'
      - File
    doc: "Only include variants overlapping the intervals in\n                   \
      \     the provided BED file and with a VEP annotation\n                    \
      \    for the provided gene/transcript/protein\n                        identifiers.
      The fourth column of the provided BED\n                        file should contain
      gene symbols and/or Ensembl\n                        gene/transcript/protein
      identifiers (multiple IDs\n                        should be separated with
      '/' characters). Requires\n                        input to be annotated with
      VEP.\n                        \n                        A suitably formatted
      BED can be created using the\n                        'coordinates_from_genes'
      program installed with\n                        vase."
    inputBinding:
      position: 101
      prefix: --gene_bed
  - id: gnomad
    type:
      - 'null'
      - type: array
        items: File
    doc: "gnomAD/ExAC file for variant annotating/filtering\n                    \
      \    using population allele frequencies. By default\n                     \
      \   allele frequencies from AFR, AMR, EAS, FIN, NFE\n                      \
      \  and SAS populations are used. Populations to use\n                      \
      \  can be chosen with the --gnomad_pops argument."
    inputBinding:
      position: 101
      prefix: --gnomad
  - id: gnomad
    type:
      - 'null'
      - type: array
        items: File
    doc: "gnomAD/ExAC file for variant annotating/filtering\n                    \
      \    using population allele frequencies. By default\n                     \
      \   allele frequencies from AFR, AMR, EAS, FIN, NFE\n                      \
      \  and SAS populations are used. Populations to use\n                      \
      \  can be chosen with the --gnomad_pops argument."
    inputBinding:
      position: 101
      prefix: --gnomad
  - id: gnomad_burden
    type:
      - 'null'
      - boolean
    doc: "If using --burden_counts, use this flag to\n                        indicate
      that the input is from gnomAD and should\n                        be parsed
      per population."
    inputBinding:
      position: 101
      prefix: --gnomad_burden
  - id: gnomad_pops
    type:
      - 'null'
      - type: array
        items: string
    doc: "Populations to use for annotating/filtering from\n                     \
      \   gnomAD VCFs. The default are AFR, AMR, EAS, FIN, NFE\n                 \
      \       and SAS. Any combination of these plus \"ASJ\"\n                   \
      \     and \"POPMAX\" can be chosen."
    inputBinding:
      position: 101
      prefix: --gnomad_pops
  - id: gq
    type:
      - 'null'
      - int
    doc: "Minimum genotype quality score threshold. Sample\n                     \
      \   genotype calls with a score lower than this\n                        threshold
      will be treated as no-calls.\n                        Default = 20."
    default: 20
    inputBinding:
      position: 101
      prefix: --gq
  - id: gq
    type:
      - 'null'
      - int
    doc: "Minimum genotype quality score threshold. Sample\n                     \
      \   genotype calls with a score lower than this\n                        threshold
      will be treated as no-calls.\n                        Default = 20."
    default: 20
    inputBinding:
      position: 101
      prefix: -gq
  - id: het_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for heterozygous\n                     \
      \   genotypes. Heterozygous sample genotype calls\n                        with
      a ratio of the alternate allele vs total\n                        depth lower
      than this threshold will be treated as\n                        no-calls. Default
      = 0."
    default: 0
    inputBinding:
      position: 101
      prefix: --het_ab
  - id: het_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for heterozygous\n                     \
      \   genotypes. Heterozygous sample genotype calls\n                        with
      a ratio of the alternate allele vs total\n                        depth lower
      than this threshold will be treated as\n                        no-calls. Default
      = 0."
    default: 0
    inputBinding:
      position: 101
      prefix: -het_ab
  - id: hom_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for homozygous\n                       \
      \ genotypes. Homozygous sample genotype calls\n                        with
      a ratio of the alternate allele vs total\n                        depth lower
      than this threshold will be treated as\n                        no-calls. Default
      = 0."
    default: 0
    inputBinding:
      position: 101
      prefix: --hom_ab
  - id: hom_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for homozygous\n                       \
      \ genotypes. Homozygous sample genotype calls\n                        with
      a ratio of the alternate allele vs total\n                        depth lower
      than this threshold will be treated as\n                        no-calls. Default
      = 0."
    default: 0
    inputBinding:
      position: 101
      prefix: -hom_ab
  - id: ignore_existing
    type:
      - 'null'
      - boolean
    doc: "Ignore previously added annotations from\n                        dbSNP/gnomAD/CADD
      files that may be present in the\n                        input VCF. Default
      behaviour is to use these\n                        annotations for filtering
      if present and the\n                        relevant arguments (e.g. --freq)
      are given."
    inputBinding:
      position: 101
      prefix: -ignore_existing
  - id: ignore_existing_annotations
    type:
      - 'null'
      - boolean
    doc: "Ignore previously added annotations from\n                        dbSNP/gnomAD/CADD
      files that may be present in the\n                        input VCF. Default
      behaviour is to use these\n                        annotations for filtering
      if present and the\n                        relevant arguments (e.g. --freq)
      are given."
    inputBinding:
      position: 101
      prefix: --ignore_existing_annotations
  - id: ignore_existing_annotations
    type:
      - 'null'
      - boolean
    doc: "Ignore previously added annotations from\n                        dbSNP/gnomAD/CADD
      files that may be present in the\n                        input VCF. Default
      behaviour is to use these\n                        annotations for filtering
      if present and the\n                        relevant arguments (e.g. --freq)
      are given."
    inputBinding:
      position: 101
      prefix: --ignore_existing_annotations
  - id: impact
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more VEP 'IMPACT' types to retain. Valid\n                      \
      \  values are 'HIGH', 'MODERATE', 'LOW' and\n                        'MODIFIER'.
      Any consequence classes specified by\n                        the '--csq' argument
      will still be retained\n                        irrespective of values specified
      here.\n\n                        Note, that using the --impact option automatically\n\
      \                        turns on biotype filtering (see the --biotypes\n  \
      \                      option below)."
    inputBinding:
      position: 101
      prefix: --impact
  - id: info_filters
    type:
      - 'null'
      - type: array
        items: string
    doc: "Custom filter expressions for filtering on fields\n                    \
      \    in the INFO field of each record. Must be in the\n                    \
      \    format '<INFO_FIELD> <comparator> <value>'.\n                        Variants
      will be retained if they meet the given\n                        criteria. For
      example, to only keep records with a\n                        QD score greater
      than 4, you would pass the\n                        expression \"QD > 4\". To
      only keep records with the\n                        \"DB\" flag present you
      would pass the expression\n                        \"DB == True\".\n\n     \
      \                   Standard python style operators (=\">\", \"<\", \">=\",\n\
      \                        \"<=\", \"==\", \"!=\") are supported. Comparisons
      will\n                        be performed using the types specified for the\n\
      \                        given field in the VCF header (e.g. Float, Integer\n\
      \                        or String) or as booleans for Flags."
    inputBinding:
      position: 101
      prefix: --info_filters
  - id: input_vcf
    type: File
    doc: Input VCF filename
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_filters
    type:
      - 'null'
      - type: array
        items: string
    doc: "Only keep variants that have these FILTER Fields.\n                    \
      \    Can not be used with --pass_filters but you can\n                     \
      \   use 'pass' as one of your arguments here to retain\n                   \
      \     variants that pass filters in addition to variants\n                 \
      \       with a FILTER Field matching the values specified.\n               \
      \         If multiple filter annotations are given for a\n                 \
      \       variant all must match one of these fields or it\n                 \
      \       will be filtered."
    inputBinding:
      position: 101
      prefix: --keep_filters
  - id: keep_if_any_damaging
    type:
      - 'null'
      - boolean
    doc: "For use in conjunction with --missense_filters. If this option is provided,
      a missense consequence\n                        is only filtered if ALL of the
      programs provided\n                        to --missense_filters do not have
      an appropriate\n                        prediction/score - that is, the missense\n\
      \                        consequence will be retained if ANY of the given\n\
      \                        programs has an appropriate value for the\n       \
      \                 prediction/score. This behaviour is overridden by\n      \
      \                  '--filter_unpredicted' when a prediction/score is\n     \
      \                   missing for any program."
    inputBinding:
      position: 101
      prefix: --keep_if_any_damaging
  - id: loftee
    type:
      - 'null'
      - boolean
    doc: "Retain LoF (stop_gained, frameshift_variant,\n                        splice_acceptor_variant
      and splice_donor_variant)\n                        classes only if the LoF annotation
      from loftee is\n                        'HC'."
    inputBinding:
      position: 101
      prefix: --loftee
  - id: log_progress
    type:
      - 'null'
      - boolean
    doc: "Use logging output for progress rather than wiping\n                   \
      \     progress line after each update."
    inputBinding:
      position: 101
      prefix: --log_progress
  - id: log_progress
    type:
      - 'null'
      - boolean
    doc: "Use logging output for progress rather than wiping\n                   \
      \     progress line after each update."
    inputBinding:
      position: 101
      prefix: -log_progress
  - id: max_alt_alleles
    type:
      - 'null'
      - int
    doc: "Filter variants at sites with more than this\n                        many
      ALT alleles. For example, using\n                        '--max_alt_alleles
      1' would retain biallelic sites\n                        only ('*' alleles are
      not counted for this\n                        purpose)."
    inputBinding:
      position: 101
      prefix: --max_alt_alleles
  - id: max_build
    type:
      - 'null'
      - string
    doc: "Maximum dbSNP build version cutoff. For use with\n                     \
      \   --dbsnp files. Alleles/variants present in dbSNP\n                     \
      \   builds later than this version will be filtered."
    inputBinding:
      position: 101
      prefix: --max_build
  - id: max_build
    type:
      - 'null'
      - string
    doc: "Maximum dbSNP build version cutoff. For use with\n                     \
      \   --dbsnp files. Alleles/variants present in dbSNP\n                     \
      \   builds later than this version will be filtered."
    inputBinding:
      position: 101
      prefix: --max_build
  - id: max_dp
    type:
      - 'null'
      - int
    doc: "Maximum genotype depth threshold. Sample genotype\n                    \
      \    calls with a read depth higher than this threshold\n                  \
      \      will be treated as no-calls. Default = 0 (i.e. not\n                \
      \        used)."
    default: 0
    inputBinding:
      position: 101
      prefix: --max_dp
  - id: max_dp
    type:
      - 'null'
      - int
    doc: "Maximum genotype depth threshold. Sample genotype\n                    \
      \    calls with a read depth higher than this threshold\n                  \
      \      will be treated as no-calls. Default = 0 (i.e. not\n                \
      \        used)."
    default: 0
    inputBinding:
      position: 101
      prefix: -max_dp
  - id: max_freq
    type:
      - 'null'
      - float
    doc: "Allele frequency cutoff (between 0 and 1). Used\n                      \
      \  for extenal allele frequency sources such as\n                        --dbsnp
      or --gnomad files. Alleles/variants with\n                        an allele
      frequency equal to or greater than\n                        this value in these
      sources will be filtered\n                        from your input. VEP annotated
      allele frequencies\n                        will also be used for filtering
      if '--csq' or\n                        '--impact' options are used (annotations
      from VEP\n                        v90 or higher required). This can be disabled
      with\n                        the --no_vep_freq option."
    inputBinding:
      position: 101
      prefix: --max_freq
  - id: max_gnomad_homozygotes
    type:
      - 'null'
      - int
    doc: "Filter alleles if the total number of homozygotes\n                    \
      \    or hemizygotes in any provided gnomAD VCF is\n                        greater
      than this value."
    inputBinding:
      position: 101
      prefix: --max_gnomad_homozygotes
  - id: max_gnomad_homozygotes
    type:
      - 'null'
      - int
    doc: "Filter alleles if the total number of homozygotes\n                    \
      \    or hemizygotes in any provided gnomAD VCF is\n                        greater
      than this value."
    inputBinding:
      position: 101
      prefix: --max_gnomad_homozygotes
  - id: min_ac
    type:
      - 'null'
      - int
    doc: "Minimum AC value in input VCF. Any allele with an\n                    \
      \    AC < than this value will be filtered."
    inputBinding:
      position: 101
      prefix: --min_ac
  - id: min_af
    type:
      - 'null'
      - float
    doc: "Minimum AF value in input VCF. Any allele with an\n                    \
      \    AF < than this value will be filtered."
    inputBinding:
      position: 101
      prefix: --min_af
  - id: min_an
    type:
      - 'null'
      - int
    doc: "Minimum number of allele calls as given by the\n                       \
      \ 'AN' INFO field. Variants with an AN value below\n                       \
      \ this threshold or a missing AN field will be\n                        filtered.
      Default=0."
    default: 0
    inputBinding:
      position: 101
      prefix: --min_an
  - id: min_families
    type:
      - 'null'
      - int
    doc: "Minimum number of families (or unrelated samples)\n                    \
      \    required to contain a qualifying dominant/de novo\n                   \
      \     or biallelic combination of variants in a feature\n                  \
      \      before they are output. Default = 1."
    default: 1
    inputBinding:
      position: 101
      prefix: --min_families
  - id: min_families
    type:
      - 'null'
      - int
    doc: "Minimum number of families (or unrelated samples)\n                    \
      \    required to contain a qualifying dominant/de novo\n                   \
      \     or biallelic combination of variants in a feature\n                  \
      \      before they are output. Default = 1."
    default: 1
    inputBinding:
      position: 101
      prefix: -min_families
  - id: min_freq
    type:
      - 'null'
      - float
    doc: "Minimum allele frequency cutoff (between 0 and 1).\n                   \
      \     Used for extenal allele frequency sources such as\n                  \
      \      --dbsnp or --gnomad files. Alleles/variants with\n                  \
      \      a frequency lower than this value will be filtered.\n               \
      \         VEP annotated allele frequencies will also be used\n             \
      \           for filtering if '--csq' option is used (VEP v90\n             \
      \           or higher required). This can be disabled with the\n           \
      \             --no_vep_freq option."
    inputBinding:
      position: 101
      prefix: --min_freq
  - id: min_freq
    type:
      - 'null'
      - float
    doc: "Minimum allele frequency cutoff (between 0 and 1).\n                   \
      \     Used for extenal allele frequency sources such as\n                  \
      \      --dbsnp or --gnomad files. Alleles/variants with\n                  \
      \      a frequency lower than this value will be filtered.\n               \
      \         VEP annotated allele frequencies will also be used\n             \
      \           for filtering if '--csq' option is used (VEP v90\n             \
      \           or higher required). This can be disabled with the\n           \
      \             --no_vep_freq option."
    inputBinding:
      position: 101
      prefix: --min_freq
  - id: missense_filters
    type:
      - 'null'
      - type: array
        items: string
    doc: "A list of in silico prediction programs to use\n                       \
      \ for filtering missense variants (must be used in\n                       \
      \ conjunction with --csq argument). The programs\n                        provided
      here must have been annotated on the\n                        input VCF file
      either directly by VEP or via the\n                        dbNSFP VEP plugin.
      Recognised program names and\n                        default 'damaging' values
      are provided in the\n                        \"data/vep_insilico_pred.tsv\"\
      \ file.\n\n                        You may optionally specify score criteria
      for\n                        filtering as in the the following examples:\n\n\
      \                            FATHMM_pred=D\n                            MutationTaster_pred=A\n\
      \                            MetaSVM_rankscore=0.8\n\n                     \
      \   Or you may just provide the program names\n                        and the
      default 'damaging' prediction values\n                        will be used,
      as listed in the file\n                        \"vase/data/vep_insilico_pred.tsv\"\
      .\n\n                        By default, a missense consequence is filtered\n\
      \                        unless each of the programs listed here have an\n \
      \                       appropriate or missing prediction/score. This\n    \
      \                    behaviour can be changed using the\n                  \
      \      --filter_unpredicted or --keep_if_any_damaging\n                    \
      \    flags."
    inputBinding:
      position: 101
      prefix: --missense_filters
  - id: missing_cadd_scores
    type:
      - 'null'
      - File
    doc: "Filename to output variants that are not found\n                       \
      \ in CADD annotation files. Output will be gzip\n                        compressed
      and in a format suitable for uploading\n                        to https://cadd.gs.washington.edu/score
      for\n                        scoring (or for scoring locally)."
    inputBinding:
      position: 101
      prefix: --missing_cadd_scores
  - id: missing_splice_ai_scores
    type:
      - 'null'
      - File
    doc: "Filename to output variants that are not found in\n                    \
      \    SpliceAI annotation files. Output will be gzip\n                      \
      \  compressed VCFs suitable for scoring with the\n                        SpliceAI
      program\n                        (https://github.com/Illumina/SpliceAI)."
    inputBinding:
      position: 101
      prefix: --missing_splice_ai_scores
  - id: missing_splice_ai_scores
    type:
      - 'null'
      - File
    doc: "Filename to output variants that are not found in\n                    \
      \    SpliceAI annotation files. Output will be gzip\n                      \
      \  compressed VCFs suitable for scoring with the\n                        SpliceAI
      program\n                        (https://github.com/Illumina/SpliceAI)."
    inputBinding:
      position: 101
      prefix: --missing_splice_ai_scores
  - id: n_cases
    type:
      - 'null'
      - int
    doc: "Instead of requiring a variant to be present in\n                      \
      \  ALL samples specified by --cases, require at least\n                    \
      \    this many cases."
    inputBinding:
      position: 101
      prefix: --n_cases
  - id: n_cases
    type:
      - 'null'
      - int
    doc: "Instead of requiring a variant to be present in\n                      \
      \  ALL samples specified by --cases, require at least\n                    \
      \    this many cases."
    inputBinding:
      position: 101
      prefix: -n_cases
  - id: n_controls
    type:
      - 'null'
      - int
    doc: "Instead of filtering an allele/variant if present\n                    \
      \    in ANY sample specified by --controls, require at\n                   \
      \     least this many controls to carry a variant before\n                 \
      \       it is filtered."
    inputBinding:
      position: 101
      prefix: --n_controls
  - id: n_controls
    type:
      - 'null'
      - int
    doc: "Instead of filtering an allele/variant if present\n                    \
      \    in ANY sample specified by --controls, require at\n                   \
      \     least this many controls to carry a variant before\n                 \
      \       it is filtered."
    inputBinding:
      position: 101
      prefix: -n_controls
  - id: no_conflicted
    type:
      - 'null'
      - boolean
    doc: "When used in conjunction with --pathogenic\n                        argument,
      variants labelled as pathogenic will\n                        only be retained
      if there are no conflicting\n                        'benign' or 'likely benign'
      assertions."
    inputBinding:
      position: 101
      prefix: --no_conflicted
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Do not output progress information to STDERR.
    inputBinding:
      position: 101
      prefix: --no_progress
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Do not output progress information to STDERR.
    inputBinding:
      position: 101
      prefix: --no_progress
  - id: no_vep_freq
    type:
      - 'null'
      - boolean
    doc: "Use this option if you want to ignore VEP\n                        annotated
      allele frequencies when using --freq and\n                        --csq/--impact
      options."
    inputBinding:
      position: 101
      prefix: --no_vep_freq
  - id: no_warnings
    type:
      - 'null'
      - boolean
    doc: "Do not output INFO or WARN messages to\n                        STDERR.
      Only program ending errors will appear."
    inputBinding:
      position: 101
      prefix: --no_warnings
  - id: no_warnings
    type:
      - 'null'
      - boolean
    doc: "Do not output INFO or WARN messages to\n                        STDERR.
      Only program ending errors will appear."
    inputBinding:
      position: 101
      prefix: --no_warnings
  - id: pass_filters
    type:
      - 'null'
      - boolean
    doc: "Only keep variants that have passed filters\n                        (i.e.
      FILTER field must be \"PASS\")"
    inputBinding:
      position: 101
      prefix: --pass_filters
  - id: path
    type:
      - 'null'
      - boolean
    doc: "Retain variants with ClinVar 'likely pathogenic'\n                     \
      \   or 'pathogenic' flags regardless of frequency or\n                     \
      \   other settings provided to other Annotation File\n                     \
      \   Arguments. This requires one of the files\n                        provided
      to --dbsnp to have CLNSIG annotations\n                        from ClinVar."
    inputBinding:
      position: 101
      prefix: --path
  - id: path
    type:
      - 'null'
      - boolean
    doc: "Retain variants with ClinVar 'likely pathogenic'\n                     \
      \   or 'pathogenic' flags regardless of frequency or\n                     \
      \   other settings provided to other Annotation File\n                     \
      \   Arguments. This requires one of the files\n                        provided
      to --dbsnp to have CLNSIG annotations\n                        from ClinVar."
    inputBinding:
      position: 101
      prefix: -path
  - id: pathogenic
    type:
      - 'null'
      - boolean
    doc: "When used in conjunction with --csq argument,\n                        retain
      variants flagged as pathogenic by either\n                        'CLIN_SIG'
      or 'clinvar_clnsig' VEP annotations\n                        even if the consequence
      class is not included in\n                        those selected using the --csq
      argument. Note that\n                        this only alters filtering as specified
      by --csq\n                        and --missense_filters options; frequency,\n\
      \                        canonical transcript, flagged_features and biotype\n\
      \                        filtering will still occur as normal."
    inputBinding:
      position: 101
      prefix: --pathogenic
  - id: ped
    type:
      - 'null'
      - File
    doc: "A ped file containing information about samples in\n                   \
      \     your VCF for use for filtering on affectation\n                      \
      \  status and inheritance patterns.\n\n                        A PED file is
      a white-space (space or tab) \n                        delimited file with the
      first six mandatory\n                        columns:\n                    \
      \    \n                             Family ID\n                            \
      \ Individual ID\n                             Paternal ID\n                \
      \             Maternal ID\n                             Sex (1=male; 2=female;
      other=unknown)\n                             Phenotype\n                   \
      \     \n                        Affection status should be coded:\n        \
      \                \n                            -9 missing\n                \
      \             0 missing\n                             1 unaffected\n       \
      \                      2 affected\n                        \n              \
      \          All individuals of interest, including parents,\n               \
      \         should be specified in this file so that\n                       \
      \ affectation status can be read and dominant versus\n                     \
      \   recessive/de novo inheritance models can be\n                        inferred."
    inputBinding:
      position: 101
      prefix: --ped
  - id: ped
    type:
      - 'null'
      - File
    doc: "A ped file containing information about samples in\n                   \
      \     your VCF for use for filtering on affectation\n                      \
      \  status and inheritance patterns.\n\n                        A PED file is
      a white-space (space or tab) \n                        delimited file with the
      first six mandatory\n                        columns:\n                    \
      \    \n                             Family ID\n                            \
      \ Individual ID\n                             Paternal ID\n                \
      \             Maternal ID\n                             Sex (1=male; 2=female;
      other=unknown)\n                             Phenotype\n                   \
      \     \n                        Affection status should be coded:\n        \
      \                \n                            -9 missing\n                \
      \             0 missing\n                             1 unaffected\n       \
      \                      2 affected\n                        \n              \
      \          All individuals of interest, including parents,\n               \
      \         should be specified in this file so that\n                       \
      \ affectation status can be read and dominant versus\n                     \
      \   recessive/de novo inheritance models can be\n                        inferred."
    inputBinding:
      position: 101
      prefix: --ped
  - id: prioritise_cadd
    type:
      - 'null'
      - boolean
    doc: "If using --cadd_phred or --cadd_raw cutoffs,\n                        filter
      variants below threshold even if they meet\n                        SpliceAI
      delta cutoffs. Default behaviour is to\n                        retain variants
      if they meet --splice_ai_min_delta\n                        irrespective of
      CADD cutoffs."
    inputBinding:
      position: 101
      prefix: --prioritise_cadd
  - id: prioritise_cadd
    type:
      - 'null'
      - boolean
    doc: "If using --cadd_phred or --cadd_raw cutoffs,\n                        filter
      variants below threshold even if they meet\n                        SpliceAI
      delta cutoffs. Default behaviour is to\n                        retain variants
      if they meet --splice_ai_min_delta\n                        irrespective of
      CADD cutoffs."
    inputBinding:
      position: 101
      prefix: --prioritise_cadd
  - id: prog_interval
    type:
      - 'null'
      - int
    doc: "Report progress information every N variants.\n                        Default=1000."
    default: 1000
    inputBinding:
      position: 101
      prefix: --prog_interval
  - id: prog_interval
    type:
      - 'null'
      - int
    doc: "Report progress information every N variants.\n                        Default=1000."
    default: 1000
    inputBinding:
      position: 101
      prefix: --prog_interval
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Do not output INFO messages to STDERR. Warnings\n                      \
      \  will still be shown."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Do not output INFO messages to STDERR. Warnings\n                      \
      \  will still be shown."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: recessive
    type:
      - 'null'
      - boolean
    doc: "Identify variants matching a recessive inheritance\n                   \
      \     pattern in cases present in the PED file specified\n                 \
      \       by the --ped argument. Input must be VEP\n                        annotated.
      If the --csq argument is given, only\n                        variants/alleles
      resulting in the given functional\n                        consequences will
      be used to identify qualifying\n                        variants/alleles, otherwise
      the default set of\n                        VEP consequences (see --csq argument
      for details)\n                        will be used."
    inputBinding:
      position: 101
      prefix: --recessive
  - id: recessive
    type:
      - 'null'
      - boolean
    doc: "Identify variants matching a recessive inheritance\n                   \
      \     pattern in cases present in the PED file specified\n                 \
      \       by the --ped argument. Input must be VEP\n                        annotated.
      If the --csq argument is given, only\n                        variants/alleles
      resulting in the given functional\n                        consequences will
      be used to identify qualifying\n                        variants/alleles, otherwise
      the default set of\n                        VEP consequences (see --csq argument
      for details)\n                        will be used."
    inputBinding:
      position: 101
      prefix: --recessive
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: "Only include variants overlapping these intervals\n                    \
      \    (in the format chr1:1000-2000)."
    inputBinding:
      position: 101
      prefix: --region
  - id: report_prefix
    type:
      - 'null'
      - string
    doc: "DEPRECATED - use the 'vase_reporter' program\n                        provided
      alongside vase instead.\n                        \n                        Prefix
      for segregation summary report output\n                        files. If either
      --biallelic, --de_novo or\n                        --dominant options are in
      effect this option will\n                        write summaries for segregating
      variants to files\n                        with the respective suffixes of\n\
      \                        '_recessive.report.tsv', '_de_novo.report.tsv' and\n\
      \                        '_dominant.report.tsv'."
    inputBinding:
      position: 101
      prefix: --report_prefix
  - id: retain_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: "Retain consequence annotations if there is a\n                        matching
      annotation for the given label. For\n                        example, to retain
      any consequence where there is\n                        a VEP annotation for
      'FOO' matching 'BAR' use\n                        \"--retain_labels FOO=BAR\"\
      ."
    inputBinding:
      position: 101
      prefix: --retain_labels
  - id: seg_controls
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more sample IDs to treat as controls for\n                      \
      \  segregation analysis only. Useful if you want to\n                      \
      \  specify controls to use for rejecting compound\n                        heterozygous
      combinations of variants or\n                        homozygous variants when
      using --biallelic option.\n                        Unlike the --controls option,
      alleles/variants\n                        present in these samples will only
      be used for\n                        filtering when looking at inheritance patterns
      in\n                        families present in a PED file or samples\n    \
      \                    specified with --singleton_recessive or\n             \
      \           --singleton_dominant options. This option is not\n             \
      \           necessary if your unaffected samples are already\n             \
      \           present in your PED file specified with --ped."
    inputBinding:
      position: 101
      prefix: --seg_controls
  - id: seg_controls
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more sample IDs to treat as controls for\n                      \
      \  segregation analysis only. Useful if you want to\n                      \
      \  specify controls to use for rejecting compound\n                        heterozygous
      combinations of variants or\n                        homozygous variants when
      using --biallelic option.\n                        Unlike the --controls option,
      alleles/variants\n                        present in these samples will only
      be used for\n                        filtering when looking at inheritance patterns
      in\n                        families present in a PED file or samples\n    \
      \                    specified with --singleton_recessive or\n             \
      \           --singleton_dominant options. This option is not\n             \
      \           necessary if your unaffected samples are already\n             \
      \           present in your PED file specified with --ped."
    inputBinding:
      position: 101
      prefix: -seg_controls
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "Equivalent to specifying both '--no_progress' and\n                    \
      \    '--no_warnings' options."
    inputBinding:
      position: 101
      prefix: --silent
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "Equivalent to specifying both '--no_progress' and\n                    \
      \    '--no_warnings' options."
    inputBinding:
      position: 101
      prefix: --silent
  - id: singleton_dominant
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more samples to treat as unrelated\n                        individuals
      and identify variants matching a\n                        dominant inheritance
      pattern."
    inputBinding:
      position: 101
      prefix: --singleton_dominant
  - id: singleton_dominant
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more samples to treat as unrelated\n                        individuals
      and identify variants matching a\n                        dominant inheritance
      pattern."
    inputBinding:
      position: 101
      prefix: -singleton_dominant
  - id: singleton_recessive
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more samples to treat as unrelated\n                        individuals
      and identify variants matching a\n                        recessive inheritance
      pattern."
    inputBinding:
      position: 101
      prefix: --singleton_recessive
  - id: singleton_recessive
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more samples to treat as unrelated\n                        individuals
      and identify variants matching a\n                        recessive inheritance
      pattern."
    inputBinding:
      position: 101
      prefix: -singleton_recessive
  - id: snpeff
    type:
      - 'null'
      - boolean
    doc: "Use SnpEff annotations instead of VEP for\n                        filtering."
    inputBinding:
      position: 101
      prefix: --snpeff
  - id: splice_ai_max_delta
    type:
      - 'null'
      - float
    doc: "Same as --splice_ai_min_delta but\n                        alleles/consequences
      will be retained only if\n                        all SpliceAI delta scores
      are equal to or below\n                        this threshold."
    inputBinding:
      position: 101
      prefix: --splice_ai_max_delta
  - id: splice_ai_max_delta
    type:
      - 'null'
      - float
    doc: "Same as --splice_ai_min_delta but\n                        alleles/consequences
      will be retained only if\n                        all SpliceAI delta scores
      are equal to or below\n                        this threshold."
    inputBinding:
      position: 101
      prefix: -splice_ai_max_delta
  - id: splice_ai_min_delta
    type:
      - 'null'
      - float
    doc: "Retain alleles/consequences with a SpliceAI delta\n                    \
      \    score equal to or greater than this threshold. If\n                   \
      \     using filtering on VEP consequence (--csq or\n                       \
      \ --impact options) VEP consequences for genes\n                        with
      symbols matching the SpliceAI gene symbol\n                        annotation
      will be marked for retention also (e.g.\n                        if using segregation
      filtering). Note that allele\n                        frequency filters will
      still be applied.\n\n                        If used in conjunction with --csq
      or --impact\n                        options, variants that match the specified\n\
      \                        --csq/--impact classes will be retained\n         \
      \               irrespective of SpliceAI delta score, while\n              \
      \          variants not matching specified --csq/--impact\n                \
      \        classes will be retained if they meet the SpliceAI\n              \
      \          delta score threshold."
    inputBinding:
      position: 101
      prefix: --splice_ai_min_delta
  - id: splice_ai_min_delta
    type:
      - 'null'
      - float
    doc: "Retain alleles/consequences with a SpliceAI delta\n                    \
      \    score equal to or greater than this threshold. If\n                   \
      \     using filtering on VEP consequence (--csq or\n                       \
      \ --impact options) VEP consequences for genes\n                        with
      symbols matching the SpliceAI gene symbol\n                        annotation
      will be marked for retention also (e.g.\n                        if using segregation
      filtering). Note that allele\n                        frequency filters will
      still be applied.\n\n                        If used in conjunction with --csq
      or --impact\n                        options, variants that match the specified\n\
      \                        --csq/--impact classes will be retained\n         \
      \               irrespective of SpliceAI delta score, while\n              \
      \          variants not matching specified --csq/--impact\n                \
      \        classes will be retained if they meet the SpliceAI\n              \
      \          delta score threshold."
    inputBinding:
      position: 101
      prefix: -splice_ai_min_delta
  - id: splice_ai_vcfs
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more tabix indexed VCFs containing SpliceAI\n                   \
      \     delta scores with which to filter or annotate\n                      \
      \  records. SpliceAI INFO fields must be present in\n                      \
      \  the format produced for pre-scored variants as\n                        downloaded
      from Jaganathan et al. Cell (2018) or\n                        else as generated
      by the SpliceAI program\n                        (https://github.com/Illumina/SpliceAI).\n\
      \                        Alleles/variants can be retained on these scores\n\
      \                        using the --splice_ai_min_delta or\n              \
      \          --splice_ai_max_delta options."
    inputBinding:
      position: 101
      prefix: --splice_ai_vcfs
  - id: splice_ai_vcfs
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more tabix indexed VCFs containing SpliceAI\n                   \
      \     delta scores with which to filter or annotate\n                      \
      \  records. SpliceAI INFO fields must be present in\n                      \
      \  the format produced for pre-scored variants as\n                        downloaded
      from Jaganathan et al. Cell (2018) or\n                        else as generated
      by the SpliceAI program\n                        (https://github.com/Illumina/SpliceAI).\n\
      \                        Alleles/variants can be retained on these scores\n\
      \                        using the --splice_ai_min_delta or\n              \
      \          --splice_ai_max_delta options."
    inputBinding:
      position: 101
      prefix: -splice_ai_vcfs
  - id: splice_filter_unpredicted
    type:
      - 'null'
      - boolean
    doc: "Same as --filter_unpredicted but for\n                        --splice_filters
      only."
    inputBinding:
      position: 101
      prefix: --splice_filter_unpredicted
  - id: splice_filters
    type:
      - 'null'
      - type: array
        items: string
    doc: "Similar to --missense_filters except only splice\n                     \
      \   consequences (splice_donor_variant, \n                        splice_acceptor_variant
      and splice_region_variant) \n                        are checked versus the
      given in silico prediction\n                        programs. Currently only
      dbscSNV, (rf_score and\n                        ada_score), MaxEntScan and SpliceDistance\n\
      \                        (https://github.com/david-a-parry/SpliceDistance)\n\
      \                        plugins are supported.\n\n                        For
      example '--splice_filters ada_score' will\n                        filter splice
      region variants with a dbscSNV\n                        ada_score cutoff below
      the default value (0.7).\n                        Alternatively, '--splice_filters
      ada_score=0.9'\n                        would filter on a higher threshold of
      0.9 or\n                        above."
    inputBinding:
      position: 101
      prefix: --splice_filters
  - id: splice_keep_if_any_damaging
    type:
      - 'null'
      - boolean
    doc: "Same as --keep_if_any_damaging but for\n                        --splice_filters
      only."
    inputBinding:
      position: 101
      prefix: --splice_keep_if_any_damaging
  - id: stream
    type:
      - 'null'
      - boolean
    doc: "When using region filtering arguments, read all\n                      \
      \  variants in your VCF and filter out all that do\n                       \
      \ overlap your regions of interest instead of\n                        index-jumping.
      This allows processing of unindexed\n                        VCFs and potentially
      speeds up processing of VCFs\n                        with large structural
      variants that otherwise\n                        severely slow-down tabix-style
      variant retrieval."
    inputBinding:
      position: 101
      prefix: --stream
  - id: strict_recessive
    type:
      - 'null'
      - boolean
    doc: "When using the --biallelic/--recessive option,\n                       \
      \ for any affected sample with parents, require\n                        confirmation
      of parental genotypes. If either\n                        parent genotype is
      a no-call or fails genotype\n                        filters then a potential
      biallelic variant will be\n                        ignored."
    inputBinding:
      position: 101
      prefix: --strict_recessive
  - id: strict_recessive
    type:
      - 'null'
      - boolean
    doc: "When using the --biallelic/--recessive option,\n                       \
      \ for any affected sample with parents, require\n                        confirmation
      of parental genotypes. If either\n                        parent genotype is
      a no-call or fails genotype\n                        filters then a potential
      biallelic variant will be\n                        ignored."
    inputBinding:
      position: 101
      prefix: --strict_recessive
  - id: sv_control_dp
    type:
      - 'null'
      - int
    doc: "Minimum supporting read threshold for\n                        parents/unaffecteds/controls
      when filtering\n                        structural variants. Defaults to the
      same value as\n                        --sv_dp but you may wish to set this
      to a lower\n                        value if, for example, you require less
      evidence\n                        from controls/unaffected in order to filter
      a\n                        variant or from parental genotype calls when\n  \
      \                      confirming a potential de novo variant."
    inputBinding:
      position: 101
      prefix: --sv_control_dp
  - id: sv_control_dp
    type:
      - 'null'
      - int
    doc: "Minimum supporting read threshold for\n                        parents/unaffecteds/controls
      when filtering\n                        structural variants. Defaults to the
      same value as\n                        --sv_dp but you may wish to set this
      to a lower\n                        value if, for example, you require less
      evidence\n                        from controls/unaffected in order to filter
      a\n                        variant or from parental genotype calls when\n  \
      \                      confirming a potential de novo variant."
    inputBinding:
      position: 101
      prefix: -sv_con_dp
  - id: sv_control_gq
    type:
      - 'null'
      - int
    doc: "Minimum genotype quality score threshold for\n                        parents/unaffecteds/controls
      when filtering\n                        structural variants. Defaults to the
      same value as\n                        --sv_gq but you may wish to set this
      to a lower\n                        value if, for example, you require less
      evidence\n                        from controls/unaffected in order to filter
      a\n                        variant or from parental genotype calls when\n  \
      \                      confirming a potential de novo variant."
    inputBinding:
      position: 101
      prefix: --sv_control_gq
  - id: sv_control_gq
    type:
      - 'null'
      - int
    doc: "Minimum genotype quality score threshold for\n                        parents/unaffecteds/controls
      when filtering\n                        structural variants. Defaults to the
      same value as\n                        --sv_gq but you may wish to set this
      to a lower\n                        value if, for example, you require less
      evidence\n                        from controls/unaffected in order to filter
      a\n                        variant or from parental genotype calls when\n  \
      \                      confirming a potential de novo variant."
    inputBinding:
      position: 101
      prefix: -sv_con_gq
  - id: sv_control_het_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for heterozygous\n                     \
      \   genotypes for structural variants. Heterozygous\n                      \
      \  sample genotype calls with a ratio of the\n                        reads
      supporting the alternate allele vs total\n                        supporting
      reads depth lower than this threshold\n                        will be treated
      as no-calls. Defaults to the same\n                        as --sv_het_ab but
      you may wish to set this to a\n                        lower value if, for example,
      you require less\n                        evidence from controls/unaffected
      in order to\n                        filter a variant."
    inputBinding:
      position: 101
      prefix: --sv_control_het_ab
  - id: sv_control_het_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for heterozygous\n                     \
      \   genotypes for structural variants. Heterozygous\n                      \
      \  sample genotype calls with a ratio of the\n                        reads
      supporting the alternate allele vs total\n                        supporting
      reads depth lower than this threshold\n                        will be treated
      as no-calls. Defaults to the same\n                        as --sv_het_ab but
      you may wish to set this to a\n                        lower value if, for example,
      you require less\n                        evidence from controls/unaffected
      in order to\n                        filter a variant."
    inputBinding:
      position: 101
      prefix: -sv_con_het_ab
  - id: sv_control_hom_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for homozygous\n                       \
      \ genotypes for structural variants. Homozygous\n                        sample
      genotype calls with a ratio of the\n                        reads supporting
      the alternate allele vs total\n                        supporting reads depth
      lower than this threshold\n                        will be treated as no-calls.
      Defaults to the same\n                        as --sv_hom_ab but you may wish
      to set this to a\n                        lower value if, for example, you require
      less\n                        evidence from controls/unaffected in order to\n\
      \                        filter a variant."
    inputBinding:
      position: 101
      prefix: --sv_control_hom_ab
  - id: sv_control_hom_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for homozygous\n                       \
      \ genotypes for structural variants. Homozygous\n                        sample
      genotype calls with a ratio of the\n                        reads supporting
      the alternate allele vs total\n                        supporting reads depth
      lower than this threshold\n                        will be treated as no-calls.
      Defaults to the same\n                        as --sv_hom_ab but you may wish
      to set this to a\n                        lower value if, for example, you require
      less\n                        evidence from controls/unaffected in order to\n\
      \                        filter a variant."
    inputBinding:
      position: 101
      prefix: -sv_con_hom_ab
  - id: sv_control_max_dp
    type:
      - 'null'
      - int
    doc: "Maximum supporting read threshold for\n                        parents/unaffecteds/controls
      when filtering\n                        structural variants. Defaults to the
      same value as\n                        --sv_max_dp."
    inputBinding:
      position: 101
      prefix: --sv_control_max_dp
  - id: sv_control_max_dp
    type:
      - 'null'
      - int
    doc: "Maximum supporting read threshold for\n                        parents/unaffecteds/controls
      when filtering\n                        structural variants. Defaults to the
      same value as\n                        --sv_max_dp."
    inputBinding:
      position: 101
      prefix: -sv_con_max_dp
  - id: sv_control_max_ref_ab
    type:
      - 'null'
      - float
    doc: "Maximum genotype allele balance for\n                        parents/unaffecteds/controls
      with reference (0/0)\n                        genotypes when filtering structural
      variants. If\n                        you wish to count/exclude variants where\n\
      \                        controls/unaffecteds are called as homozygous\n   \
      \                     reference but still have a low proportion of ALT\n   \
      \                     alleles specify a suitable cutoff here."
    inputBinding:
      position: 101
      prefix: --sv_control_max_ref_ab
  - id: sv_control_max_ref_ab
    type:
      - 'null'
      - float
    doc: "Maximum genotype allele balance for\n                        parents/unaffecteds/controls
      with reference (0/0)\n                        genotypes when filtering structural
      variants. If\n                        you wish to count/exclude variants where\n\
      \                        controls/unaffecteds are called as homozygous\n   \
      \                     reference but still have a low proportion of ALT\n   \
      \                     alleles specify a suitable cutoff here."
    inputBinding:
      position: 101
      prefix: -sv_con_max_ref_ab
  - id: sv_dp
    type:
      - 'null'
      - int
    doc: "Minimum genotype 'depth' threshold for structural\n                    \
      \    variants. Sample genotype calls with fewer than\n                     \
      \   this nunmber of supporting reads will be treated\n                     \
      \   as no-calls. Default = 0."
    default: 0
    inputBinding:
      position: 101
      prefix: --sv_dp
  - id: sv_dp
    type:
      - 'null'
      - int
    doc: "Minimum genotype 'depth' threshold for structural\n                    \
      \    variants. Sample genotype calls with fewer than\n                     \
      \   this nunmber of supporting reads will be treated\n                     \
      \   as no-calls. Default = 0."
    default: 0
    inputBinding:
      position: 101
      prefix: -sv_dp
  - id: sv_gq
    type:
      - 'null'
      - int
    doc: "Minimum genotype quality score threshold for\n                        structural
      variants. Sample genotype calls with a\n                        score lower
      than this threshold will be treated as\n                        no-calls. Default
      = 20."
    default: 20
    inputBinding:
      position: 101
      prefix: --sv_gq
  - id: sv_gq
    type:
      - 'null'
      - int
    doc: "Minimum genotype quality score threshold for\n                        structural
      variants. Sample genotype calls with a\n                        score lower
      than this threshold will be treated as\n                        no-calls. Default
      = 20."
    default: 20
    inputBinding:
      position: 101
      prefix: -sv_gq
  - id: sv_het_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for heterozygous\n                     \
      \   genotypes for structural variants. Heterozygous\n                      \
      \  sample genotype calls with a ratio of reads\n                        supporting
      the alternate allele vs total\n                        supporting reads lower
      than this threshold will\n                        be treated as no-calls. Default
      = 0."
    default: 0
    inputBinding:
      position: 101
      prefix: --sv_het_ab
  - id: sv_het_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for heterozygous\n                     \
      \   genotypes for structural variants. Heterozygous\n                      \
      \  sample genotype calls with a ratio of reads\n                        supporting
      the alternate allele vs total\n                        supporting reads lower
      than this threshold will\n                        be treated as no-calls. Default
      = 0."
    default: 0
    inputBinding:
      position: 101
      prefix: -sv_het_ab
  - id: sv_hom_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for homozygous\n                       \
      \ genotypes for structural variants. Homozygous\n                        sample
      genotype calls with a ratio of reads\n                        supporting the
      alternate allele vs total\n                        supporting reads lower than
      this threshold will\n                        be treated as no-calls. Default
      = 0."
    default: 0
    inputBinding:
      position: 101
      prefix: --sv_hom_ab
  - id: sv_hom_ab
    type:
      - 'null'
      - float
    doc: "Minimum genotype allele balance for homozygous\n                       \
      \ genotypes for structural variants. Homozygous\n                        sample
      genotype calls with a ratio of reads\n                        supporting the
      alternate allele vs total\n                        supporting reads lower than
      this threshold will\n                        be treated as no-calls. Default
      = 0."
    default: 0
    inputBinding:
      position: 101
      prefix: -sv_hom_ab
  - id: sv_max_dp
    type:
      - 'null'
      - int
    doc: "Maximum genotype 'depth' threshold for structural\n                    \
      \    variants. Sample genotype calls with more than\n                      \
      \  this nunmber of supporting reads will be treated\n                      \
      \  as no-calls. Default = 0 (i.e. not used)."
    default: 0
    inputBinding:
      position: 101
      prefix: --sv_max_dp
  - id: sv_max_dp
    type:
      - 'null'
      - int
    doc: "Maximum genotype 'depth' threshold for structural\n                    \
      \    variants. Sample genotype calls with more than\n                      \
      \  this nunmber of supporting reads will be treated\n                      \
      \  as no-calls. Default = 0 (i.e. not used)."
    default: 0
    inputBinding:
      position: 101
      prefix: -sv_max_dp
  - id: var_types
    type:
      - 'null'
      - type: array
        items: string
    doc: "Keep variants of the following type(s). Valid\n                        types
      are 'SNV' (single nucleotide variants),\n                        'MNV' (multi-nucleotide
      variants excluding\n                        indels), 'INSERTION' (insertions
      or duplications\n                        relative to the reference), 'DELETION'
      (deletions\n                        relative to the reference), 'INDEL' (shorthand
      for\n                        both insertions and deletions) and 'SV'\n     \
      \                   (structural variants). If a site is multiallelic\n     \
      \                   it will be retained if any ALT allele matches one\n    \
      \                    of these types, but per-allele filtering for\n        \
      \                segregation filtering will only consider ALT\n            \
      \            alleles of the appropriate types."
    inputBinding:
      position: 101
      prefix: --var_types
  - id: variant_quality
    type:
      - 'null'
      - string
    doc: "Minimum variant quality score ('QUAL' field).\n                        Variants
      with a QUAL score below this value will be\n                        filtered/ignored."
    inputBinding:
      position: 101
      prefix: --variant_quality
  - id: vcf_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: "VCF file(s) and name(s) to use in INFO fields\n                        for
      frequency annotation and/or filtering. Each\n                        file and
      its associated annotation ID should be\n                        given in pairs
      separated with commas. INFO fields\n                        will be added to
      your output for the AN and AF\n                        fields with the field
      names of VASE_<ID>_AN and\n                        VASE_<ID>_AF. If --freq or
      --min_freq arguments\n                        are set then matching variants
      in your input will\n                        be filtered using AF values found
      in these files.\n\n                        You may also add additonal INFO fields
      to extract\n                        and annotate your matching variants with
      by\n                        including additional comma-separated fields after\n\
      \                        the ID."
    inputBinding:
      position: 101
      prefix: --vcf_filter
  - id: vcf_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: "VCF file(s) and name(s) to use in INFO fields\n                        for
      frequency annotation and/or filtering. Each\n                        file and
      its associated annotation ID should be\n                        given in pairs
      separated with commas. INFO fields\n                        will be added to
      your output for the AN and AF\n                        fields with the field
      names of VASE_<ID>_AN and\n                        VASE_<ID>_AF. If --freq or
      --min_freq arguments\n                        are set then matching variants
      in your input will\n                        be filtered using AF values found
      in these files.\n\n                        You may also add additonal INFO fields
      to extract\n                        and annotate your matching variants with
      by\n                        including additional comma-separated fields after\n\
      \                        the ID."
    inputBinding:
      position: 101
      prefix: -vcf_filter
  - id: vep_af
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more VEP allele frequency annotations to\n                      \
      \  use for frequency filtering. Default is to use the\n                    \
      \    following (assuming --csq/--impact and --freq or\n                    \
      \    --min_freq arguments are in effect):\n\n                              \
      \          MAX_AF\n                                        AFR_AF\n        \
      \                                AMR_AF\n                                  \
      \      EAS_AF\n                                        EUR_AF\n            \
      \                            SAS_AF\n                                      \
      \  AA_AF\n                                        EA_AF\n                  \
      \                      gnomAD_AF\n                                        gnomAD_AFR_AF\n\
      \                                        gnomAD_AMR_AF\n                   \
      \                     gnomAD_ASJ_AF\n                                      \
      \  gnomAD_EAS_AF\n                                        gnomAD_FIN_AF\n  \
      \                                      gnomAD_NFE_AF\n                     \
      \                   gnomAD_OTH_AF\n                                        gnomAD_SAS_AF\n\
      \                                        gnomADg_AF_AFR\n                  \
      \                      gnomADg_AF_AMR\n                                    \
      \    gnomADg_AF_ASJ\n                                        gnomADg_AF_EAS\n\
      \                                        gnomADg_AF_FIN\n                  \
      \                      gnomADg_AF_NFE\n                                    \
      \    gnomADg_AF_OTH\n                        "
    inputBinding:
      position: 101
      prefix: --vep_af
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Filename for VCF output. If this ends in .gz or\n                      \
      \  .bgz the output will be BGZIP compressed.\n                        Default
      = STDOUT"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vase:0.5.1--pyh086e186_0
