resource "aws_cognito_user_pool" "pool_1" {
  name = "alanredfordhayes_pool_1"

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