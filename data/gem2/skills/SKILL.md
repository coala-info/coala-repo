---
name: gem2
description: The gem2 tool converts RubyGems into RPM-compatible source packages by extracting metadata to generate spec files. Use when user asks to generate a spec file from a gem, fetch and convert a gem in one step, or create and use custom templates for RPM packaging.
homepage: https://github.com/fedora-ruby/gem2rpm
---


# gem2

## Overview
The `gem2` skill facilitates the transformation of RubyGems into RPM-compatible source packages. While RubyGems handles its own dependency and installation logic, RPM-based systems require a `.spec` file to manage software within the system's package manager. This tool extracts metadata—such as versioning, dependencies, and file lists—directly from a `.gem` file to bootstrap a spec file. It is designed to handle both pure-ruby gems and those requiring compilation, providing a template-based system for maintaining package quality over multiple version updates.

## Basic Usage
The primary command for this tool is `gem2rpm`.

- **Generate a spec file from a local gem:**
  `gem2rpm GEM_NAME-1.0.0.gem > rubygem-GEM_NAME.spec`

- **Fetch and generate in one step:**
  `gem2rpm --fetch GEM_NAME`

- **List available system templates:**
  `gem2rpm --templates`

## Recommended Workflow
Because gems often lack specific RPM metadata (like changelogs or distribution-specific licenses), you should use a template-based workflow rather than editing the generated spec file directly.

1. **Export the default template:**
   `gem2rpm -T > rubygem-GEM_NAME.spec.template`

2. **Customize the template:**
   Open the `.spec.template` file and add the License, Changelog, or specific build requirements.

3. **Generate the final spec using your template:**
   `gem2rpm -t rubygem-GEM_NAME.spec.template GEM_NAME-1.0.0.gem > rubygem-GEM_NAME.spec`

## Expert Tips and Patterns

### Handling Binary Extensions
For gems that include prebuilt binary extensions (e.g., `nokogiri`), a standard `gem fetch` might download a platform-specific binary. To ensure you have the source code for a proper RPM build, always fetch using the ruby platform:
`gem fetch GEM_NAME --platform ruby`

### Template Configuration
You can modify the behavior of the template by editing the `config` variable within the ERB template.

- **Redefine Macros:**
  `<% config.macros[:instdir] = '%{vagrant_plugin_instdir}' %>`

- **Adjust Documentation Filtering:**
  If files are being incorrectly categorized, update the doc rules:
  `<% config.rules[:doc] = [/\/?doc(\/.*)?/, /README.*/] %>`

### Dependency Management
The tool provides `runtime_dependencies` and `development_dependencies` objects. If a gem has complex dependency requirements that don't map 1:1 to RPM packages, you may need to manually override these in your custom template.

## Reference documentation
- [gem2rpm README and Usage](./references/github_com_fedora-ruby_gem2rpm.md)