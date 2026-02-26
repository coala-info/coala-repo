---
name: mobyle
description: The mobyle skill integrates the Mobylette gem into Ruby on Rails to detect mobile devices and serve optimized templates. Use when user asks to identify mobile requests, serve mobile-specific views, or force mobile rendering via session overrides.
homepage: https://github.com/tscolari/mobylette
---


# mobyle

## Overview
The mobyle skill facilitates the integration of the Mobylette gem into Ruby on Rails projects. It enables controllers to recognize mobile requests as a distinct MIME type, allowing the application to automatically serve mobile-optimized templates. It provides a set of helpers to identify specific devices like iPhones or Android phones and allows developers to force or ignore mobile rendering through session variables or URL parameters.

## Implementation Patterns

### Basic Setup
To enable mobile request handling, include the module in your `ApplicationController` or specific functional controllers:

```ruby
class ApplicationController < ActionController::Base
  include Mobylette::RespondToMobileRequests
end
```

Once included, the controller will automatically look for `.mobile.erb` (or other engines like `.mobile.haml`) when a mobile device is detected.

### Controller Logic and Format Handling
You can explicitly handle the mobile format within `respond_to` blocks:

```ruby
respond_to do |format|
  format.html   { render :index }
  format.mobile { render :mobile_index }
end
```

### Helper Methods
Use these helpers in views or controllers to branch logic based on the request source:
- `is_mobile_request?`: Returns `true` if the user agent matches a mobile device.
- `is_mobile_view?`: Returns `true` if the current request format is `:mobile`.
- `request_device?(:device)`: Checks for specific platforms. Supported by default: `:iphone`, `:ipad`, `:ios`, `:android`.

### Session Overrides
You can manually control the rendering mode by setting the `:mobylette_override` session variable. This is useful for "View Desktop Site" or "View Mobile Site" buttons.

- **Force Mobile**: `session[:mobylette_override] = :force_mobile`
- **Ignore Mobile**: `session[:mobylette_override] = :ignore_mobile`
- **Reset**: `session[:mobylette_override] = nil`

### Global Configuration
Configure the gem's behavior in an initializer or within the controller using `mobylette_config`:

```ruby
mobylette_config do |config|
  # Custom user agent detection
  config[:mobile_user_agents] = proc { %r{iphone|android}i }
  
  # Skip specific devices
  config[:skip_user_agents] = [:ipad]
  
  # Handle XHR (Ajax) requests as mobile (disabled by default)
  config[:skip_xhr_requests] = false
end
```

## Expert Tips
- **XHR Handling**: If you are using jQuery Mobile or similar frameworks that rely on Ajax for navigation, ensure `config[:skip_xhr_requests]` is set to `false`, otherwise Ajax requests will default to standard HTML views.
- **Fallback Chains**: You can define format fallbacks if a `.mobile` view is missing. For example, setting `config[:fallback_chains] = { mobile: [:mobile, :html] }` ensures that if `show.mobile.erb` doesn't exist, Rails will render `show.html.erb`.
- **URL Parameters**: Use a `before_action` to allow users to toggle mobile view via URL params (e.g., `?skip_mobile=true`) by updating the `session[:mobylette_override]` accordingly.

## Reference documentation
- [Mobylette Main Documentation](./references/github_com_tscolari_mobylette.md)