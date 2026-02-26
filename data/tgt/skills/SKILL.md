---
name: tgt
description: tgt is a Python toolkit for the programmatic manipulation and automation of Praat TextGrid and ELAN annotation files. Use when user asks to automate linguistic annotation tasks, shift time boundaries, concatenate multiple TextGrids, or convert between TextGrid and ELAN formats.
homepage: https://github.com/hbuschme/TextGridTools/
---


# tgt

## Overview
TextGridTools (tgt) is a Python-based toolkit that provides a robust API for handling linguistic annotations. While Praat is the standard for manual annotation, `tgt` allows for the automation of repetitive tasks such as shifting time boundaries, concatenating multiple files, and converting between TextGrid and ELAN formats. It treats TextGrids as structured objects (Tiers and Annotations), making it easier to perform data analysis and batch modifications than parsing the raw text files directly.

## Usage and Best Practices

### Core Python Workflow
The primary way to use `tgt` is through Python scripts to automate annotation tasks.

*   **Loading Files**: Use `tgt.read_textgrid(filename)` for standard Praat files. For ELAN files, use `tgt.io.read_eaf(filename)`.
*   **Tier Management**: Access tiers by name using `tg.get_tier_by_name('name')`. `tgt` distinguishes between `IntervalTier` (for durations) and `PointTier` (for specific time points).
*   **Modification**: You can append annotations, delete intervals, or change time offsets.
*   **Saving**: Use `tgt.write_to_file(tg, 'output.TextGrid', format='long')`. The 'long' format is generally preferred for maximum compatibility with Praat.

### Common Manipulation Patterns
*   **Concatenation**: Use `tgt.util.concatenate_textgrids(list_of_textgrids)` to merge multiple recording segments into a single continuous annotation file.
*   **Time Shifting**: When aligning audio segments to a larger corpus, use the `shift_boundaries` methods to adjust all annotations by a specific offset.
*   **Validation**: Always check for overlapping annotations on an `IntervalTier`, as `tgt` provides methods to identify these inconsistencies which might cause issues in Praat.

### CLI Utilities
The package includes standalone scripts for common tasks. If installed via pip or conda, these are often available directly in the terminal:
*   **shift-boundaries**: A utility to shift all time markers in a TextGrid. This is useful when you have trimmed the beginning of an audio file and need the annotations to match the new start time.

### Expert Tips
*   **Encoding**: When reading files, ensure you handle encoding correctly (UTF-8 vs UTF-16), as Praat versions vary in their default output.
*   **Memory Efficiency**: For very large corpora, process files individually and use `tgt.util` functions to aggregate data rather than loading hundreds of TextGrids into a single list.
*   **Format Conversion**: Use `tgt` as a bridge between ELAN and Praat. Load an `.eaf` file and immediately write it as a `.TextGrid` to preserve tier hierarchies and time alignments.

## Reference documentation
- [TextGridTools GitHub Repository](./references/github_com_hbuschme_TextGridTools.md)
- [Bioconda tgt Package Overview](./references/anaconda_org_channels_bioconda_packages_tgt_overview.md)