---
name: brass
description: Brass Mono is a retro-industrial monospaced font designed for coding and technical work.
homepage: https://github.com/fonsecapeter/brass_mono
---

# brass

## Overview
Brass Mono is a retro-industrial monospaced font designed for coding and technical work. This skill facilitates the management of the font's development lifecycle, which relies on a scripted build pipeline using Docker and FontForge to transform SVG glyphs into functional OpenType/TrueType fonts. It covers the transition from source editing in Inkscape to production-ready distribution.

## Development Workflow

### Environment Setup
Before modifying glyphs, initialize the environment to ensure all dependencies and submodules are present.
*   **Initialize**: Run `bin/init` to set up git submodules.
*   **Containerization**: The build system is Docker-based. Ensure Docker is running before executing build commands.

### Building and Compiling
The project converts `src/BrassMono.svg` into multiple TTF variants (Regular, Bold, Italic, and Code versions with ligatures).
*   **Initial Build**: Use `bin/build` to compile the fonts and create the distribution zip files for the first time.
*   **Iterative Rebuild**: After making changes to the SVG source in Inkscape, use `bin/rebuild` to re-compile the TTF files in the `dist/` directory.
*   **Output Variants**: The build process generates two distinct families:
    *   `Brass Mono`: Standard monospaced version.
    *   `Brass Mono Code`: Version containing programming ligatures.

### Quality Assurance and Linting
The project aims for Google Fonts compatibility.
*   **Compliance Check**: Run `bin/lint` to execute `fontbakery`. This checks the compiled fonts against industry standards and identifies metadata or structural issues.
*   **Manual Verification**: Use `bin/install` to move the compiled fonts to `~/.fonts/BrassMonoFonts` for immediate testing in local editors or IDEs.

### Versioning and Maintenance
*   **Help Utility**: Run `bin/help` to see a full list of project management commands.
*   **Versioning**: Use `bin/bump` to increment version numbers and `bin/tag` to manage Git releases.

## Best Practices
*   **Source Editing**: Always edit `src/BrassMono.svg` using the Inkscape SVG Font Editor. The build pipeline is specifically tuned to parse this file.
*   **Ligature Management**: When working on `Brass Mono Code`, ensure that the `isFixedPitch` flag is handled correctly during the build to maintain monospaced behavior in IDEs.
*   **Docker Consistency**: Always use the provided `bin/` scripts rather than calling `fontforge` directly to ensure the environment matches the project's specific build requirements.

## Reference documentation
- [Brass Mono README](./references/github_com_fonsecapeter_brass_mono.md)
- [Commit History](./references/github_com_fonsecapeter_brass_mono_commits_main.md)