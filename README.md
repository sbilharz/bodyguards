bodyguards
==========

bodyguards provides a small DSL to create classes to manage the feature permissions in your project.

Example application
-------------------

```ruby
  class User
    def admin?
      true
    end
  end

  class ApplicationBodyguard < Bodyguards::Base
    permit_to :show_admin_panel { admin? }
  end

  class AdminController
    before_action do
      throw :abort unless ApplicationBodyguard.permission_to?(:show_admin_panel, current_user)
    end
  end
```
