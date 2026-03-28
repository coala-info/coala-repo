[Eidos](/)   [Download](/download) [Pricing](/pricing)

Services

[Relay Beta](/relay)

Sync Soon

Publish Soon

[Extensions](/extensions) [Docs](https://docs.eidos.space) Account    Open main menu

[Download](/download) [Pricing](/pricing)

Services

 [Relay Beta](/relay)

Sync Soon

Publish Soon

[Extensions](/extensions) [Docs](https://docs.eidos.space) [Account](/account)

# v0.29.1

**Date:** March 26, 2026

## New Cli Command

* **New `table import` command** — Import JSON data to existing tables

```
eidos table import tb_xxxx --file data.json
cat data.json | eidos table tb_xxxx
```

* **New `table create` command** — Create tables with schema inference

```
cat sample.json | eidos table create "My Table"

eidos table create "Tasks" --fields "title:text,done:checkbox"

eidos table create "New Table" --template tb_source
```

**Full Changelog**: [https://github.com/mayneyao/eidos/compare/v0.29.0…v0.29.1](https://github.com/mayneyao/eidos/compare/v0.29.0...v0.29.1)

# v0.29.0

**Date:** March 25, 2026

## 📢 Important

Node name uniqueness validation. For backward compatibility, this feature is not automatically enabled. You need to manually enable it in Space Data Management and complete the data migration. Once enabled, new nodes must have unique names within the same folder level, matching standard file system logic. This is required for using the Eidos CLI.

## ✨ Highlights

* **Eidos CLI:** You can now interact with Eidos via the CLI, designed to work seamlessly with Claude Code and Codex. Press `Cmd+K` and type `install` to follow the installation prompts.
* **Skills:** You can now install “Skills” to guide AI agents on how to interact with Eidos (run `npx skills add eidos-space/skills` to install).
* **[Relay Service](https://eidos.space/relay):** Integrated relay services with the new **Relay Handler** script type, enabling automatic processing of external messages.

## 🚀 New Features

* **Terminal Integration:** Open the terminal panel using `Ctrl + “.
* **New File Management Component:** Full file management capabilities.
* **Theme Market:** A file-based theme loading mechanism.
* **Table Schema Import/Export:** Quickly export or copy table schemas and rebuild tables using the “Import Table Schema” command in CMDK.
* **Create Table from Dataview:** Creating tables from dataview. Here is a new useful UDF `lsdir` to list directory.

## 🔧 Improvements and Fixes

* Fixed an issue where the client package could not correctly call the API.
* Fixed a bug where the app wouldn’t reactively update after importing CSV data.
* Fixed image loading issues for document bookmarks via proxy.
* Improved login persistence by removing frontend token caching.
* Fixed macOS native tab menu issues when switching between “lock” and “full width”.
* Resolved table issues after deleting link fields; added a new `fix` command in CMDK to repair problematic tables.
* Optimized directory tree loading and scrolling performance.
* Refined the dark mode visual experience for the default theme.
* Enhanced various table components.
* Gallery view now automatically selects the file field as the cover by default.
* Improved CSV column name generation to use semantic headers instead of random identifiers.
* `tableView` and `tableAction` extensions now support `tableId` binding to specific tables.
* Migrated to `oxfmt` for significantly faster code formatting.
* Upgraded Tailwind to v4.
* Upgraded Lexical to v0.42.0.

## What’s Changed

* Feat/relay by @mayneyao in <https://github.com/mayneyao/eidos/pull/298>
* Feat/cli by @mayneyao in <https://github.com/mayneyao/eidos/pull/299>
* chore: upgrade to tailwind v4 by @mayneyao in <https://github.com/mayneyao/eidos/pull/300>

**Full Changelog**: [https://github.com/mayneyao/eidos/compare/v0.28.0…v0.29.0](https://github.com/mayneyao/eidos/compare/v0.28.0...v0.29.0)

# v0.28.0

**Date:** February 12, 2026

## ⚠️ Breaking Changes

* **Table API Reorganization**: The `table()` method now returns the new Prisma-style TableClient API. The legacy TableManager API has been moved to `_table()`.

## ✨ Highlights

### Prisma-style Table SDK

Introducing a brand-new Table SDK client that brings the intuitive Prisma-style API to Eidos. You can now perform CRUD operations directly using database column names: [View documentation →](https://docs.eidos.space/api-reference/table/sdk/)

```
// Query records with field selection
const records = await eidos.space.table("myTable").findMany({
  where: { status: "active" },
  select: { id: true, title: true },
});

// Create record
await eidos.space.table("myTable").create({
  data: { title: "New Item", status: "active" },
});
```

### Tab Split View

Tabs now support split view, allowing you to work with multiple documents side by side. Right-click on a tab to split it into a new group, making it easier to reference and edit related content simultaneously.

### Built-in Extensions with Eject Support

A new built-in extension mechanism has been introduced. Extensions can now be “ejected” - exported as editable source code, allowing you to take full control and customize them to your needs.

### Custom Sync Providers

You can now configure custom S3-compatible sync providers for space synchronization. This feature is available to licensed users, with a new license management system integrated into the desktop app. [Learn how to setup →](https://docs.eidos.space/how-to/setup-custom-sync-provider/)

## 🚀 New Features

* **Customizable New Tab Page:** You can now customize the new tab page using blocks. Create a personalized dashboard or workspace by arranging blocks exactly how you want them. [Learn more →](https://docs.eidos.space/how-to/customize-new-tab/)
* **Extension Directory Tree:** Now supports hierarchical display using slug prefixes for better organization.

## 🔧 Improvements and Fixes

* **Document:** New “Open in File Handler” option for image and file blocks.
* **UI:** Added “Copy Node ID” to node context menu, enhanced clone space UX with progress modal, sidebar now opens by default.
* **Architecture:** Migrated to shared `@eidos.space/ext-server` package, unified RPC logic into client package, unified CORS handling architecture.
* Fixed native context menu memory leak.

## What’s Changed

* Refactor/extensions by @mayneyao in <https://github.com/mayneyao/eidos/pull/292>
* feat(sync): architecture for multi-provider support by @mayneyao in <https://github.com/mayneyao/eidos/pull/294>

**Full Changelog**: [https://github.com/mayneyao/eidos/compare/v0.27.1…v0.28.0](https://github.com/mayneyao/eidos/compare/v0.27.1...v0.28.0)

# v0.27.1

**Date:** January 15, 2026

[fix(extension): ensure editor displays TypeScript source instead of compiled JS](https://github.com/mayneyao/eidos/commit/6c012f186b98d72b9203d95138379f6dc06a7396)

**Full Changelog**: [https://github.com/mayneyao/eidos/compare/v0.27.0…v0.27.1](https://github.com/mayneyao/eidos/compare/v0.27.0...v0.27.1)

# v0.27.0

**Date:** January 10, 2026

## 🚀 Highlights

This iteration mainly introduces graft v2 to support space data synchronization, with multi-process architecture adjustments to the electron backend.

## 🔧 Improvements and Fixes

* Fixed bug where non-journal documents couldn’t be retrieved
* Fixed bug where folders couldn’t be completely deleted
* Recycle bin now supports one-click cleanup, optimized node deletion logic - when confirming node deletion in recycle bin, child nodes are also completely deleted
* Tab state persistence - now reopening the app or force-reloading the page can restore the previous state
* Optimized login status updates
* Optimized navigation button layout on Windows

## What’s Changed

* sync by @mayneyao in <https://github.com/mayneyao/eidos/pull/285>

**Full Changelog**: [https://github.com/mayneyao/eidos/compare/v0.26.0…v0.27.0](https://github.com/mayneyao/eidos/compare/v0.26.0...v0.27.0)

# v0.26.0

**Date:** December 12, 2025

## 🚀 Highlights

Now supports multi-tab mode, allowing parallel management of multiple pages for easier context organization. The current mode is more like an IDE or browser, but serves only your personal data.

## 🔧 Improvements and Fixes

* Settings now include account login/logout options. Supports one-click login to eidos.space account; after login, you no longer need to configure API key to share extensions. Removed the key store page.
* Continued optimization of the directory tree component. Supports multi-node selection, drag-and-drop movement, keyboard navigation. Supports F2 rename, open file in new tab.
* macOS version provides native context menus.
* Made some UI adjustments to journals, now it’s a separate sidebar tab navigation.
* Changed the default shortcut key for opening the left sidebar. cmd + / => cmd + opt + \
* Desktop app now remembers the last window size and position.

## What’s Changed

* Fix ui issues investigate by @mayneyao in <https://github.com/mayneyao/eidos/pull/279>
* Feat/multi tabs by @mayneyao in <https://github.com/mayneyao/eidos/pull/278>

**Full Changelog**: [https://github.com/mayneyao/eidos/compare/v0.25.1…v0.26.0](https://github.com/mayneyao/eidos/compare/v0.25.1...v0.26.0)

# v0.25.1

**Date:** November 29, 2025

## 🔧 Improvements and Fixes

* cmd + p now supports files search and directory tree navigation, with an optimized directory tree implementation.
* custom SQLite extension (experimental)
* fix document slash menu error when some extensions are enabled
* temporarily disable default AI tools (create record), AI functionality is not mature yet, tools may mislead LLM
* cmd + k to add a “Reload App” item; when the app behaves abnormally, try executing this item.

**Full Changelog**: [https://github.com/mayneyao/eidos/compare/v0.25.0…v0.25.1](https://github.com/mayneyao/eidos/compare/v0.25.0...v0.25.1)

# v0.25.0

**Date:** November 23, 2025

This release focuses on storage and routing mechanism refactoring, adding external file handling capabilities. Thanks to these adjustments, many features become more flexible and stable. This also brings breaking changes, you may need to fix some data, see the guide below for details.

## ⚠️ Breaking Changes

* **Storage Architecture Refactoring**: Previously you needed to choose a single location to store all Eidos data, now you can set any folder as a workspace. This will add a `.eidos` folder under that folder.
* **Routing Path Simplification**: Removed the `/<space>/*` prefix from routing pathnames, making file routing more flexible, replaced by universal subdomain pattern matching for workspaces.
* **Dataview Compatibility**: Since we no longer need the `/<space>/` prefix, some dataviews containing pathnames may be affected and need to be deleted and recreated.
* **Workspace Decoupling**: This change decouples workspace names from resource paths stored in the database. For some old data, we provide three fix commands that can be triggered through the CMDK panel:
  + `fix file paths`: This will fix paths in `eidos__files`. Make image and file selectors work properly.
  + `fix file paths (current doc)`: When current node is document, this will fix file paths in the current document uniformly.
  + `fix file paths (current table)`: When current node is table, this will fix paths in all file fields of the current table.

If you encounter unsolvable problems, please join our Discord or submit GitHub issue for support.

## 🚀 New Features

* **Folder Mounting**: You can mount any folder on disk, then access external files in Eidos through the `/@/<mount-name>` pattern. [Check documentation](https://docs.eidos.space/concepts/file/) for more about mounting mechanism.
* **API - File System**: SDK adds file-related APIs including `readdir`, `mkdir`, `readFile`, `writeFile`, `stat`, `rename`, `watch`, etc. [View documentation](https://docs.eidos.space/api-reference/space/#file-system-api)
* **Extension - File Handler**: New block type for custom file processing methods. [View documentation](https://docs.eidos.space/extensions/block/#43-file-handler-extensions)
* **Extension - File Action**: New script type. Custom file actions, quick file processing triggered through right-click menu. Like compression, copy, translation, etc. [View documentation](https://docs.eidos.space/extensions/script/#24-file-action-scripts)
* **Extension Directive**: `'use sidebar'` directive changes the default opening behavior of favorited blocks, you can now fully customize your own sidebar. [View documentation](https://docs.eidos.space/extensions/block/#5-directive-system)

## 🔧 Improvements and Fixes

* **Extension Theme Fix**: Fixed bug where extension block initialization theme was always light mode.
* **File Path Display**: Fixed table file fields couldn’t properly display files with commas in file paths
* **Global Shortcuts**: Now general shortcuts are global mode, shortcuts still work in activated extension blocks.
* **Document Image Alignment**: New document configuration: change default alignment of images in documents.
* **Dataview Template**: New dataview template: view document reference relationships.
* **CMDK Simplification**: Simplified cmdk. Node and document search functions moved to sidebar. Removed space search, node name search through cmd +p
* **Tailwind Plugin Support**: Fixed issue where Tailwind plugins (like typography plugin prose) didn’t work in block environment.
* **Sidebar Resizing**: Left sidebar can now adjust width.

## What’s Changed

* Move node search to nodes sidebar by @mayneyao in <https://github.com/mayneyao/eidos/pull/272>
* Refactor storage and routing by @mayneyao in <https://github.com/mayneyao/eidos/pull/269>
* refactor(search): Transition from FTS to trigram indexing for document… by @mayneyao in <https://github.com/mayneyao/eidos/pull/274>

**Full Changelog**: [https://github.com/mayneyao/eidos/compare/v0.24.0…v0.25.0](https://github.com/mayneyao/eidos/compare/v0.24.0...v0.25.0)

# v0.24.0

**Date:** October 3, 2025

This version focuses on custom document properties, providing a new way to manage documents that works seamlessly with dataview.

## ✨ Highlights

### Custom Document Properties

* **Custom Document Properties**: You can now add custom document properties. You can reference properties dynamically in documents using @ properties. Properties are similar to infoboxes in wikis for storing structured information. [Learn more about custom properties →](https://docs.eidos.space/nodes/doc/#custom-properties)

### Custom Document Actions

* **New Script Extension Type**: Added `docAction` type script for better automation of properties and document content. Trigger through the actions menu or CMDK on any document page. [Learn more about custom actions →](https://docs.eidos.space/nodes/doc/#custom-actions)

## 🚀 New Features

### dataview

* **Query Preview**: You can now preview dataview query results.
* **Richer Templates**: Added more comprehensive templates.
* **SQL Comment Support**: Support for setting display types for fields t