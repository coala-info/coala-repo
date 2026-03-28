---
name: crux
description: Crux is a framework for building cross-platform applications with a shared Rust core and native UI shells. Use when user asks to implement shared business logic in Rust, generate foreign language bindings for mobile or web, or manage side effects using a functional architecture.
homepage: https://github.com/redbadger/crux
---

# crux

## Overview
Crux enables a "Shared Core, Thin Shell" architecture. You implement your application's state management and business logic once in Rust and project it into platform-native UIs (SwiftUI, Jetpack Compose, React). The core is side-effect free; it receives events and emits "Effects" (requests for actions like HTTP calls or disk I/O) which the platform-specific shell executes and returns as "Responses".

## Core Implementation Patterns

### Defining the Core
Every Crux core requires four main components defined in the `shared` crate:
1.  **Model**: The state of your application.
2.  **Event**: Actions that can happen (User interactions or Effect responses).
3.  **Effect**: Side effects the shell must perform.
4.  **Update**: A function that takes an `Event` and `Model`, updates the `Model`, and potentially emits `Effect`s.

### Implementing the App Trait
```rust
impl App for MyApp {
    type Model = Model;
    type Event = Event;
    type ViewModel = ViewModel;
    type Capabilities = Capabilities;

    fn update(&self, event: Event, model: &mut Model, caps: &Capabilities) {
        match event {
            Event::TriggerAction => {
                caps.http.get("https://api.example.com").expect_json().send(Event::Response);
            }
            Event::Response(Ok(data)) => {
                model.data = data;
            }
            // ...
        }
    }

    fn view(&self, model: &Model) -> ViewModel {
        ViewModel { /* project state to UI-friendly format */ }
    }
}
```

## CLI and Workflow Patterns

### Type Generation
Crux uses a dedicated crate (usually `shared_types`) to generate foreign language bindings. This is the primary CLI interaction point.
- **Generate all types**: `cargo run -p shared_types`
- This command typically generates:
    - **Swift**: For iOS shells.
    - **Kotlin**: For Android shells.
    - **TypeScript**: For Web shells.

### Project Structure
Maintain the standard Crux directory layout for seamless integration:
- `shared/`: The Rust core logic.
- `shared_types/`: The type generation binary.
- `iOS/`: SwiftUI project.
- `Android/`: Jetpack Compose project.
- `web/`: React/Vue/TypeScript project.

### Testing the Core
Because the core is side-effect free, you can test complex user journeys in pure Rust without mocks:
- Use `crux_core::testing::Tester` to simulate events and assert on model changes or emitted effects.
- Run tests: `cargo test -p shared`

## Managed Capabilities
Instead of calling APIs directly, use Crux Capabilities to request actions:
- **HTTP**: `crux_http` for web requests.
- **Key-Value**: `crux_kv` for persistent storage.
- **Time**: `crux_time` for getting the current time or setting timers.
- **Platform**: `crux_platform` for device-specific information.

## Expert Tips
- **Keep the Shell Thin**: The shell should only handle UI rendering and executing effects. If you find yourself writing logic in Swift or Kotlin, move it to the Rust `update` function.
- **ViewModel Projection**: Use the `view` function to transform your complex `Model` into a simple `ViewModel` that the UI can render directly without further processing.
- **Effect Composition**: Use `compose` patterns when one event triggers multiple capabilities (e.g., fetching data and logging the time simultaneously).



## Subcommands

