resource "aws_cognito_user_pool" "pool_1" {
  name = "alanredfordhayes_pool_1"

  username_attributes = true
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

resource "aws_cognito_user_pool_client" "client" {
  name = "alanredfordhayes_app_client_1"

  user_pool_id = aws_cognito_user_pool.pool_1.id
  supported_identity_providers = ["COGNITO"]
  callback_urls = ["https://localhost:8080/login"]
  logout_urls = ["https://localhost:8080/logout"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["code"]
  allowed_oauth_scopes = ["email", "openid"]
}