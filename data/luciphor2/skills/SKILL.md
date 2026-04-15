---
name: luciphor2
description: Luciphor2 calculates the probability of post-translational modification site assignments to refine site-specific confidence. Use when user asks to score PTM localization, identify the most probable modification sites, or process pepXML and tab-delimited search results for site refinement.
homepage: http://luciphor2.sourceforge.net/
metadata:
  docker_image: "quay.io/biocontainers/luciphor2:2020_04_03--hdfd78af_1"
---

# luciphor2

## Overview
Luciphor2 is a Java-based tool designed to calculate the probability of PTM site assignments. It extends the original Luciphor algorithm to support any modification type and integrates with various upstream search engines. It is particularly useful for refining site-specific confidence in phosphoproteomics or other PTM-focused workflows by identifying the most probable location of a modification when multiple sites are possible.

## Usage Instructions

### Installation
The tool is available via Bioconda. To install in a conda environment:
```bash
conda install bioconda::luciphor2
```

### Basic Workflow
Luciphor2 operates using a configuration file. The recommended workflow is to generate a template, modify it, and then run the analysis.

1. **Generate the Input Template**
   Run the following command to create a commented template file named `lucxor_input_template.txt`:
   ```bash
   java -jar luciphor2.jar -t
   ```

2. **Configure the Analysis**
   Open the generated `lucxor_input_template.txt` in a text editor. The template is pre-configured for phosphorylation but can be adjusted for any PTM. Key configurations include:
   - Specifying the input file path (pepXML or tab-delimited).
   - Defining the target PTMs and their mass shifts.
   - Setting the neutral loss values if applicable.

3. **Execute the Localization**
   Run the tool by passing your configured input file:
   ```bash
   java -jar luciphor2.jar your_config_file.txt
   ```

### Input Formats
- **pepXML**: Standard output from PeptideProphet.
- **Tab-delimited**: Custom scores from any protein search tool. Ensure the columns match the requirements specified in the generated template.

## Best Practices and Tips
- **Template First**: Always generate a fresh template when switching between different PTM types to ensure all parameters are correctly defined.
- **Java Dependency**: Since Luciphor2 is Java-based, ensure a compatible Java Runtime Environment (JRE) is active in your path.
- **PTM Flexibility**: Unlike the original version, Luciphor2 can score any PTM. If working with non-standard modifications, ensure the mass shifts are calculated accurately in the configuration file.
- **Search Tool Agnostic**: If your search tool does not output pepXML, use the tab-delimited input option to import scores from tools like MaxQuant, Mascot, or Comet.

## Reference documentation
- [Luciphor2 Overview](./references/anaconda_org_channels_bioconda_packages_luciphor2_overview.md)
- [Luciphor2 Documentation](./references/luciphor2_sourceforge_net_index.md)