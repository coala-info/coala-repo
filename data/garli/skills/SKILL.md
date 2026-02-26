---
name: garli
description: Garlic.js is a client-side library that automatically persists HTML form field values to the browser's local storage to prevent data loss. Use when user asks to save form states automatically, prevent data loss from browser crashes, or configure persistent input fields using data attributes.
homepage: https://github.com/guillaumepotier/Garlic.js
---


# garli

## Overview

Garlic.js is a client-side persistence library that automatically saves the state of HTML form fields (text inputs and select boxes) to the browser's local storage. It prevents data loss from accidental tab closures or browser crashes by maintaining field values until the form is explicitly submitted. This skill provides the necessary procedures for deploying the library, customizing its behavior via data attributes, and utilizing its build and testing CLI tools.

## Implementation and Usage

### Basic Activation
To enable automatic persistence on a form, add the `data-persist="garlic"` attribute to the `<form>` element. Garlic.js will automatically detect this and begin watching all supported child inputs.

```html
<form data-persist="garlic" method="POST">
  <input type="text" name="username" />
  <select name="options">
    <option value="1">Option 1</option>
  </select>
  <button type="submit">Submit</button>
</form>
```

### Field Identification
Garlic.js relies on the `name` or `id` attributes of input fields to generate unique storage keys. 
- **Best Practice**: Always provide a unique `name` or `id` for every input you wish to persist.
- **Storage Key Strategy**: The library generates keys based on the window location and the element's identity.

### Build and Development CLI
If you are modifying the source or creating a custom distribution, use the following command-line patterns:

1. **Install Dependencies**:
   ```bash
   npm install
   ```

2. **Run Tests**:
   - **Headless**: `npm test`
   - **Browser-based**: Open `tests/index.html` in your target browser.

3. **Build Production Versions**:
   The build process requires Ruby and the Google Closure compiler (`gem install closure-compiler`).
   ```bash
   ./bin/build.sh <version_number>
   ```
   Example: `./bin/build.sh 1.4.2`
   The minified output will be generated in the `dist/` directory.

### Advanced Configuration Patterns
- **Excluding Fields**: To prevent specific fields from being persisted within a managed form, use `data-storage="false"` on the specific input.
- **Custom Storage**: While Garlic.js defaults to `localStorage`, it can be extended or configured to use `sessionStorage` via specific options if the environment supports it.
- **Events**: Utilize the internal event hooks like `prePersist`, `preRetrieve`, and `onRetrieve` to execute logic before or after data is moved to/from storage.

## Reference documentation
- [Garlic.js README](./references/github_com_guillaumepotier_Garlic.js.md)
- [Garlic.js Issues and Limitations](./references/github_com_guillaumepotier_Garlic.js_issues.md)