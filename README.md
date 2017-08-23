bodyguards
==========

bodyguards provides a small DSL to create classes to manage the feature permissions in your project.

Documentation
-------------

You create bodyguard classes by inheriting from `Bodyguards::Base` and registering rules for your feature names.

`Bodyguards::Base` methods
* `#permit_to(feature_name, &block)`
  * Register a rule for the given feature name
  * The block is evaluated in the scope of the given subject
  * The result of the block evaluation is returned by `#permission_to?`/`#rejection_to?`
* `#permit_all(&block)`
  * Register a global rule that is evaluated before any feature-specific rule by `#permission_to?`/`#rejection_to?` and stops any further evaluation on success
* `#permission_to?(feature_name, subject)`
  * Evaluates the rule block registered for the given feature name in the scope of the given subject and returns the result
* `#rejection_to?(feature_name, subject)`
  * Complement to `#permission_to?`
* `#any_permission?(subject)`
  * Returns the result of the first rule block evaluation with a truthy return value

You can create as many bodyguard classes as you want, e.g. corresponding to the available contexts of your project.

Example rails application
-------------------

app/models/user.rb
```ruby
  class User
    def admin?
      [...]
    end

    def super_cool?
      id == 1
    end
  end
```

app/bodyguards/application_bodyguard.rb
```ruby
  class AdminBodyguard < Bodyguards::Base
    permit_to :show_dashboard { admin? }
    permit_to :delete_users { admin? }

    permit_all { super_cool? }
  end
```

app/controllers/admin_controller.rb
```ruby
  class AdminController
    def index
      render template: 'public/system/403.html' unless AdminBodyguard.permission_to?(:show_dashboard, current_user)
    end
  end
```

app/layouts/application.html.erb
```ruby
  [...]
  <%= link_to '/admin' if AdminBodyguard.any_permission?(current_user) %>
  [...]
```

Things to do
------------

* Add some rails-specific helpers, e.g. to auto-check permissions in controllers based on naming conventions
* Maybe put the rails-specific things into an extra gem 'bodyguards-rails'
