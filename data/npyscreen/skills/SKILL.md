---
name: npyscreen
description: npyscreen is a high-level framework for building complex terminal-based user interfaces using an object-oriented approach. Use when user asks to create terminal applications, build interactive forms and widgets, or develop command-line data-entry tools.
homepage: http://www.npcole.com/npyscreen/
---


# npyscreen

## Overview
npyscreen is a high-level framework designed to simplify the creation of complex terminal-based applications. Unlike raw curses, it provides an object-oriented approach to UI development, allowing you to treat the interface as a collection of forms and widgets. It is particularly effective for rapid prototyping of data-entry tools, system dashboards, and interactive scripts where a standard command-line argument interface is insufficient.

## Core Workflow
To build an application with npyscreen, follow this standard lifecycle:

1.  **Define the Application Class**: Inherit from `npyscreen.NPSAppManaged` to handle multiple screens and state transitions.
2.  **Define Forms**: Inherit from `npyscreen.Form` or `npyscreen.ActionForm`.
3.  **Add Widgets**: Use the `add()` method within the Form's `create()` method to place widgets.
4.  **Handle Logic**: Implement `on_ok()` or `on_cancel()` for `ActionForm` types to process user input.

## Essential Patterns

### Basic Form Setup
```python
import npyscreen

class MyTestApp(npyscreen.NPSAppManaged):
    def onStart(self):
        # Register forms here
        self.addForm("MAIN", MainMenuForm, name="Main Menu")

class MainMenuForm(npyscreen.Form):
    def create(self):
        self.name_field = self.add(npyscreen.TitleText, name="Name:")
        self.choice = self.add(npyscreen.TitleSelectOne, name="Pick one:", 
                              values=["Option 1", "Option 2"], scroll_exit=True)

    def afterEditing(self):
        # Transition logic or exit
        self.parentApp.setNextForm(None)

if __name__ == "__main__":
    App = MyTestApp()
    App.run()
```

### Common Widget Types
- **TitleText / TitlePassword**: Text input with a label.
- **TitleSelectOne / TitleMultiSelect**: List-based selection.
- **Pager / MultiLineEdit**: For displaying or editing large blocks of text.
- **ButtonPress**: For triggering specific functions.

### Best Practices
- **Managed Applications**: Always prefer `NPSAppManaged` over simple `NPSApp` for anything beyond a single-page script. It handles the screen switching logic (`setNextForm`) cleanly.
- **Widget Values**: Access user input via the `.value` attribute of the widget object (e.g., `self.name_field.value`).
- **Validation**: Perform input validation inside the `on_ok` method of an `ActionForm`. If validation fails, you can prevent the form from closing by not changing the next form.
- **Terminal Resizing**: While npyscreen handles terminal resizing to prevent crashes, it calculates widget positions at creation. For dynamic layouts, ensure forms are re-initialized or use the newer auto-resizing form classes if available in the environment.

## Expert Tips
- **Navigation**: Use `scroll_exit=True` on selection widgets to allow users to move to the next widget using arrow keys once they reach the end of the list.
- **Color Themes**: npyscreen uses "Theme" classes. You can change the look of the entire app by setting `npyscreen.setTheme(npyscreen.Themes.ElegantTheme)` before initializing the app.
- **Hidden Fields**: Use the `hidden=True` argument when adding widgets to dynamically show or hide UI elements based on previous selections during the `while_editing` loop.

## Reference documentation
- [npyscreen Project Overview](./references/www_npcole_com_npyscreen.md)