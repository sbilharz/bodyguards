bodyguards
==========

bodyguards provides a small DSL to create classes to manage the feature permissions in your project.

Example rails application
-------------------

app/models/user.rb
```ruby
  class User
    def admin?
      true
    end
  end
```

app/bodyguards/application_bodyguard.rb
```ruby
  class AdminBodyguard < Bodyguards::Base
    permit_to :show_dashboard { admin? }
    permit_to :delete_users { admin? }
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
