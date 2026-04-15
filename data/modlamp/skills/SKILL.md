---
name: modlamp
description: The modlamp tool provides a Python framework for the design, analysis, and physical-chemical characterization of peptide and protein sequences. Use when user asks to generate peptide libraries, calculate molecular descriptors, train machine learning models for biological activity prediction, or visualize helical wheel projections.
homepage: http://modlamp.org
metadata:
  docker_image: "quay.io/biocontainers/modlamp:4.3.2--pyh7e72e81_0"
---

# modlamp

## Overview
The `modlamp` skill enables the design and analysis of peptides and proteins using a specialized Python framework. It provides tools for generating diverse sequence libraries (random, helical, etc.), calculating over 200 physical-chemical descriptors, and building predictive models for biological activity. Use this skill to automate the characterization of amino acid sequences, perform virtual screening, or process circular dichroism (CD) data from wet-lab experiments.

## Core Workflows

### Sequence Generation
Generate peptide libraries with specific structural characteristics using the `modlamp.sequences` module.

*   **Mixed Libraries**: Create diverse sets of sequences for screening.
    ```python
    from modlamp.sequences import MixedLibrary
    lib = MixedLibrary(1000)
    lib.generate_sequences()
    # Access sequences via lib.sequences
    ```
*   **Structural Classes**: Use specific classes like `Helices`, `Random`, `AmphipathicArc`, or `Kinked` to target specific motifs.

### Descriptor Calculation
Calculate global or residue-scale descriptors for sequences.

*   **Global Descriptors**: Calculate properties like charge, MW, and isoelectric point.
    ```python
    from modlamp.descriptors import GlobalDescriptor
    glob = GlobalDescriptor(sequences)
    glob.calculate_MW(amide=True)
    glob.calculate_charge(ph=7.4)
    glob.isoelectric_point()
    ```
*   **Peptide Descriptors (AA Scales)**: Use specific scales (e.g., Eisenberg, Kyte-Doolittle) for hydrophobic moments or autocorrelation.
    ```python
    from modlamp.descriptors import PeptideDescriptor
    # Calculate Eisenberg hydrophobic moment
    desc = PeptideDescriptor(sequences, 'eisenberg')
    desc.calculate_moment()
    # Calculate PepCATS cross-correlation (window size 7)
    pep = PeptideDescriptor(sequences, 'pepcats')
    pep.calculate_crosscorr(7)
    ```

### Machine Learning & Classification
Train and apply models to predict peptide activity (e.g., AMP vs. non-AMP).

*   **Training**: Use `modlamp.ml` to train Random Forest (RF) or SVM models.
    ```python
    from modlamp.ml import train_best_model, score_cv
    # Train RF model on descriptor data and target labels
    model = train_best_model('RF', desc.descriptor, targets)
    # Evaluate with 10-fold cross-validation
    score_cv(model, desc.descriptor, targets, cv=10)
    ```
*   **Prediction**: Predict probabilities for new sequences.
    ```python
    proba = model.predict_proba(new_descriptors)
    ```

### Data Handling & Visualization
*   **FASTA Processing**: Load sequences directly from FASTA files into descriptor objects.
    ```python
    desc = PeptideDescriptor('input.fasta', 'eisenberg')
    ```
*   **Plotting**: Visualize features using `modlamp.plot`.
    *   `helical_wheel('SEQUENCE')`: Generate helical wheel projections.
    *   `plot_feature(data)`: Create boxplots for descriptor distributions.
    *   `plot_2_features(d1, d2)`: Create 2D scatter plots for class separation.

## Expert Tips
*   **Duplicate Removal**: `MixedLibrary` and other generation classes automatically remove duplicates. If you need exactly $N$ sequences, check `len(lib.sequences)` after generation, as it may be slightly lower than requested.
*   **Amidation**: When calculating charge or MW for synthetic peptides, always set `amide=True` if the C-terminus is modified, as this significantly impacts the net charge at physiological pH.
*   **Scale Loading**: You can switch scales on an existing `PeptideDescriptor` object using `load_scale('new_scale')` to avoid re-initializing the object.
*   **Database Scraping**: Use `modlamp.database.query_apd()` or `query_camp()` to pull known active sequences directly into your workflow for use as positive training sets.

## Reference documentation
- [Example scripts](./references/modlamp_org_examplescript.html.md)
- [Package Documentation](./references/modlamp_org_modlamp.html.md)
- [Modlamp README](./references/modlamp_org_readme.html.md)