---
name: ci-proxy
description: "This tool manages Conda packages, specifically for the bioconda channel. Use when user asks to search for packages, retrieve package information, or understand package availability within the bioconda channel."
homepage: https://github.com/cirosantilli/china-dictatorship
---


# ci-proxy

Provides functionality for managing and interacting with Conda packages, specifically for the bioconda channel.
  Use this skill when you need to perform operations related to Conda packages, such as searching for packages,
  retrieving package information, or understanding package availability within the bioconda channel.
  This skill is particularly useful for developers and users working with bioinformatics tools and environments managed by Conda.
body: |
  ## Overview
  The `ci-proxy` tool appears to be related to managing Conda packages, specifically within the bioconda channel. It likely facilitates interactions with package repositories, allowing users to search for, retrieve information about, or manage packages. This skill is designed to assist users who are working with Conda environments, particularly in the bioinformatics domain where the bioconda channel is prevalent.

  ## Usage Instructions

  This skill is designed to interact with Conda package information, primarily focusing on the bioconda channel. The available documentation does not provide specific CLI commands or detailed usage patterns for `ci-proxy` itself. Therefore, this skill will focus on general principles of interacting with package managers like Conda, assuming `ci-proxy` acts as an interface or utility for such operations.

  **General Conda Package Interaction Principles:**

  When working with Conda packages, especially from specific channels like bioconda, consider the following:

  1.  **Searching for Packages:**
      *   To find packages related to a specific tool or library, use search commands. For example, if `ci-proxy` were a direct Conda interface, a command might look like `conda search <package_name> --channel bioconda`.
      *   Be specific with your search terms to narrow down results.

  2.  **Retrieving Package Information:**
      *   Once a package is identified, you may need to get detailed information about it, such as its version, dependencies, and build details. A typical Conda command for this is `conda info <package_name>`.
      *   If `ci-proxy` offers a similar function, it would likely involve specifying the package name and potentially the channel.

  3.  **Understanding Channel Priority:**
      *   The bioconda channel is a popular source for bioinformatics tools. When installing or searching, ensure the bioconda channel is correctly configured and prioritized in your Conda environment.
      *   You can often specify channels directly in search or install commands, or configure them in your `.condarc` file.

  **Expert Tips:**

  *   **Specify Channels Explicitly:** When dealing with specialized channels like bioconda, always explicitly specify the channel in your commands (e.g., `conda install -c bioconda <package_name>`) to avoid ambiguity and ensure you get the correct package.
  *   **Environment Management:** Use Conda environments to isolate project dependencies. This prevents conflicts between different software versions. Commands like `conda create -n myenv python=3.9` and `conda activate myenv` are fundamental.
  *   **Troubleshooting Installation Issues:** If you encounter installation problems, check the package's dependencies, ensure your Conda channels are up-to-date (`conda update --all`), and consult the bioconda documentation or issue tracker for known problems.

  **Note:** The provided documentation for `ci-proxy` is limited and does not offer concrete command-line examples. Therefore, the guidance above is based on general Conda best practices. If specific `ci-proxy` commands become available, this skill can be updated with more precise instructions.

  ## Reference documentation
  - [Overview of ci-proxy on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ci-proxy_overview.md)