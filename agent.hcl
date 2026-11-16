exit_after_auth = true

auto_auth {
  method "approle" {
    config {
      role_id_file_path   = "/tmp/bao/role_id"
      secret_id_file_path = "/tmp/bao/secret_id"
    }
  }
}

template_config {
  exit_on_retry_failure = true
}

vault {
  address = "http://openbao:8200"
}

template {
  destination          = "/tmp/bao/env"
  perms                = "0600"
  error_on_missing_key = true
  contents             = <<EOT
{{ with secret (printf "secret/data/%s" (env "BAO_SECRET_PATH")) }}{{ range $k, $v := .Data.data }}export {{ $k }}='{{ $v | replaceAll "'" "'\\''" }}'
{{ end }}{{ end }}
EOT
}
