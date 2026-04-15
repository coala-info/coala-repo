---
name: proteomiqon-joinquantpepionswithproteins
description: This tool maps quantified peptide ions to their corresponding inferred protein groups to create a unified dataset for protein-level quantification. Use when user asks to join peptide quantification results with protein inference data, map peptides to proteins, or prepare data for label-free protein quantification.
homepage: https://csbiology.github.io/ProteomIQon/
metadata:
  docker_image: "quay.io/biocontainers/proteomiqon-joinquantpepionswithproteins:0.0.2--hdfd78af_1"
---

# proteomiqon-joinquantpepionswithproteins

## Overview

The `proteomiqon-joinquantpepionswithproteins` tool is a critical integration step in the ProteomIQon proteomics pipeline. While peptide quantification tools provide detailed signal intensities for individual ions, they often lack the refined statistical context of the proteins they belong to. Conversely, protein inference tools provide high-accuracy protein assignments and q-values but do not contain the raw quantification metrics. 

This tool joins these two data sources, mapping every quantified peptide to its corresponding inferred protein group. This creates a unified dataset where peptide abundances are contextualized by protein-level confidence scores, serving as the primary input for final protein-level quantification.

## Command Line Usage

The tool follows a standard CLI pattern using `-i` for quantification results and `-ii` for protein inference results.

### Basic Execution
To combine a single quantification file with its corresponding protein inference file:

```bash
proteomiqon -joinquantpepionswithproteins \
  -i "path/to/your/run.quant" \
  -ii "path/to/your/run.prot" \
  -o "path/to/output_directory"
```

### Batch Processing
You can process multiple runs simultaneously by providing space-separated lists. 

**Note:** When using lists, the tool matches files based on their position in the list. Ensure the order of `.quant` files exactly matches the order of `.prot` files.

```bash
proteomiqon -joinquantpepionswithproteins \
  -i "run1.quant" "run2.quant" "run3.quant" \
  -ii "run1.prot" "run2.prot" "run3.prot" \
  -o "path/to/output_directory"
```

## Best Practices and Tips

- **Pipeline Positioning**: This tool must be run after both `PSMBasedQuantification` (or `AlignmentBasedQuantification`) and `ProteinInference` are complete.
- **Input Validation**: Ensure that the protein inference was performed using the same peptide evidence that was quantified. If the inputs are mismatched, the join will fail to map peptides to proteins.
- **Downstream Compatibility**: The output of this tool is specifically required for `LabelFreeProteinQuantification`. If you intend to perform protein-level abundance aggregation, this joining step is mandatory.
- **Help Command**: For a full list of available flags and detailed argument descriptions, use:
  ```bash
  proteomiqon -joinquantpepionswithproteins --help
  ```

## Reference documentation
- [Join Quant Peptide-Ions With Proteins](./references/csbiology_github_io_ProteomIQon_tools_JoinQuantPepIonsWithProteins.html.md)
- [ProteomIQon Overview](./references/csbiology_github_io_ProteomIQon.md)