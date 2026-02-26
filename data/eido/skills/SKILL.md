---
name: eido
description: "Eido is a personal data management framework that allows users to create and manage Notion-like documents and databases locally with AI features. Use when user asks to manage personal data, create Notion-like documents, or leverage AI for data analysis and interaction."
homepage: https://github.com/mayneyao/eidos
---


# eido

yaml
name: eido
description: A framework for Personal Data Management, enabling users to organize, store, and manage personal data with Notion-like documents and databases. It offers offline support, AI features for data interaction, and an extensible architecture for custom tools and blocks. Use when Claude needs to manage personal data, create Notion-like documents, or leverage AI for data analysis and interaction.
```
## Overview
Eido is an extensible framework designed for personal data management. It allows users to create and manage Notion-like documents and databases locally, offering offline access and AI-powered features for data interaction, summarization, and translation. Its core strength lies in its extensibility, allowing for custom tools and UI blocks to be developed.

## Usage Instructions

Eido is primarily used through its desktop application, which can be downloaded from [eidos.space](https://eidos.space/download).

### Core Functionality

*   **Personal Data Management**: Organize, store, and manage personal data using a Notion-like interface with documents and databases.
*   **Offline Support**: All functionalities operate locally, ensuring data access without an internet connection.
*   **AI Features**: Integrate with LLMs for tasks such as translating, summarizing, and interacting with your data.
*   **Extensibility**: Develop custom extensions using JavaScript/TypeScript or Python to build tools and enhance Eido's capabilities.

### Developing Extensions

To develop extensions for Eido:

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/mayneyao/eidos.git
    ```
2.  **Install dependencies**:
    ```bash
    pnpm install
    ```
3.  **Install SQLite extensions**:
    ```bash
    pnpm install:sqlite-ext
    ```
    (This is typically only needed for the first time.)
4.  **Start development**:
    *   For desktop development:
        ```bash
        pnpm dev:desktop
        ```

Extensions are located within the `extensions/` directory and are released under the MIT License.

## Reference documentation
- [Eido Overview](./references/github_com_mayneyao_eidos.md)