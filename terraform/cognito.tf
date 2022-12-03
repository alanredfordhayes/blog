resource "aws_cognito_user_pool" "pool_1" {
  name = "alanredfordhayes_pool_1"

  alias_attributes = ["email"]
  auto_verified_attributes = ["email"]

  schema {
    name = "email"
    attribute_data_type = "String"
    developer_only_attribute = false
    mutable = false
    required = true

    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }

  schema {
    name = "name"
    attribute_data_type = "String"
    developer_only_attribute = false
    mutable = false
    required = true

    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }

  recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  password_policy {
    minimum_length = 8
    require_lowercase = true
    require_uppercase = true
    require_symbols = true 
  }

}

