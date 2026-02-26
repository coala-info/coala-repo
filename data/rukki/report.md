# rukki CWL Generation Report

## rukki_trio

### Tool Description
Trio-marker based analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/rukki:0.3.0--ha6fb395_1
- **Homepage**: https://github.com/marbl/rukki
- **Package**: https://anaconda.org/channels/bioconda/packages/rukki/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rukki/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marbl/rukki
- **Stars**: N/A
### Original Help Text
```text
Trio-marker based analysis

Usage: rukki trio [OPTIONS] --graph <GRAPH> --markers <MARKERS>

Options:
  -g, --graph <GRAPH>
          GFA file
  -m, --markers <MARKERS>
          Parental markers file
      --init-assign <INIT_ASSIGN>
          Marker-based annotation output file
      --refined-assign <REFINED_ASSIGN>
          Refined annotation output file
      --final-assign <FINAL_ASSIGN>
          Final annotation output file
      --hap-names <HAP_NAMES>
          Comma separated haplotype names to be used in outputs (default: "mat,pat") [default: mat,pat]
  -p, --paths <PATHS>
          Marker-assisted extracted haplo-paths
      --gaf-format
          Use GAF ([<>]<name1>)+ format for paths
      --marker-cnt <MARKER_CNT>
          Minimal number of parent-specific markers required for assigning parental group to a node [default: 10]
      --marker-sparsity <MARKER_SPARSITY>
          Require at least (node_length / <value>) markers within the node for parental group assignment [default: 10000]
      --marker-ratio <MARKER_RATIO>
          Sets minimal marker excess for assigning a parental group to <value>:1 [default: 5]
      --trusted-len <TRUSTED_LEN>
          Longer nodes are unlikely to be spurious and likely to be reliably assigned based on markers (used in HOMOZYGOUS node labeling) [default: 200000]
      --suspect-homozygous-cov-coeff <SUSPECT_HOMOZYGOUS_COV_COEFF>
          Nodes with coverage below <coeff> * <weighted mean coverage of 'solid' nodes> can not be 'reclassified' as homozygous. Negative turns off reclassification, 0. disables coverage check [default: 1.5]
      --max-homozygous-len <MAX_HOMOZYGOUS_LEN>
          Longer nodes can not be classified as homozygous [default: 2000000]
      --solid-len <SOLID_LEN>
          Longer nodes are unlikely to represent repeats, polymorphic variants, etc (used to seed and guide the path search) [default: 500000]
      --solid-ratio <SOLID_RATIO>
          Sets minimal marker excess for assigning a parental group of solid nodes to <value>:1. Must be <= marker_ratio (by default == marker_ratio)
      --solid-homozygous-cov-coeff <SOLID_HOMOZYGOUS_COV_COEFF>
          Solid nodes with coverage below <coeff> * <weighted mean coverage of 'solid' nodes> can not be classified as homozygous. 0. disables check [default: 1.5]
      --issue-len <ISSUE_LEN>
          Minimal node length for assigning ISSUE label [default: 50000]
      --issue-cnt <ISSUE_CNT>
          Minimal number of markers for assigning ISSUE label (by default == marker_cnt, will typically be set to a value >= marker_cnt)
      --issue-sparsity <ISSUE_SPARSITY>
          Require at least (node_length / <value>) markers for assigning ISSUE label (by default == marker_sparsity, will typically be set to a value >= marker_sparsity)
      --issue-ratio <ISSUE_RATIO>
          Require primary marker excess BELOW <value>:1 for assigning ISSUE label. Must be <= marker_ratio (by default == marker_ratio)
      --try-fill-bubbles
          Try to fill in small ambiguous bubbles
      --max-unique-cov-coeff <MAX_UNIQUE_COV_COEFF>
          Do not fill bubble if source or sink is non-solid, non-homozygous and has coverage above <coeff> * <weighted mean coverage of 'solid' nodes>. Negative disables check, 0. makes it fail [default: 1.5]
      --fillable-bubble-len <FILLABLE_BUBBLE_LEN>
          Bubbles including a longer alternative sequence will not be filled [default: 50000]
      --fillable-bubble-diff <FILLABLE_BUBBLE_DIFF>
          Bubbles with bigger difference between alternatives' lengths will not be filled [default: 200]
      --het-fill-bubble-len <HET_FILL_BUBBLE_LEN>
          Heterozygous bubbles including a longer alternative sequence will not be filled (by default equal to fillable_bubble_len)
      --het-fill-bubble-diff <HET_FILL_BUBBLE_DIFF>
          Heterozygous bubbles with bigger difference between alternatives' lengths will not be filled (by default equal to fillable_bubble_diff)
      --good-side-cov-gap <GOOD_SIDE_COV_GAP>
          During bubble filling ignore simple sides of bubbles with coverage less than source/sink average divided by this value 0. disables check [default: 5]
      --min-gap-size <MIN_GAP_SIZE>
          Minimal introducible gap size (number of Ns reported). If the gap size estimate is smaller it will be artificially increased to this value [default: 1000]
      --default-gap-size <DEFAULT_GAP_SIZE>
          Default gap size, which will be output in cases where reasonable estimate is not possible or (more likely) hasn't been implemented yet [default: 5000]
      --assign-tangles
          Assign tangles flanked by solid nodes from the same class
      --tangle-allow-deadend
          Allow dead-end nodes in the tangles
      --tangle-check-inner
          Check that inner tangle nodes are either unassigned or assigned to correct class
      --tangle-prevent-reassign
          Prevent reassignment of nodes
  -h, --help
          Print help
```