| Command | Description |
|---------|-------------|
| crux | Supports a variety of primary and utility commands for mass spectrometry data analysis. |
| crux | crux supports the following primary commands: |
| crux | Crux supports the following primary commands and utility commands. |
| crux | Crux supports the following primary commands and utility commands. |
| crux | Supports a variety of commands for mass spectrometry data analysis. |
| crux | Crux is a suite of tools for analyzing tandem mass spectrometry data. |
| crux | Supports a variety of commands for mass spectrometry data analysis. |
| crux | Crux is a suite of tools for analyzing tandem mass spectrometry data. |
| crux | Crux is a suite of tools for analyzing tandem mass spectrometry data. |
| crux | Crux is a suite of tools for analyzing tandem mass spectrometry data. |
| crux | Crux is a suite of tools for analyzing tandem mass spectrometry data. |
| crux | Supports a variety of commands for mass spectrometry data analysis. |
| crux | Supports a variety of commands for mass spectrometry data analysis. |
| crux | Crux is a suite of tools for analyzing tandem mass spectrometry data. |
| crux | Supports a variety of commands for mass spectrometry data analysis. |
| crux | Crux supports the following primary commands and utility commands. |
| crux | Crux is a suite of tools for analyzing tandem mass spectrometry data. |
| crux | Crux is a suite of tools for analyzing mass spectrometry data. |
| crux | Crux is a suite of tools for analyzing tandem mass spectrometry data. |
| crux | Crux is a suite of tools for analyzing mass spectrometry proteomics data. |
| crux | Crux is a suite of tools for analyzing mass spectrometry proteomics data. |
| crux | A suite of tools for analyzing mass spectrometry data in proteomics. |
| crux | Crux supports the following primary commands and utility commands. |
| crux | Crux is a suite of tools for analyzing mass spectrometry proteomics data. |
| crux | Crux is a suite of tools for analyzing mass spectrometry data. |
| crux | Crux is a suite of tools for analyzing mass spectrometry proteomics data. |
| crux | Crux is a suite of tools for analyzing mass spectrometry proteomics data. |
| crux | crux supports the following primary commands: |
| crux | crux supports the following primary commands: |
| crux | Crux is a suite of tools for analyzing mass spectrometry data. |
| crux | Crux is a suite of tools for analyzing tandem mass spectrometry data. |
| crux | Crux is a suite of tools for analyzing mass spectrometry data. |
| crux assign-confidence | Assign confidence estimates to peptide-spectrum matches (PSMs). |
| crux barista | Barista is a tool for identifying peptides from tandem mass spectra. |
| crux bullseye | Bullseye will search for PPIDs in these spectra. Bullseye will assign high-resolution precursor masses to these spectra. |
| crux cascade-search | Searches spectra against a series of databases in a cascade. |
| crux comet | Comet is a widely used open-source tandem mass spectrometry search algorithm. |
| crux extract-columns | Extracts specified columns from a tab-delimited file. |
| crux extract-rows | Extract rows from a TSV file based on a column value. |
| crux generate-peptides | Generate peptides from a protein FASTA file. |
| crux get-ms2-spectrum | Parse fragmentation spectra from MS2 files. |
| crux hardklor | Parses high-resolution spectra from a file. |
| crux localize-modification | Localize modifications in PSM files. |
| crux make-pin | Creates a pin file from one or more input files containing peptide-spectrum matches (PSMs). |
| crux param-medic | Parse fragmentation spectra to estimate measurement error. |
| crux pipeline | Run the Crux pipeline for peptide identification. |
| crux predict-peptide-ions | Predict theoretical peptide ions. |
| crux print-processed-spectra | Parse fragmentation spectra from MS2 files and write processed spectra to an output file. |
| crux psm-convert | Convert PSM files to different formats. |
| crux q-ranker | Rank fragmentation spectra using search results. |
| crux search-for-xlinks | Search for cross-linked peptides in MS2 and FASTA files. |
| crux sort-by-column | Sorts a tab-delimited file by the values in a specified column. |
| crux spectral-counts | Calculate spectral counts for PSMs. |
| crux stat-column | Extracts a column from a tab-delimited file. |
| crux subtract-index | A new peptide index containing all peptides that occur in the first index but not the second. |
| crux tide-index | Create a peptide index for the tide search engine. |
| crux tide-search | Search for peptides in mass spectrometry data using the Tide algorithm. |
| crux xlink-assign-ions | Assigns cross-linked peptides to MS/MS spectra. |
| crux xlink-score-spectrum | Score cross-linked peptides based on their mass spectrum. |
| percolator | Percolator is a widely used tool for the statistical validation and rescoring of peptide identification results from mass spectrometry. |

## Reference documentation
- [README.md](./references/github_com_redbadger_crux.md)
- [Getting Started](./references/redbadger_github_io_crux_getting_started_core.html.md)
- [Capabilities Guide](./references/redbadger_github_io_crux_guide_capabilities.html.md)