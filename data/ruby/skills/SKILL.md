---
name: ruby
description: Installs and manages Ruby environments and packages. Use when user asks to install a specific Ruby version, install Ruby gems, run Ruby scripts, or manage Ruby development environments.
homepage: https://github.com/krahets/hello-algo
metadata:
  docker_image: "quay.io/biocontainers/ruby:2.2.3--1"
---

# ruby

Installs and manages Ruby environments and packages. Use when you need to:
  - Install a specific Ruby version.
  - Install Ruby gems (packages).
  - Run Ruby scripts.
  - Manage Ruby development environments.
body: |
  ## Overview
  This skill helps you manage Ruby installations and packages. It's useful for setting up Ruby development environments, installing specific Ruby versions, and managing Ruby gems (libraries) for your projects.

  ## Installation and Usage

  ### Installing Ruby via Conda
  For managing Ruby environments, especially in scientific or data-related contexts, Conda is a convenient option.

  To install a specific version of Ruby from the bioconda channel:
  ```bash
  conda install bioconda::ruby=<version>
  ```
  For example, to install Ruby 2.2.3:
  ```bash
  conda install bioconda::ruby=2.2.3
  ```

  ### Installing Ruby Gems
  Once Ruby is installed, you can manage its packages (gems) using the `gem` command.

  To install a specific gem:
  ```bash
  gem install <gem_name>
  ```
  For example, to install the `nokogiri` gem:
  ```bash
  gem install nokogiri
  ```

  To install a specific version of a gem:
  ```bash
  gem install <gem_name> -v <version>
  ```
  For example, to install version 1.10.0 of `nokogiri`:
  ```bash
  gem install nokogiri -v 1.10.0
  ```

  To list installed gems:
  ```bash
  gem list
  ```

  ### Running Ruby Scripts
  You can execute Ruby scripts directly from the command line.

  To run a Ruby file named `your_script.rb`:
  ```bash
  ruby your_script.rb
  ```

  ### Expert Tips
  *   **Version Management:** When working on multiple projects, consider using a Ruby version manager like `rbenv` or `RVM` for more granular control over Ruby versions per project. While Conda is useful for environment management, these tools are specifically designed for Ruby versioning.
  *   **Gemfile:** For managing project-specific gem dependencies, use a `Gemfile` with Bundler. This ensures that all developers on a project use the same set of gem versions.
      ```bash
      # Example Gemfile content
      source 'https://rubygems.org'
      gem 'rails', '~> 7.0'
      gem 'nokogiri', '~> 1.10'
      ```
      Then, install gems using:
      ```bash
      bundle install
      ```
  *   **Documentation:** Refer to the official Ruby documentation and the documentation for specific gems you are using for detailed API information and advanced usage.

  ## Reference documentation
  - [Anaconda.org Channels Bioconda Packages Ruby Overview](./references/anaconda_org_channels_bioconda_packages_ruby_overview.md)

## Subcommands

| Command | Description |
|---------|-------------|
| gem | RubyGems is a sophisticated package manager for Ruby. This is a basic help message containing pointers to more information. |
| ruby | Execute a Ruby script |